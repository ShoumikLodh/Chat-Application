const messagesList = document.getElementById('chat-msgs');

var activeChatID = null;
const groups = [];
const DMs = [];

const socket = io({
    autoConnect: false
});

function showMessage(text) {
    const message = document.createElement('li');
    messagesList.appendChild(message);
    message.textContent = text;
}

function clearMessages() {
   messagesList.innerHTML = '';
}

function submitChat(event) {
    event.preventDefault();
    const message = event.target.chatinput.value;
    event.target.chatinput.value = '';

    socket.emit('message submit', {
        name: localStorage.getItem('name'),
        chatID: activeChatID,
        content: message
    });
}

if (localStorage.getItem('user-id')) {
    socket.auth = { userID: localStorage.getItem('user-id') };
    socket.connect();
}
else {
    window.location.replace('/login.html');
}

socket.onAny((event, ...args) => {
    console.log(`got ${event}, with args:\n`, args);
});

socket.once('connect', () => {
    console.log("Connected to server");

    socket.emit('request DMs');
    socket.emit('request groups');
})

function createUserCard(user) {
    const userCard = document.createElement('div');
    userCard.className = 'chat-with';
    userCard.innerHTML = `
        <div class="person-info">
            <div class="circle"></div>
            <h3>${user.name.toUpperCase()}</h3>
        </div>
        <div class="circle" id="circle-status"></div>
    `;
    userCard.addEventListener('click', function(event) {
        socket.emit('request messages from chat id', user.chats_chat_id);
        showchat();
        activeChatID = user.chats_chat_id;
        clearMessages();
        document.getElementById('active-conversationee').innerHTML=user.name;
    })
    return userCard;
}
function userprofile(userid,email,status){
    document.getElementById('user-name').innerHTML = userid;
    document.getElementById('user-email').innerHTML = email;
    document.getElementById('user-status').innerHTML = status;
    //document.getElementById('profile-email').innerHTML = user.email;
    //document.getElementById('profile-bio').innerHTML = user.bio;
    //document.getElementById('profile-pic').src = user.profile_pic;
}

function showDMs(data) {
    const userListDOM = document.getElementById('chat-box');
    data.forEach(user => {
        userListDOM.appendChild(createUserCard(user));
    })
}

function showGroups(data) {
    const userListDOM = document.getElementById('chat-box');
    data.forEach(user => {
        userListDOM.appendChild(createGroupCard(user));
    })
}

socket.on('DMs', data => {
    DMs.length = 0;
    DMs.push(...data);
    showDMs(data)
});

socket.on('messages', data => {
    data.forEach(message => {
        showMessage(message.name + ": " + message.content);
    })
})

socket.on('message', data => {
    console.log("?");
    if (activeChatID === data.chatID) {
        showMessage(data.name + ": " + data.content);
    }
})

// for the groups of the user
function createGroupCard(group) {
    const groupCard = document.createElement('div');
    groupCard.className = 'chat-with';
    groupCard.innerHTML = `
        <div class="person-info">
            <div class="circle"></div>
            <h3>${group.gname.toUpperCase()}</h3>
        </div>
        <div class="circle" id="circle-status"></div>`;
    groupCard.addEventListener('click', function(event) {
        socket.emit('request messages from chat id', group.chats_chat_id);
        showchat();
        activeChatID = group.chats_chat_id;
        clearMessages();
        document.getElementById('active-conversationee').innerHTML = group.gname;
    })
    return groupCard;
}

socket.on('groups', data => {
    groups.length = 0;
    groups.push(...data);
});

function clearChatList() {
    const temp1 = document.getElementById('chat-box');
    temp1.innerHTML=`
        <div class="chat-type">
            <button type="button" class="chat-type-btn" onclick="switchToGroups()">Groups</button>
            <button type="button" class="chat-type-btn" onclick="switchToDMs()">Direct</button>
        </div>`
}

function switchToGroups() {
    clearChatList();
    console.log("clicked", groups);
    showGroups(groups);
}

function switchToDMs() {
    clearChatList();
    console.log("clicked", DMs);
    showDMs(DMs);
}

function showprofile() {

    document.getElementsByClassName('profile-info')[0].style = "";
    document.getElementsByClassName('chatting')[0].style = "display: none;";
    document.getElementById('group-members-info').style = "display: none;";
    document.getElementById('group-info').style = "display: none;";
    userprofile(localStorage.getItem('name'),localStorage.getItem('email_id'),localStorage.getItem('status'));
}

function showgroupmembers() {
    console.log("inside showgroupmembers");

    const targetGroup = groups.find(group => group.chats_chat_id === activeChatID)

    if (!targetGroup) return;

    document.getElementsByClassName('profile-info')[0].style = "display: none;";
    document.getElementsByClassName('chatting')[0].style = "display: none;";
    document.getElementById('group-members-info').style = "";
    document.getElementById('group-info').style = "display: none;";

    socket.emit('request group admins', activeChatID);
    socket.emit('request group non-admins', activeChatID);

    Array.from(document.getElementsByClassName("group-name-text"))
        .forEach(DOMNode => DOMNode.innerHTML = targetGroup.gname);
}

function showgroupdescription() {
    console.log("inside showgroupdescription");

    const targetGroup = groups.find(group => group.chats_chat_id === activeChatID)

    if (!targetGroup) return;

    document.getElementsByClassName('profile-info')[0].style = "display: none;";
    document.getElementsByClassName('chatting')[0].style = "display: none;";
    document.getElementById('group-members-info').style = "display: none;";
    document.getElementById('group-info').style = "";

    document.getElementById('group-info-text').innerHTML = targetGroup.gdesc;

    Array.from(document.getElementsByClassName("group-name-text"))
        .forEach(DOMNode => DOMNode.innerHTML = targetGroup.gname);
}

function showchat() {
    document.getElementsByClassName('profile-info')[0].style = "display: none;";
    document.getElementsByClassName('chatting')[0].style = "";
    document.getElementById('group-members-info').style = "display: none;";
    document.getElementById('group-info').style = "display: none;";
}

function setGroupAdminsList(admins) {
    console.log("admins", admins);
    document.getElementById('info-2').innerHTML = "";
    
    admins.forEach(admin => {
        document.getElementById('info-2').innerHTML += `
            <li><h3>${admin.name}</h3></li>
        `
    })
}

function setGroupNonAdminsList(nonAdmins) {
    document.getElementById('info-3').innerHTML = "";

    nonAdmins.forEach(nonAdmin => {
        document.getElementById('info-3').innerHTML += `
            <li><h3>${nonAdmin.name}</h3></li>
        `
    })
}

socket.on('group admins', data => setGroupAdminsList(data));
socket.on('group non-admins', data => setGroupNonAdminsList(data));