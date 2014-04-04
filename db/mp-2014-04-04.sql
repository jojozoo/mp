-- MySQL dump 10.13  Distrib 5.1.73, for debian-linux-gnu (i486)
--
-- Host: localhost    Database: mp_dev
-- ------------------------------------------------------
-- Server version	5.1.73-1

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
-- Table structure for table `accepts`
--

DROP TABLE IF EXISTS `accepts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accepts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `followd_mail` tinyint(1) DEFAULT '0',
  `recom_mail` tinyint(1) DEFAULT '0',
  `like_mail` tinyint(1) DEFAULT '0',
  `store_mail` tinyint(1) DEFAULT '0',
  `comment_mail` tinyint(1) DEFAULT '0',
  `msg_mail` tinyint(1) DEFAULT '0',
  `followd_notice` tinyint(1) DEFAULT '0',
  `recom_notice` tinyint(1) DEFAULT '0',
  `like_notice` tinyint(1) DEFAULT '0',
  `store_notice` tinyint(1) DEFAULT '0',
  `comment_notice` tinyint(1) DEFAULT '0',
  `msg_notice` tinyint(1) DEFAULT '0',
  `del` tinyint(1) DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accepts`
--

LOCK TABLES `accepts` WRITE;
/*!40000 ALTER TABLE `accepts` DISABLE KEYS */;
INSERT INTO `accepts` VALUES (1,1,0,1,0,0,0,0,0,0,0,0,0,0,0,'2014-03-16 07:31:01','2014-03-16 07:31:09'),(2,2,0,0,0,0,0,0,0,0,0,0,0,0,0,'2014-03-16 07:31:01','2014-03-16 07:31:01'),(3,3,0,0,0,0,0,0,0,0,0,0,0,0,0,'2014-03-16 07:31:01','2014-03-16 07:31:01'),(4,4,0,0,0,0,0,0,0,0,0,0,0,0,0,'2014-03-16 07:31:01','2014-03-16 07:31:01'),(5,5,0,0,0,0,0,0,0,0,0,0,0,0,0,'2014-03-17 03:52:41','2014-03-17 03:52:41'),(6,6,0,0,0,0,0,0,0,0,0,0,0,0,0,'2014-03-17 03:54:02','2014-03-17 03:54:02');
/*!40000 ALTER TABLE `accepts` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts`
--

LOCK TABLES `accounts` WRITE;
/*!40000 ALTER TABLE `accounts` DISABLE KEYS */;
INSERT INTO `accounts` VALUES (1,'1798097447',NULL,'weibo',NULL,'2.00jRdgxBLk739Dc9a72567197p_CkC',NULL,'157679999','1553676345','{\"uid\":1798097447,\"name\":\"\\u567c\\u91cc\\u556a\\u5566\\u5c0f\\u4e94\\u54e5\",\"province\":\"\\u5317\\u4eac\",\"city\":\"\\u4e1c\\u57ce\\u533a\",\"resume\":\"\\u7cbe\\u795e\\u751f\\u6d3b\\u5f88\\u91cd\\u8981\",\"domain\":\"zhu404\",\"gender\":true,\"site\":\"http://www.zhuxiaowu.com\",\"avatar\":\"http://tp4.sinaimg.cn/1798097447/50/5627521723/1\",\"other\":{\"id\":1798097447,\"idstr\":\"1798097447\",\"class\":1,\"screen_name\":\"\\u567c\\u91cc\\u556a\\u5566\\u5c0f\\u4e94\\u54e5\",\"name\":\"\\u567c\\u91cc\\u556a\\u5566\\u5c0f\\u4e94\\u54e5\",\"province\":\"11\",\"city\":\"1\",\"location\":\"\\u5317\\u4eac \\u4e1c\\u57ce\\u533a\",\"description\":\"\\u7cbe\\u795e\\u751f\\u6d3b\\u5f88\\u91cd\\u8981\",\"url\":\"http://www.zhuxiaowu.com\",\"profile_image_url\":\"http://tp4.sinaimg.cn/1798097447/50/5627521723/1\",\"profile_url\":\"zhu404\",\"domain\":\"zhu404\",\"weihao\":\"\",\"gender\":\"m\",\"followers_count\":335,\"friends_count\":238,\"statuses_count\":1419,\"favourites_count\":16,\"created_at\":\"Thu Aug 19 11:16:55 +0800 2010\",\"following\":false,\"allow_all_act_msg\":false,\"geo_enabled\":true,\"verified\":true,\"verified_type\":0,\"remark\":\"\",\"status\":{\"created_at\":\"Fri Jul 19 18:28:04 +0800 2013\",\"id\":3601842711703284,\"mid\":\"3601842711703284\",\"idstr\":\"3601842711703284\",\"text\":\"...//@\\u738b\\u82e5\\u611a_MaxWong: ......//@\\u6f58\\u5c0f\\u5b87\\u540c\\u5b66: @\\u6d77\\u9614and\\u5929\\u7a7a\\u7a7a \\u5f15\\u4ee5\\u4e3a\\u6212\\u554a\\uff5e\",\"source\":\"<a href=\\\"http://weibo.com/\\\" rel=\\\"nofollow\\\">\\u65b0\\u6d6a\\u5fae\\u535a</a>\",\"favorited\":false,\"truncated\":false,\"in_reply_to_status_id\":\"\",\"in_reply_to_user_id\":\"\",\"in_reply_to_screen_name\":\"\",\"pic_urls\":[],\"geo\":null,\"reposts_count\":0,\"comments_count\":0,\"attitudes_count\":0,\"mlevel\":0,\"visible\":{\"type\":0,\"list_id\":0}},\"ptype\":0,\"allow_all_comment\":true,\"avatar_large\":\"http://tp4.sinaimg.cn/1798097447/180/5627521723/1\",\"avatar_hd\":\"http://tp4.sinaimg.cn/1798097447/180/5627521723/1\",\"verified_reason\":\"\\u5929\\u9645\\u7f51Ruby\\u5de5\\u7a0b\\u5e08\\u6731\\u6653\\u6b66\",\"follow_me\":false,\"online_status\":0,\"bi_followers_count\":133,\"lang\":\"zh-cn\",\"star\":0,\"mbtype\":0,\"mbrank\":0,\"block_word\":0,\"block_app\":0}}',0,'2014-03-28 08:45:46','2014-03-28 08:45:46');
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `albums`
--

LOCK TABLES `albums` WRITE;
/*!40000 ALTER TABLE `albums` DISABLE KEYS */;
INSERT INTO `albums` VALUES (1,NULL,NULL,NULL,NULL,1,'默认相册',NULL,1,0,'2014-03-09 09:03:54','2014-03-09 09:03:54'),(2,NULL,NULL,NULL,NULL,1,'活动相册',NULL,1,0,'2014-03-09 09:08:29','2014-03-09 09:08:29'),(3,NULL,NULL,NULL,NULL,2,'默认相册',NULL,1,0,'2014-03-10 08:13:01','2014-03-10 08:13:01'),(4,NULL,NULL,NULL,NULL,2,'活动相册',NULL,1,0,'2014-03-10 08:20:52','2014-03-10 08:20:52'),(5,NULL,NULL,NULL,NULL,3,'默认相册',NULL,1,0,'2014-03-13 12:09:39','2014-03-13 12:09:39'),(6,NULL,NULL,NULL,NULL,4,'默认相册',NULL,1,0,'2014-03-15 07:45:57','2014-03-15 07:45:57'),(7,NULL,NULL,NULL,NULL,5,'默认相册',NULL,1,0,'2014-03-17 03:52:41','2014-03-17 03:52:41'),(8,NULL,NULL,NULL,NULL,6,'默认相册',NULL,1,0,'2014-03-17 03:54:02','2014-03-17 03:54:02'),(9,NULL,NULL,NULL,NULL,4,'活动相册',NULL,1,0,'2014-04-02 02:19:30','2014-04-02 02:19:30'),(10,NULL,NULL,NULL,NULL,1,'ss','sd',1,0,'2014-04-03 02:13:49','2014-04-03 02:13:49');
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
INSERT INTO `comments` VALUES (1,2,'Topic',4,NULL,NULL,'还是不错的嘛',0,'2014-03-15 07:46:16','2014-03-15 07:46:16'),(2,4,'Topic',1,NULL,NULL,'sdfsadfsaf',0,'2014-04-03 02:11:42','2014-04-03 02:11:42'),(3,4,'Topic',1,NULL,NULL,'sdfsdfsdf',0,'2014-04-03 02:11:47','2014-04-03 02:11:47');
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
  `images_count` int(11) DEFAULT '0',
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
INSERT INTO `events` VALUES (1,'身边的风景',1,'c4ca4238a0.jpg','image/jpeg',659162,'2014-03-14 02:46:36','你走到过哪里','这是美的风景<br><br>这是大自然解决浮躁的良方',NULL,'2014-12-31',2,6,39,2,1,0,'2014-03-09 09:06:26','2014-04-02 02:19:30'),(2,'活动测试',1,'c81e728d9d.jpg','image/jpeg',93523,'2014-03-14 02:46:39','活动测试','asdfsaf asf','','2014-03-30',0,0,0,2,1,0,'2014-03-13 11:23:45','2014-04-02 04:51:27');
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
  `state` tinyint(1) DEFAULT '0',
  `likes_count` int(11) DEFAULT '0',
  `stores_count` int(11) DEFAULT '0',
  `recoms_count` int(11) DEFAULT '0',
  `comments_count` int(11) DEFAULT '0',
  `warrant` int(11) DEFAULT NULL,
  `picture_file_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `picture_content_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `picture_file_size` int(11) DEFAULT NULL,
  `picture_updated_at` datetime DEFAULT NULL,
  `hex` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `randomhex` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `desc` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `exif` text COLLATE utf8_unicode_ci,
  `wh` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `del` tinyint(1) DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `images`
--

LOCK TABLES `images` WRITE;
/*!40000 ALTER TABLE `images` DISABLE KEYS */;
INSERT INTO `images` VALUES (1,'1281699100_big.jpg',1,1,1,2,1,0,0,0,0,5,'bc640ecb0f821b0d408a8d7bc1997976.jpg','image/jpeg',190258,'2014-03-19 17:12:15','e0cd62f23533','XzAGlyVuHKadCFcjZxJmpOEgkWiUIo','','{\"width\":1000,\"height\":619,\"bits\":8,\"comment\":null}','250x155',0,'2014-03-09 09:07:52','2014-04-03 05:06:58'),(2,'DSC06855.JPG',2,NULL,NULL,4,1,0,0,0,0,5,'3a17b2790e0fb6f9a94400d70b9d81bf.JPG','image/jpeg',890844,'2014-03-19 17:12:24','341866e3ae39','tTFyNOABuDsLzpglmGRdrocQSniehW','TC 活动','{\"width\":1632,\"height\":1224,\"bits\":8,\"comment\":null,\"image_description\":\"\",\"make\":\"SONY\",\"model\":\"DSC-T10\",\"orientation\":1,\"x_resolution\":72.0,\"y_resolution\":72.0,\"resolution_unit\":2,\"date_time\":\"2011-10-31T09:36:31+04:00\",\"ycb_cr_positioning\":2,\"exposure_time\":0.125,\"f_number\":3.5,\"exposure_program\":2,\"iso_speed_ratings\":320,\"date_time_original\":\"2011-10-31T09:36:31+04:00\",\"date_time_digitized\":\"2011-10-31T09:36:31+04:00\",\"compressed_bits_per_pixel\":8.0,\"exposure_bias_value\":0.0,\"max_aperture_value\":3.625,\"metering_mode\":5,\"light_source\":0,\"flash\":16,\"focal_length\":7.7,\"color_space\":1,\"pixel_x_dimension\":1632,\"pixel_y_dimension\":1224,\"custom_rendered\":0,\"exposure_mode\":0,\"white_balance\":0,\"scene_capture_type\":0,\"contrast\":0,\"saturation\":0,\"sharpness\":0}','250x188',0,'2014-03-10 08:20:16','2014-04-03 05:06:58'),(3,'DSC06855.JPG',2,NULL,NULL,4,1,0,0,0,0,5,'aef0b17b6a4ec4c7322ba5888299f205.JPG','image/jpeg',890844,'2014-03-19 17:12:32','cedb1bef52b9','JWUFNzTHxyAslCiSrIBgaLYQfRdjwV','','{\"width\":1632,\"height\":1224,\"bits\":8,\"comment\":null,\"image_description\":\"\",\"make\":\"SONY\",\"model\":\"DSC-T10\",\"orientation\":1,\"x_resolution\":72.0,\"y_resolution\":72.0,\"resolution_unit\":2,\"date_time\":\"2011-10-31T09:36:31+04:00\",\"ycb_cr_positioning\":2,\"exposure_time\":0.125,\"f_number\":3.5,\"exposure_program\":2,\"iso_speed_ratings\":320,\"date_time_original\":\"2011-10-31T09:36:31+04:00\",\"date_time_digitized\":\"2011-10-31T09:36:31+04:00\",\"compressed_bits_per_pixel\":8.0,\"exposure_bias_value\":0.0,\"max_aperture_value\":3.625,\"metering_mode\":5,\"light_source\":0,\"flash\":16,\"focal_length\":7.7,\"color_space\":1,\"pixel_x_dimension\":1632,\"pixel_y_dimension\":1224,\"custom_rendered\":0,\"exposure_mode\":0,\"white_balance\":0,\"scene_capture_type\":0,\"contrast\":0,\"saturation\":0,\"sharpness\":0}','250x188',0,'2014-03-10 08:21:37','2014-04-03 05:06:58'),(4,'p2.jpeg',1,NULL,NULL,2,1,0,0,0,0,5,'1d36a482364ae497fea4d5719caf2823.jpeg','image/jpeg',29450,'2014-03-19 17:12:41','72c2eaa2226a','BpdTqOjwAuHrkCSxGiIXNfJhtnsWeL','','{\"width\":236,\"height\":353,\"bits\":8,\"comment\":null}','236x353',0,'2014-03-10 08:25:25','2014-04-03 05:06:58'),(5,'1281693252_big.jpg',1,1,2,2,1,1,0,0,0,5,'f6064cdb992229205044f81942b54c07.jpg','image/jpeg',224849,'2014-03-19 17:12:47','b3166bc2b53d','VabXdNjHLZSvQfClUOFqrwetscGJpn','如果美景','{\"width\":1000,\"height\":669,\"bits\":8,\"comment\":null}','250x167',0,'2014-03-10 08:34:47','2014-04-03 05:06:58'),(6,'1281698992_big.jpg',1,1,3,2,1,0,0,0,0,5,'8daea0e781b3da20f4c7e9f4615c2e0c.jpg','image/jpeg',150506,'2014-03-19 17:12:54','ab789a06f88b','hYLJFZlACvirIjTdkBWzpHtRgoMabS','','{\"width\":1000,\"height\":602,\"bits\":8,\"comment\":null}','250x151',0,'2014-03-11 06:47:50','2014-04-03 05:06:58'),(7,'1.gif',1,1,4,2,1,0,0,0,0,5,'ee2555044379b460f3d8969bf0478c40.gif','image/gif',3648304,'2014-03-19 17:13:03','7f4222298332','KIiBuSsFkrlXEaUGPHTMyLQwdVnptJ','','{}','236x356',0,'2014-03-14 05:02:00','2014-04-03 05:06:58'),(8,'2.jpg',1,1,4,2,1,0,0,0,0,5,'0f08e6246eb3cd929f624259d3a2346a.jpg','image/jpeg',103365,'2014-03-19 17:13:24','f16c39589059','DYQzmGpExfqsZwvRdXcaCKgrnNJIMW','','{\"width\":426,\"height\":640,\"bits\":8,\"comment\":null}','250x376',0,'2014-03-14 05:02:08','2014-04-03 05:06:58'),(9,'3.jpg',1,1,4,2,1,0,0,0,0,5,'dcca313264e5d5cb0c30ad8c208101ce.jpg','image/jpeg',134950,'2014-03-19 17:13:31','3341d8f49100','elhyuKjXIZNcPvRnSJkgpMQDOqULwd','','{\"width\":610,\"height\":891,\"bits\":8,\"comment\":null}','250x365',0,'2014-03-14 05:02:17','2014-04-03 05:06:58'),(10,'4.jpg',1,1,4,2,1,0,0,0,0,5,'a4d7a6aa075a8562d1bd088445c3c56f.jpg','image/jpeg',226575,'2014-03-19 17:13:37','ae9a0ed4999a','HiGDTngSlIVpcvrEzhwLNmCtMaBYsO','','{\"width\":498,\"height\":750,\"bits\":8,\"comment\":null}','250x377',0,'2014-03-14 05:02:25','2014-04-03 05:06:58'),(11,'5.jpg',1,1,4,2,1,0,0,0,0,5,'3369d48452434ddd8ebebb1cc9857a2d.jpg','image/jpeg',109975,'2014-03-19 17:13:44','5c49d7b1bad7','mCzXsIuOTatjwxBrvAKyMVcgqSDbQf','','{\"width\":401,\"height\":600,\"bits\":8,\"comment\":null}','250x374',0,'2014-03-14 05:02:32','2014-04-03 05:06:58'),(12,'6.jpg',1,1,4,2,1,0,0,0,0,5,'053836b9746691bf8189832e9de54a07.jpg','image/jpeg',107855,'2014-03-19 17:13:50','4e9c90a18117','alWTOYJvbIVdcxhiDegSQtFpXwjAks','','{\"width\":499,\"height\":750,\"bits\":8,\"comment\":null}','250x376',0,'2014-03-14 05:02:39','2014-04-03 05:06:58'),(13,'7.jpg',1,1,4,2,1,0,0,0,0,5,'7f2f6503868b33158a77d657a5106162.jpg','image/jpeg',246447,'2014-03-19 17:13:57','09196e91bbeb','jSQIdbiDWGJCpelgynfOYBhaMFkTvx','','{\"width\":474,\"height\":720,\"bits\":8,\"comment\":null}','250x380',0,'2014-03-14 05:02:49','2014-04-03 05:06:58'),(14,'8.jpg',1,1,4,2,1,0,0,0,0,5,'c467f8b24992c09b4ba302d23f347145.jpg','image/jpeg',188142,'2014-03-19 17:14:06','9d49eb3d296a','GCTbiSDkQwlOdWfRcqrFyjELnxsKBN','','{\"width\":466,\"height\":700,\"bits\":8,\"comment\":null}','250x376',0,'2014-03-14 05:02:57','2014-04-03 05:06:58'),(15,'9.jpg',1,1,4,2,1,0,0,0,0,5,'94091f155392e18e66b74415b06f0d0f.jpg','image/jpeg',169167,'2014-03-19 17:14:14','763c64219e7d','iWUsSDoPhXZycIzNCAeYndRkjvpHrw','','{\"width\":642,\"height\":960,\"bits\":8,\"comment\":null}','250x374',0,'2014-03-14 05:03:06','2014-04-03 05:06:58'),(16,'10.jpg',1,1,4,2,1,0,0,0,0,5,'89d5636b1b5133c3ed46407ecde565e1.jpg','image/jpeg',259738,'2014-03-19 17:14:21','5bf3da907b51','GYvepEdZMsQLSfXkgDnlmjcRVuCFWU','','{\"width\":619,\"height\":933,\"bits\":8,\"comment\":null}','250x377',0,'2014-03-14 05:03:15','2014-04-03 05:06:58'),(17,'p3.jpeg',1,1,4,2,1,0,0,0,0,5,'9a6bf38f7d0d2305f13a7abe0dc64302.jpeg','image/jpeg',33799,'2014-03-19 17:14:28','eaa923430e06','KTrfQDVNputhgdIWsUvHbAnjGSROZM','','{\"width\":236,\"height\":355,\"bits\":8,\"comment\":null}','236x355',0,'2014-03-14 05:03:21','2014-04-03 05:06:58'),(18,'p4.jpeg',1,1,4,2,1,0,0,0,0,5,'ae457ffa3fa69433d4a5b51919e43302.jpeg','image/jpeg',36397,'2014-03-19 17:14:33','8604d1aba7fd','msnthOwcJfFvDSprYekWAqgxLQRuTX','','{\"width\":236,\"height\":354,\"bits\":8,\"comment\":null}','236x354',0,'2014-03-14 05:03:27','2014-04-03 05:06:58'),(19,'p5.jpeg',1,1,4,2,1,0,0,0,0,5,'06439179514383e0483cebd3925f9d71.jpeg','image/jpeg',71674,'2014-03-19 17:14:39','91eea4e48738','hvBFdSytAMTgYZpCxjGXzsHuOPbiVc','','{\"width\":236,\"height\":355,\"bits\":8,\"comment\":null}','236x355',0,'2014-03-14 05:03:33','2014-04-03 05:06:58'),(20,'p7.jpeg',1,1,4,2,1,0,0,0,0,5,'aa10bbffbb6decfa1743a21b8cde45c2.jpeg','image/jpeg',42993,'2014-03-19 17:14:46','afa9b53f30ca','YEFjLMXoRylwrhfuBixWtcQGAzSanK','','{\"width\":236,\"height\":354,\"bits\":8,\"comment\":null}','236x354',0,'2014-03-14 05:03:39','2014-04-03 05:06:58'),(21,'p8.jpeg',1,1,4,2,1,0,0,0,0,5,'f4b4ce046881b31934d5f7c058c55917.jpeg','image/jpeg',86935,'2014-03-19 17:14:51','a5120db87470','GmxfUhEgJAOndkrKlzBwRHpeMtjLQo','','{\"width\":236,\"height\":591,\"bits\":8,\"comment\":null}','236x591',0,'2014-03-14 05:03:46','2014-04-03 05:06:58'),(22,'0.jpg',1,1,5,2,1,0,0,0,0,5,'af8f31a7012424889722261be47abb77.jpg','image/jpeg',115766,'2014-03-19 17:14:56','87b118ebce86','EINAqCelykncBwhOTSGMZQYabofWrR','','{\"width\":460,\"height\":717,\"bits\":8,\"comment\":null}','250x390',0,'2014-03-14 05:20:53','2014-04-03 05:06:58'),(23,'1.jpg',1,1,5,2,1,0,0,0,0,5,'00a836277eb5edfd9a77821ec6de2218.jpg','image/jpeg',179455,'2014-03-19 17:15:04','2a4227dcbb95','XaGHIdsQyzVqxeZYvFCbSEPluwLkAM','','{\"width\":554,\"height\":755,\"bits\":8,\"comment\":null}','250x341',0,'2014-03-14 05:21:01','2014-04-03 05:06:58'),(24,'2.jpg',1,1,5,2,1,0,0,0,0,5,'a1216ced3fd3227d51e88bf8fcb8aff4.jpg','image/jpeg',66719,'2014-03-19 17:15:12','c8e34f4cebbb','QWprMdaXDxejRLoIfOkYclHvSZsUJm','','{\"width\":553,\"height\":841,\"bits\":8,\"comment\":null}','250x380',0,'2014-03-14 05:21:09','2014-04-03 05:06:58'),(25,'3.jpg',1,1,5,2,1,0,0,0,0,5,'a74527fca29bc36fe524cb8d370f1d5a.jpg','image/jpeg',209754,'2014-03-19 17:15:18','14b5302f854a','qejyUhvKsdGlOicbfEAWPaTBSxLwtQ','','{\"width\":500,\"height\":750,\"bits\":8,\"comment\":null}','250x375',0,'2014-03-14 05:21:20','2014-04-03 05:06:58'),(26,'4.jpg',1,1,5,2,1,0,0,0,0,5,'391bcabb60828827b4595ebd8d89eded.jpg','image/jpeg',155484,'2014-03-19 17:15:26','6419dbe3a8ff','UgeusExXoFbaNmWpPqldnOyMGSRZYV','','{\"width\":427,\"height\":640,\"bits\":8,\"comment\":null}','250x375',0,'2014-03-14 05:21:30','2014-04-03 05:06:58'),(27,'5.jpg',1,1,5,2,1,0,0,0,0,5,'9df6f5e842fd16585b8719b7ba5b813a.jpg','image/jpeg',216365,'2014-03-19 17:15:34','ba6b210f8ad5','eHGJgvWNIMSyAnXuaRQCLtTcUlxhsk','','{\"width\":460,\"height\":687,\"bits\":8,\"comment\":null}','250x373',0,'2014-03-14 05:21:40','2014-04-03 05:06:58'),(28,'6.jpg',1,1,5,2,1,0,0,0,0,5,'a713062acbea7aff5c78ca23bde95bb3.jpg','image/jpeg',302824,'2014-03-19 17:15:40','acb5b8765148','vQpkqbxHhsgReDAZVNjfMIJWTrEiCO','','{\"width\":500,\"height\":750,\"bits\":8,\"comment\":null}','250x375',0,'2014-03-14 05:21:50','2014-04-03 05:06:58'),(29,'7.jpg',1,1,5,2,1,0,0,0,0,5,'f9a45676a2f05b3d1142c552bc274d11.jpg','image/jpeg',112249,'2014-03-19 17:15:47','3ed56dcb2371','hriMxLAWumeoRvtlXYafUsQGSdJjTy','','{\"width\":480,\"height\":613,\"bits\":8,\"comment\":null}','250x319',0,'2014-03-14 05:22:00','2014-04-03 05:06:58'),(30,'8.jpg',1,1,5,2,1,0,0,0,0,5,'65f51e46e4d86a4e400cb4135d7ab5d4.jpg','image/jpeg',137207,'2014-03-19 17:15:54','ee86e7f5da09','swhXCpxobqkzWaPNUQOMgRAZdlFifK','','{\"width\":467,\"height\":700,\"bits\":8,\"comment\":null}','250x375',0,'2014-03-14 05:22:10','2014-04-03 05:06:58'),(31,'9.jpg',1,1,5,2,1,0,0,0,0,5,'2d214930fd88ba0267be96c625160578.jpg','image/jpeg',404133,'2014-03-19 17:16:01','7f9eb51ed9c2','bfTGPvSELsAXeuwWFxjBcrZIgKpaHR','','{\"width\":554,\"height\":832,\"bits\":8,\"comment\":null}','250x375',0,'2014-03-14 05:22:19','2014-04-03 05:06:58'),(32,'10.jpg',1,1,5,2,1,0,0,0,0,5,'5d73051e7acf333cf6865e7c027c1f33.jpg','image/jpeg',364385,'2014-03-19 17:16:08','e09e9ef10bb8','tlFVpxNKegmRjAHbkXwazPoGIQTiWE','','{\"width\":554,\"height\":800,\"bits\":8,\"comment\":null}','250x361',0,'2014-03-14 05:22:29','2014-04-03 05:06:58'),(33,'11.jpg',1,1,5,2,1,0,0,0,0,5,'0cbc458805b31cb0871271340eb09e33.jpg','image/jpeg',286949,'2014-03-19 17:16:15','1fb0e72f6cc6','vxZsUKQXAeNrWPkLMRIlOEyHcFBwnf','','{\"width\":427,\"height\":640,\"bits\":8,\"comment\":null}','250x375',0,'2014-03-14 05:22:39','2014-04-03 05:06:58'),(34,'12.jpg',1,1,5,2,1,0,0,0,0,5,'f62976580d8c2ec869909ba74897670a.jpg','image/jpeg',213769,'2014-03-19 17:16:22','520618ba5118','CeXfTmzRrJdjENLAnvsUyutDhPZKQF','','{\"width\":467,\"height\":700,\"bits\":8,\"comment\":null}','250x375',0,'2014-03-14 05:22:48','2014-04-03 05:06:58'),(35,'13.jpg',1,1,5,2,1,0,0,0,0,5,'b9fa9add97a90dcd5244d84b8761717f.jpg','image/jpeg',279253,'2014-03-19 17:16:31','9346663d79c8','dpqwDgjUuELoXVictSHReaKIbJnFyW','','{\"width\":510,\"height\":766,\"bits\":8,\"comment\":null}','250x375',0,'2014-03-14 05:22:58','2014-04-03 05:06:58'),(36,'14.jpg',1,1,5,2,1,0,0,0,0,5,'26430f958167bf8f902f43f08ca2eb50.jpg','image/jpeg',311878,'2014-03-19 17:16:38','28ed53486b8d','rHuaFqvwgcKJOWXZpoMhPYNUTBGIix','','{\"width\":467,\"height\":700,\"bits\":8,\"comment\":null}','250x375',0,'2014-03-14 05:23:08','2014-04-03 05:06:58'),(37,'15.jpg',1,1,5,2,1,0,0,0,0,5,'4901e9d69e772233d075bcf97f265d66.jpg','image/jpeg',184165,'2014-03-19 17:16:46','cb0e2aa819e4','nirbwHdpDfMIWKjTZVSCgkALxGXYah','','{\"width\":440,\"height\":638,\"bits\":8,\"comment\":null}','250x363',0,'2014-03-14 05:23:18','2014-04-03 05:06:58'),(38,'16.jpg',1,1,5,2,1,0,0,0,0,5,'5c207cac3bd8cf95a8cd8d02f4816f13.jpg','image/jpeg',167426,'2014-03-19 17:16:54','5a27952a3f27','SgnfLvWJcoHrayeRBOqsFuKNpZblGh','','{\"width\":528,\"height\":800,\"bits\":8,\"comment\":null}','250x379',0,'2014-03-14 05:23:29','2014-04-03 05:06:58'),(39,'17.jpg',1,1,5,2,1,0,0,0,0,5,'15b894fca7838753f69109936d99317f.jpg','image/jpeg',468843,'2014-03-19 17:17:01','12ca93166342','GmSJnUVkzfljZoIcdypFDtiQAxbhTr','','{\"width\":600,\"height\":900,\"bits\":8,\"comment\":null}','250x375',0,'2014-03-14 05:23:40','2014-04-03 05:06:58'),(40,'18.jpg',1,1,5,2,1,0,0,0,0,5,'0a4ef8a82bfcea054da8e70f3c30cda0.jpg','image/jpeg',66076,'2014-03-19 17:17:07','6a2fa9cf5662','lyfjaCShvKZBgrJbXATkFiuYIpGcds','','{\"width\":440,\"height\":586,\"bits\":8,\"comment\":null}','250x333',0,'2014-03-14 05:23:48','2014-04-03 05:06:58'),(41,'19.jpg',1,1,5,2,1,0,0,0,0,5,'72999afc8c82869d0a7d141d4f50933a.jpg','image/jpeg',165371,'2014-03-19 17:17:14','ab6d033a1288','uGMsLcJjhglIZKOToRVXYebpHWUwCx','','{\"width\":580,\"height\":446,\"bits\":8,\"comment\":null}','250x192',0,'2014-03-14 05:23:58','2014-04-03 05:06:58'),(42,'1281698951_big.jpg',4,1,6,9,1,0,0,1,0,5,'1281698951_big.jpg','application/octet-stream',125845,'2014-04-02 02:19:00','ce6c918ea4ea','rIyqlKVwzeHjJgBkGvpLtNZYFWOsTi',NULL,'{\"width\":1000,\"height\":569,\"bits\":8,\"comment\":null}','250x142',0,'2014-04-02 02:19:07','2014-04-03 05:06:58'),(43,'1.JPG',1,1,1,1,1,0,0,0,0,NULL,'1.JPG','application/octet-stream',53556,'2014-04-03 02:08:48','3fcde20f5b63','OPQtWjEcAwvCiHeIuGyMnFpsUSDoBL',NULL,'{\"width\":640,\"height\":480,\"bits\":8,\"comment\":null}','250x188',0,'2014-04-03 02:08:54','2014-04-03 05:06:58'),(44,'avatar.png',1,1,1,1,1,0,0,0,0,NULL,'avatar.png','application/octet-stream',587786,'2014-04-03 04:06:57','6bc608f4e124','WEroNmtbBOYPSqMHZKeiDjAnJVwluG',NULL,'{}','250x277',0,'2014-04-03 04:07:05','2014-04-03 07:12:33');
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
  `sender_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `talk` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `state` int(11) DEFAULT '0',
  `s_is_del` int(11) DEFAULT '0',
  `u_is_del` int(11) DEFAULT '0',
  `content` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `del` int(11) DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
INSERT INTO `messages` VALUES (1,5,6,'5_6',0,0,0,'nihaonihao',0,'2014-03-19 17:33:17','2014-03-19 17:33:17');
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
  `source_id` int(11) DEFAULT NULL,
  `source_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `channel` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `mark` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `del` tinyint(1) DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pushes`
--

LOCK TABLES `pushes` WRITE;
/*!40000 ALTER TABLE `pushes` DISABLE KEYS */;
INSERT INTO `pushes` VALUES (1,5,'Image',5,'Image','每日一图',NULL,'2014-04-01（晚上版）【星期二】',0,'2014-04-01 18:56:57','2014-04-01 18:56:57'),(2,5,'Image',1,'User','漫拍之星',NULL,'无',0,'2014-04-01 18:57:01','2014-04-01 18:57:01'),(3,9,'Image',9,'Image','每日一图',NULL,'2014-04-01（晚上版）【星期二】',0,'2014-04-01 18:57:19','2014-04-01 18:57:19'),(4,1,'Event',1,'Event','推荐活动',NULL,'推荐活动',0,'2014-04-02 01:44:11','2014-04-02 01:44:17'),(5,42,'Image',4,'User','推荐摄影师',NULL,'无',0,'2014-04-02 02:21:15','2014-04-02 02:21:15'),(6,2,'Event',2,'Event','推荐活动',NULL,'推荐活动',0,'2014-04-02 04:51:06','2014-04-02 04:51:06'),(7,8,'Image',8,'Image','每日精选',NULL,'无',0,'2014-04-02 04:57:57','2014-04-02 04:57:57');
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sbgs`
--

LOCK TABLES `sbgs` WRITE;
/*!40000 ALTER TABLE `sbgs` DISABLE KEYS */;
INSERT INTO `sbgs` VALUES (1,'bg2.jpg','image/jpeg',862492,'2014-03-15 09:53:16',0,0,'2014-03-15 09:53:16','2014-03-15 09:53:16'),(2,'bg1.jpg','image/jpeg',659162,'2014-03-15 09:53:48',0,0,'2014-03-15 09:53:48','2014-03-15 09:53:48'),(3,'bg4.jpg','image/jpeg',264581,'2014-03-15 09:54:02',0,0,'2014-03-15 09:54:02','2014-03-15 09:54:02'),(4,'signs.jpg','image/jpeg',190298,'2014-03-15 09:54:33',0,0,'2014-03-15 09:54:33','2014-03-15 09:54:33'),(5,'bgs.jpg','image/jpeg',6564,'2014-03-15 09:54:53',1,0,'2014-03-15 09:54:53','2014-03-15 09:54:53');
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
INSERT INTO `schema_migrations` VALUES ('20131225140149'),('20131225140150'),('20140114064822'),('20140114070954'),('20140116091959'),('20140119074029'),('20140119075534'),('20140128085710'),('20140207085415'),('20140208085729'),('20140208085730'),('20140208085731'),('20140217060518'),('20140217073800'),('20140218035042'),('20140218035306'),('20140218035521'),('20140218035523'),('20140218050947'),('20140218051156'),('20140218051157'),('20140218051158'),('20140315083033'),('20140315083034'),('20140315083035');
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
  `channel` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
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
  `last_updated_at` datetime DEFAULT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `content` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `comments_count` int(11) DEFAULT '0',
  `del` tinyint(1) DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `topics`
--

LOCK TABLES `topics` WRITE;
/*!40000 ALTER TABLE `topics` DISABLE KEYS */;
INSERT INTO `topics` VALUES (1,1,9,NULL,NULL,'好i好i好i好i好i好i','好i好i好i好i好i好i好i好i好i好i好i好i好i好i好i好i好i好i好i好i好i好i好i好i好i好i好i好i好i好i好i好i好i好i好i好i好i好i好i好i好i好i',0,0,'2014-03-15 07:06:01','2014-03-15 07:06:01'),(2,1,68,4,NULL,'测试测试一下啊如何了','测试测试一下啊如何了测试测试一下啊如何了测试测试一下啊如何了测试测试一下啊如何了',1,0,'2014-03-15 07:06:37','2014-03-15 07:46:16'),(3,1,9,NULL,NULL,'测试测试','原来是这样~~测试测试测试测试测试测试测试测试',0,0,'2014-04-02 04:53:25','2014-04-02 04:53:25'),(4,1,2,NULL,NULL,'士大夫','asdfasdfasdf',2,0,'2014-04-03 02:11:35','2014-04-03 02:11:35');
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tuis`
--

LOCK TABLES `tuis` WRITE;
/*!40000 ALTER TABLE `tuis` DISABLE KEYS */;
INSERT INTO `tuis` VALUES (1,1,'Image','Tuilaud',1,0,NULL,0,'2014-03-10 06:10:19','2014-03-10 06:10:19'),(2,5,'Image','Tuilike',2,0,NULL,0,'2014-03-10 08:43:11','2014-03-10 08:43:11'),(3,5,'Image','Tuilaud',2,0,NULL,0,'2014-03-10 08:43:13','2014-03-10 08:43:13'),(4,42,'Image','Tuirecom',1,0,NULL,0,'2014-04-03 04:11:57','2014-04-03 04:11:57');
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
  `notices_count` int(11) DEFAULT '0',
  `followers_count` int(11) DEFAULT '0',
  `bg` varchar(255) COLLATE utf8_unicode_ci DEFAULT '/images/defaults/bgs.jpg',
  `repeat` varchar(255) COLLATE utf8_unicode_ci DEFAULT 'repeat',
  `remember_me` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `del` tinyint(1) DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin@shanpro.com','管理员',NULL,'','','9574be986128d15270f02ee203ffce18',NULL,'000e34c90192f431623917db7049a28ef7f1f26e.jpg','image/jpeg',13649,'2014-03-09 09:03:53','','','','','','',NULL,NULL,4,1,0,0,0,'/images/defaults/bgs.jpg','repeat',NULL,0,'2014-03-09 09:03:53','2014-04-03 02:02:25'),(2,'tianyishengshui1226@126.com','huishan1226',NULL,NULL,NULL,'c023bc0f91e5e6bb95e82c9254540433',NULL,'71cb74554036a1cd70c0180c1f9f3fcb913abc4b.jpg','image/jpeg',6908,'2014-03-10 08:12:58',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,5,0,0,0,0,'/images/defaults/bgs.jpg','repeat',NULL,0,'2014-03-10 08:13:01','2014-03-10 08:13:01'),(3,'xingcj@126.com','邢春江',NULL,NULL,NULL,'e10655cb0a445d47de4f4148954c4e11',NULL,'5fb47b3e48d4b4d059ff7d40b89d0b683ce6df41.jpg','image/jpeg',9501,'2014-03-13 12:09:35',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,5,0,1,0,0,'/images/defaults/bgs.jpg','repeat',NULL,0,'2014-03-13 12:09:39','2014-04-01 18:57:58'),(4,'515856563@qq.com','朱晓武',NULL,NULL,NULL,'9574be986128d15270f02ee203ffce18',NULL,'817ad5bc0539b9fc62c485718af9a0f699ebd57f.jpg','image/jpeg',13249,'2014-03-15 07:45:53',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,5,0,1,0,0,'/images/defaults/bgs.jpg','repeat',NULL,0,'2014-03-15 07:45:57','2014-04-01 18:58:20'),(5,'mike.gao0611@gmail.com','icelatte',NULL,NULL,NULL,'8567308aa6fc871d290cdf98edd4edfa',NULL,'a87e78649c3da0696f91070908e6760ee7535f97.jpg','image/jpeg',4965,'2014-03-17 03:52:37',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,5,0,0,0,0,'/images/defaults/bgs.jpg','repeat',NULL,0,'2014-03-17 03:52:41','2014-03-17 03:52:41'),(6,'147541232@qq.com','icelatte8',NULL,NULL,NULL,'8567308aa6fc871d290cdf98edd4edfa',NULL,'f4a3d8e145f4c8dcd2be2b031d18ce779d36ba8b.jpg','image/jpeg',7404,'2014-03-17 03:53:59',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,5,0,0,0,0,'/images/defaults/bgs.jpg','repeat',NULL,0,'2014-03-17 03:54:02','2014-03-17 03:54:02');
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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `visits`
--

LOCK TABLES `visits` WRITE;
/*!40000 ALTER TABLE `visits` DISABLE KEYS */;
INSERT INTO `visits` VALUES (1,6,'Work',4,NULL,0,'2014-04-02 02:19:30','2014-04-02 02:19:30'),(2,1,'Work',1,NULL,0,'2014-04-02 04:54:07','2014-04-02 04:54:07'),(3,2,'Work',NULL,NULL,0,'2014-04-02 11:41:22','2014-04-02 11:41:22'),(4,1,'Work',NULL,NULL,0,'2014-04-02 11:41:25','2014-04-02 11:41:25'),(5,3,'Work',NULL,NULL,0,'2014-04-02 11:44:04','2014-04-02 11:44:04'),(6,5,'Work',NULL,NULL,0,'2014-04-02 11:44:44','2014-04-02 11:44:44'),(7,4,'Work',NULL,NULL,0,'2014-04-02 11:44:44','2014-04-02 11:44:44'),(8,5,'Work',NULL,NULL,0,'2014-04-03 01:50:31','2014-04-03 01:50:31'),(9,5,'Work',NULL,NULL,0,'2014-04-03 01:57:42','2014-04-03 01:57:42'),(10,5,'Work',1,NULL,0,'2014-04-03 02:07:08','2014-04-03 02:07:08'),(11,5,'Work',NULL,NULL,0,'2014-04-03 02:38:02','2014-04-03 02:38:02'),(12,5,'Work',1,NULL,0,'2014-04-03 02:38:29','2014-04-03 02:38:29');
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
  `comments_count` int(11) DEFAULT '0',
  `visits_count` int(11) DEFAULT '0',
  `del` tinyint(1) DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `works`
--

LOCK TABLES `works` WRITE;
/*!40000 ALTER TABLE `works` DISABLE KEYS */;
INSERT INTO `works` VALUES (1,1,1,1,NULL,NULL,'不知道哪里的美景，着实羡慕','在这里享受，在这里甩掉城市的浮躁',0,0,2,0,'2014-03-09 09:08:29','2014-03-09 09:08:29'),(2,1,5,1,NULL,NULL,'如果美景','如果美景如果美景',0,0,1,0,'2014-03-10 08:34:53','2014-03-10 08:34:53'),(3,1,6,1,NULL,NULL,'有太多这样的美景照片','有太多这样的美景照片，如果有幸亲自到场！！！！',0,0,1,0,'2014-03-11 06:48:19','2014-03-11 06:48:19'),(4,1,7,1,NULL,NULL,'采集一点，放到我大漫拍','采集一点，放到我大漫拍。\r\n还是很漂亮的',0,0,1,0,'2014-03-14 05:03:50','2014-03-14 05:03:50'),(5,1,22,1,NULL,NULL,'采集一点，放到我大漫拍','采集一点，放到我大漫拍采集一点，放到我大漫拍采集一点，放到我大漫拍',0,0,6,0,'2014-03-14 05:24:22','2014-03-14 05:24:22'),(6,4,42,1,NULL,1,'采集一点，放到我大漫拍','采集一点，放到我大漫拍',1,0,1,0,'2014-04-02 02:19:30','2014-04-02 04:55:22');
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

-- Dump completed on 2014-04-04  5:57:17
