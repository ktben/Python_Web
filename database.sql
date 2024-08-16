-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: labsaledb
-- ------------------------------------------------------
-- Server version	8.0.36

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
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'Điện thoại'),(2,'Tablet'),(3,'Smartwatch'),(4,'Loa'),(5,'Laptop'),(6,'Tai Nghe'),(7,'Sạc, cáp'),(8,'Chuột máy tính'),(9,'Bàn phím'),(10,'Ốp lưng');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `content` varchar(255) NOT NULL,
  `product_id` int NOT NULL,
  `user_id` int NOT NULL,
  `created_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `comment_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  CONSTRAINT `comment_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
INSERT INTO `comment` VALUES (3,'good',2,7,'2024-04-18 00:22:02');
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `face`
--

DROP TABLE IF EXISTS `face`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `face` (
  `id` int NOT NULL AUTO_INCREMENT,
  `img` varchar(255) DEFAULT NULL,
  `user_id` int NOT NULL,
  `name` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `img` (`img`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `face_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=128 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `face`
--

LOCK TABLES `face` WRITE;
/*!40000 ALTER TABLE `face` DISABLE KEYS */;
INSERT INTO `face` VALUES (127,'./dataset/7',7,NULL);
/*!40000 ALTER TABLE `face` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `price` float DEFAULT NULL,
  `image` varchar(100) DEFAULT NULL,
  `active` tinyint(1) DEFAULT NULL,
  `created_table` datetime DEFAULT NULL,
  `category_id` int NOT NULL,
  `sale` tinyint(1) DEFAULT '0',
  `sale_price` float DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `product_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=84 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1,'IPhone 7 Plus','Màn hình:  LED-backlit IPS LCD5.5\"Retina HD Hệ điều hành:  iOS 14 Camera sau:  2 camera 12 MP Camera trước:  7 MP Chip:  Apple A10 Fusion RAM:  3 GB Dung lượng lưu trữ:  256 GB SIM:  1 Nano SIM Pin, Sạc:  2900 mAh Hãng  iPhone (Apple)',17990000,'images/iphone7.jpg',1,'2024-04-09 18:16:05',1,1,15990000),(2,'IPad Pro 2020','Màn hình:  12.9\"Liquid Retina Hệ điều hành:  iPadOS 15 Chip:  Apple A12Z Bionic RAM:  6 GB Dung lượng lưu trữ:  128 GB Kết nối:  Nghe gọi qua FaceTime Camera sau:  Chính 12 MP & Phụ 10 MP, TOF 3D LiDAR Camera trước:  7 MP Pin, Sạc:  36.71 Wh (~ 9720 mAh)1',36990000,'images/ipadpro20.jpg',1,'2024-04-09 18:16:05',2,1,34550000),(3,'IPhone 6 Plus','Màn hình:  LED-backlit IPS LCD5.5\"Retina HD Hệ điều hành:  iOS 10 Camera sau:  8 MP Camera trước:  1.2 MP Chip:  Apple A8 RAM:  1 GB Dung lượng lưu trữ:  32 GB SIM:  1 Nano SIM Pin, Sạc:  2915 mAh Hãng  iPhone (Apple)',13990000,'images/iphone6.jpg',1,'2024-04-09 18:16:05',1,1,11990000),(4,'IPad Mini 2020','Màn hình: 8.3\"Liquid Retina Hệ điều hành: iPadOS 15 Chip: Apple A12Z Bionic RAM: 6 GB Dung lượng lưu trữ: 128 GB Kết nối: Nghe gọi qua FaceTime Camera sau: Chính 12 MP & Phụ 10 MP, TOF 3D LiDAR Camera trước: 7 MP Pin, Sạc: 36.71 Wh (~ 9720 mAh)1',29000000,'images/ipadmini.jpg',1,'2024-04-09 18:16:05',2,1,27990000),(16,'Iphone 8','Màn hình:  LED-backlit IPS LCD4.7\"Retina HD Hệ điều hành:  iOS 14 Camera sau:  12 MP Camera trước:  7 MP Chip:  Apple A11 Bionic RAM:  2 GB Dung lượng lưu trữ:  64 GB SIM:  1 Nano SIM Pin, Sạc:  1821 mAh Hãng  iPhone (Apple)',22990000,'images/iphone8.jpg',1,'2024-04-15 19:19:00',1,0,0),(17,'Iphone X','Màn hình:  OLED5.8\"Super Retina Hệ điều hành:  iOS 12 Camera sau:  2 camera 12 MP Camera trước:  7 MP Chip:  Apple A11 Bionic RAM:  3 GB Dung lượng lưu trữ:  256 GB SIM:  1 Nano SIM Pin, Sạc:  2716 mAh Hãng  iPhone (Apple)',26990000,'images/iphoneX.jpg',1,'2024-04-15 19:19:00',1,0,24990000),(20,'AirPods2','Thời gian tai nghe:  Dùng 6 giờ Thời gian hộp sạc:  Dùng 30 giờ Cổng sạc:  Sạc MagSafeSạc không dây QiLightning Công nghệ âm thanh:  Chip Apple H2Adaptive EQActive Noise Cancellation Tương thích:  macOS (Macbook, iMac)Android, iOS, Windows Tiện ích:  Trợ ',6190000,'images/airpods2.jpg',1,'2024-04-15 19:19:00',6,1,4990000),(21,'OPENFIT T910','Thời gian tai nghe:  Dùng 7 giờ - Sạc 1 giờ Thời gian hộp sạc:  Dùng 28 giờ - Sạc 2 giờ Cổng sạc:  Type-C Công nghệ âm thanh:  Dẫn truyền khí DirectPitch Tương thích:  macOSAndroid, iOS, Windows Tiện ích:  Sạc nhanhKhử tiếng ồn AIChống nước & bụi IP542 Mi',5690000,'images/openfitt910.jpg',1,'2024-04-15 19:19:00',6,0,0),(22,'Iphone 13','Màn hình:  OLED6.1\"Super Retina XDR Hệ điều hành:  iOS 15 Camera sau:  2 camera 12 MP Camera trước:  12 MP Chip:  Apple A15 Bionic RAM:  4 GB Dung lượng lưu trữ:  256 GB SIM:  1 Nano SIM & 1 eSIMHỗ trợ 5G Pin, Sạc:  3240 mAh20 W Hãng  iPhone (Apple)',38900000,'images/iphone13.jpg',1,'2024-04-15 20:36:10',1,1,36990000),(23,'Xiaomi 13T Pro 5G ','Màn hình:  AMOLED6.67\"1.5K Hệ điều hành:  Android 13 Camera sau:  Chính 50 MP & Phụ 50 MP, 12 MP Camera trước:  20 MP Chip:  MediaTek Dimensity 9200+ 5G 8 nhân RAM:  12 GB Dung lượng lưu trữ:  256 GB SIM:  2 Nano SIMHỗ trợ 5G Pin, Sạc:  5000 mAh120 W Hãng',28900000,'images/xiaomi13tpro.jpg',1,'2024-04-15 20:36:10',1,1,25990000),(24,'Samsung Galxy A54','Màn hình:  Super AMOLED6.4\"Full HD+ Hệ điều hành:  Android 13 Camera sau:  Chính 50 MP & Phụ 12 MP, 5 MP Camera trước:  32 MP Chip:  Exynos 1380 8 nhân RAM:  8 GB Dung lượng lưu trữ:  128 GB SIM:  2 Nano SIMHỗ trợ 5G Pin, Sạc:  5000 mAh25 W Hãng  Samsung',20990000,'images/ssgalaxya54.jpg',1,'2024-04-15 20:36:10',1,0,0),(25,'Ipad Air 5 M1 Wifi','Màn hình:  10.9\"Retina IPS LCD Hệ điều hành:  iPadOS 15 Chip:  Apple M1 RAM:  8 GB Dung lượng lưu trữ:  64 GB Kết nối:  Nghe gọi qua FaceTime Camera sau:  12 MP Camera trước:  12 MP Pin, Sạc:  28.6 Wh (~ 7587 mAh)20 W Hãng  iPad (Apple)',25690000,'images/ipadair5m1.jpg',1,'2024-04-15 20:36:10',2,0,0),(26,'Ipad 9 Wifi','Màn hình:  10.2\"Retina IPS LCD Hệ điều hành:  iPadOS 15 Chip:  Apple A13 Bionic RAM:  3 GB Dung lượng lưu trữ:  256 GB Kết nối:  Nghe gọi qua FaceTime Camera sau:  8 MP Camera trước:  12 MP Pin, Sạc:  32.4 Wh (~ 8600 mAh)20 W Hãng  iPad (Apple)',14990000,'images/ipad9.jpg',1,'2024-04-15 20:36:10',2,1,12990000),(27,'Ipad Pro M2 12.9 inch Wifi','Màn hình:  12.9\"Liquid Retina XDR Hệ điều hành:  iPadOS 16 Chip:  Apple M2 8 nhân RAM:  8 GB Dung lượng lưu trữ:  256 GB Kết nối:  Nghe gọi qua FaceTime Camera sau:  Chính 12 MP & Phụ 10 MP, TOF 3D LiDAR Camera trước:  12 MP Pin, Sạc:  40.88 Wh (~ 10.835 ',32990000,'images/ipadprom2.jpg',1,'2024-04-15 20:36:10',2,1,30990000),(28,'Macbook Air 13 Inch M3','CPU:  Apple M3100GB/s RAM:  16 GB Ổ cứng:  512 GB SSD Màn hình:  13.6\"Liquid Retina (2560 x 1664) Card màn hình:  Card tích hợp10 nhân GPU Cổng kết nối:  MagSafe 3Jack tai nghe 3.5 mm2 x Thunderbolt 3 / USB 4 (lên đến 40 Gb/s) Đặc biệt:  Có đèn bàn phím H',42990000,'images/macbookair13m3.jpg',1,'2024-04-15 20:36:10',5,1,40990000),(29,'Macbook Air 15 Inch M2','CPU:  Apple M2100GB/s RAM:  16 GB Ổ cứng:  256 GB SSD Màn hình:  15.3\"Liquid Retina (2880 x 1864) Card màn hình:  Card tích hợp10 nhân GPU Cổng kết nối:  MagSafe 3Jack tai nghe 3.5 mm2 x Thunderbolt / USB 4 (hỗ trợ DisplayPort, Thunderbolt 3 (up to 40Gb/s',44990000,'images/macbookair15m2.jpg',1,'2024-04-15 20:36:10',5,1,42990000),(30,'Apple Watch Series 9 GPS','Màn hình:  OLED1.9 inch Thời lượng pin:  Khoảng 36 giờ (ở chế độ Năng lượng thấp)Khoảng 18 giờ (ở chế độ sử dụng thông thường) Kết nối với hệ điều hành:  iPhone Xs trở lên chạy iOS 17 trở lên Mặt:  Ion-X strengthened glass41 mm Hãng: Apple.',13990000,'images/awseries9.jpg',1,'2024-04-15 21:06:22',3,0,0),(31,'Apple Watch SE 2023 GPS','Màn hình:  OLED Thời lượng pin:  Khoảng 18 giờ (ở chế độ sử dụng thông thường) Kết nối với hệ điều hành:  iPhone Xs trở lên chạy iOS 17 trở lên Mặt:  Ion-X strengthened glass44 mm Hãng  Apple.',9990000,'images/awse23.jpg',1,'2024-04-15 21:06:22',3,0,0),(32,'Apple Watch Ultra Titanium','Màn hình:  OLED1.92 inch Thời lượng pin:  Khoảng 60 giờ (ở chế độ tiết kiệm pin)Khoảng 36 giờ (ở chế độ sử dụng thông thường) Kết nối với hệ điều hành:  iPhone 8 trở lên với iOS phiên bản mới nhất Mặt:  Kính Sapphire49 mm Hãng  Apple',23990000,'images/awultra2.jpg',1,'2024-04-15 21:06:22',3,0,0),(33,'Samsung Galaxy Tab S9 FE+','Màn hình:  12.4\"TFT LCD Hệ điều hành:  Android 13 Chip:  Exynos 1380 8 nhân RAM:  8 GB Dung lượng lưu trữ:  128 GB Camera sau:  Chính 8 MP & Phụ 8 MP Camera trước:  12 MP Pin, Sạc:  10090 mAh45 W Hãng  Samsung.',16990000,'images/ssgalaxytabs9.jpg',1,'2024-04-15 21:06:22',2,0,14990000),(34,'Loa Bluetooth JBL Partybox Encore 2Mic','Tổng công suất:  100 W Nguồn:  Cắm điện hoặc pin Thời gian sử dụng:  Dùng khoảng 10 tiếngSạc khoảng 3.5 tiếng Kết nối không dây:  Bluetooth 5.1 Tiện ích:  Sạc được cho thiết bị khác (cổng USB)Kết nối cùng lúc 2 loaCó đèn LEDChống nước IPX42 Micro kèm theo',10390000,'images/jblpartyboxencore2mic.jpg',1,'2024-04-15 21:06:22',4,1,9699000),(35,'Loa Bluetooth JBL Partybox 110','Tổng công suất:  160 W Nguồn:  Pin Thời gian sử dụng:  Dùng khoảng 12 tiếngSạc khoảng 3.5 tiếng Kết nối không dây:  Bluetooth 5.1 Tiện ích:  Điều khiển bằng điện thoạiSạc được cho thiết bị khác (cổng USB)Kết nối cùng lúc 2 loaCó đèn LEDChống nước IPX4',10990000,'images/jblpartybox110.jpg',1,'2024-04-15 21:06:22',4,1,9790000),(36,'Loa JBL Authentics AUTH 500','Tổng công suất:  270 W Nguồn:  200 - 240V/50 - 60Hz Kết nối không dây:  WifiBluetooth 5.3 Tiện ích:  Sạc được cho thiết bị khác (Cổng Type C)Nghe nhạc trực tuyến qua kết nối WifiKết nối cùng lúc 2 loaGoogle AssistantChống nước IPX4Alexa',16900000,'images/jblauth500.jpg',1,'2024-04-15 21:06:22',4,0,0),(37,'Lenovo Ideapad Gaming 3','CPU:  Ryzen 55500H3.3GHz RAM:  16 GBDDR4 2 khe (1 khe 8 GB + 1 khe 8 GB)3200 MHz Ổ cứng:  Hỗ trợ khe cắm HDD SATA 2.5 inch mở rộng (nâng cấp tối đa 1 TB)512 GB SSD NVMe PCIe Gen 4.0 (Có thể tháo ra, lắp thanh khác tối đa 1 TB (2280) / 512 GB (2242)) Màn h',22590000,'images/lenovoideapadgaming3.jpg',1,'2024-04-15 21:06:22',5,1,21990000),(38,'Iphone 15 Pro Max','Màn hình:  OLED6.7\"Super Retina XDR Hệ điều hành:  iOS 17 Camera sau:  Chính 48 MP & Phụ 12 MP, 12 MP Camera trước:  12 MP Chip:  Apple A17 Pro 6 nhân RAM:  8 GB Dung lượng lưu trữ:  1 TB SIM:  1 Nano SIM & 1 eSIMHỗ trợ 5G Pin, Sạc:  4422 mAh20 W Hãng  iP',43990000,'images/iphone15promax.jpg',1,'2024-04-15 21:06:22',1,0,0),(39,'Oppo Find N3 5G','Màn hình:  AMOLEDChính 7.82\" & Phụ 6.31\"Quad HD+ (2K+) Hệ điều hành:  Android 13 Camera sau:  Chính 48 MP & Phụ 48 MP, 64 MP Camera trước:  Trong: 20 MP & Ngoài: 32 MP Chip:  Snapdragon 8 Gen 2 8 nhân RAM:  16 GB Dung lượng lưu trữ:  512 GB SIM:  2 Nano S',41990000,'images/oppofindn3.jpg',1,'2024-04-15 21:06:22',1,0,0),(40,'Samsung Galaxy Tab S9+','Màn hình:  12.4\"Dynamic AMOLED 2X Hệ điều hành:  Android 13 Chip:  Snapdragon 8 Gen 2 for Galaxy RAM:  12 GB Dung lượng lưu trữ:  256 GB Kết nối:  5GCó nghe gọi SIM:  1 Nano SIM & 1 eSIM Camera sau:  Chính 13 MP & Phụ 8 MP Camera trước:  12 MP Pin, Sạc:  ',34990000,'images/ssgalaxytabs9plus.jpg',1,'2024-04-15 21:06:22',2,0,0),(41,'Xiaomi 14 5G','Màn hình:  AMOLED6.36\"1.5K Hệ điều hành:  Android 14 Camera sau:  Chính 50 MP & Phụ 50 MP, 50 MP Camera trước:  32 MP Chip:  Snapdragon 8 Gen 3 RAM:  12 GB Dung lượng lưu trữ:  512 GB SIM:  2 Nano SIMHỗ trợ 5G Pin, Sạc:  4610 mAh90 W Hãng  Xiaomi',31990000,'images/xiaomi145g.jpg',1,'2024-04-15 21:06:22',1,0,29990000),(42,'Samsung Galaxy Z Fold 5 ','Màn hình:  Dynamic AMOLED 2XChính 7.6\" & Phụ 6.2\"Quad HD+ (2K+) Hệ điều hành:  Android 13 Camera sau:  Chính 50 MP & Phụ 12 MP, 10 MP Camera trước:  10 MP & 4 MP Chip:  Snapdragon 8 Gen 2 for Galaxy RAM:  12 GB Dung lượng lưu trữ:  1 TB SIM:  2 Nano SIM h',48990000,'images/ssgalaxyzfold5.jpg',1,'2024-04-18 03:06:03',1,0,0),(43,'Sạc Apple',NULL,550000,'images/sacapple.jpg',1,'2024-04-18 04:08:52',7,0,0),(44,'Sạc Samsung',NULL,475000,'images/sacsamsung.jpg',1,'2024-04-18 04:08:52',7,0,0),(45,'Cáp Type C Apple ',NULL,375000,'images/captypecapple.jpg',1,'2024-04-18 04:08:52',7,0,0),(46,'Cáp Lightning',NULL,369000,'images/caplightning.jpg',1,'2024-04-18 04:08:52',7,0,0),(47,'Cáp Type C',NULL,275000,'images/captypec.jpg',1,'2024-04-18 04:08:52',7,0,0),(48,'Cáp Micro USB',NULL,179000,'images/capmicrousb.jpg',1,'2024-04-18 04:08:52',7,0,0),(49,'Sạc dự phòng Baseus ioTa BPE45A ',NULL,5450000,'images/sacbaseus.jpg',1,'2024-04-18 04:08:52',7,1,4750000),(50,'Sạc dự phòng Samsung EB-P3400 ',NULL,980000,'images/sacduphongsamsung.jpg',1,'2024-04-18 04:08:52',7,1,750000),(51,'Tai nghe Shokz OPENRUN S803 ',NULL,3490000,'images/taingheshokz2.jpg',1,'2024-04-18 04:08:52',6,0,0),(52,'Tai nghe  Denon Perl Pro AHC15PLBKEM',NULL,8490000,'images/tainghedenon.jpg',1,'2024-04-18 04:08:52',6,1,7890000),(53,'Chuột Bluetooth Apple MK2E3 ',NULL,1790000,'images/chuotapple.jpg',1,'2024-04-18 04:08:52',8,0,0),(54,'Chuột  Gaming ASUS ROG Keris Aimpoint',NULL,2690000,'images/chuotasus1.jpg',1,'2024-04-18 04:08:52',8,1,2499000),(55,'Chuột Gaming ASUS ROG Gladius III',NULL,2290000,'images/chuotasus2.jpg',1,'2024-04-18 04:08:52',8,0,2199000),(56,'Chuột Gaming ASUS ROG Gladius III',NULL,1890000,'images/chuotasus3.jpg',1,'2024-04-18 04:08:52',8,0,0),(57,'Chuột Gaming MSI Clutch GM41 Lightweight V2',NULL,1490000,'images/chuotmsi.jpg',1,'2024-04-18 04:08:52',8,0,1299000),(58,'Chuột Silent Logitech Signature M650 ',NULL,1190000,'images/chuotlogitech.jpg',1,'2024-04-18 04:08:52',8,0,990000),(59,'Bàn phím Gaming Asus ROG Strix Scope NX TKL',NULL,3320000,'images/banphimasus.jpg',1,'2024-04-18 04:08:52',9,0,3190000),(60,'Bàn phím Apple Magic Keyboard',NULL,3240000,'images/banphimapple.jpg',1,'2024-04-18 04:08:52',9,0,0),(61,'Bàn Phím Gaming Razer Huntsman Tournamen',NULL,2485000,'images/banphimrazer.jpg',1,'2024-04-18 04:08:52',9,1,2200000),(62,'Bàn Phím Gaming MSI Vigor GK50 Elite',NULL,2250000,'images/banphimmsi.jpg',1,'2024-04-18 04:08:52',9,1,2150000),(63,'Bàn Phím Bluetooth Rapoo V700 - 8A',NULL,1390000,'images/banphimrapoo.jpg',1,'2024-04-18 04:08:52',9,0,0),(64,'Bàn Phím Bluetooth Dareu EK75 Pro',NULL,990000,'images/banphimdareu.jpg',1,'2024-04-18 04:08:52',9,1,810000),(65,'Bàn Phím Gaming Asus TUF K1',NULL,850000,'images/banphimasus2.jpg',1,'2024-04-18 04:08:52',9,1,729000),(66,'Ốp lưng iPhone 15 Pro Max Nhựa dẻo TPU Mipow Ultra',NULL,520000,'images/olip15.jpg',1,'2024-04-18 04:08:52',10,0,0),(67,'Ốp lưng MagSafe iPhone 15 Pro Max Nhựa',NULL,1100000,'images/olip152.jpg',1,'2024-04-18 04:08:52',10,0,990000),(68,'Ốp lưng MagSafe iPhone 15 Pro Max Nhựa cứng',NULL,320000,'images/olip153.jpg',1,'2024-04-18 04:08:52',10,0,299000),(69,'Ốp lưng Magsafe iPhone 15 Pro Max Vải tinh dệt',NULL,1090000,'images/olip154.jpg',1,'2024-04-18 04:08:52',10,0,0),(70,'Ốp lưng MagSafe iPhone 15 Pro Max IML UNI',NULL,665000,'images/olip155.jpg',1,'2024-04-18 04:08:52',10,1,559000),(71,'Ốp lưng Magsafe Galaxy Z Fold5 Nhựa cứng PC Araree',NULL,1090000,'images/opss1.jpg',1,'2024-04-18 04:08:52',10,0,989000),(72,'Ốp lưng Galaxy Z Fold5 Nhựa cứng viền dẻo Samsung ',NULL,780000,'images/olss2.jpg',1,'2024-04-18 04:08:52',10,0,0),(73,'Ốp lưng Galaxy Z Fold5 Da ECO Samsung',NULL,1950000,'images/olss3.jpg',1,'2024-04-18 04:08:52',10,0,1780000),(74,'Ốp lưng Galaxy Z Fold5 Samsung  Kèm S Pen ',NULL,1295000,'images/olss4.jpg',1,'2024-04-18 04:08:52',10,0,1180000),(75,'Bao da Galaxy Tab S9+ / Tab S9 FE+ Samsung ',NULL,2079000,'images/optabs9.jpg',1,'2024-04-18 04:08:52',10,0,1890000),(76,'Bao da Pad Pro 12.9 inch ESR Rebound Hybrid ',NULL,1390000,'images/opipadpro1.jpg',1,'2024-04-18 04:08:52',10,0,0),(77,'Bao da iPad Pro 11 inch ESR Rebound Hybrid',NULL,1250000,'images/opipadpro2.jpg',1,'2024-04-18 04:08:52',10,0,0),(78,'iPad Pro M2 11 inch WiFi ',NULL,27990000,'images/ipadpro11inch.jpg',1,'2024-04-18 04:08:52',2,1,25990000),(79,'Bao da Galaxy A54 Smart Clear View Samsung',NULL,779000,'images/opa541.jpg',1,'2024-04-18 04:08:52',10,0,0),(80,'Ốp lưng Galaxy A54 Silicone Samsung',NULL,390000,'images/opa542.jpg',1,'2024-04-18 04:08:52',10,0,349000),(81,'Bao da nắp gập iPad 10 UniQ Camden',NULL,849000,'images/opipad10.jpg',1,'2024-04-18 04:08:52',10,0,799000),(82,'Bao da nắp gập iPad Pro 11 inch UNIQ Rovus Magneti',NULL,1170000,'images/baoipadpro11.jpg',1,'2024-04-18 04:08:52',10,0,1070000),(83,'Samsung Galaxy Watch4 40mm','Màn hình:  SUPER AMOLED1.2 inch Thời lượng pin:  Khoảng 1.5 ngày Kết nối với hệ điều hành:  Android 7.0 trở lên dùng Google Mobile Service Mặt:  Kính cường lực Gorilla Glass Dx+40 mm Hãng  Samsung',3990000,'images/ssgalaxywatch4.jpg',1,'2024-04-22 18:07:12',3,0,0);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `receipt`
--

DROP TABLE IF EXISTS `receipt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `receipt` (
  `id` int NOT NULL AUTO_INCREMENT,
  `created_date` datetime DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `receipt_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `receipt`
--

LOCK TABLES `receipt` WRITE;
/*!40000 ALTER TABLE `receipt` DISABLE KEYS */;
INSERT INTO `receipt` VALUES (2,'2024-02-18 21:43:25',7),(3,'2024-03-22 19:23:36',1),(4,'2024-04-22 21:59:24',1),(5,'2024-04-23 00:15:10',7),(6,'2024-04-23 03:24:20',8);
/*!40000 ALTER TABLE `receipt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `receipt_detail`
--

DROP TABLE IF EXISTS `receipt_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `receipt_detail` (
  `receipt_id` int NOT NULL,
  `product_id` int NOT NULL,
  `quantity` int DEFAULT NULL,
  `unit_price` float DEFAULT NULL,
  PRIMARY KEY (`receipt_id`,`product_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `receipt_detail_ibfk_1` FOREIGN KEY (`receipt_id`) REFERENCES `receipt` (`id`),
  CONSTRAINT `receipt_detail_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `receipt_detail`
--

LOCK TABLES `receipt_detail` WRITE;
/*!40000 ALTER TABLE `receipt_detail` DISABLE KEYS */;
INSERT INTO `receipt_detail` VALUES (2,1,1,17990000),(2,3,1,13990000),(2,16,1,22990000),(2,17,1,26990000),(2,49,1,5450000),(2,52,1,8490000),(2,67,1,1100000),(2,69,1,1090000),(2,71,1,1090000),(3,3,1,13990000),(3,16,1,22990000),(3,17,1,26990000),(4,2,1,34550000),(4,4,1,27990000),(4,23,1,25990000),(4,25,1,25690000),(4,26,1,12990000),(4,39,1,41990000),(4,42,1,48990000),(5,3,1,11990000),(5,17,1,24990000),(5,25,1,25690000),(5,38,1,43990000),(5,53,1,1790000),(6,43,1,550000),(6,44,1,475000),(6,45,1,375000),(6,46,1,369000),(6,47,1,275000),(6,48,1,179000),(6,50,1,750000),(6,68,1,299000),(6,69,1,1090000),(6,71,1,989000),(6,73,1,1780000);
/*!40000 ALTER TABLE `receipt_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `avatar` varchar(100) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `active` tinyint(1) DEFAULT NULL,
  `joined_date` datetime DEFAULT NULL,
  `user_role` int DEFAULT NULL,
  `face_id` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'Thai Tuan','tuan171204','202cb962ac59075b964b07152d234b70','https://res.cloudinary.com/dr4hg7vdv/image/upload/v1712661406/fr9ol7dptpil39io5jha.webp','titofood17122004@gmail.com',1,'2024-04-09 18:15:26',2,0),(7,'Thai Tuan','tuan171205','202cb962ac59075b964b07152d234b70','https://res.cloudinary.com/dr4hg7vdv/image/upload/v1713273657/anrqdjtn2pbo1fup5wgv.webp','titofood17122004@gmail.com',1,'2024-04-16 20:20:22',1,1),(8,'Obama','Obama','202cb962ac59075b964b07152d234b70','https://res.cloudinary.com/dr4hg7vdv/image/upload/v1713274497/euj92xqawblz1vy9hm1u.jpg','titofood17122004@gmail.com',1,'2024-04-16 20:34:14',1,0);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-04-24  0:22:20
