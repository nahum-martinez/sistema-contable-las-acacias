-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: contabilidadvla
-- ------------------------------------------------------
-- Server version	8.0.40

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `bitacora_partida_contable`
--

DROP TABLE IF EXISTS `bitacora_partida_contable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bitacora_partida_contable` (
  `id_bit_movdia` bigint NOT NULL AUTO_INCREMENT,
  `cod_movmaestro` bigint DEFAULT NULL,
  `fecha_movmaestro` datetime DEFAULT NULL,
  `id_estado_anterior` int DEFAULT NULL,
  `id_estado_actual` int DEFAULT NULL,
  `total_debe` double DEFAULT '0',
  `total_haber` double DEFAULT '0',
  `user_movmaestro` varchar(100) DEFAULT NULL,
  `evento` varchar(100) DEFAULT NULL,
  `fecha_ingreso` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_bit_movdia`),
  KEY `bitacora_partida_contable_movimientos_maestros_FK` (`cod_movmaestro`),
  KEY `bitacora_partida_contable_estados_FK` (`id_estado_anterior`),
  KEY `bitacora_partida_contable_estados_FK_1` (`id_estado_actual`),
  CONSTRAINT `bitacora_partida_contable_estados_FK` FOREIGN KEY (`id_estado_anterior`) REFERENCES `estados` (`id`),
  CONSTRAINT `bitacora_partida_contable_estados_FK_1` FOREIGN KEY (`id_estado_actual`) REFERENCES `estados` (`id`),
  CONSTRAINT `bitacora_partida_contable_movimientos_maestros_FK` FOREIGN KEY (`cod_movmaestro`) REFERENCES `movimientos_maestros` (`cod_movmaestro`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bitacora_partida_contable`
--

LOCK TABLES `bitacora_partida_contable` WRITE;
/*!40000 ALTER TABLE `bitacora_partida_contable` DISABLE KEYS */;
/*!40000 ALTER TABLE `bitacora_partida_contable` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalogo_cuentas`
--

DROP TABLE IF EXISTS `catalogo_cuentas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `catalogo_cuentas` (
  `cod_cuenta` int NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `cod_grupo` int NOT NULL,
  `cod_padre` int DEFAULT NULL,
  `fec_registro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `prioridad` int NOT NULL,
  PRIMARY KEY (`cod_cuenta`),
  KEY `cod_grupo` (`cod_grupo`),
  KEY `cod_padre` (`cod_padre`),
  CONSTRAINT `catalogo_cuentas_ibfk_1` FOREIGN KEY (`cod_grupo`) REFERENCES `grupos` (`cod_grupo`),
  CONSTRAINT `catalogo_cuentas_ibfk_2` FOREIGN KEY (`cod_padre`) REFERENCES `catalogo_cuentas` (`cod_cuenta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalogo_cuentas`
--

LOCK TABLES `catalogo_cuentas` WRITE;
/*!40000 ALTER TABLE `catalogo_cuentas` DISABLE KEYS */;
INSERT INTO `catalogo_cuentas` VALUES (1,'Activos',1,NULL,'2024-11-23 16:29:32',0),(2,'Pasivos',2,NULL,'2024-11-23 16:29:32',0),(3,'Patrimonio',3,NULL,'2024-11-23 16:29:32',0),(4,'Ingresos',4,NULL,'2024-11-23 16:29:32',0),(5,'Gastos',5,NULL,'2024-11-23 16:29:32',0),(6,'Costos',6,NULL,'2024-11-23 16:29:32',0),(110,'Activo Correinte',1,1,'2024-11-23 23:19:41',1),(11010,'Caja Chica',1,110,'2024-11-23 23:19:46',2),(11011,'Bancos',1,110,'2024-11-23 23:19:54',2);
/*!40000 ALTER TABLE `catalogo_cuentas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estados`
--

DROP TABLE IF EXISTS `estados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estados` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) DEFAULT NULL,
  `grupo` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estados`
--

LOCK TABLES `estados` WRITE;
/*!40000 ALTER TABLE `estados` DISABLE KEYS */;
INSERT INTO `estados` VALUES (1,'Activo','USUARIO'),(2,'Inactivo','USUARIO'),(3,'Ingresada','LIBRO_DIARIO'),(4,'Anulada','LIBRO_DIARIO');
/*!40000 ALTER TABLE `estados` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grupos`
--

DROP TABLE IF EXISTS `grupos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `grupos` (
  `cod_grupo` int NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `tip_naturaleza` enum('acreedora','deudora') NOT NULL,
  PRIMARY KEY (`cod_grupo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grupos`
--

LOCK TABLES `grupos` WRITE;
/*!40000 ALTER TABLE `grupos` DISABLE KEYS */;
INSERT INTO `grupos` VALUES (1,'Activos','deudora'),(2,'Pasivos','acreedora'),(3,'Patrimonio','acreedora'),(4,'Ingresos','acreedora'),(5,'Gastos','deudora'),(6,'Costos','deudora');
/*!40000 ALTER TABLE `grupos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movimientos_diarios`
--

DROP TABLE IF EXISTS `movimientos_diarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `movimientos_diarios` (
  `cod_movdia` bigint NOT NULL AUTO_INCREMENT,
  `cod_cuenta` int NOT NULL,
  `concepto_movdia` varchar(300) DEFAULT NULL,
  `fecha_movdia` datetime DEFAULT NULL,
  `debe_movdia` double DEFAULT NULL,
  `haber_movdia` double DEFAULT NULL,
  `cod_movmaestro` bigint NOT NULL,
  `id_estado` int DEFAULT '3',
  PRIMARY KEY (`cod_movdia`),
  KEY `movimientos_diarios_movimientos_maestros_FK` (`cod_movmaestro`),
  KEY `movimientos_diarios_catalogo_cuentas_FK` (`cod_cuenta`),
  KEY `movimientos_diarios_estados_FK` (`id_estado`),
  CONSTRAINT `movimientos_diarios_catalogo_cuentas_FK` FOREIGN KEY (`cod_cuenta`) REFERENCES `catalogo_cuentas` (`cod_cuenta`),
  CONSTRAINT `movimientos_diarios_estados_FK` FOREIGN KEY (`id_estado`) REFERENCES `estados` (`id`),
  CONSTRAINT `movimientos_diarios_movimientos_maestros_FK` FOREIGN KEY (`cod_movmaestro`) REFERENCES `movimientos_maestros` (`cod_movmaestro`)
) ENGINE=InnoDB AUTO_INCREMENT=108 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movimientos_diarios`
--

LOCK TABLES `movimientos_diarios` WRITE;
/*!40000 ALTER TABLE `movimientos_diarios` DISABLE KEYS */;
INSERT INTO `movimientos_diarios` VALUES (98,11010,'fdsfdsf','2024-11-23 00:00:00',5000,0,41,3),(99,11011,'asdfdssad','2024-11-23 00:00:00',0,5000,41,3),(100,11010,'dsasadasd','2024-11-23 00:00:00',10500,0,42,3),(101,11011,'sadsadsad','2024-11-23 00:00:00',0,10500,42,3),(102,2,'sadasdsad','2024-11-23 00:00:00',5450,0,42,3),(103,5,'sadsadsad','2024-11-23 00:00:00',0,5450,42,3),(104,11010,'dsafsafsad','2024-11-23 00:00:00',5000,0,43,3),(105,11011,'sadsad','2024-11-23 00:00:00',0,5000,43,3),(106,3,'dfsdfsdf','2024-11-22 00:00:00',10500,0,44,3),(107,11011,'dsafdsafasdf','2024-11-22 00:00:00',0,10500,44,3);
/*!40000 ALTER TABLE `movimientos_diarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movimientos_maestros`
--

DROP TABLE IF EXISTS `movimientos_maestros`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `movimientos_maestros` (
  `cod_movmaestro` bigint NOT NULL AUTO_INCREMENT,
  `fecha_movmaestro` datetime DEFAULT NULL,
  `fecha_ingreso` datetime DEFAULT CURRENT_TIMESTAMP,
  `user_movmaestro` varchar(100) DEFAULT NULL,
  `total_debe` double DEFAULT '0',
  `total_haber` double DEFAULT '0',
  `id_estado` int DEFAULT '3',
  PRIMARY KEY (`cod_movmaestro`),
  KEY `movimientos_maestros_estados_FK` (`id_estado`),
  CONSTRAINT `movimientos_maestros_estados_FK` FOREIGN KEY (`id_estado`) REFERENCES `estados` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movimientos_maestros`
--

LOCK TABLES `movimientos_maestros` WRITE;
/*!40000 ALTER TABLE `movimientos_maestros` DISABLE KEYS */;
INSERT INTO `movimientos_maestros` VALUES (41,'2024-11-23 00:00:00','2024-11-24 03:36:10','nahum.martinez',5000,5000,3),(42,'2024-11-23 00:00:00','2024-11-24 04:28:15','nahum.martinez',15950,15950,3),(43,'2024-11-23 00:00:00','2024-11-24 05:18:09','nahum.martinez',5000,5000,3),(44,'2024-11-22 00:00:00','2024-11-24 05:34:36','nahum.martinez',10500,10500,3);
/*!40000 ALTER TABLE `movimientos_maestros` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `tr_insert_bit_partida_contable` AFTER INSERT ON `movimientos_maestros` FOR EACH ROW BEGIN 
	INSERT INTO bitacora_partida_contable
		(cod_movmaestro, fecha_movmaestro, id_estado_anterior,id_estado_actual,
		total_debe, total_haber, user_movmaestro, evento)
	VALUES(NEW.cod_movmaestro, NEW.fecha_movmaestro, NEW.id_estado, NEW.id_estado,
		NEW.total_debe, NEW.total_haber, NEW.user_movmaestro, 'NUEVA_PARTIDA');
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `tr_update_bit_partida_contable` AFTER UPDATE ON `movimientos_maestros` FOR EACH ROW BEGIN 
	INSERT INTO bitacora_partida_contable
		(cod_movmaestro, fecha_movmaestro, id_estado_anterior,id_estado_actual,
		total_debe, total_haber, user_movmaestro, evento)
	VALUES(NEW.cod_movmaestro, NEW.fecha_movmaestro, OLD.id_estado, NEW.id_estado,
		NEW.total_debe, NEW.total_haber, NEW.user_movmaestro, 'ANULA_PARTIDA');
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `id` char(36) NOT NULL DEFAULT (uuid()),
  `codigo` varchar(50) NOT NULL,
  `usuario` varchar(100) NOT NULL,
  `contrasenia` varchar(60) NOT NULL,
  `nombres` varchar(100) NOT NULL,
  `apellidos` varchar(100) NOT NULL,
  `fec_registro` datetime DEFAULT CURRENT_TIMESTAMP,
  `fec_modificacion` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `estado` tinyint(1) DEFAULT '1',
  `correo_electronico` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `usuario` (`usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES ('1eded5c7-a9b8-11ef-bfe2-0242ac120002','USER-0001','admin','$2b$10$ujwCP0Hsk0dYTP5zaUFIH.wcsINDxkJ/xWu9IqpGpqt4idf1te17i','Admin','System','2024-11-23 16:29:32','2024-11-24 05:06:43',1,'admin@gmail.com');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'contabilidadvla'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-23 23:40:50
