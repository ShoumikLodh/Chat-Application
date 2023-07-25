require('dotenv').config();
const express = require('express');
const app = express();
const path = require('path');
const http = require('http');
const { Server } = require('socket.io');
const mysql = require('mysql');
const { getSystemErrorMap } = require('util');
const { application } = require('express');

const db = mysql.createConnection({
    host: process.env.DB_HOSTNAME,
    user: process.env.DB_USERNAME,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME
});

db.connect();

db.query('SELECT * FROM alter_ego.users', (err, result) => {
    if (err) {
        return console.error(err);
    }

    // console.log(result);
});

const PORT = 3000;

app.use(express.static(path.join(__dirname, '../static')));
app.use(express.json());

app.post('/login', async (req, res) => {
    const users = await runQuery(`SELECT * FROM alter_ego.users WHERE email_id='${req.body.email}'`);

    if (users.length !== 1) {
        return res.status(401).json({message: "User does not exist"});
    }

    const user = users[0];

    if (user.password !== req.body.password) {
        return res.status(401).json({message: "Invalid credentials"});
    }

    return res.json({ user_id: user.user_id, name: user.name,email_id: user.email_id ,status: user.status });
})

//for the sign up
app.post('/signup', async (req, res) => {
    try {
        const userID = await adduser(req.body);
        console.log(req.body);
        return res.json({ user_id: user.user_id, name: user.name,email_id: user.email_id ,status: user.status });
    }
    catch (err) {
        res.status(400).json({ message: "User already exists. Please use different email" });
    }
})

//to add a new user
async function adduser(data) {//data=> {name: name, email_id: email_id, password: password, status: status}
    console.log(`select max(user_id) from alter_ego.users;`);
    const highest_user_id = 1+(await runQuery(`select max(user_id) from alter_ego.users;`))[0]['max(user_id)'];
    console.log(`Insert into alter_ego.users values(${highest_user_id},'${data.name}','${data.email_id}','${data.password}','${data.status}');`);
    await runQuery(`Insert into alter_ego.users values(${highest_user_id},'${data.name}','${data.email_id}','${data.password}','${data.status}');`);
    console.log('finished');
    return highest_user_id;
}

const httpServer = http.createServer(app);
const io = new Server(httpServer);

io.use(function (socket, next) {
    if (!socket.handshake.auth.userID) return socket.disconnect();

    socket.userID = socket.handshake.auth.userID;
    next();
})

io.on('connection', function (socket) {
    console.log('a user connected with a socket', socket.id, socket.handshake.auth);

    socket.on('disconnect', function () {
        console.log("User disconnected", socket.id);
    })

    // socket.join('user ' + socket.userID);
    // Join all DM and groups IDs
    requestDMIDs(socket).then(chatIDs => {
        chatIDs.forEach(chatID => socket.join(chatID));
    })
    requestGroupIDs(socket).then(chatIDs => {
        chatIDs.forEach(chatID => socket.join(chatID));
    });
    
    socket.on('showMyRooms', () => {
        socket.rooms.forEach(room => {
            console.log(room, typeof room);
            io.to(room).emit('what', 'ok');
            console.log(`io.to(${room}).emit('what', 'ok');`, typeof room);
        })
    })
    socket.on('request DM IDS', data => requestDMIDs(socket));
    socket.on('request Group IDS', data => requestGroupIDs(socket));
    socket.on('request DMs', data => requestDMs(socket, data));
    socket.on('request groups', data => requestGroups(socket, data));
    socket.on('request messages from chat id', data => requestMessages(socket, data));
    socket.on('request group info', data => requestGroupInfo(socket, data));
    socket.on('request group admins', data => requestGroupAdmins(socket, data));
    socket.on('request group non-admins', data => requestGroupNonAdmins(socket, data));
    socket.on('request delete chat', data => requestDeleteChat(socket, data));
    socket.on('message submit', data => submitMessage(socket, data));
    socket.on('user profile',data => requestUserProfile(socket));
})

httpServer.listen(PORT, function () {
    console.log(`Listening on port ${PORT}!`);
});

async function requestDMIDs(socket) {
    const dm_chats = await runQuery(`Select u.chats_chat_id from alter_ego.users_has_chats u,alter_ego.chats c where c.chat_type='DM'
    and u.Users_user_id=${socket.userID} and u.Chats_chat_id=c.chat_id;`);

    return dm_chats.map(row => row.chats_chat_id);
}
async function requestGroupIDs(socket) {
    const group_chats = await runQuery(`Select u.chats_chat_id from alter_ego.users_has_chats u,alter_ego.chats c where c.chat_type='GROUP'
     and u.Users_user_id=${socket.userID} and u.Chats_chat_id=c.chat_id;`);
    
    return group_chats.map(row => row.chats_chat_id);
}

function runQuery(query) {
    return new Promise((resolve, reject) => {
        db.query(query, (err, result) => {
            if (err) {
                reject(err);
            } else {
                resolve(result);
            }
        });
    })
}

async function requestUserProfile(socket) {
    const user_profile = await runQuery(`SELECT * FROM alter_ego.users WHERE user_id=${socket.userID};`);
    socket.emit('user profile', user_profile[0]);
}

async function submitMessage(socket, data) {
    console.log(data);
    io.to(parseInt(data.chatID)).emit('message', data);
    var d=new Date();
    const current_time=""+[d.getFullYear(),d.getMonth()+1,d.getDate()].join('-')+' '+[d.getHours(),d.getMinutes(),d.getSeconds()].join(':')+"";
    const msg_id= 1+ (await runQuery(`select max(msg_id) from alter_ego.messages;`))[0]['max(msg_id)'];
    console.log(msg_id);
    runQuery(`Insert into alter_ego.messages values(${msg_id},'${data.content}','${current_time}',${socket.userID},${data.chatID});`);
}   

async function requestDMs(socket) {
    const dm_chats = await runQuery(`Select u.chats_chat_id from alter_ego.users_has_chats u,alter_ego.chats c where c.chat_type='DM'
     and u.Users_user_id=${socket.userID} and u.Chats_chat_id=c.chat_id;`);
    // return console.log(chats);
    // get DMs from databse, make a chat array
    if (dm_chats.length === 0) return socket.emit('DMs', []);
    
    const query = `select a.name,u.users_user_id,u.chats_chat_id from alter_ego.users a,alter_ego.users_has_chats u where a.user_id=u.Users_user_id and u.Users_user_id!=${socket.userID} and 
    u.Chats_chat_id IN(${dm_chats.map(chat => chat.chats_chat_id).toString()});`;

    db.query(query,
        function(err,result){
            console.log(11, query);
            if(err){
                return console.error(err);
            }
            console.log(result);
            socket.emit('DMs', result);
        }
    )  
}
async function requestGroups(socket) {
    const group_chats = await runQuery(`Select u.chats_chat_id from alter_ego.users_has_chats u,alter_ego.chats c where c.chat_type='GROUP'
     and u.Users_user_id=${socket.userID} and u.Chats_chat_id=c.chat_id;`);
    
     if (group_chats.length === 0) return socket.emit('groups', []);

    db.query(`select gname,chats_chat_id,gdesc  from alter_ego.groups where 
    Chats_chat_id IN(${group_chats.map(chat => chat.chats_chat_id).toString()});`,
        function(err,result){
            if(err){
                return console.error(err);
            }
            console.log(result);
            socket.emit('groups', result);
        }
    )
}

function requestMessages(socket, chatid) {//chatid-> it is the id of the chat whose msgs i want to retrieve
    // get msgs from database and present 
    db.query(`select m.msg_id,m.content,m.create_time,m.sender_id,u.name from messages m,users u
    where m.sender_id=u.user_id and m.Chats_chat_id=${chatid} order by m.create_time;`,
        function(err,result){
            if(err){
                return console.error(err);
            }
            console.log(result);
            socket.emit('messages', result);
        }
    )
}

function requestGroupInfo(socket, groupid) {//chatid-> it is the id of the chat whose msgs i want to retrieve
    // get msgs from database and present 
    var grpinfo=[];//[gname,gdesc]
    db.query(`select gname,gdesc from alter_ego.groups where chats_chat_id=${groupid};`,
        function(err, result){
            if(err) {
                return console.error(err);
            }
            console.log(result);
            socket.emit('group info', result);
        }
    )
}

function requestGroupAdmins(socket, groupid) {//chatid-> it is the id of the chat whose msgs i want to retrieve
    // get msgs from database and present 
    var grp_admins=[];//[gname,gdesc]
    db.query(`Select u.name,p.users_user_id from alter_ego.users u,alter_ego.users_has_chats p where
    p.chats_chat_id=${groupid} and p.users_user_id=u.user_id and p.admin=1;`,
        function(err, result) {
            if(err){
                return console.error(err);
            }
            console.log(result);
            socket.emit('group admins', result);
        }
    )
}

function requestGroupNonAdmins(socket, groupid) {//chatid-> it is the id of the chat whose msgs i want to retrieve
    // get msgs from database and present 
    db.query(`Select u.name,p.users_user_id from alter_ego.users u,alter_ego.users_has_chats p where
    p.chats_chat_id=${groupid} and p.users_user_id=u.user_id and p.admin=0;`,
        function(err,result){
            if(err){
                return console.error(err);
            }
            console.log(result);
            socket.emit('group non-admins', result);
        }
    )
}

function requestDeleteChat(socket,chat_id){
    db.query(`DELETE FROM alter_ego.chats WHERE chat_id=${chat_id};`,
        function(err,result){
            if(err) {
                return console.error(err);
            }
            console.log(result);
        }
    )
}
