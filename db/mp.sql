-- MySQL dump 10.13  Distrib 5.1.63, for debian-linux-gnu (i686)
--
-- Host: localhost    Database: mp_dev
-- ------------------------------------------------------
-- Server version	5.1.63-0ubuntu0.11.04.1

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
INSERT INTO `accounts` VALUES (1,'1798097447',1,'weibo',NULL,'2.00jRdgxBLk739Dc9a72567197p_CkC',NULL,'157679999','1549781610','{\"uid\":1798097447,\"name\":\"\\u567c\\u91cc\\u556a\\u5566\\u5c0f\\u4e94\\u54e5\",\"province\":\"\\u5317\\u4eac\",\"city\":\"\\u4e1c\\u57ce\\u533a\",\"resume\":\"\\u7cbe\\u795e\\u751f\\u6d3b\\u5f88\\u91cd\\u8981\",\"domain\":\"zhu404\",\"gender\":true,\"site\":\"http://www.zhuxiaowu.com\",\"avatar\":\"http://tp4.sinaimg.cn/1798097447/50/5627521723/1\",\"other\":{\"id\":1798097447,\"idstr\":\"1798097447\",\"class\":1,\"screen_name\":\"\\u567c\\u91cc\\u556a\\u5566\\u5c0f\\u4e94\\u54e5\",\"name\":\"\\u567c\\u91cc\\u556a\\u5566\\u5c0f\\u4e94\\u54e5\",\"province\":\"11\",\"city\":\"1\",\"location\":\"\\u5317\\u4eac \\u4e1c\\u57ce\\u533a\",\"description\":\"\\u7cbe\\u795e\\u751f\\u6d3b\\u5f88\\u91cd\\u8981\",\"url\":\"http://www.zhuxiaowu.com\",\"profile_image_url\":\"http://tp4.sinaimg.cn/1798097447/50/5627521723/1\",\"profile_url\":\"zhu404\",\"domain\":\"zhu404\",\"weihao\":\"\",\"gender\":\"m\",\"followers_count\":327,\"friends_count\":238,\"statuses_count\":1419,\"favourites_count\":16,\"created_at\":\"Thu Aug 19 11:16:55 +0800 2010\",\"following\":false,\"allow_all_act_msg\":false,\"geo_enabled\":true,\"verified\":true,\"verified_type\":0,\"remark\":\"\",\"status\":{\"created_at\":\"Fri Jul 19 18:28:04 +0800 2013\",\"id\":3601842711703284,\"mid\":\"3601842711703284\",\"idstr\":\"3601842711703284\",\"text\":\"...//@\\u738b\\u82e5\\u611a_MaxWong: ......//@\\u6f58\\u5c0f\\u5b87\\u540c\\u5b66: @\\u6d77\\u9614and\\u5929\\u7a7a\\u7a7a \\u5f15\\u4ee5\\u4e3a\\u6212\\u554a\\uff5e\",\"source\":\"<a href=\\\"http://weibo.com/\\\" rel=\\\"nofollow\\\">\\u65b0\\u6d6a\\u5fae\\u535a</a>\",\"favorited\":false,\"truncated\":false,\"in_reply_to_status_id\":\"\",\"in_reply_to_user_id\":\"\",\"in_reply_to_screen_name\":\"\",\"pic_urls\":[],\"geo\":null,\"reposts_count\":0,\"comments_count\":0,\"attitudes_count\":0,\"mlevel\":0,\"visible\":{\"type\":0,\"list_id\":0}},\"ptype\":0,\"allow_all_comment\":true,\"avatar_large\":\"http://tp4.sinaimg.cn/1798097447/180/5627521723/1\",\"avatar_hd\":\"http://tp4.sinaimg.cn/1798097447/180/5627521723/1\",\"verified_reason\":\"\\u5929\\u9645\\u7f51Ruby\\u5de5\\u7a0b\\u5e08\\u6731\\u6653\\u6b66\",\"follow_me\":false,\"online_status\":0,\"bi_followers_count\":134,\"lang\":\"zh-cn\",\"star\":0,\"mbtype\":0,\"mbrank\":0,\"block_word\":0}}','2014-02-08 20:19:25','2014-02-11 06:53:32');
/*!40000 ALTER TABLE `accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `albums`
--

DROP TABLE IF EXISTS `albums`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `albums` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `logo_file_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `logo_content_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `logo_file_size` int(11) DEFAULT NULL,
  `logo_updated_at` datetime DEFAULT NULL,
  `text` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `open` int(11) DEFAULT '0',
  `del` tinyint(1) DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `albums`
--

LOCK TABLES `albums` WRITE;
/*!40000 ALTER TABLE `albums` DISABLE KEYS */;
INSERT INTO `albums` VALUES (1,1,'默认相册',NULL,NULL,NULL,NULL,'默认相册',0,0,'2014-02-08 20:19:37','2014-02-08 20:19:37'),(2,2,'默认相册',NULL,NULL,NULL,NULL,'默认相册',0,0,'2014-02-08 21:02:50','2014-02-08 21:02:50'),(3,3,'默认相册',NULL,NULL,NULL,NULL,'默认相册',0,0,'2014-02-09 10:57:59','2014-02-09 10:57:59'),(4,3,'图片１',NULL,NULL,NULL,NULL,'图片１',0,0,'2014-02-09 11:04:47','2014-02-09 11:04:47'),(5,4,'默认相册',NULL,NULL,NULL,NULL,'默认相册',0,0,'2014-02-10 13:17:07','2014-02-10 13:17:07'),(6,4,'2014扫街',NULL,NULL,NULL,NULL,'街头是一个不落幕的舞台，你我都是演员，也都是导演，我还是这部舞台剧的摄影。',0,0,'2014-02-10 13:19:52','2014-02-10 13:19:52');
/*!40000 ALTER TABLE `albums` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bgs`
--

DROP TABLE IF EXISTS `bgs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bgs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name_file_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name_content_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name_file_size` int(11) DEFAULT NULL,
  `name_updated_at` datetime DEFAULT NULL,
  `repeat` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `admin` tinyint(1) DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bgs`
--

LOCK TABLES `bgs` WRITE;
/*!40000 ALTER TABLE `bgs` DISABLE KEYS */;
/*!40000 ALTER TABLE `bgs` ENABLE KEYS */;
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
  `text` text COLLATE utf8_unicode_ci,
  `tag` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `end_time` date DEFAULT NULL,
  `members_count` int(11) DEFAULT '0',
  `works_count` int(11) DEFAULT '0',
  `state` int(11) DEFAULT '0',
  `show` tinyint(1) DEFAULT '0',
  `del` tinyint(1) DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `events`
--

LOCK TABLES `events` WRITE;
/*!40000 ALTER TABLE `events` DISABLE KEYS */;
INSERT INTO `events` VALUES (1,'第一个活动',NULL,NULL,NULL,NULL,NULL,'这个活动必不可少','你除了可以用单反相机、卡片机，把拍到的照片上传到快拍快拍网各个频道外，还特别推出——手机快拍（IPhone快拍）频道\r\n\r\n我们会从“手机快拍”频道挑选优秀照片，见报即奖200元——1000元。\r\n每周评选手机快拍之星，投票以快拍快拍网为准（选取有效投票数，一个ID多投、新注册刷票马甲且相册为空者，投票均无效）。每周手机快拍之星直接晋级当月四进二大奖角逐，每月评出手机摄影月度冠军和人气奖，月度冠军奖金500元，人气奖奖金300元。月度冠军由专业评委评选产生，人气奖以快拍快拍网和微博@三个好友参与投票相结合的方式产生。谢谢大家支持。\r\n\r\n为了让大家更简便地使用IPhone手机拍照上传，快拍快拍网（www.manpai.com）开发的\r\niphone手机客户端体验版，大家不用再连接数据线，将手机的照片导入电脑了，只要一点，照片就可以上传到快拍快拍网·手机快拍频道，与大家一起分享那时的人、景、故事和心情，建立属于你自己的iphone照片相册。\r\n还等什么，一起快拍吧。','未知','2016-02-04',0,0,2,0,0,'2014-02-08 20:36:32','2014-02-08 20:36:58');
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
  `text` text COLLATE utf8_unicode_ci,
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
-- Table structure for table `images`
--

DROP TABLE IF EXISTS `images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `images` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `album_id` int(11) DEFAULT NULL,
  `event_id` int(11) DEFAULT NULL,
  `state` int(11) DEFAULT '0',
  `warrant` int(11) DEFAULT NULL,
  `picture_file_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `picture_content_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `picture_file_size` int(11) DEFAULT NULL,
  `picture_updated_at` datetime DEFAULT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `text` text COLLATE utf8_unicode_ci,
  `exif` text COLLATE utf8_unicode_ci,
  `del` tinyint(1) DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `images`
--

LOCK TABLES `images` WRITE;
/*!40000 ALTER TABLE `images` DISABLE KEYS */;
INSERT INTO `images` VALUES (1,'p.jpg',1,1,1,1,NULL,'p.jpg','application/octet-stream',2562102,'2014-02-08 20:25:48','这是第一个图片','图片描述的不怎么好\r\n\r\n不过凑活看吧','{\"width\":3264,\"height\":2448,\"bits\":8,\"comment\":null,\"make\":\"Apple\",\"model\":\"iPhone 4S\",\"orientation\":6,\"x_resolution\":72.0,\"y_resolution\":72.0,\"resolution_unit\":2,\"software\":\"5.1.1\",\"date_time\":\"2012-09-29T21:09:57+08:00\",\"ycb_cr_positioning\":1,\"exposure_time\":0.05,\"f_number\":2.4,\"exposure_program\":2,\"iso_speed_ratings\":400,\"date_time_original\":\"2012-09-29T21:09:57+08:00\",\"date_time_digitized\":\"2012-09-29T21:09:57+08:00\",\"shutter_speed_value\":0.05,\"aperture_value\":2.4,\"brightness_value\":0.3018793273986152,\"metering_mode\":5,\"flash\":24,\"focal_length\":4.28,\"subject_area\":[1631,1223,881,881],\"color_space\":1,\"pixel_x_dimension\":3264,\"pixel_y_dimension\":2448,\"sensing_method\":2,\"exposure_mode\":0,\"white_balance\":0,\"focal_length_in_35mm_film\":35,\"scene_capture_type\":0,\"sharpness\":0}',0,'2014-02-08 20:25:52','2014-02-08 20:37:51'),(2,'1122184996.jpg',3,4,1,1,NULL,'1122184996.jpg','application/octet-stream',51213,'2014-02-09 11:04:25','','','{\"width\":640,\"height\":434,\"bits\":8,\"comment\":null,\"orientation\":1,\"software\":\"ACD Systems Digital Imaging\",\"date_time\":\"2006-04-19T13:34:08+04:00\",\"ycb_cr_positioning\":1,\"subsec_time\":\"171\",\"pixel_x_dimension\":640,\"pixel_y_dimension\":434}',0,'2014-02-09 11:04:36','2014-02-09 11:05:00');
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
  `text` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `del` int(11) DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
INSERT INTO `messages` VALUES (1,1,1,'asdfasdfasdfsadfsda',0,'2014-02-08 21:18:12','2014-02-08 21:18:12'),(2,2,1,'asdfasdfasdfsadfsda',0,'2014-02-08 21:18:13','2014-02-08 21:18:13'),(3,1,1,'hihihihihihi',0,'2014-02-08 21:19:19','2014-02-08 21:19:19'),(4,2,1,'hihihihihihi',0,'2014-02-08 21:19:19','2014-02-08 21:19:19'),(5,2,1,'hihihihihihiasdasdasda',0,'2014-02-08 21:20:34','2014-02-08 21:20:34'),(6,1,1,'hihihihihihiasdasdasda',0,'2014-02-08 21:20:34','2014-02-08 21:20:34');
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
-- Table structure for table `pushes`
--

DROP TABLE IF EXISTS `pushes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pushes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sourcer_id` int(11) DEFAULT NULL,
  `sourcer_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
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
INSERT INTO `schema_migrations` VALUES ('20131225140149'),('20140110053017'),('20140114064822'),('20140114070954'),('20140116091959'),('20140119074029'),('20140119075534'),('20140119075801'),('20140120145855'),('20140128085240'),('20140128085710'),('20140128093041'),('20140128095530'),('20140207085415'),('20140208085729');
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
  `del` tinyint(1) DEFAULT NULL,
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
  `t` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `likes_count` int(11) DEFAULT '0',
  `del` tinyint(1) DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
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
  `text` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `state` int(11) DEFAULT '1',
  `messages_count` int(11) DEFAULT '0',
  `del` tinyint(1) DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `talks`
--

LOCK TABLES `talks` WRITE;
/*!40000 ALTER TABLE `talks` DISABLE KEYS */;
INSERT INTO `talks` VALUES (1,1,3,'hihihihihihiasdasdasda',0,3,0,'2014-02-08 21:18:12','2014-02-08 21:20:34'),(2,3,1,'hihihihihihiasdasdasda',1,3,0,'2014-02-08 21:18:13','2014-02-08 21:20:34');
/*!40000 ALTER TABLE `talks` ENABLE KEYS */;
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
  `warrant` int(11) DEFAULT NULL,
  `admin` tinyint(1) DEFAULT '0',
  `photographer` tinyint(1) DEFAULT '0',
  `talks_count` int(11) DEFAULT '0',
  `notices_count` int(11) DEFAULT '0',
  `bg` varchar(255) COLLATE utf8_unicode_ci DEFAULT '/images/defaults/bg.jpg',
  `repeat` varchar(255) COLLATE utf8_unicode_ci DEFAULT 'repeat',
  `remember_me` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `del` tinyint(1) DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'1@qq.com','噼里啪啦小五哥',NULL,'','','9574be986128d15270f02ee203ffce18',NULL,'stringio.txt','image/jpeg',2527,'2014-02-08 20:19:37','北京','北京','http://www.zhuxiaowu.com','精神生活很重要','zhu404','',NULL,1,5,0,0,0,0,'/images/defaults/bg.jpg','repeat',NULL,0,'2014-02-08 20:19:37','2014-02-08 20:38:41'),(2,'2@q.com','bopro',NULL,NULL,NULL,'9574be986128d15270f02ee203ffce18',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'/images/defaults/bg.jpg','repeat',NULL,0,'2014-02-08 21:02:50','2014-02-08 21:02:50'),(3,'xingcj@126.com','xingcj',NULL,NULL,NULL,'e10655cb0a445d47de4f4148954c4e11',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'/images/defaults/bg.jpg','repeat',NULL,0,'2014-02-09 10:57:59','2014-02-09 10:57:59'),(4,'13626361516@163.com','王宁wangning1980_',NULL,NULL,NULL,'cc3f1fc5fc56962817466d0a78c1b756',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'/images/defaults/bg.jpg','repeat',NULL,0,'2014-02-10 13:17:07','2014-02-10 13:17:07');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
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
  `image_id` int(11) DEFAULT NULL,
  `event_id` int(11) DEFAULT NULL,
  `warrant` int(11) DEFAULT NULL,
  `winner` int(11) DEFAULT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `text` text COLLATE utf8_unicode_ci,
  `del` tinyint(1) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `works`
--

LOCK TABLES `works` WRITE;
/*!40000 ALTER TABLE `works` DISABLE KEYS */;
INSERT INTO `works` VALUES (1,1,1,1,NULL,NULL,'这是第一个图片','图片描述的不怎么好\r\n\r\n不过凑活看吧',NULL,'2014-02-08 20:37:51','2014-02-08 20:37:51'),(2,3,2,1,NULL,NULL,'','',NULL,'2014-02-09 11:05:00','2014-02-09 11:05:00');
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

-- Dump completed on 2014-02-11 10:24:36
