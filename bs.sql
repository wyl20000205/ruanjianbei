-- MySQL dump 10.13  Distrib 5.7.31, for Win64 (x86_64)
--
-- Host: localhost    Database: bs
-- ------------------------------------------------------
-- Server version	5.7.31

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
-- Table structure for table `t_admin`
--
CREATE DATABASE `bs`;
USE `bs`;
DROP TABLE IF EXISTS `t_admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `pass` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `mail` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `last_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `time` datetime DEFAULT CURRENT_TIMESTAMP,
  `extra` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `user` (`user`),
  UNIQUE KEY `mail` (`mail`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_admin`
--

LOCK TABLES `t_admin` WRITE;
/*!40000 ALTER TABLE `t_admin` DISABLE KEYS */;
INSERT INTO `t_admin` VALUES (1,'123123','123123','123123@qq.com','2024-05-15 15:24:05','2024-02-13 04:37:09',NULL);
/*!40000 ALTER TABLE `t_admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_bill`
--

DROP TABLE IF EXISTS `t_bill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_bill` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `fid` int(11) NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `old_price` decimal(10,2) NOT NULL,
  `new_price` decimal(10,2) NOT NULL,
  `change_price` decimal(10,2) NOT NULL,
  `time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `extra` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=72 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_bill`
--

LOCK TABLES `t_bill` WRITE;
/*!40000 ALTER TABLE `t_bill` DISABLE KEYS */;
INSERT INTO `t_bill` VALUES (2,2,-1,'用户注册',0.00,0.00,0.00,'2024-04-26 20:22:45',NULL),(1,1,-1,'用户注册',0.00,0.00,0.00,'2024-04-26 20:22:42',NULL),(48,1,1,'余额购买',10.00,9.99,0.01,'2024-04-26 20:36:13',NULL),(49,1,1,'扫码购买',9.99,9.99,0.01,'2024-04-26 20:39:54',NULL),(50,1,2,'余额购买',9.99,9.89,0.10,'2024-05-02 19:07:46',NULL),(51,1,21,'余额购买',9.89,9.88,0.01,'2024-05-02 19:07:58',NULL),(52,30,-1,'用户注册',0.00,0.00,0.00,'2024-05-02 19:15:31',NULL),(53,30,12,'余额购买',0.00,-7.50,7.50,'2024-05-02 19:18:04',NULL),(54,30,11,'余额购买',-7.50,-18.00,10.50,'2024-05-02 19:18:08',NULL),(55,30,5,'余额购买',-18.00,-30.50,12.50,'2024-05-02 19:18:12',NULL),(56,1,-1,'扫码充值',9.88,9.89,0.01,'2024-05-03 20:22:08',NULL),(57,1,-1,'扫码充值',9.89,9.90,0.01,'2024-05-03 20:22:43',NULL),(3,1,-1,'扫码充值',0.00,10.00,10.00,'2024-04-26 20:22:52',NULL),(58,1,1,'扫码购买',9.90,9.90,0.01,'2024-05-06 00:03:31',NULL),(59,1,1,'扫码购买',9.90,9.90,0.01,'2024-05-06 00:04:03',NULL),(60,1,1,'余额购买',9.90,9.89,0.01,'2024-05-12 09:49:29',NULL),(61,1,1,'扫码购买',9.89,9.89,0.01,'2024-05-15 14:52:30',NULL),(62,1,-1,'扫码充值',9.89,9.90,0.01,'2024-05-15 14:53:59',NULL),(63,31,-1,'用户注册',0.00,0.00,0.00,'2024-05-15 16:22:01',NULL),(64,32,-1,'用户注册',0.00,0.00,0.00,'2024-05-15 16:22:13',NULL),(65,33,-1,'用户注册',0.00,0.00,0.00,'2024-05-15 16:22:55',NULL),(66,34,-1,'用户注册',0.00,0.00,0.00,'2024-05-15 16:23:05',NULL),(67,35,-1,'用户注册',0.00,0.00,0.00,'2024-05-15 16:23:16',NULL),(68,36,-1,'用户注册',0.00,0.00,0.00,'2024-05-15 16:23:34',NULL),(69,37,-1,'用户注册',0.00,0.00,0.00,'2024-05-15 17:02:31',NULL),(70,1,1,'扫码购买',9.90,9.90,0.01,'2024-05-15 17:17:35',NULL),(71,1,2,'扫码购买',9.90,9.90,0.02,'2024-05-15 17:22:48',NULL);
/*!40000 ALTER TABLE `t_bill` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_business`
--

DROP TABLE IF EXISTS `t_business`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_business` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `user` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `pass` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `tel` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `people` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  `extra` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `user` (`user`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_business`
--

LOCK TABLES `t_business` WRITE;
/*!40000 ALTER TABLE `t_business` DISABLE KEYS */;
INSERT INTO `t_business` VALUES (1,'第一食堂','123123','123123','12345612331','华落','2024-05-06 17:30:26',NULL),(2,'第二食堂','222222','222222','18996401122','寒冰','2024-05-06 17:30:49',NULL),(4,'第三食堂','333333','333333','12312323223','塞拉斯',NULL,NULL),(5,'第四食堂','444444','444444','444444','444444',NULL,NULL),(6,'第五食堂','555555','555555','555555','5555555',NULL,NULL),(7,'第六食堂','666666','666666','666666','666666',NULL,NULL),(8,'第七食堂','777777','777777','777777','777777',NULL,NULL),(9,'第八食堂','888888','888888','888888','888888',NULL,NULL),(10,'第十食堂','999999','999999','999999','999999',NULL,NULL);
/*!40000 ALTER TABLE `t_business` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_detail`
--

DROP TABLE IF EXISTS `t_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `time` datetime DEFAULT CURRENT_TIMESTAMP,
  `extra` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_detail`
--

LOCK TABLES `t_detail` WRITE;
/*!40000 ALTER TABLE `t_detail` DISABLE KEYS */;
INSERT INTO `t_detail` VALUES (1,'文昌食堂负责人:张三     联系邮箱:119221321@qq.com','2024-02-05 06:58:35',NULL),(2,'柳东食堂负责人:李四    联系邮箱:2122333122@qq.com','2024-02-20 03:03:20',NULL),(3,'柳石食堂负责人:王五    联系邮箱:3222213321@qq.com','2024-01-21 22:51:05',NULL),(4,'食堂安全卫生投诉:    电话:0772-2685979(校办)    0772-2687698(传真)','2024-01-19 21:06:13',NULL),(5,'网站备案号:   桂ICP备17000546号-11','2024-02-20 21:31:13',NULL);
/*!40000 ALTER TABLE `t_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_estimate`
--

DROP TABLE IF EXISTS `t_estimate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_estimate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `fid` int(11) NOT NULL,
  `trade_id` int(11) NOT NULL,
  `content` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `love` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `ip` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `extra` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_estimate`
--

LOCK TABLES `t_estimate` WRITE;
/*!40000 ALTER TABLE `t_estimate` DISABLE KEYS */;
INSERT INTO `t_estimate` VALUES (22,30,5,119,'好吃?','0','广西柳州市',1,'2024-05-15 14:37:26',NULL),(23,1,1,122,'不好吃?','0','美国佛州',1,'2024-05-15 14:37:42',NULL),(21,1,1,114,'好吃\n爱吃','0',NULL,1,'2024-04-26 20:40:31',NULL),(20,1,1,112,'太好吃了?','0',NULL,1,'2024-04-26 20:39:08',NULL),(19,1,1,113,'好吃捏\n','0',NULL,1,'2024-04-26 20:38:37',NULL),(24,1,1,121,'好吃?','0',NULL,1,'2024-05-15 14:23:51',NULL),(25,1,1,124,'好吃','0','本地发送',1,'2024-05-15 17:19:33',NULL);
/*!40000 ALTER TABLE `t_estimate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_evidence`
--

DROP TABLE IF EXISTS `t_evidence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_evidence` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `out_trade_on` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `time` datetime DEFAULT CURRENT_TIMESTAMP,
  `extra` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `out_trade_on` (`out_trade_on`)
) ENGINE=MyISAM AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_evidence`
--

LOCK TABLES `t_evidence` WRITE;
/*!40000 ALTER TABLE `t_evidence` DISABLE KEYS */;
INSERT INTO `t_evidence` VALUES (19,'yumao_89377702836','2024-02-22 17:35:39',NULL),(18,'yumao_34160454910','2024-02-22 17:34:40',NULL),(17,'yumao_69747726822','2024-02-22 17:32:08',NULL),(16,'yumao_43871106451','2024-02-22 17:30:10',NULL),(15,'yumao_64477333663','2024-02-22 17:29:30',NULL),(14,'yumao_93937521587','2024-02-22 17:25:30',NULL),(13,'yumao_15960882857','2024-02-22 17:23:30',NULL),(12,'yumao_85277098379','2024-02-22 17:21:43',NULL),(11,'yumao_5667991106','2024-02-22 17:20:01',NULL),(20,'yumao_58011255785','2024-02-22 17:37:20',NULL),(21,'yumao_62955946572','2024-02-22 17:37:58',NULL),(22,'yumao_63705379830','2024-02-22 17:39:28',NULL),(23,'yumao_55439638505','2024-02-22 17:41:36',NULL),(24,'yumao_42008873230','2024-02-22 17:45:25',NULL),(25,'yumao_9218480553','2024-02-22 17:47:54',NULL),(26,'yumao_14703281021','2024-02-22 17:54:16',NULL),(27,'yumao_8484249744','2024-02-22 17:55:56',NULL),(28,'yumao_53229352477','2024-02-22 17:56:12',NULL),(29,'yumao_22925193948','2024-02-22 17:56:45',NULL),(30,'yumao_1237913309','2024-02-22 17:59:10',NULL),(31,'yumao_70593845533','2024-02-22 18:12:30',NULL),(32,'yumao_68647637595','2024-02-22 18:25:48',NULL),(33,'yumao_30742349424','2024-02-23 21:45:33',NULL),(34,'yumao_13758861970','2024-02-24 15:07:26',NULL),(35,'yumao_19466496916','2024-02-24 15:08:09',NULL),(36,'yumao_21886764509','2024-02-24 20:02:17',NULL),(37,'yumao_83167244543','2024-02-25 08:15:49',NULL),(38,'yumao_2245595394','2024-02-25 08:47:59',NULL),(39,'yumao_24255725029','2024-02-25 10:20:30',NULL),(40,'yumao_45826089337','2024-02-25 10:21:11',NULL),(41,'yumao_80867025737','2024-04-26 17:07:02',NULL),(42,'yumao_2669865930','2024-04-26 17:49:14',NULL),(43,'yumao_8972560423','2024-04-26 17:50:08',NULL),(44,'yumao_93695260520','2024-04-26 17:52:02',NULL),(45,'yumao_59576413328','2024-04-26 18:26:27',NULL),(46,'yumao_33829363851','2024-04-26 19:13:44',NULL),(47,'yumao_93132450244','2024-04-26 20:02:33',NULL),(48,'yumao_66533728966','2024-04-26 20:39:54',NULL),(49,'yumao_99356328816','2024-05-03 20:22:08',NULL),(50,'yumao_50033213406','2024-05-03 20:22:43',NULL),(51,'yumao_44419602505','2024-05-06 00:03:31',NULL),(52,'yumao_9483814775','2024-05-06 00:04:03',NULL),(53,'yumao_49500085571','2024-05-15 14:52:30',NULL),(54,'yumao_97684999889','2024-05-15 14:53:59',NULL),(55,'yumao_85633272426','2024-05-15 17:17:35',NULL),(56,'yumao_27690449715','2024-05-15 17:22:48',NULL);
/*!40000 ALTER TABLE `t_evidence` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_food`
--

DROP TABLE IF EXISTS `t_food`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_food` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `detail` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `introduce` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `localtion` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `price` decimal(20,2) NOT NULL DEFAULT '0.00',
  `img` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `time` datetime DEFAULT CURRENT_TIMESTAMP,
  `extra` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_food`
--

LOCK TABLES `t_food` WRITE;
/*!40000 ALTER TABLE `t_food` DISABLE KEYS */;
INSERT INTO `t_food` VALUES (1,'红烧肉包子','猪肉、面粉、调味料','软糯的包子皮包裹着香气四溢的红烧肉馅，是一道经典的中式小吃。','第一食堂',0.01,'food_1.jpg','2024-02-11 09:51:40',NULL),(2,'清炖鸡汤面','鸡肉、面条、蔬菜、调味料','清淡的鸡汤搭配细腻的面条，营养丰富，是一款滋补的汤面。','第二食堂',0.02,'food_2.jpg','2024-02-20 12:46:23',NULL),(4,'麻辣火锅料','鲈鱼、调味料','多种食材在麻辣汤中涮烫，辛辣美味，是一道富有火锅文化的菜品。','第二食堂',0.04,'food_4.jpg','2024-01-19 05:19:39',NULL),(5,'番茄炖牛腩','各类肉片、蔬菜、麻辣汤底','牛腩经过炖煮，肉质鲜嫩，番茄的酸甜味为其增色不少。','第一食堂',0.05,'food_5.jpg','2024-01-19 05:19:39',NULL),(6,'葱油拌面条','面条、葱油、调味料','简单清爽的面拌上葱油，香气扑鼻，令人回味。','第二食堂',0.06,'food_6.jpg','2024-01-19 05:19:39',NULL),(7,'红烧鲤鱼汤','鲤鱼、调味料','鲤鱼搭配红烧汤底，汤色橙红，鱼肉鲜美。','第三食堂',0.07,'food_7.jpg','2024-01-19 05:19:39',NULL),(8,'芝士焗烤包','面包、芝士、黄油','面包表面覆盖浓郁芝士，烤至金黄，口感香脆。','第一食堂',0.08,'food_8.jpg','2024-01-19 05:19:39',NULL),(9,'麻辣香锅血','鸭血、蔬菜、麻辣汤底','热辣的香锅搭配鸭血，口感丰富，麻辣味十足。','第三食堂',0.09,'food_9.jpg','2024-01-19 05:19:39',NULL),(10,'椒盐脆皮鸡','河虾、蒜蓉、调味料','鸡翅表面炸至脆皮，椒盐香气四溢，是一道下饭的小吃','第一食堂',0.10,'food_10.jpg','2024-01-19 05:19:39',NULL),(11,'蒜蓉炒河虾','鸡肉、牛奶、蔬菜','河虾炒至鲜嫩，蒜蓉提味，香气扑鼻。','第二食堂',0.11,'food_11.jpg','2024-01-19 05:19:39',NULL),(12,'奶香炖鸡煲','牛肚、五香卤汁','鸡肉搭配奶香汤底，口感醇厚，是一道温暖的炖菜。','第一食堂',0.12,'food_12.jpg','2024-01-19 05:19:39',NULL),(13,'五香卤牛肚','意大利面、蘑菇、培根','牛肚卤至软糯，五香味浸透其中，是一道传统的卤味小吃。','第二食堂',21.50,'food_13.jpg','2024-01-19 05:19:39',NULL),(14,'蘑菇培根面','西兰花、虾仁、松子','意大利面搭配香炸培根和蘑菇，味道丰富。','第一食堂',12.50,'food_14.jpg','2024-01-19 05:19:39',NULL),(15,'松子西兰花','烤鸭、蜜汁、饼皮','清爽的西兰花搭配鲜嫩虾仁，松子提味，口感独特。','第二食堂',18.50,'food_15.jpg','2024-01-19 05:19:39',NULL),(16,'蜜汁烤鸭饼','千层肚、蔬菜、干锅底料','脆皮烤鸭包裹在饼皮中，蜜汁增香，是一道受欢迎的中式小吃。','第三食堂',12.50,'food_16.jpg','2024-01-19 05:19:39',NULL),(17,'干锅千层肚','金枪鱼、面包、蔬菜','3千层肚与蔬菜在干锅中翻炒，香味四溢，口感鲜嫩。','第三食堂',21.50,'food_17.jpg','2024-01-19 05:19:39',NULL),(18,'金枪鱼三文','猪肉、米饭、卤汁','金枪鱼搭配新鲜蔬菜，夹在香脆的面包中，是一款轻食。','第一食堂',41.50,'food_18.jpg','2024-01-19 05:19:39',NULL),(19,'豆腐鲫鱼汤','乌龙面、香料','清淡的豆腐与鲜美的鲫鱼相搭配，汤汁鲜美可口。','第三食堂',8.50,'food_19.jpg','2024-01-19 05:19:39',NULL),(20,'香煎乌龙面','虾仁、椒盐、面粉','乌龙面煎至香脆，口感独特，是一款创意十足的面食。','第一食堂',12.50,'2fb0ab84eb64a08e66dd8293d611ba69.png','2024-01-19 05:19:39',NULL),(3,'椒盐虾球面','猪肉、葱、饺子皮','香糯的米饭包裹着美味的卤肉，是一款方便携带的日式小吃。','第一食堂',0.03,'c30c7b2bbe11b58e8fa9848ae7243a43.png','2024-01-19 05:19:39',NULL);
/*!40000 ALTER TABLE `t_food` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_log`
--

DROP TABLE IF EXISTS `t_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT NULL,
  `aid` int(11) DEFAULT NULL,
  `bid` int(11) DEFAULT NULL,
  `content` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `ip` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `device` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `extra` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=59 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_log`
--

LOCK TABLES `t_log` WRITE;
/*!40000 ALTER TABLE `t_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_mess`
--

DROP TABLE IF EXISTS `t_mess`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_mess` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `content` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `extra` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_mess`
--

LOCK TABLES `t_mess` WRITE;
/*!40000 ALTER TABLE `t_mess` DISABLE KEYS */;
INSERT INTO `t_mess` VALUES (1,'show_food','1,2,3,4,5,6,7,8,9,10,11,12','2024-05-15 15:20:34',NULL),(2,'user_notice','?用户公告:在放假期间，食堂将全面关闭，不提供早餐、午餐以及晚餐等日常餐饮服务。如有特殊情况需临时开放食堂，我们将提前通过公告或内部通知的形式告知，请大家留意相关信息。2','2024-05-15 13:51:49',NULL),(3,'business_notice','?商家公告: 在放假期间，食堂将全面关闭，不提供早餐、午餐以及晚餐等日常餐饮服务。如有特殊情况需临时开放食堂，我们将提前通过公告或内部通知的形式告知，请大家留意相关信息。','2024-05-15 13:51:50',NULL);
/*!40000 ALTER TABLE `t_mess` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_news`
--

DROP TABLE IF EXISTS `t_news`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_news` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `link` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `time` datetime DEFAULT CURRENT_TIMESTAMP,
  `extra` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_news`
--

LOCK TABLES `t_news` WRITE;
/*!40000 ALTER TABLE `t_news` DISABLE KEYS */;
INSERT INTO `t_news` VALUES (1,'我校师生热议习近平总书记对学校思政课建设作出的重要指示精神','https://www.gxust.edu.cn/info/1043/30965.htm','2024-02-15 08:43:26',NULL),(2,'学校入选自治区第二批广西职业院校“双师型”教师培养培训基地','https://www.gxust.edu.cn/info/1043/30901.htm','2024-02-05 07:02:09',NULL),(3,'学校领导参加二附院放疗中心、旧病房改扩建及相关配套工程开工奠基仪式','https://www.gxust.edu.cn/info/1043/30844.htm','2024-02-05 07:02:09',NULL),(4,'广西普通本科高校示范性现代产业学院中期评估专家组到我校开展现场评估工作','https://www.gxust.edu.cn/info/1043/30861.htm','2024-02-05 07:02:09',NULL),(5,'学校教师在第四届全国高校教师教学创新大赛（广西赛区）中喜获佳绩','https://www.gxust.edu.cn/info/1043/30876.htm','2024-02-05 07:02:09',NULL),(6,'广西科学技术协会原党组书记、副主席纳翔应邀到我校作专题报告','https://www.gxust.edu.cn/info/1043/30823.htm','2024-02-05 07:02:28',NULL);
/*!40000 ALTER TABLE `t_news` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_staff`
--

DROP TABLE IF EXISTS `t_staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_staff` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `tel` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `sort` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `localtion` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `time` datetime DEFAULT CURRENT_TIMESTAMP,
  `extra` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_staff`
--

LOCK TABLES `t_staff` WRITE;
/*!40000 ALTER TABLE `t_staff` DISABLE KEYS */;
INSERT INTO `t_staff` VALUES (1,'羽毛','18996404622','打饭阿姨','第一食堂','2024-02-11 09:02:13',NULL),(2,'华落','12356404622','食堂主管','第三食堂','2024-02-11 09:02:17',NULL),(5,'寒冰','18996404622','打饭阿姨','第三食堂',NULL,NULL),(6,'酒桶','13407829122','酿酒大师','第一食堂',NULL,NULL),(7,'剑魔','28913332112','炒菜师傅','第三食堂',NULL,NULL),(8,'铁男','18976642213','炒菜师傅','第五食堂',NULL,NULL),(9,'羽毛','312322213','食堂主管','第一食堂','2024-02-24 14:23:37',NULL),(11,'新民','1232312231','打饭阿姨','第一食堂','2024-05-15 16:26:33',NULL),(12,'卡瓦','123213221','炒菜师傅','第一食堂','2024-05-15 16:27:06',NULL);
/*!40000 ALTER TABLE `t_staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_swiper`
--

DROP TABLE IF EXISTS `t_swiper`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_swiper` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `img` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `introdece` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `time` datetime DEFAULT CURRENT_TIMESTAMP,
  `extra` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=132 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_swiper`
--

LOCK TABLES `t_swiper` WRITE;
/*!40000 ALTER TABLE `t_swiper` DISABLE KEYS */;
INSERT INTO `t_swiper` VALUES (130,'ea1acbd77fd2d00a25370957d7e0149c.jpeg',NULL,'2024-05-14 16:47:26',NULL),(131,'41d25452615dfeb813ab2e9ac0491cc6.jpeg',NULL,'2024-05-14 16:47:26',NULL);
/*!40000 ALTER TABLE `t_swiper` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_trade`
--

DROP TABLE IF EXISTS `t_trade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_trade` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fid` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `user_name` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `out_trade_on` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'balance_pay',
  `food_name` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `food_price` decimal(20,2) NOT NULL,
  `food_localtion` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `time` datetime DEFAULT CURRENT_TIMESTAMP,
  `estimate` int(255) DEFAULT NULL,
  `estimate_content` longtext COLLATE utf8mb4_unicode_520_ci,
  `ip` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `extra` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=126 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_trade`
--

LOCK TABLES `t_trade` WRITE;
/*!40000 ALTER TABLE `t_trade` DISABLE KEYS */;
INSERT INTO `t_trade` VALUES (119,5,30,'用户_135887','balance_pay','番茄炖牛腩',12.50,'第一食堂','2024-05-02 19:18:12',-2,'好吃?',NULL,'-1',NULL),(117,12,30,'用户_135887','balance_pay','奶香炖鸡煲',7.50,'第一食堂','2024-05-02 19:18:04',0,NULL,NULL,'-1',NULL),(116,21,1,'华落','balance_pay','椒盐虾球面',0.01,'第一食堂','2024-05-02 19:07:58',0,NULL,NULL,'-1',NULL),(121,1,1,'华落','yumao_9483814775','红烧肉包子',0.01,'第一食堂','2024-05-06 00:04:03',1,'好吃?',NULL,'1',NULL),(120,1,1,'华落','yumao_44419602505','红烧肉包子',0.01,'第一食堂','2024-05-06 00:03:31',0,NULL,NULL,'1',NULL),(118,11,30,'用户_135887','balance_pay','蒜蓉炒河虾',10.50,'第二食堂','2024-05-02 19:18:08',0,NULL,NULL,'-1',NULL),(115,2,1,'华落','balance_pay','清炖鸡汤面',0.10,'第二食堂','2024-05-02 19:07:46',0,NULL,NULL,'-1',NULL),(114,1,1,'华落','yumao_66533728966','红烧肉包子',0.01,'第一食堂','2024-04-26 20:39:54',-1,'好吃\n爱吃',NULL,'-1',NULL),(113,1,1,'华落','balance_pay','红烧肉包子',0.01,'第一食堂','2024-04-26 20:36:13',1,'好吃捏\n',NULL,'-1',NULL),(112,1,1,'华落','yumao_93132450244','红烧肉包子',0.01,'第一食堂','2024-04-26 20:02:33',1,'太好吃了?','美国佛州','-1',NULL),(111,1,1,'华落','balance_pay','红烧肉包子',0.01,'第一食堂','2024-04-26 19:46:08',0,NULL,NULL,'-1',NULL),(110,1,1,'华落','balance_pay','红烧肉包子',0.01,'第一食堂','2024-04-26 19:22:09',0,NULL,NULL,'-1',NULL),(122,1,1,'华落','balance_pay','红烧肉包子',0.01,'第一食堂','2024-05-12 09:49:29',1,'不好吃?','广西柳州市','1',NULL),(123,1,1,'华落','yumao_49500085571','红烧肉包子',0.01,'第一食堂','2024-05-15 14:52:30',1,'太好吃啦?','本地发送','1',NULL),(124,1,1,'华落','yumao_85633272426','红烧肉包子',0.01,'第一食堂','2024-05-15 17:17:35',1,'好吃','本地发送','1',NULL),(125,2,1,'华落','yumao_27690449715','清炖鸡汤面',0.02,'第二食堂','2024-05-15 17:22:48',0,NULL,NULL,'-1',NULL);
/*!40000 ALTER TABLE `t_trade` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_user`
--

DROP TABLE IF EXISTS `t_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user` varchar(50) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `pass` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_520_ci DEFAULT '用户名',
  `mail` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `price` decimal(20,2) NOT NULL DEFAULT '0.00',
  `time` datetime DEFAULT CURRENT_TIMESTAMP,
  `status` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `last_time` datetime DEFAULT NULL,
  `extra` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `user` (`user`),
  UNIQUE KEY `mail` (`mail`)
) ENGINE=MyISAM AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_user`
--

LOCK TABLES `t_user` WRITE;
/*!40000 ALTER TABLE `t_user` DISABLE KEYS */;
INSERT INTO `t_user` VALUES (1,'123123','123123','华落','1799498990@qq.com',9.89,'2024-02-21 15:31:02','1',NULL,NULL),(3,'121212','121212','搜罗','121212@qq.com',9968.50,'2024-05-02 19:15:31',NULL,NULL,NULL),(2,'1231233','123123','水卡','1231232@qq.om',0.00,'2024-04-26 17:28:03',NULL,NULL,NULL),(31,'444444','444444','声卡','4444444',0.00,'2024-05-15 16:22:01',NULL,NULL,NULL),(32,'555555','5555555','四维','5555555',0.00,'2024-05-15 16:22:13',NULL,NULL,NULL),(33,'666666','666666','卡瓦','666666',0.00,'2024-05-15 16:22:55',NULL,NULL,NULL),(34,'777777','777777','大蒜','777777',0.00,'2024-05-15 16:23:05',NULL,NULL,NULL),(35,'888888','888888','数控','888888',0.00,'2024-05-15 16:23:16',NULL,NULL,NULL),(36,'999999','999999','大库','999999',0.00,'2024-05-15 16:23:34',NULL,NULL,NULL),(37,'322222113','2221223123213','款式','12312223@qq.com',0.00,'2024-05-15 17:02:31',NULL,NULL,NULL);
/*!40000 ALTER TABLE `t_user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-05-15 17:24:06
