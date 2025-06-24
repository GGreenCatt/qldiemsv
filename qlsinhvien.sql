-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: localhost    Database: qldiemsv
-- ------------------------------------------------------
-- Server version	8.0.41

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
-- Table structure for table `chuongtrinhdaotao`
--

DROP TABLE IF EXISTS `chuongtrinhdaotao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chuongtrinhdaotao` (
  `ID_CTDT` int NOT NULL AUTO_INCREMENT,
  `MA_CTDT` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `TEN_CTDT` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `SOTC` float DEFAULT NULL,
  `MA_NGANH` char(50) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`ID_CTDT`),
  UNIQUE KEY `MA_CTDT` (`MA_CTDT`),
  KEY `chuongtrinhdaotao_ibfk_1` (`MA_NGANH`),
  CONSTRAINT `chuongtrinhdaotao_ibfk_1` FOREIGN KEY (`MA_NGANH`) REFERENCES `nganh` (`MA_NGANH`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chuongtrinhdaotao`
--

LOCK TABLES `chuongtrinhdaotao` WRITE;
/*!40000 ALTER TABLE `chuongtrinhdaotao` DISABLE KEYS */;
/*!40000 ALTER TABLE `chuongtrinhdaotao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `diem`
--

DROP TABLE IF EXISTS `diem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `diem` (
  `SBD` int NOT NULL AUTO_INCREMENT,
  `MA_SV` int NOT NULL,
  `MA_MH` char(10) COLLATE utf8mb4_general_ci NOT NULL,
  `CC` float DEFAULT NULL,
  `KT1` float DEFAULT NULL,
  `KT2` float DEFAULT NULL,
  `KT3` float DEFAULT NULL,
  `THI1` float DEFAULT NULL,
  `THI2` float DEFAULT NULL,
  `THI3` float DEFAULT NULL,
  PRIMARY KEY (`SBD`),
  UNIQUE KEY `MA_SV` (`MA_SV`,`MA_MH`),
  KEY `MA_MH` (`MA_MH`),
  CONSTRAINT `diem_ibfk_1` FOREIGN KEY (`MA_SV`) REFERENCES `sinhvien` (`MA_SV`),
  CONSTRAINT `diem_ibfk_2` FOREIGN KEY (`MA_MH`) REFERENCES `monhoc` (`MA_MH`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `diem`
--

LOCK TABLES `diem` WRITE;
/*!40000 ALTER TABLE `diem` DISABLE KEYS */;
INSERT INTO `diem` VALUES (1,1,'IT05',10,8.5,NULL,NULL,7,NULL,NULL),(3,3,'TT01',10,5,2,6,2,6,2),(4,4,'DS22',3,4,5,2,6,2,3),(5,4,'IT05',10,5,2,6,2,6,2),(6,2,'TT01',3,4,5,2,6,2,3),(7,6,'TT01',10,5,2,6,2,6,2),(8,5,'TIT203',3,4,5,2,6,2,3),(9,8,'DS22',10,5,2,6,2,6,2),(10,7,'TIT203',3,4,5,2,6,2,3),(11,1,'TT01',10,5,2,6,2,6,2),(12,1,'DS22',10,8.5,NULL,NULL,7,NULL,NULL),(37,2,'IT05',NULL,1,1,1,1,1,1);
/*!40000 ALTER TABLE `diem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `giangvien`
--

DROP TABLE IF EXISTS `giangvien`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `giangvien` (
  `ID_GV` int NOT NULL AUTO_INCREMENT,
  `MA_GV` int DEFAULT NULL,
  `TEN_GV` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `DIACHI` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `SDT` int DEFAULT NULL,
  `GMAIL` char(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`ID_GV`),
  UNIQUE KEY `MA_GV` (`MA_GV`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `giangvien`
--

LOCK TABLES `giangvien` WRITE;
/*!40000 ALTER TABLE `giangvien` DISABLE KEYS */;
INSERT INTO `giangvien` VALUES (1,1,'Nguyễn Văn A','Hà Nội',235353,'A@gmail.com'),(2,2,'Nguyễn Văn B','Việt Nam',345345,'B@gmail.com'),(3,3,'Nguyễn Văn C','Hà Nội',235235,'C@gmail.com');
/*!40000 ALTER TABLE `giangvien` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `he_dao_tao`
--

DROP TABLE IF EXISTS `he_dao_tao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `he_dao_tao` (
  `ID_HE` int NOT NULL AUTO_INCREMENT,
  `TEN_HE` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `MA_HE` char(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`ID_HE`),
  UNIQUE KEY `MA_HE` (`MA_HE`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `he_dao_tao`
--

LOCK TABLES `he_dao_tao` WRITE;
/*!40000 ALTER TABLE `he_dao_tao` DISABLE KEYS */;
/*!40000 ALTER TABLE `he_dao_tao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `khoa`
--

DROP TABLE IF EXISTS `khoa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `khoa` (
  `ID_KHOA` int NOT NULL AUTO_INCREMENT,
  `TEN_KHOA` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `MA_KHOA` char(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`ID_KHOA`),
  UNIQUE KEY `MA_KHOA` (`MA_KHOA`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `khoa`
--

LOCK TABLES `khoa` WRITE;
/*!40000 ALTER TABLE `khoa` DISABLE KEYS */;
/*!40000 ALTER TABLE `khoa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `khoahoc`
--

DROP TABLE IF EXISTS `khoahoc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `khoahoc` (
  `ID_KH` int NOT NULL AUTO_INCREMENT,
  `TEN_KH` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `MA_KH` char(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`ID_KH`),
  UNIQUE KEY `MA_KH` (`MA_KH`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `khoahoc`
--

LOCK TABLES `khoahoc` WRITE;
/*!40000 ALTER TABLE `khoahoc` DISABLE KEYS */;
INSERT INTO `khoahoc` VALUES (3,'Khóa 10','K10'),(4,'Khóa 11','K11');
/*!40000 ALTER TABLE `khoahoc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lop`
--

DROP TABLE IF EXISTS `lop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lop` (
  `ID_LOP` int NOT NULL AUTO_INCREMENT,
  `TEN_LOP` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `MA_LOP` char(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `MA_MH` char(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `MA_GV` int DEFAULT NULL,
  `SISO` int DEFAULT NULL,
  PRIMARY KEY (`ID_LOP`),
  UNIQUE KEY `MA_LOP` (`MA_LOP`),
  KEY `lop_ibfk_1` (`MA_GV`),
  KEY `lop_ibfk_2` (`MA_MH`),
  CONSTRAINT `lop_ibfk_1` FOREIGN KEY (`MA_GV`) REFERENCES `giangvien` (`MA_GV`),
  CONSTRAINT `lop_ibfk_2` FOREIGN KEY (`MA_MH`) REFERENCES `monhoc` (`MA_MH`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lop`
--

LOCK TABLES `lop` WRITE;
/*!40000 ALTER TABLE `lop` DISABLE KEYS */;
INSERT INTO `lop` VALUES (1,'Tính toán số','TTC01','TT01',1,60),(2,'Đại số','DS001','DS22',3,60),(3,'Kiến trúc máy tính','IT05','IT05',3,NULL),(4,'Tin đại cương','IT203','TIT203',1,62),(5,'Lớp 3','lop3','IT05',2,40),(6,'Lớp 4','lop4','IT05',2,40);
/*!40000 ALTER TABLE `lop` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lopcv`
--

DROP TABLE IF EXISTS `lopcv`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lopcv` (
  `ID_LOPCV` int NOT NULL AUTO_INCREMENT,
  `TEN_LOPCV` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `MA_GV` int NOT NULL,
  `MA_KH` char(50) COLLATE utf8mb4_general_ci NOT NULL,
  `MA_LOPCV` int NOT NULL,
  PRIMARY KEY (`ID_LOPCV`),
  KEY `lopcv_ibfk_1` (`MA_KH`),
  KEY `lopcv_ibfk_2` (`MA_GV`),
  CONSTRAINT `lopcv_ibfk_1` FOREIGN KEY (`MA_KH`) REFERENCES `khoahoc` (`MA_KH`),
  CONSTRAINT `lopcv_ibfk_2` FOREIGN KEY (`MA_GV`) REFERENCES `giangvien` (`MA_GV`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lopcv`
--

LOCK TABLES `lopcv` WRITE;
/*!40000 ALTER TABLE `lopcv` DISABLE KEYS */;
INSERT INTO `lopcv` VALUES (1,'K10-CNTTA',1,'K10',1),(2,'K10-CNTTB',2,'K10',2),(3,'K11-CNTTA',3,'K11',3);
/*!40000 ALTER TABLE `lopcv` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `monhoc`
--

DROP TABLE IF EXISTS `monhoc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `monhoc` (
  `ID_MH` int NOT NULL AUTO_INCREMENT,
  `TEN_MH` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `MA_MH` char(10) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `SOTC` float DEFAULT NULL,
  `THELOAI` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `HinhThucDanhGia` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `%TINH` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`ID_MH`),
  UNIQUE KEY `MA_MH` (`MA_MH`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `monhoc`
--

LOCK TABLES `monhoc` WRITE;
/*!40000 ALTER TABLE `monhoc` DISABLE KEYS */;
INSERT INTO `monhoc` VALUES (3,'Đại số','DS22',3,'Bắt buộc','Tự luận','40-60'),(5,'Kiến trúc máy tính','IT05',2,'Bắt buộc','Tự luận','50-50'),(9,'Tính toán số','TT01',3,'Bắt buộc','Tự luận','40-60'),(10,'Tin đại cương','TIT203',3,'Bắt buộc','Thực hành','40-60');
/*!40000 ALTER TABLE `monhoc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nganh`
--

DROP TABLE IF EXISTS `nganh`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nganh` (
  `ID_NGANH` int NOT NULL AUTO_INCREMENT,
  `TEN_NGANH` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `MA_NGANH` char(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `MA_KHOA` char(50) COLLATE utf8mb4_general_ci NOT NULL,
  `MA_HE` char(50) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`ID_NGANH`),
  KEY `MA_NGANH` (`MA_NGANH`),
  KEY `nganh_ibfk_1` (`MA_KHOA`),
  KEY `nganh_ibfk_2` (`MA_HE`),
  CONSTRAINT `nganh_ibfk_1` FOREIGN KEY (`MA_KHOA`) REFERENCES `khoa` (`MA_KHOA`),
  CONSTRAINT `nganh_ibfk_2` FOREIGN KEY (`MA_HE`) REFERENCES `he_dao_tao` (`MA_HE`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nganh`
--

LOCK TABLES `nganh` WRITE;
/*!40000 ALTER TABLE `nganh` DISABLE KEYS */;
/*!40000 ALTER TABLE `nganh` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phanhoi`
--

DROP TABLE IF EXISTS `phanhoi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `phanhoi` (
  `MA_PH` int NOT NULL AUTO_INCREMENT,
  `TEN_PH` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `MA_SV` int NOT NULL,
  `NguoiNhan` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `MA_NguoiNhan` int DEFAULT NULL,
  `TinNhan` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `TraLoi` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`MA_PH`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phanhoi`
--

LOCK TABLES `phanhoi` WRITE;
/*!40000 ALTER TABLE `phanhoi` DISABLE KEYS */;
INSERT INTO `phanhoi` VALUES (17,'12345678',1,'GV',1,'24680vbn,./bnm,','trả lời'),(18,'Chủ đề',1,'GV',1,'oàihawiofnwaifiwaof','jsknjksfnjksfs'),(19,'Phản hồi',1,'AD',0,'Đây là tin nhắn phản hồi',NULL);
/*!40000 ALTER TABLE `phanhoi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `ID_ROLE` int NOT NULL AUTO_INCREMENT,
  `TEN_ROLE` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `ROLE` int DEFAULT NULL,
  PRIMARY KEY (`ID_ROLE`),
  UNIQUE KEY `ROLE` (`ROLE`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'ADMIN',NULL),(2,'Giảng viên',NULL),(3,'Sinh viên',NULL);
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sinhvien`
--

DROP TABLE IF EXISTS `sinhvien`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sinhvien` (
  `ID_SV` int NOT NULL AUTO_INCREMENT,
  `MA_SV` int DEFAULT NULL,
  `TEN_SV` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `SDT` int DEFAULT NULL,
  `DIACHI` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `GIOITINH` varchar(5) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `NGAYSINH` date DEFAULT NULL,
  `GMAIL` char(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `MA_KH` char(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`ID_SV`),
  UNIQUE KEY `MA_SV` (`MA_SV`),
  KEY `MA_KH` (`MA_KH`),
  CONSTRAINT `sinhvien_ibfk_1` FOREIGN KEY (`MA_KH`) REFERENCES `khoahoc` (`MA_KH`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sinhvien`
--

LOCK TABLES `sinhvien` WRITE;
/*!40000 ALTER TABLE `sinhvien` DISABLE KEYS */;
INSERT INTO `sinhvien` VALUES (8,1,'Nguyễn Văn A',235235235,'Hà Nội','Nam','2004-06-21','A@gmail.com','K10'),(9,2,'Nguyễn Văn B',35253253,'B@gmail.com','Nam','2004-07-21','B@gmail.com','K10'),(10,3,'Nguyễn Văn C',23233523,'Hải Phòng','Nu','2004-01-21','C@gmail.com','K10'),(11,4,'Nguyễn Văn D',23423442,'Thái Nguyên','Nu','2004-01-01','D@gmail.com','K10'),(12,5,'Nguyễn Văn E',21421425,'Thái Nguyên','Nam','2004-02-02','E@gmail.com','K10'),(13,6,'Nguyễn Văn F',2342424,'Hà Nội','Nu','2004-12-02','F@gmail.com','K10'),(14,7,'Nguyễn Văn G',14124124,'Hải Phòng','Nu','2004-05-02','G@gmail.com','K10'),(15,8,'Nguyễn Văn H',35235235,'Hà Nội','Nam','2004-11-22','H@gmail.com','K10'),(16,9,'Nguyễn Văn I',242142344,'Hà Nội','Nam','2004-04-02','I@gmail.com','K10'),(17,10,'Nguyễn Văn J',232535235,'Thái Nguyên','Nam','2004-02-11','J@gmail.com','K10');
/*!40000 ALTER TABLE `sinhvien` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sinhvien_lopcv`
--

DROP TABLE IF EXISTS `sinhvien_lopcv`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sinhvien_lopcv` (
  `MA_SV` int NOT NULL,
  `MA_LOPCV` int NOT NULL,
  PRIMARY KEY (`MA_SV`),
  KEY `sinhvien_lopcv_ibfk_2` (`MA_LOPCV`),
  CONSTRAINT `sinhvien_lopcv_ibfk_1` FOREIGN KEY (`MA_SV`) REFERENCES `sinhvien` (`MA_SV`),
  CONSTRAINT `sinhvien_lopcv_ibfk_2` FOREIGN KEY (`MA_LOPCV`) REFERENCES `lopcv` (`ID_LOPCV`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sinhvien_lopcv`
--

LOCK TABLES `sinhvien_lopcv` WRITE;
/*!40000 ALTER TABLE `sinhvien_lopcv` DISABLE KEYS */;
INSERT INTO `sinhvien_lopcv` VALUES (1,1),(2,1),(3,1),(4,1),(5,1),(6,2),(7,2),(8,2),(9,2),(10,2);
/*!40000 ALTER TABLE `sinhvien_lopcv` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `taikhoan`
--

DROP TABLE IF EXISTS `taikhoan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `taikhoan` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `TEN` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `USERNAME` char(100) COLLATE utf8mb4_general_ci NOT NULL,
  `PASSWORD` char(100) COLLATE utf8mb4_general_ci NOT NULL,
  `ROLE` int DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `USERNAME` (`USERNAME`),
  KEY `taikhoan_ibfk_1` (`ROLE`),
  CONSTRAINT `taikhoan_ibfk_1` FOREIGN KEY (`ROLE`) REFERENCES `roles` (`ID_ROLE`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `taikhoan`
--

LOCK TABLES `taikhoan` WRITE;
/*!40000 ALTER TABLE `taikhoan` DISABLE KEYS */;
INSERT INTO `taikhoan` VALUES (3,'Nguyễn Văn Bảo Long','SV00001','Baolong',3),(4,'Lê Mỹ Dung','GV00001','Mydung',2),(5,'Nguyễn Văn Bảo Long','ADMIN00001','Baolong',1);
/*!40000 ALTER TABLE `taikhoan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `thamgiahoc`
--

DROP TABLE IF EXISTS `thamgiahoc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `thamgiahoc` (
  `MA_LOP` char(50) COLLATE utf8mb4_general_ci NOT NULL,
  `MA_SV` int NOT NULL,
  `CC` float DEFAULT NULL,
  `KT1` float DEFAULT NULL,
  `KT2` float DEFAULT NULL,
  `KT3` float DEFAULT NULL,
  PRIMARY KEY (`MA_LOP`,`MA_SV`),
  KEY `thamgiahoc_ibfk_2` (`MA_SV`),
  CONSTRAINT `thamgiahoc_ibfk_1` FOREIGN KEY (`MA_LOP`) REFERENCES `lop` (`MA_LOP`),
  CONSTRAINT `thamgiahoc_ibfk_2` FOREIGN KEY (`MA_SV`) REFERENCES `sinhvien` (`MA_SV`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `thamgiahoc`
--

LOCK TABLES `thamgiahoc` WRITE;
/*!40000 ALTER TABLE `thamgiahoc` DISABLE KEYS */;
INSERT INTO `thamgiahoc` VALUES ('DS001',1,NULL,NULL,NULL,NULL),('DS001',2,NULL,NULL,NULL,NULL),('DS001',6,NULL,NULL,NULL,NULL),('DS001',7,NULL,NULL,NULL,NULL),('DS001',8,NULL,NULL,NULL,NULL),('IT05',1,NULL,NULL,NULL,NULL),('IT05',2,NULL,NULL,NULL,NULL),('IT05',3,NULL,NULL,NULL,NULL),('IT05',4,NULL,NULL,NULL,NULL),('IT203',1,NULL,NULL,NULL,NULL),('IT203',2,NULL,NULL,NULL,NULL),('IT203',5,NULL,NULL,NULL,NULL),('IT203',6,NULL,NULL,NULL,NULL),('TTC01',2,NULL,NULL,NULL,NULL),('TTC01',6,NULL,NULL,NULL,NULL),('TTC01',8,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `thamgiahoc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tinchi`
--

DROP TABLE IF EXISTS `tinchi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tinchi` (
  `ID_TC` int NOT NULL AUTO_INCREMENT,
  `SOTC` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `MATC` char(10) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`ID_TC`),
  UNIQUE KEY `MATC` (`MATC`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tinchi`
--

LOCK TABLES `tinchi` WRITE;
/*!40000 ALTER TABLE `tinchi` DISABLE KEYS */;
/*!40000 ALTER TABLE `tinchi` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-06-24 17:42:22
