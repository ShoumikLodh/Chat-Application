CREATE DATABASE  IF NOT EXISTS `alter_ego` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `alter_ego`;
-- MySQL dump 10.13  Distrib 8.0.28, for Win64 (x86_64)
--
-- Host: deep.moe    Database: alter_ego
-- ------------------------------------------------------
-- Server version	8.0.28

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Temporary view structure for view `all_user_messages_1`
--

DROP TABLE IF EXISTS `all_user_messages_1`;
/*!50001 DROP VIEW IF EXISTS `all_user_messages_1`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `all_user_messages_1` AS SELECT 
 1 AS `users_user_id`,
 1 AS `msg_id`,
 1 AS `content`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `chats`
--

DROP TABLE IF EXISTS `chats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chats` (
  `chat_id` int NOT NULL,
  `chat_type` varchar(45) NOT NULL,
  PRIMARY KEY (`chat_id`),
  KEY `idx_chats_type` (`chat_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chats`
--

LOCK TABLES `chats` WRITE;
/*!40000 ALTER TABLE `chats` DISABLE KEYS */;
INSERT INTO `chats` VALUES (1,'DM'),(2,'DM'),(3,'DM'),(4,'DM'),(5,'DM'),(6,'DM'),(7,'DM'),(8,'DM'),(9,'DM'),(10,'DM'),(11,'DM'),(12,'DM'),(13,'DM'),(14,'DM'),(15,'DM'),(16,'DM'),(17,'DM'),(18,'DM'),(19,'DM'),(20,'DM'),(21,'DM'),(22,'DM'),(23,'DM'),(24,'DM'),(25,'DM'),(26,'DM'),(27,'DM'),(28,'DM'),(29,'DM'),(30,'DM'),(31,'DM'),(32,'DM'),(33,'DM'),(34,'DM'),(35,'DM'),(36,'DM'),(37,'DM'),(38,'DM'),(39,'DM'),(40,'DM'),(41,'GROUP'),(42,'GROUP'),(43,'GROUP'),(44,'GROUP'),(45,'GROUP'),(46,'GROUP'),(47,'GROUP'),(48,'GROUP'),(49,'GROUP'),(50,'GROUP');
/*!40000 ALTER TABLE `chats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `groups`
--

DROP TABLE IF EXISTS `groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `groups` (
  `gname` varchar(45) NOT NULL,
  `gdesc` varchar(45) DEFAULT NULL,
  `chats_chat_id` int NOT NULL,
  PRIMARY KEY (`chats_chat_id`),
  KEY `idx_groups_name` (`gname`),
  CONSTRAINT `fk_groups_chats_new` FOREIGN KEY (`chats_chat_id`) REFERENCES `chats` (`chat_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `groups`
--

LOCK TABLES `groups` WRITE;
/*!40000 ALTER TABLE `groups` DISABLE KEYS */;
INSERT INTO `groups` VALUES ('Professional B-Mobile Corporation','Beatae doloremque error. Ratione.',41),('East Space Explore Corporation','Porro soluta dolorum. Facilis.\r\n',42),('Canadian Media Co.','Et repellat unde. Error ut.\r\n',43),('International B-Mobile Group','Vero eveniet amet mollitia rerum,.',44),('American U-Mobile Group','Repellat nihil quia. Officia.\r\n',45),('International Optics Corp.','Explicabo quia eos. Excepturi quas.',46),('Australian Software Corporation','Quia sed voluptas. Ut rerum sed.',47),('Creative High-Technologies Group','Ipsa unde aut. Ex corrupti sed.\r\n',48),('WorldWide Green Power Corporation','In omnis corporis. Sunt natus esse.',49),('Federal Space Research Inc.','Rerum illo nobis. Adipisci.\r\n',50);
/*!40000 ALTER TABLE `groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `list_group_members`
--

DROP TABLE IF EXISTS `list_group_members`;
/*!50001 DROP VIEW IF EXISTS `list_group_members`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `list_group_members` AS SELECT 
 1 AS `gname`,
 1 AS `name`,
 1 AS `admin`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `messages` (
  `msg_id` int NOT NULL,
  `content` varchar(45) NOT NULL,
  `create_time` datetime NOT NULL,
  `sender_id` int NOT NULL,
  `chats_chat_id` int NOT NULL,
  PRIMARY KEY (`msg_id`,`chats_chat_id`),
  KEY `fk_Messgaes_Users_idx` (`sender_id`),
  KEY `fk_Messgaes_Chats_new` (`chats_chat_id`),
  KEY `idx_content_messages` (`content`),
  CONSTRAINT `fk_Messgaes_Chats_new` FOREIGN KEY (`chats_chat_id`) REFERENCES `chats` (`chat_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_Messgaes_Users_new` FOREIGN KEY (`sender_id`) REFERENCES `users` (`user_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
INSERT INTO `messages` VALUES (1,'Omnis et quis. Nulla laudantium.\r\n','2011-04-24 00:23:01',2,1),(2,'Totam in rerum. Sit error qui?\r\n','1972-03-31 18:58:49',3,2),(3,'Qui blanditiis nihil.\r\n','1970-01-01 01:08:43',1,3),(4,'Sit enim autem. Consequatur vel!','1970-01-01 00:01:08',5,4),(5,'Dolor aperiam dolorem. Error qui.\r\n','1976-06-06 22:07:28',1,5),(6,'Qui voluptatem temporibus. Quo!','2013-01-28 00:36:55',7,6),(7,'Iste consequuntur ab. Explicabo.','1991-08-26 10:56:17',1,7),(8,'Adipisci saepe est. Ipsa!\r\n','1976-10-14 09:07:30',1,8),(9,'Rerum sunt ut; fugit id eum.\r\n','1979-04-01 10:13:02',1,9),(10,'Sed et voluptatem. Harum quia.\r\n','1975-08-23 16:21:17',11,10),(11,'Ut qui laudantium. Mollitia qui.\r\n','1985-05-30 05:30:09',12,11),(12,'Quia magni perspiciatis. Magni!\r\n','1970-01-01 00:10:13',13,12),(13,'Voluptatem cumque non. Voluptas!','1985-07-13 16:14:07',1,13),(14,'Culpa sit reprehenderit non iste.','1978-09-20 04:54:21',1,14),(15,'Neque natus deleniti. Magnam eum.\r\n','1976-10-13 12:19:36',1,15),(16,'Dolor nisi deleniti. Qui sit.\r\n','1970-01-01 00:00:01',17,16),(17,'Illum voluptas id. Quos!\r\n','1970-08-01 16:29:49',18,17),(18,'Mollitia voluptatem ducimus.\r\n','1972-04-30 19:26:08',1,18),(19,'Nemo possimus voluptatem.\r\n','2015-02-21 10:07:23',1,19),(20,'Laborum vel debitis. Id est et.','1975-04-23 06:03:05',21,20),(21,'Incidunt laborum ut. Error.\r\n','2019-04-07 22:06:19',2,21),(22,'Error sint ut. Minus architecto!\r\n','2011-05-07 21:54:45',2,22),(23,'Qui aut accusantium. Laboriosam.','1970-01-01 00:00:09',2,23),(24,'Tempora nihil in. Aspernatur nihil?','1996-06-25 18:33:49',6,24),(25,'Sit omnis voluptas. Omnis.\r\n','2017-06-10 10:26:44',7,25),(26,'Dolorum qui dolores. Eveniet.\r\n','1991-02-12 00:33:57',8,26),(27,'Ut alias consequatur.','1970-01-01 00:01:05',9,27),(28,'Rem enim ex; vel eaque aut? Ut.\r\n','1970-01-01 00:00:03',2,28),(29,'Accusantium sed nihil. Molestiae;','1970-01-01 01:45:10',2,29),(30,'Est ut est magni a animi inventore.','1989-05-06 00:46:59',2,30),(31,'Eos quasi sed; voluptatem.','1970-01-01 00:01:38',13,31),(32,'Qui tempora vel. Mollitia.\r\n','2013-03-28 01:16:37',14,32),(33,'Dolorem praesentium rem. Qui est!\r\n','1983-08-22 11:22:52',15,33),(34,'Qui dolor illum.\r\nSapiente sequi.','2017-10-16 00:27:19',2,34),(35,'Minus eos et. Saepe dolorem.','1980-12-26 23:42:04',2,35),(36,'Eos eligendi necessitatibus;\r\n','2005-06-05 05:49:10',2,36),(37,'Quo quibusdam maxime. Iste libero.','1974-04-13 19:49:55',19,37),(38,'Quam nihil dicta. Sed vero et!','1970-01-01 01:57:04',2,38),(39,'In ut distinctio; nulla iure.\r\n','1972-01-10 21:05:50',21,39),(40,'Autem harum odit; dolores.\r\n','1970-01-01 00:36:44',2,40),(41,'Corrupti quia facilis.\r\n','2013-06-05 19:30:39',22,40),(42,'Fugiat perspiciatis animi.\r\n','1970-01-01 00:00:07',2,40),(43,'Ut nemo qui. Est aut aliquid.\r\n','2002-04-23 14:47:31',22,40),(44,'Perspiciatis eligendi et.\r\n','1970-01-01 00:09:35',22,40),(45,'Perspiciatis nobis non. Id.\r\n','1970-01-01 00:00:05',2,30),(46,'Reprehenderit molestiae autem.','1970-01-01 00:00:41',2,30),(47,'Voluptatem obcaecati dolores.\r\n','1971-10-14 18:06:07',12,30),(48,'Quibusdam debitis impedit.\r\n','1976-03-06 00:06:26',12,30),(49,'Voluptatem doloribus.\r\n','1984-12-16 20:35:38',12,30),(50,'Dolores minima temporibus.\r\n','2010-11-16 10:26:46',46,50);
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`jatin-chat`@`%`*/ /*!50003 TRIGGER `receiver_fill` AFTER INSERT ON `messages` FOR EACH ROW BEGIN
    INSERT INTO users_receive_messages(users_user_id, messages_chats_chat_id, messages_msg_id) 
    select distinct c.users_user_id, NEW.chats_chat_id, NEW.msg_id from messages, users_has_chats as c 
    where NEW.chats_chat_id = c.chats_chat_id and c.users_user_id <> NEW.sender_id;
  END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `messages_chat_1`
--

DROP TABLE IF EXISTS `messages_chat_1`;
/*!50001 DROP VIEW IF EXISTS `messages_chat_1`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `messages_chat_1` AS SELECT 
 1 AS `chats_chat_id`,
 1 AS `msg_no`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `msg_receivers`
--

DROP TABLE IF EXISTS `msg_receivers`;
/*!50001 DROP VIEW IF EXISTS `msg_receivers`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `msg_receivers` AS SELECT 
 1 AS `name`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `user_chats`
--

DROP TABLE IF EXISTS `user_chats`;
/*!50001 DROP VIEW IF EXISTS `user_chats`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `user_chats` AS SELECT 
 1 AS `chat_id`,
 1 AS `chat_type`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` int NOT NULL,
  `name` varchar(45) NOT NULL,
  `email_id` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `status` varchar(45) DEFAULT 'Hey there! I am using app.',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `e-mail_UNIQUE` (`email_id`),
  KEY `idx_name_users` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Helias ebinder','Alexia_Dobbins8@example.com','3','Quos quo rerum asperiores.'),(2,'Askanja Lindenstrauss','vnlx5987@nowhere.com','863S3L5G7','Quisquam temporibus et. Sed;\r\n'),(3,'Annea Grünbaum','Allen@example.com','1J801','Qui non quia. Assumenda!\r\n'),(4,'Markus Dötzer','Bradbury@example.com','8K4','Ut qui voluptatem.\r\nVitae quis.\r\n'),(5,'Algriet  Kugler','Marci_Peterson485@example.com','7L6','Et obcaecati itaque; maiores.\r\n'),(6,'Alesia  Delbrück','Tristan.Mcgregor65@example.com','3LFI1','Eius alias quidem. Eaque.\r\n'),(7,'Perez Taschenberg','fjfn7678@nowhere.com','10977UF','Eius perspiciatis omnis qui et.'),(8,'Adelisa  ack','Abrams@nowhere.com','85CWN90',NULL),(9,'Sigi Sievers','Arndt@example.com','1I03W','Inventore ut in. Eaque sed!'),(10,'Siegher Kramer','Burgess@example.com','T705H0T18O998','Eveniet id magnam. Consequatur.\r\n'),(11,'Ehrenfried Lerch','StefanieSpring@example.com','465KL','Omnis voluptatem dolores. Modi!'),(12,'Ottomar Wegener','WendellTalley@example.com','Y93FG','Ut et ut.\r\nVoluptatem non nemo.\r\n'),(13,'Gotlinde Maler','Demers@example.com','6EG39','Ab aperiam facere. Unde quae.\r\n'),(14,'Eva-Maria Möbius','Marin2@example.com','1H6PP5JI','Voluptatem distinctio aperiam.\r\n'),(15,'Burgmann Angst','AdelaDoran@example.com','8UOX','Quibusdam et corrupti. Facere?\r\n'),(16,'Fabius chultz','Cardwell@example.com','1GP8','Dolores totam temporibus.\r\n'),(17,'Felini Singer','Anaya@example.com','0Q1S','Minima itaque sed. Unde sit?\r\n'),(18,'Radulf Heinemann','Ferris@nowhere.com','212L','Laborum consequatur qui. Sit.\r\n'),(19,'Raginmar Gerngross','AleciaAlston97@nowhere.com','6','Voluptatum voluptatem rerum; sed.\r\n'),(20,'Elsi Knecht','Alaine.Block7@example.com','3','Exercitationem explicabo nam.\r\n'),(21,'Northild Mauch','NathanDubose@example.com','HA099J','Rem mollitia sit. Harum sapiente.\r\n'),(22,'Ennja Glauber','Brenda_Roderick35@example.com','551','Doloribus sed et. Consectetur!\r\n'),(23,'Raiko Altmann','Gustavo_Monk@example.com','05VBNKB9','Quisquam architecto voluptatem.\r\n'),(24,'Zélenya Singer','AdelaidaMorrow@nowhere.com','1F8N0V5T2M','Aut et dolorem. Eveniet non.\r\n'),(25,'Amrei Kramer','YungTerrell279@example.com','6V','Eos nostrum voluptatem. Et.\r\n'),(26,'Cyriacus Bering','Felicita.Amos@example.com','1344PI3EX6LA','Et culpa quia. Fuga reiciendis.\r\n'),(27,'Xandra chs','Moore2@example.com','E','Nam quis omnis. Perferendis.\r\n'),(28,'Godot Kleinmann','Thanh_Bullock522@example.com','R97','Natus est et. Quam est quae!\r\n'),(29,'Achime  Falkenstein','Hanks@nowhere.com','9Y3E5V','Impedit accusamus dignissimos.'),(30,'Hellmuth Gekkel','uepqajr3283@nowhere.com','T','Officiis odit vel. Voluptas...\r\n'),(31,'Burgmann Uhlig','Penni_Elrod238@example.com','EWLVOR1K','Aut unde quibusdam. Asperiores.'),(32,'Ehrhard Kaltenbrunner','Abney@nowhere.com','6QA9P5GW5','Maiores corporis sit. Sed sit.\r\n'),(33,'Nante Marschner','Benson@nowhere.com','21','Iste numquam voluptas. Ullam.\r\n'),(34,'Davi Feuchtwanger','GeoffreySmalls@nowhere.com','7L8EFC','Natus ut ipsa. Unde quisquam.\r\n'),(35,'Lirabelle flüger','amner9923@example.com','9H9K5GD9711H5','Placeat eos maxime; magnam.\r\n'),(36,'Adelisa  Borsig','Ness@example.com','V','Voluptatem eius ut. Veniam laborum.'),(37,'Adine  Kallisen','AdanMount@example.com','L1D57MW22TRK','In expedita eum. Minus quis!'),(38,'Joelline cheffer','Daigle792@example.com','41FH','Autem quaerat ut. Eos provident!\r\n'),(39,'Avera  Franke','AdamPham@example.com','6DZKNS','Et molestiae dignissimos. Quas!'),(40,'Sigumari chall','Blythe.Hahn@example.com','J34OB14836C','Ratione voluptatem vitae; quas est.'),(41,'Jochen Böhm','Naylor134@example.com','YXZ','Facilis ut ex; quaerat ullam.\r\n'),(42,'Balintt  Heine','Errol_Mckeown@example.com','JE','Architecto illo molestiae.\r\n'),(43,'Clivia Braunfels','Liliana.Timm742@example.com','0J','Incidunt itaque doloremque.\r\n'),(44,'Florien Appel','DeshawnPMayo61@nowhere.com','5F1H273PB8Z','In consequatur nisi. Sit!\r\n'),(45,'Volkbert Schweizer','Criswell@example.com','9457','Debitis sit eveniet. Esse.\r\n'),(46,'Colias Kleist','Danuta_Aguirre@example.com','B9I','Voluptates fugiat illum. Unde sed.'),(47,'Fine Gardenberg','AliceMontanez@example.com','4I12','Et commodi quia. Excepturi error.\r\n'),(48,'Dorita Hildenbrand','Acevedo@nowhere.com','J081TS63CS74P3','Neque doloremque voluptatibus.\r\n'),(49,'Dieter Krummacher','Alethia.S.Murillo@example.com','C2T3','Dolorem sit molestias. Vel harum.'),(50,'Levia Herzog','aguh325@nowhere.com','H899O1315VB4','Nostrum est corporis; nemo.'),(51,'Jatin Tyagi','undefined','hall','hall'),(52,'Jatin Tyagi','jatokin20381@iiitd.ac.in','hall','hall'),(53,'Jatin Tyagi','jatin22ed0381@iiitd.ac.in','1','cdd'),(54,'yash arodhiya','yash20415@iiitd.ac.in','123','status hi hai'),(55,'deep','abs@ac','1','cwj'),(56,'karan manoj singh','karan@abc','90','lesss go!');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_has_chats`
--

DROP TABLE IF EXISTS `users_has_chats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_has_chats` (
  `users_user_id` int NOT NULL,
  `chats_chat_id` int NOT NULL,
  `admin` tinyint NOT NULL,
  PRIMARY KEY (`users_user_id`,`chats_chat_id`),
  KEY `fk_Users_has_Chats_Chats1_idx` (`chats_chat_id`),
  KEY `fk_Users_has_Chats_Users1_idx` (`users_user_id`),
  KEY `idx_isadmin_uhc` (`admin`),
  CONSTRAINT `fk_Users_has_Chats_Chats_new` FOREIGN KEY (`chats_chat_id`) REFERENCES `chats` (`chat_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_Users_has_Chats_Users_new` FOREIGN KEY (`users_user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_has_chats`
--

LOCK TABLES `users_has_chats` WRITE;
/*!40000 ALTER TABLE `users_has_chats` DISABLE KEYS */;
INSERT INTO `users_has_chats` VALUES (1,1,0),(1,2,0),(1,3,0),(1,4,0),(1,5,0),(1,6,0),(1,7,0),(1,8,0),(1,9,0),(1,10,0),(1,11,0),(1,12,0),(1,13,0),(1,14,0),(1,15,0),(1,16,0),(1,17,0),(1,18,0),(1,19,0),(1,20,0),(2,1,0),(2,21,0),(2,22,0),(2,23,0),(2,24,0),(2,25,0),(2,26,0),(2,27,0),(2,28,0),(2,29,0),(2,30,0),(2,31,0),(2,32,0),(2,33,0),(2,34,0),(2,35,0),(2,36,0),(2,37,0),(2,38,0),(2,39,0),(2,40,0),(2,41,0),(3,2,0),(3,21,0),(3,41,0),(4,3,0),(4,22,0),(4,41,0),(5,4,0),(5,23,0),(5,41,0),(6,5,0),(6,24,0),(6,42,0),(7,6,0),(7,25,0),(8,7,0),(8,26,0),(8,42,0),(9,8,0),(9,27,0),(9,42,0),(10,9,0),(10,28,0),(10,42,0),(11,10,0),(11,29,0),(12,11,0),(12,30,0),(12,43,0),(13,12,0),(13,31,0),(13,43,0),(14,13,0),(14,32,0),(14,44,0),(15,14,0),(15,33,0),(15,43,0),(16,15,0),(16,34,0),(17,16,0),(17,35,0),(17,44,0),(18,17,0),(18,36,0),(18,44,0),(19,18,0),(19,37,0),(19,44,0),(20,19,0),(20,38,0),(20,44,0),(21,20,0),(21,39,0),(21,45,0),(22,40,0),(22,45,0),(24,45,0),(25,45,0),(26,46,0),(28,46,0),(29,46,0),(30,46,0),(31,47,0),(32,47,0),(33,47,0),(34,47,0),(37,48,0),(39,48,0),(40,48,0),(41,49,0),(42,49,0),(43,49,0),(45,49,0),(46,50,0),(48,50,0),(49,50,0),(50,50,0),(1,41,1),(7,42,1),(11,43,1),(16,44,1),(23,45,1),(27,46,1),(35,47,1),(36,48,1),(38,48,1),(44,49,1),(47,50,1);
/*!40000 ALTER TABLE `users_has_chats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_receive_messages`
--

DROP TABLE IF EXISTS `users_receive_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_receive_messages` (
  `users_user_id` int NOT NULL,
  `messages_chats_chat_id` int NOT NULL,
  `messages_msg_id` int NOT NULL,
  PRIMARY KEY (`users_user_id`,`messages_chats_chat_id`,`messages_msg_id`),
  KEY `fk_Users_has_Messgaes_Messgaes1_idx` (`messages_chats_chat_id`,`messages_msg_id`),
  KEY `fk_Users_has_Messgaes_Users1_idx` (`users_user_id`),
  KEY `_idx_rec_receive` (`messages_msg_id`,`messages_chats_chat_id`),
  CONSTRAINT `fk_Users_has_Messgaes_Messgaes_nw` FOREIGN KEY (`messages_chats_chat_id`, `messages_msg_id`) REFERENCES `messages` (`chats_chat_id`, `msg_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_Users_has_Messgaes_Users_nw` FOREIGN KEY (`users_user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_receive_messages`
--

LOCK TABLES `users_receive_messages` WRITE;
/*!40000 ALTER TABLE `users_receive_messages` DISABLE KEYS */;
INSERT INTO `users_receive_messages` VALUES (1,1,1),(1,2,2),(1,4,4),(1,6,6),(1,10,10),(1,11,11),(1,12,12),(1,16,16),(1,17,17),(1,20,20),(2,24,24),(2,25,25),(2,26,26),(2,27,27),(2,30,47),(2,30,48),(2,30,49),(2,31,31),(2,32,32),(2,33,33),(2,37,37),(2,39,39),(2,40,41),(2,40,43),(2,40,44),(3,21,21),(4,3,3),(4,22,22),(5,23,23),(6,5,5),(8,7,7),(9,8,8),(10,9,9),(10,28,28),(11,29,29),(12,30,30),(12,30,45),(12,30,46),(14,13,13),(15,14,14),(16,15,15),(16,34,34),(17,35,35),(18,36,36),(19,18,18),(20,19,19),(20,38,38),(22,40,40),(22,40,42),(47,50,50),(48,50,50),(49,50,50),(50,50,50);
/*!40000 ALTER TABLE `users_receive_messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_stars_messages`
--

DROP TABLE IF EXISTS `users_stars_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_stars_messages` (
  `users_user_id` int NOT NULL,
  `messages_chats_chat_id` int NOT NULL,
  `messages_msg_id` int NOT NULL,
  PRIMARY KEY (`users_user_id`,`messages_chats_chat_id`,`messages_msg_id`),
  KEY `fk_Users_has_Messgaes_Messgaes2_idx` (`messages_chats_chat_id`,`messages_msg_id`),
  KEY `fk_Users_has_Messgaes_Users2_idx` (`users_user_id`),
  CONSTRAINT `fk_Users_has_Messages_Users_2` FOREIGN KEY (`users_user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_Users_has_Messgaes_Messages_4` FOREIGN KEY (`messages_chats_chat_id`, `messages_msg_id`) REFERENCES `messages` (`chats_chat_id`, `msg_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_stars_messages`
--

LOCK TABLES `users_stars_messages` WRITE;
/*!40000 ALTER TABLE `users_stars_messages` DISABLE KEYS */;
INSERT INTO `users_stars_messages` VALUES (1,10,10),(1,11,11),(1,12,12),(1,16,16),(1,17,17),(1,20,20),(2,24,24),(2,25,25),(2,26,26),(2,27,27),(2,30,47),(2,30,48),(2,30,49),(2,31,31),(2,32,32),(2,33,33),(2,37,37),(2,39,39),(2,40,41),(2,40,43),(2,40,44),(3,21,21),(4,22,22),(5,23,23),(9,8,8),(10,9,9),(10,28,28),(11,29,29),(12,30,30),(12,30,45),(12,30,46),(14,13,13),(15,14,14),(16,15,15),(16,34,34),(17,35,35),(18,36,36),(19,18,18),(20,19,19),(20,38,38),(22,40,40),(22,40,42),(47,50,50);
/*!40000 ALTER TABLE `users_stars_messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'alter_ego'
--

--
-- Dumping routines for database 'alter_ego'
--

--
-- Final view structure for view `all_user_messages_1`
--

/*!50001 DROP VIEW IF EXISTS `all_user_messages_1`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jatin-chat`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `all_user_messages_1` AS select distinct `hc`.`users_user_id` AS `users_user_id`,`m`.`msg_id` AS `msg_id`,`m`.`content` AS `content` from (`users_has_chats` `hc` join `messages` `m`) where ((`m`.`chats_chat_id` = `hc`.`chats_chat_id`) and (`hc`.`users_user_id` = '1')) order by `m`.`msg_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `list_group_members`
--

/*!50001 DROP VIEW IF EXISTS `list_group_members`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jatin-chat`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `list_group_members` AS select `g`.`gname` AS `gname`,`u`.`name` AS `name`,`hc`.`admin` AS `admin` from ((`groups` `g` join `users_has_chats` `hc` on((`g`.`chats_chat_id` = `hc`.`chats_chat_id`))) join `users` `u` on((`hc`.`users_user_id` = `u`.`user_id`))) where (`g`.`gname` = 'Professional B-Mobile Corporation') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `messages_chat_1`
--

/*!50001 DROP VIEW IF EXISTS `messages_chat_1`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jatin-chat`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `messages_chat_1` AS select `messages`.`chats_chat_id` AS `chats_chat_id`,count(`messages`.`msg_id`) AS `msg_no` from `messages` group by `messages`.`chats_chat_id` having `messages`.`chats_chat_id` in (select `c`.`chat_id` from (`users_has_chats` `u` join `chats` `c` on((`u`.`chats_chat_id` = `c`.`chat_id`))) where (`u`.`users_user_id` = '1')) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `msg_receivers`
--

/*!50001 DROP VIEW IF EXISTS `msg_receivers`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jatin-chat`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `msg_receivers` AS select `u`.`name` AS `name` from (`users_receive_messages` `rm` join `users` `u` on((`u`.`user_id` = `rm`.`users_user_id`))) where (`rm`.`messages_msg_id` = 50) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `user_chats`
--

/*!50001 DROP VIEW IF EXISTS `user_chats`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jatin-chat`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `user_chats` AS select `c`.`chat_id` AS `chat_id`,`c`.`chat_type` AS `chat_type` from (`users_has_chats` `u` join `chats` `c` on((`u`.`chats_chat_id` = `c`.`chat_id`))) where (`u`.`users_user_id` = '1') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-04-29 21:23:25
