-- MySQL dump 10.13  Distrib 5.6.15, for osx10.7 (x86_64)
--
-- Host: localhost    Database: mp_dev
-- ------------------------------------------------------
-- Server version 5.6.15

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `accounts`
--

DROP TABLE IF EXISTS `accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `site` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `refresh_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `expires_in` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `expires_at` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `other` text COLLATE utf8_unicode_ci,
  `del` tinyint(1) DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts`
--

LOCK TABLES `accounts` WRITE;
/*!40000 ALTER TABLE `accounts` DISABLE KEYS */;
/*!40000 ALTER TABLE `accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ads`
--

DROP TABLE IF EXISTS `ads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ads` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `photo_file_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `photo_content_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `photo_file_size` int(11) DEFAULT NULL,
  `photo_updated_at` datetime DEFAULT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `desc` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `target` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `t` int(11) DEFAULT NULL,
  `s` int(11) DEFAULT NULL,
  `del` tinyint(1) DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ads`
--

LOCK TABLES `ads` WRITE;
/*!40000 ALTER TABLE `ads` DISABLE KEYS */;
/*!40000 ALTER TABLE `ads` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `albums`
--

DROP TABLE IF EXISTS `albums`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `albums` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `logo_file_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `logo_content_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `logo_file_size` int(11) DEFAULT NULL,
  `logo_updated_at` datetime DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `desc` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `publish` tinyint(1) DEFAULT '1',
  `del` tinyint(1) DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `albums`
--

LOCK TABLES `albums` WRITE;
/*!40000 ALTER TABLE `albums` DISABLE KEYS */;
INSERT INTO `albums` VALUES (1,NULL,NULL,NULL,NULL,1,'默认相册',NULL,1,0,'2014-03-09 09:03:54','2014-03-09 09:03:54'),(2,NULL,NULL,NULL,NULL,1,'活动相册',NULL,1,0,'2014-03-09 09:08:29','2014-03-09 09:08:29'),(3,NULL,NULL,NULL,NULL,2,'默认相册',NULL,1,0,'2014-03-10 08:13:01','2014-03-10 08:13:01'),(4,NULL,NULL,NULL,NULL,2,'活动相册',NULL,1,0,'2014-03-10 08:20:52','2014-03-10 08:20:52'),(5,NULL,NULL,NULL,NULL,3,'默认相册',NULL,1,0,'2014-03-13 12:09:39','2014-03-13 12:09:39');
/*!40000 ALTER TABLE `albums` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `obj_id` int(11) DEFAULT NULL,
  `obj_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `reply_id` int(11) DEFAULT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `content` text COLLATE utf8_unicode_ci,
  `del` tinyint(1) DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `events`
--

DROP TABLE IF EXISTS `events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `events` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `logo_file_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `logo_content_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `logo_file_size` int(11) DEFAULT NULL,
  `logo_updated_at` datetime DEFAULT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `desc` text COLLATE utf8_unicode_ci,
  `channel` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `end_time` date DEFAULT NULL,
  `members_count` int(11) DEFAULT '0',
  `works_count` int(11) DEFAULT '0',
  `state` int(11) DEFAULT '0',
  `totop` tinyint(1) DEFAULT '0',
  `del` tinyint(1) DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `events`
--

LOCK TABLES `events` WRITE;
/*!40000 ALTER TABLE `events` DISABLE KEYS */;
INSERT INTO `events` VALUES (1,'身边的风景',1,'c4ca4238a0.jpg','image/jpeg',659162,'2014-03-14 02:46:36','你走到过哪里','这是美的风景<br><br>这是大自然解决浮躁的良方',NULL,'2014-12-31',0,0,2,1,0,'2014-03-09 09:06:26','2014-03-14 02:46:39'),(2,'活动测试',1,'c81e728d9d.jpg','image/jpeg',93523,'2014-03-14 02:46:39','活动测试','asdfsaf asf','','2014-03-30',0,0,2,0,0,'2014-03-13 11:23:45','2014-03-14 02:46:40');
/*!40000 ALTER TABLE `events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `feedbacks`
--

DROP TABLE IF EXISTS `feedbacks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `feedbacks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `subject` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ip` int(11) DEFAULT NULL,
  `desc` text COLLATE utf8_unicode_ci,
  `del` tinyint(1) DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `feedbacks`
--

LOCK TABLES `feedbacks` WRITE;
/*!40000 ALTER TABLE `feedbacks` DISABLE KEYS */;
/*!40000 ALTER TABLE `feedbacks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `follows`
--

DROP TABLE IF EXISTS `follows`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `follows` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `follower_id` int(11) DEFAULT NULL,
  `mark` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `del` tinyint(1) DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `follows`
--

LOCK TABLES `follows` WRITE;
/*!40000 ALTER TABLE `follows` DISABLE KEYS */;
/*!40000 ALTER TABLE `follows` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `images`
--

DROP TABLE IF EXISTS `images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `images` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `event_id` int(11) DEFAULT NULL,
  `work_id` int(11) DEFAULT NULL,
  `album_id` int(11) DEFAULT NULL,
  `state` int(11) DEFAULT '0',
  `lauds_count` int(11) DEFAULT '0',
  `likes_count` int(11) DEFAULT '0',
  `stores_count` int(11) DEFAULT '0',
  `recoms_count` int(11) DEFAULT '0',
  `comments_count` int(11) DEFAULT '0',
  `warrant` int(11) DEFAULT NULL,
  `picture_file_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `picture_content_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `picture_file_size` int(11) DEFAULT NULL,
  `picture_updated_at` datetime DEFAULT NULL,
  `desc` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `exif` text COLLATE utf8_unicode_ci,
  `wh` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `del` tinyint(1) DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `images`
--

LOCK TABLES `images` WRITE;
/*!40000 ALTER TABLE `images` DISABLE KEYS */;
INSERT INTO `images` VALUES (1,'1281699100_big.jpg',1,1,1,2,1,1,0,0,0,0,5,'bc640ecb0f821b0d408a8d7bc1997976.jpg','image/jpeg',190258,'2014-03-14 04:55:12','','{\"width\":1000,\"height\":619,\"bits\":8,\"comment\":null}','250x155',0,'2014-03-09 09:07:52','2014-03-14 10:25:34'),(2,'DSC06855.JPG',2,NULL,NULL,4,1,0,0,0,0,0,5,'3a17b2790e0fb6f9a94400d70b9d81bf.JPG','image/jpeg',890844,'2014-03-14 04:55:18','TC 活动','{\"width\":1632,\"height\":1224,\"bits\":8,\"comment\":null,\"image_description\":\"\",\"make\":\"SONY\",\"model\":\"DSC-T10\",\"orientation\":1,\"x_resolution\":72.0,\"y_resolution\":72.0,\"resolution_unit\":2,\"date_time\":\"2011-10-31T09:36:31+04:00\",\"ycb_cr_positioning\":2,\"exposure_time\":0.125,\"f_number\":3.5,\"exposure_program\":2,\"iso_speed_ratings\":320,\"date_time_original\":\"2011-10-31T09:36:31+04:00\",\"date_time_digitized\":\"2011-10-31T09:36:31+04:00\",\"compressed_bits_per_pixel\":8.0,\"exposure_bias_value\":0.0,\"max_aperture_value\":3.625,\"metering_mode\":5,\"light_source\":0,\"flash\":16,\"focal_length\":7.7,\"color_space\":1,\"pixel_x_dimension\":1632,\"pixel_y_dimension\":1224,\"custom_rendered\":0,\"exposure_mode\":0,\"white_balance\":0,\"scene_capture_type\":0,\"contrast\":0,\"saturation\":0,\"sharpness\":0}','250x188',0,'2014-03-10 08:20:16','2014-03-14 10:25:35'),(3,'DSC06855.JPG',2,NULL,NULL,4,1,0,0,0,0,0,5,'aef0b17b6a4ec4c7322ba5888299f205.JPG','image/jpeg',890844,'2014-03-14 04:55:25','','{\"width\":1632,\"height\":1224,\"bits\":8,\"comment\":null,\"image_description\":\"\",\"make\":\"SONY\",\"model\":\"DSC-T10\",\"orientation\":1,\"x_resolution\":72.0,\"y_resolution\":72.0,\"resolution_unit\":2,\"date_time\":\"2011-10-31T09:36:31+04:00\",\"ycb_cr_positioning\":2,\"exposure_time\":0.125,\"f_number\":3.5,\"exposure_program\":2,\"iso_speed_ratings\":320,\"date_time_original\":\"2011-10-31T09:36:31+04:00\",\"date_time_digitized\":\"2011-10-31T09:36:31+04:00\",\"compressed_bits_per_pixel\":8.0,\"exposure_bias_value\":0.0,\"max_aperture_value\":3.625,\"metering_mode\":5,\"light_source\":0,\"flash\":16,\"focal_length\":7.7,\"color_space\":1,\"pixel_x_dimension\":1632,\"pixel_y_dimension\":1224,\"custom_rendered\":0,\"exposure_mode\":0,\"white_balance\":0,\"scene_capture_type\":0,\"contrast\":0,\"saturation\":0,\"sharpness\":0}','250x188',0,'2014-03-10 08:21:37','2014-03-14 10:25:35'),(4,'p2.jpeg',1,NULL,NULL,2,1,0,0,0,0,0,5,'1d36a482364ae497fea4d5719caf2823.jpeg','image/jpeg',29450,'2014-03-14 04:55:33','','{\"width\":236,\"height\":353,\"bits\":8,\"comment\":null}','236x353',0,'2014-03-10 08:25:25','2014-03-14 10:25:35'),(5,'1281693252_big.jpg',1,1,2,2,1,1,1,0,0,0,5,'f6064cdb992229205044f81942b54c07.jpg','image/jpeg',224849,'2014-03-14 04:55:38','如果美景','{\"width\":1000,\"height\":669,\"bits\":8,\"comment\":null}','250x167',0,'2014-03-10 08:34:47','2014-03-14 10:25:35'),(6,'1281698992_big.jpg',1,1,3,2,1,0,0,0,0,0,5,'8daea0e781b3da20f4c7e9f4615c2e0c.jpg','image/jpeg',150506,'2014-03-14 04:55:44','','{\"width\":1000,\"height\":602,\"bits\":8,\"comment\":null}','250x151',0,'2014-03-11 06:47:50','2014-03-14 10:25:35'),(7,'1.gif',1,1,4,2,1,0,0,0,0,0,5,'ee2555044379b460f3d8969bf0478c40.gif','image/gif',3648304,'2014-03-14 05:13:55','','{}','236x356',0,'2014-03-14 05:02:00','2014-03-14 10:25:35'),(8,'2.jpg',1,1,4,2,1,0,0,0,0,0,5,'2.jpg','application/octet-stream',103365,'2014-03-14 05:02:02','','{\"width\":426,\"height\":640,\"bits\":8,\"comment\":null}','250x376',0,'2014-03-14 05:02:08','2014-03-14 10:25:35'),(9,'3.jpg',1,1,4,2,1,0,0,0,0,0,5,'3.jpg','application/octet-stream',134950,'2014-03-14 05:02:10','','{\"width\":610,\"height\":891,\"bits\":8,\"comment\":null}','250x365',0,'2014-03-14 05:02:17','2014-03-14 10:25:35'),(10,'4.jpg',1,1,4,2,1,0,0,0,0,0,5,'4.jpg','application/octet-stream',226575,'2014-03-14 05:02:19','','{\"width\":498,\"height\":750,\"bits\":8,\"comment\":null}','250x377',0,'2014-03-14 05:02:25','2014-03-14 10:25:35'),(11,'5.jpg',1,1,4,2,1,0,0,0,0,0,5,'5.jpg','application/octet-stream',109975,'2014-03-14 05:02:26','','{\"width\":401,\"height\":600,\"bits\":8,\"comment\":null}','250x374',0,'2014-03-14 05:02:32','2014-03-14 10:25:35'),(12,'6.jpg',1,1,4,2,1,0,0,0,0,0,5,'6.jpg','application/octet-stream',107855,'2014-03-14 05:02:33','','{\"width\":499,\"height\":750,\"bits\":8,\"comment\":null}','250x376',0,'2014-03-14 05:02:39','2014-03-14 10:25:35'),(13,'7.jpg',1,1,4,2,1,0,0,0,0,0,5,'7.jpg','application/octet-stream',246447,'2014-03-14 05:02:41','','{\"width\":474,\"height\":720,\"bits\":8,\"comment\":null}','250x380',0,'2014-03-14 05:02:49','2014-03-14 10:25:35'),(14,'8.jpg',1,1,4,2,1,0,0,0,0,0,5,'8.jpg','application/octet-stream',188142,'2014-03-14 05:02:50','','{\"width\":466,\"height\":700,\"bits\":8,\"comment\":null}','250x376',0,'2014-03-14 05:02:57','2014-03-14 10:25:35'),(15,'9.jpg',1,1,4,2,1,0,0,0,0,0,5,'9.jpg','application/octet-stream',169167,'2014-03-14 05:02:59','','{\"width\":642,\"height\":960,\"bits\":8,\"comment\":null}','250x374',0,'2014-03-14 05:03:06','2014-03-14 10:25:35'),(16,'10.jpg',1,1,4,2,1,0,0,0,0,0,5,'10.jpg','application/octet-stream',259738,'2014-03-14 05:03:08','','{\"width\":619,\"height\":933,\"bits\":8,\"comment\":null}','250x377',0,'2014-03-14 05:03:15','2014-03-14 10:25:35'),(17,'p3.jpeg',1,1,4,2,1,0,0,0,0,0,5,'p3.jpeg','application/octet-stream',33799,'2014-03-14 05:03:16','','{\"width\":236,\"height\":355,\"bits\":8,\"comment\":null}','236x355',0,'2014-03-14 05:03:21','2014-03-14 10:25:35'),(18,'p4.jpeg',1,1,4,2,1,0,0,0,0,0,5,'p4.jpeg','application/octet-stream',36397,'2014-03-14 05:03:22','','{\"width\":236,\"height\":354,\"bits\":8,\"comment\":null}','236x354',0,'2014-03-14 05:03:27','2014-03-14 10:25:35'),(19,'p5.jpeg',1,1,4,2,1,0,0,0,0,0,5,'p5.jpeg','application/octet-stream',71674,'2014-03-14 05:03:28','','{\"width\":236,\"height\":355,\"bits\":8,\"comment\":null}','236x355',0,'2014-03-14 05:03:33','2014-03-14 10:25:35'),(20,'p7.jpeg',1,1,4,2,1,0,0,0,0,0,5,'p7.jpeg','application/octet-stream',42993,'2014-03-14 05:03:34','','{\"width\":236,\"height\":354,\"bits\":8,\"comment\":null}','236x354',0,'2014-03-14 05:03:39','2014-03-14 10:25:35'),(21,'p8.jpeg',1,1,4,2,1,0,0,0,0,0,5,'p8.jpeg','application/octet-stream',86935,'2014-03-14 05:03:41','','{\"width\":236,\"height\":591,\"bits\":8,\"comment\":null}','236x591',0,'2014-03-14 05:03:46','2014-03-14 10:25:35'),(22,'0.jpg',1,1,5,2,1,0,0,0,0,0,5,'0.jpg','application/octet-stream',115766,'2014-03-14 05:20:47','','{\"width\":460,\"height\":717,\"bits\":8,\"comment\":null}','250x390',0,'2014-03-14 05:20:53','2014-03-14 10:25:35'),(23,'1.jpg',1,1,5,2,1,0,0,0,0,0,5,'1.jpg','application/octet-stream',179455,'2014-03-14 05:20:54','','{\"width\":554,\"height\":755,\"bits\":8,\"comment\":null}','250x341',0,'2014-03-14 05:21:01','2014-03-14 10:25:35'),(24,'2.jpg',1,1,5,2,1,0,0,0,0,0,5,'2.jpg','application/octet-stream',66719,'2014-03-14 05:21:02','','{\"width\":553,\"height\":841,\"bits\":8,\"comment\":null}','250x380',0,'2014-03-14 05:21:09','2014-03-14 10:25:35'),(25,'3.jpg',1,1,5,2,1,0,0,0,0,0,5,'3.jpg','application/octet-stream',209754,'2014-03-14 05:21:12','','{\"width\":500,\"height\":750,\"bits\":8,\"comment\":null}','250x375',0,'2014-03-14 05:21:20','2014-03-14 10:25:35'),(26,'4.jpg',1,1,5,2,1,0,0,0,0,0,5,'4.jpg','application/octet-stream',155484,'2014-03-14 05:21:23','','{\"width\":427,\"height\":640,\"bits\":8,\"comment\":null}','250x375',0,'2014-03-14 05:21:30','2014-03-14 10:25:35'),(27,'5.jpg',1,1,5,2,1,0,0,0,0,0,5,'5.jpg','application/octet-stream',216365,'2014-03-14 05:21:32','','{\"width\":460,\"height\":687,\"bits\":8,\"comment\":null}','250x373',0,'2014-03-14 05:21:40','2014-03-14 10:25:35'),(28,'6.jpg',1,1,5,2,1,0,0,0,0,0,5,'6.jpg','application/octet-stream',302824,'2014-03-14 05:21:44','','{\"width\":500,\"height\":750,\"bits\":8,\"comment\":null}','250x375',0,'2014-03-14 05:21:50','2014-03-14 10:25:36'),(29,'7.jpg',1,1,5,2,1,0,0,0,0,0,5,'7.jpg','application/octet-stream',112249,'2014-03-14 05:21:53','','{\"width\":480,\"height\":613,\"bits\":8,\"comment\":null}','250x319',0,'2014-03-14 05:22:00','2014-03-14 10:25:36'),(30,'8.jpg',1,1,5,2,1,0,0,0,0,0,5,'8.jpg','application/octet-stream',137207,'2014-03-14 05:22:03','','{\"width\":467,\"height\":700,\"bits\":8,\"comment\":null}','250x375',0,'2014-03-14 05:22:10','2014-03-14 10:25:36'),(31,'9.jpg',1,1,5,2,1,0,0,0,0,0,5,'9.jpg','application/octet-stream',404133,'2014-03-14 05:22:13','','{\"width\":554,\"height\":832,\"bits\":8,\"comment\":null}','250x375',0,'2014-03-14 05:22:19','2014-03-14 10:25:36'),(32,'10.jpg',1,1,5,2,1,0,0,0,0,0,5,'10.jpg','application/octet-stream',364385,'2014-03-14 05:22:23','','{\"width\":554,\"height\":800,\"bits\":8,\"comment\":null}','250x361',0,'2014-03-14 05:22:29','2014-03-14 10:25:36'),(33,'11.jpg',1,1,5,2,1,0,0,0,0,0,5,'11.jpg','application/octet-stream',286949,'2014-03-14 05:22:32','','{\"width\":427,\"height\":640,\"bits\":8,\"comment\":null}','250x375',0,'2014-03-14 05:22:39','2014-03-14 10:25:36'),(34,'12.jpg',1,1,5,2,1,0,0,0,0,0,5,'12.jpg','application/octet-stream',213769,'2014-03-14 05:22:41','','{\"width\":467,\"height\":700,\"bits\":8,\"comment\":null}','250x375',0,'2014-03-14 05:22:48','2014-03-14 10:25:36'),(35,'13.jpg',1,1,5,2,1,0,0,0,0,0,5,'13.jpg','application/octet-stream',279253,'2014-03-14 05:22:51','','{\"width\":510,\"height\":766,\"bits\":8,\"comment\":null}','250x375',0,'2014-03-14 05:22:58','2014-03-14 10:25:36'),(36,'14.jpg',1,1,5,2,1,0,0,0,0,0,5,'14.jpg','application/octet-stream',311878,'2014-03-14 05:23:01','','{\"width\":467,\"height\":700,\"bits\":8,\"comment\":null}','250x375',0,'2014-03-14 05:23:08','2014-03-14 10:25:36'),(37,'15.jpg',1,1,5,2,1,0,0,0,0,0,5,'15.jpg','application/octet-stream',184165,'2014-03-14 05:23:11','','{\"width\":440,\"height\":638,\"bits\":8,\"comment\":null}','250x363',0,'2014-03-14 05:23:18','2014-03-14 10:25:36'),(38,'16.jpg',1,1,5,2,1,0,0,0,0,0,5,'16.jpg','application/octet-stream',167426,'2014-03-14 05:23:22','','{\"width\":528,\"height\":800,\"bits\":8,\"comment\":null}','250x379',0,'2014-03-14 05:23:29','2014-03-14 10:25:36'),(39,'17.jpg',1,1,5,2,1,0,0,0,0,0,5,'17.jpg','application/octet-stream',468843,'2014-03-14 05:23:33','','{\"width\":600,\"height\":900,\"bits\":8,\"comment\":null}','250x375',0,'2014-03-14 05:23:40','2014-03-14 10:25:36'),(40,'18.jpg',1,1,5,2,1,0,0,0,0,0,5,'18.jpg','application/octet-stream',66076,'2014-03-14 05:23:43','','{\"width\":440,\"height\":586,\"bits\":8,\"comment\":null}','250x333',0,'2014-03-14 05:23:48','2014-03-14 10:25:36'),(41,'19.jpg',1,1,5,2,1,0,0,0,0,0,5,'19.jpg','application/octet-stream',165371,'2014-03-14 05:23:51','','{\"width\":580,\"height\":446,\"bits\":8,\"comment\":null}','250x192',0,'2014-03-14 05:23:58','2014-03-14 10:25:36');
/*!40000 ALTER TABLE `images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `talk_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `content` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `del` int(11) DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `micros`
--

DROP TABLE IF EXISTS `micros`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `micros` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `text` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `source_id` int(11) DEFAULT NULL,
  `source_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `source_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `source_title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `source_text` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sourcer_id` int(11) DEFAULT NULL,
  `sourcer_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sourcer_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sourcer_title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sourcer_text` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `refer_id` int(11) DEFAULT NULL,
  `refer_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `refer_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `refer_title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `refer_text` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `referer_id` int(11) DEFAULT NULL,
  `referer_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `referer_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `referer_title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `referer_text` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `extra_id` int(11) DEFAULT NULL,
  `extra_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `extra_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `extra_title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `extra_text` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `extraer_id` int(11) DEFAULT NULL,
  `extraer_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `extraer_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `extraer_title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `extraer_text` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `del` tinyint(1) DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `micros`
--

LOCK TABLES `micros` WRITE;
/*!40000 ALTER TABLE `micros` DISABLE KEYS */;
/*!40000 ALTER TABLE `micros` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notices`
--

DROP TABLE IF EXISTS `notices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `sends_id` int(11) DEFAULT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `content` text COLLATE utf8_unicode_ci,
  `read` tinyint(1) DEFAULT NULL,
  `del` tinyint(1) DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notices`
--

LOCK TABLES `notices` WRITE;
/*!40000 ALTER TABLE `notices` DISABLE KEYS */;
/*!40000 ALTER TABLE `notices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `obj_tags`
--

DROP TABLE IF EXISTS `obj_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `obj_tags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `obj_id` int(11) DEFAULT NULL,
  `obj_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tag_id` int(11) DEFAULT NULL,
  `del` tinyint(1) DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `obj_tags`
--

LOCK TABLES `obj_tags` WRITE;
/*!40000 ALTER TABLE `obj_tags` DISABLE KEYS */;
/*!40000 ALTER TABLE `obj_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profiles`
--

DROP TABLE IF EXISTS `profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `profiles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `pmail` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `psite` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `del` tinyint(1) DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profiles`
--

LOCK TABLES `profiles` WRITE;
/*!40000 ALTER TABLE `profiles` DISABLE KEYS */;
/*!40000 ALTER TABLE `profiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pushes`
--

DROP TABLE IF EXISTS `pushes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pushes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `obj_id` int(11) DEFAULT NULL,
  `obj_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `mark` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `del` tinyint(1) DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pushes`
--

LOCK TABLES `pushes` WRITE;
/*!40000 ALTER TABLE `pushes` DISABLE KEYS */;
/*!40000 ALTER TABLE `pushes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `putins`
--

DROP TABLE IF EXISTS `putins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `putins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ad_id` int(11) DEFAULT NULL,
  `click` int(11) DEFAULT '0',
  `browser` int(11) DEFAULT '0',
  `from` varchar(255) COLLATE utf8_unicode_ci DEFAULT 'mp',
  `start_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  `state` tinyint(1) DEFAULT '0',
  `del` tinyint(1) DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `putins`
--

LOCK TABLES `putins` WRITE;
/*!40000 ALTER TABLE `putins` DISABLE KEYS */;
/*!40000 ALTER TABLE `putins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sbanners`
--

DROP TABLE IF EXISTS `sbanners`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sbanners` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `photo_file_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `photo_content_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `photo_file_size` int(11) DEFAULT NULL,
  `photo_updated_at` datetime DEFAULT NULL,
  `link` varchar(255) COLLATE utf8_unicode_ci DEFAULT 'javascript:void(0);',
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `desc` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `del` tinyint(1) DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sbanners`
--

LOCK TABLES `sbanners` WRITE;
/*!40000 ALTER TABLE `sbanners` DISABLE KEYS */;
INSERT INTO `sbanners` VALUES (1,'slide1.jpg','image/jpeg',100502,'2014-03-09 09:11:18','javascript:void(0);','','',0,'2014-03-09 09:11:18','2014-03-09 09:11:18'),(2,'slide2.jpg','image/jpeg',88924,'2014-03-09 09:11:36','javascript:void(0);','','',0,'2014-03-09 09:11:36','2014-03-09 09:11:36');
/*!40000 ALTER TABLE `sbanners` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sbgs`
--

DROP TABLE IF EXISTS `sbgs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sbgs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `photo_file_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `photo_content_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `photo_file_size` int(11) DEFAULT NULL,
  `photo_updated_at` datetime DEFAULT NULL,
  `bg` tinyint(1) DEFAULT '1',
  `del` tinyint(1) DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sbgs`
--

LOCK TABLES `sbgs` WRITE;
/*!40000 ALTER TABLE `sbgs` DISABLE KEYS */;
/*!40000 ALTER TABLE `sbgs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schema_migrations`
--

DROP TABLE IF EXISTS `schema_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schema_migrations` (
  `version` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schema_migrations`
--

LOCK TABLES `schema_migrations` WRITE;
/*!40000 ALTER TABLE `schema_migrations` DISABLE KEYS */;
INSERT INTO `schema_migrations` VALUES ('20131225140149'),('20131225140150'),('20140114064822'),('20140114070954'),('20140116091959'),('20140119074029'),('20140119075534'),('20140119075801'),('20140120145855'),('20140128085710'),('20140207085415'),('20140208085729'),('20140208085730'),('20140208085731'),('20140217060518'),('20140217073800'),('20140218035042'),('20140218035306'),('20140218035521'),('20140218035522'),('20140218035523'),('20140218050947'),('20140218051156'),('20140218051157'),('20140218051158');
/*!40000 ALTER TABLE `schema_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sends`
--

DROP TABLE IF EXISTS `sends`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sends` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `content` text COLLATE utf8_unicode_ci,
  `tag` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `target` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `del` tinyint(1) DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sends`
--

LOCK TABLES `sends` WRITE;
/*!40000 ALTER TABLE `sends` DISABLE KEYS */;
/*!40000 ALTER TABLE `sends` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `channel` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `objs_count` int(11) DEFAULT '0',
  `del` tinyint(1) DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
INSERT INTO `tags` VALUES (1,'家庭','常用',0,0,'2014-03-09 09:04:21','2014-03-09 09:04:21'),(2,'办公室','常用',0,0,'2014-03-09 09:04:21','2014-03-09 09:04:21'),(3,'创意','常用',0,0,'2014-03-09 09:04:21','2014-03-09 09:04:21'),(4,'建筑','常用',0,0,'2014-03-09 09:04:21','2014-03-09 09:04:21'),(5,'现场','常用',0,0,'2014-03-09 09:04:21','2014-03-09 09:04:21'),(6,'孩子','常用',0,0,'2014-03-09 09:04:21','2014-03-09 09:04:21'),(7,'天气','常用',0,0,'2014-03-09 09:04:21','2014-03-09 09:04:21'),(8,'校园','常用',0,0,'2014-03-09 09:04:21','2014-03-09 09:04:21'),(9,'静物','常用',0,0,'2014-03-09 09:04:21','2014-03-09 09:04:21'),(10,'黑白','常用',0,0,'2014-03-09 09:04:21','2014-03-09 09:04:21'),(11,'植物','常用',0,0,'2014-03-09 09:04:21','2014-03-09 09:04:21'),(12,'美食','常用',0,0,'2014-03-09 09:04:21','2014-03-09 09:04:21'),(13,'动物','常用',0,0,'2014-03-09 09:04:21','2014-03-09 09:04:21'),(14,'风景','常用',0,0,'2014-03-09 09:04:21','2014-03-09 09:04:21'),(15,'宠物','常用',0,0,'2014-03-09 09:04:21','2014-03-09 09:04:21'),(16,'街头','常用',0,0,'2014-03-09 09:04:21','2014-03-09 09:04:21'),(17,'旅行','常用',0,0,'2014-03-09 09:04:21','2014-03-09 09:04:21'),(18,'自拍','常用',0,0,'2014-03-09 09:04:21','2014-03-09 09:04:21'),(19,'妹子','常用',0,0,'2014-03-09 09:04:21','2014-03-09 09:04:21'),(20,'人物','常用',0,0,'2014-03-09 09:04:21','2014-03-09 09:04:21'),(21,'爱','常用',0,0,'2014-03-09 09:04:21','2014-03-09 09:04:21'),(22,'徕卡','器材',0,0,'2014-03-09 09:04:21','2014-03-09 09:04:21'),(23,'胶片','器材',0,0,'2014-03-09 09:04:21','2014-03-09 09:04:21'),(24,'奥林巴斯','器材',0,0,'2014-03-09 09:04:21','2014-03-09 09:04:21'),(25,'宾得','器材',0,0,'2014-03-09 09:04:21','2014-03-09 09:04:21'),(26,'索尼','器材',0,0,'2014-03-09 09:04:21','2014-03-09 09:04:21'),(27,'尼康','器材',0,0,'2014-03-09 09:04:21','2014-03-09 09:04:21'),(28,'佳能','器材',0,0,'2014-03-09 09:04:21','2014-03-09 09:04:21'),(29,'卡片机','器材',0,0,'2014-03-09 09:04:21','2014-03-09 09:04:21'),(30,'120','器材',0,0,'2014-03-09 09:04:21','2014-03-09 09:04:21'),(31,'中画幅','器材',0,0,'2014-03-09 09:04:21','2014-03-09 09:04:21'),(32,'数码','器材',0,0,'2014-03-09 09:04:21','2014-03-09 09:04:21'),(33,'手机','器材',0,0,'2014-03-09 09:04:21','2014-03-09 09:04:21'),(34,'iphone','器材',0,0,'2014-03-09 09:04:21','2014-03-09 09:04:21'),(35,'大光圈','器材',0,0,'2014-03-09 09:04:21','2014-03-09 09:04:21'),(36,'广角','器材',0,0,'2014-03-09 09:04:21','2014-03-09 09:04:21'),(37,'街拍','题材',0,0,'2014-03-09 09:04:21','2014-03-09 09:04:21'),(38,'建筑','题材',0,0,'2014-03-09 09:04:21','2014-03-09 09:04:21'),(39,'植物','题材',0,0,'2014-03-09 09:04:21','2014-03-09 09:04:21'),(40,'儿童','题材',0,0,'2014-03-09 09:04:21','2014-03-09 09:04:21'),(41,'自然','题材',0,0,'2014-03-09 09:04:21','2014-03-09 09:04:21'),(42,'民俗','题材',0,0,'2014-03-09 09:04:21','2014-03-09 09:04:21'),(43,'校园','题材',0,0,'2014-03-09 09:04:21','2014-03-09 09:04:21'),(44,'一条路','题材',0,0,'2014-03-09 09:04:21','2014-03-09 09:04:21'),(45,'城市','题材',0,0,'2014-03-09 09:04:21','2014-03-09 09:04:21'),(46,'旅行','题材',0,0,'2014-03-09 09:04:21','2014-03-09 09:04:21'),(47,'静物','题材',0,0,'2014-03-09 09:04:21','2014-03-09 09:04:21'),(48,'生活','题材',0,0,'2014-03-09 09:04:21','2014-03-09 09:04:21'),(49,'女生','题材',0,0,'2014-03-09 09:04:21','2014-03-09 09:04:21'),(50,'光影','题材',0,0,'2014-03-09 09:04:21','2014-03-09 09:04:21'),(51,'自拍','题材',0,0,'2014-03-09 09:04:21','2014-03-09 09:04:21'),(52,'大海','题材',0,0,'2014-03-09 09:04:21','2014-03-09 09:04:21'),(53,'公益','题材',0,0,'2014-03-09 09:04:21','2014-03-09 09:04:21'),(54,'西湖','题材',0,0,'2014-03-09 09:04:21','2014-03-09 09:04:21'),(55,'纪实','题材',0,0,'2014-03-09 09:04:21','2014-03-09 09:04:21'),(56,'风光','题材',0,0,'2014-03-09 09:04:21','2014-03-09 09:04:21'),(57,'人文','题材',0,0,'2014-03-09 09:04:21','2014-03-09 09:04:21'),(58,'人像','题材',0,0,'2014-03-09 09:04:21','2014-03-09 09:04:21'),(59,'现场','风格技巧',0,0,'2014-03-09 09:04:21','2014-03-09 09:04:21'),(60,'长曝光','风格技巧',0,0,'2014-03-09 09:04:21','2014-03-09 09:04:21'),(61,'抓拍','风格技巧',0,0,'2014-03-09 09:04:21','2014-03-09 09:04:21'),(62,'小品','风格技巧',0,0,'2014-03-09 09:04:21','2014-03-09 09:04:21'),(63,'微距','风格技巧',0,0,'2014-03-09 09:04:21','2014-03-09 09:04:21'),(64,'观念','风格技巧',0,0,'2014-03-09 09:04:21','2014-03-09 09:04:21'),(65,'lomo','风格技巧',0,0,'2014-03-09 09:04:21','2014-03-09 09:04:21'),(66,'日系','风格技巧',0,0,'2014-03-09 09:04:21','2014-03-09 09:04:21'),(67,'HDR','风格技巧',0,0,'2014-03-09 09:04:21','2014-03-09 09:04:21'),(68,'逆光','风格技巧',0,0,'2014-03-09 09:04:21','2014-03-09 09:04:21'),(69,'情绪','风格技巧',0,0,'2014-03-09 09:04:21','2014-03-09 09:04:21'),(70,'小清新','风格技巧',0,0,'2014-03-09 09:04:21','2014-03-09 09:04:21'),(71,'黑白','风格技巧',0,0,'2014-03-09 09:04:21','2014-03-09 09:04:21'),(72,'印象','风格技巧',0,0,'2014-03-09 09:04:21','2014-03-09 09:04:21'),(73,'艺术','风格技巧',0,0,'2014-03-09 09:04:21','2014-03-09 09:04:21'),(74,'复古','风格技巧',0,0,'2014-03-09 09:04:21','2014-03-09 09:04:21'),(75,'创意','风格技巧',0,0,'2014-03-09 09:04:21','2014-03-09 09:04:21'),(76,'彩色','风格技巧',0,0,'2014-03-09 09:04:21','2014-03-09 09:04:21');
/*!40000 ALTER TABLE `tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `talks`
--

DROP TABLE IF EXISTS `talks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `talks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `sender_id` int(11) DEFAULT NULL,
  `content` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `state` int(11) DEFAULT '1',
  `messages_count` int(11) DEFAULT '0',
  `del` tinyint(1) DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `talks`
--

LOCK TABLES `talks` WRITE;
/*!40000 ALTER TABLE `talks` DISABLE KEYS */;
/*!40000 ALTER TABLE `talks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `topics`
--

DROP TABLE IF EXISTS `topics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `topics` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `tag_id` int(11) DEFAULT NULL,
  `last_user_id` int(11) DEFAULT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `content` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `comments_count` int(11) DEFAULT '0',
  `del` tinyint(1) DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `topics`
--

LOCK TABLES `topics` WRITE;
/*!40000 ALTER TABLE `topics` DISABLE KEYS */;
/*!40000 ALTER TABLE `topics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tuis`
--

DROP TABLE IF EXISTS `tuis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tuis` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `obj_id` int(11) DEFAULT NULL,
  `obj_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `score` int(11) DEFAULT '0',
  `mark` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `del` tinyint(1) DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tuis`
--

LOCK TABLES `tuis` WRITE;
/*!40000 ALTER TABLE `tuis` DISABLE KEYS */;
INSERT INTO `tuis` VALUES (1,1,'Image','Tuilaud',1,0,NULL,0,'2014-03-10 06:10:19','2014-03-10 06:10:19'),(2,5,'Image','Tuilike',2,0,NULL,0,'2014-03-10 08:43:11','2014-03-10 08:43:11'),(3,5,'Image','Tuilaud',2,0,NULL,0,'2014-03-10 08:43:13','2014-03-10 08:43:13');
/*!40000 ALTER TABLE `tuis` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `username` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `nickname` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `realname` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `mobile` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `salt` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `avatar_file_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `avatar_content_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `avatar_file_size` int(11) DEFAULT NULL,
  `avatar_updated_at` datetime DEFAULT NULL,
  `province` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `city` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `site` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `resume` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `domain` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `profession` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `duty` date DEFAULT NULL,
  `gender` tinyint(1) DEFAULT NULL,
  `warrant` int(11) DEFAULT '5',
  `admin` tinyint(1) DEFAULT '0',
  `photographer` tinyint(1) DEFAULT '0',
  `talks_count` int(11) DEFAULT '0',
  `notices_count` int(11) DEFAULT '0',
  `followers_count` int(11) DEFAULT '0',
  `bg` varchar(255) COLLATE utf8_unicode_ci DEFAULT '/images/defaults/bgs.jpg',
  `repeat` varchar(255) COLLATE utf8_unicode_ci DEFAULT 'repeat',
  `remember_me` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `del` tinyint(1) DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin@shanpro.com','管理员',NULL,NULL,NULL,'9574be986128d15270f02ee203ffce18',NULL,'000e34c90192f431623917db7049a28ef7f1f26e.jpg','image/jpeg',13649,'2014-03-09 09:03:53',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,5,1,0,0,0,0,'/images/defaults/bgs.jpg','repeat',NULL,0,'2014-03-09 09:03:53','2014-03-09 09:04:47'),(2,'tianyishengshui1226@126.com','huishan1226',NULL,NULL,NULL,'c023bc0f91e5e6bb95e82c9254540433',NULL,'71cb74554036a1cd70c0180c1f9f3fcb913abc4b.jpg','image/jpeg',6908,'2014-03-10 08:12:58',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,5,0,0,0,0,0,'/images/defaults/bgs.jpg','repeat',NULL,0,'2014-03-10 08:13:01','2014-03-10 08:13:01'),(3,'xingcj@126.com','邢春江',NULL,NULL,NULL,'e10655cb0a445d47de4f4148954c4e11',NULL,'5fb47b3e48d4b4d059ff7d40b89d0b683ce6df41.jpg','image/jpeg',9501,'2014-03-13 12:09:35',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,5,0,0,0,0,0,'/images/defaults/bgs.jpg','repeat',NULL,0,'2014-03-13 12:09:39','2014-03-13 12:09:39');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `visits`
--

DROP TABLE IF EXISTS `visits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `visits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `obj_id` int(11) DEFAULT NULL,
  `obj_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `mark` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `del` tinyint(1) DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `visits`
--

LOCK TABLES `visits` WRITE;
/*!40000 ALTER TABLE `visits` DISABLE KEYS */;
/*!40000 ALTER TABLE `visits` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `works`
--

DROP TABLE IF EXISTS `works`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `works` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `cover_id` int(11) DEFAULT NULL,
  `event_id` int(11) DEFAULT NULL,
  `warrant` int(11) DEFAULT NULL,
  `winner` int(11) DEFAULT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `desc` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `images_count` int(11) DEFAULT '0',
  `del` tinyint(1) DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `works`
--

LOCK TABLES `works` WRITE;
/*!40000 ALTER TABLE `works` DISABLE KEYS */;
INSERT INTO `works` VALUES (1,1,1,1,NULL,NULL,'不知道哪里的美景，着实羡慕','在这里享受，在这里甩掉城市的浮躁',0,0,'2014-03-09 09:08:29','2014-03-09 09:08:29'),(2,1,5,1,NULL,NULL,'如果美景','如果美景如果美景',0,0,'2014-03-10 08:34:53','2014-03-10 08:34:53'),(3,1,6,1,NULL,NULL,'有太多这样的美景照片','有太多这样的美景照片，如果有幸亲自到场！！！！',0,0,'2014-03-11 06:48:19','2014-03-11 06:48:19'),(4,1,7,1,NULL,NULL,'采集一点，放到我大漫拍','采集一点，放到我大漫拍。\r\n还是很漂亮的',0,0,'2014-03-14 05:03:50','2014-03-14 05:03:50'),(5,1,22,1,NULL,NULL,'采集一点，放到我大漫拍','采集一点，放到我大漫拍采集一点，放到我大漫拍采集一点，放到我大漫拍',0,0,'2014-03-14 05:24:22','2014-03-14 05:24:22');
/*!40000 ALTER TABLE `works` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-03-15  3:08:14
