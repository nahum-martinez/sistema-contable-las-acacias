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
  `permanente` tinyint(1) DEFAULT '0',
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
INSERT INTO `catalogo_cuentas` VALUES (1,'Activo',1,NULL,'2024-11-21 05:24:02',0,1),(2,'Pasivo',2,NULL,'2024-11-21 05:24:02',0,1),(3,'Patrimonio',3,NULL,'2024-11-21 05:24:02',0,1),(4,'Ingresos',4,NULL,'2024-11-21 05:24:02',0,1),(5,'Gastos',5,NULL,'2024-11-21 05:24:02',0,1),(6,'Costos',6,NULL,'2024-11-21 05:24:02',0,1),(110,'Activo Corriente',1,1,'2024-11-24 05:10:04',1,1),(111,'Activo No Corriente',1,1,'2024-11-24 05:10:19',1,1),(210,'Pasivo Corriente',2,2,'2024-11-24 05:10:50',1,1),(211,'Pasivo No Corriente',2,2,'2024-11-24 05:11:04',1,1),(310,'Patrimonio',3,3,'2024-11-24 17:18:15',1,1),(410,'Ingresos',4,4,'2024-11-24 17:25:32',1,1),(510,'Gastos',5,5,'2024-11-24 17:45:17',1,1),(610,'Costos',6,6,'2024-11-24 17:54:58',1,1),(11010,'Caja General',1,110,'2024-11-24 13:44:02',2,0),(11011,'Bancos',1,110,'2024-11-24 13:44:16',2,0),(11012,'Cuentas por Cobrar',1,110,'2024-11-24 13:44:34',2,0),(11013,'Inventarios',1,110,'2024-11-24 13:44:47',2,0),(11110,'Edificios',1,111,'2024-11-24 13:49:38',2,0),(11111,'Terreno',1,111,'2024-11-24 13:49:55',2,0),(11112,'Mobiliario y Equipo de Oficina',1,111,'2024-11-24 13:50:13',2,0),(11113,'Equipo de RecreaciÃ³n',1,111,'2024-11-24 13:50:59',2,0),(11114,'Equipo de Aseo',1,111,'2024-11-24 13:51:19',2,0),(11115,'Equipo de Vigilancia',1,111,'2024-11-24 13:52:02',2,0),(21010,'Cuentas Por Pagar',2,210,'2024-11-24 14:01:44',2,0),(21011,'Aguinaldo Por Pagar',2,210,'2024-11-24 14:03:01',2,0),(21012,'Catorceavo Mes Por Pagar',2,210,'2024-11-24 14:03:17',2,0),(21013,'Impuestos Por Pagar',2,210,'2024-11-24 14:03:46',2,0),(21014,'PrÃ©stamos a Corto Plazo',2,210,'2024-11-24 14:04:35',2,0),(21015,'Intereses Por Pagar',2,210,'2024-11-24 14:05:13',2,0),(21016,'Provisiones Para Beneficios a Empleados',2,210,'2024-11-24 14:05:30',2,0),(21017,'Obligaciones Sociales Por Pagar',2,210,'2024-11-24 14:05:42',2,0),(21018,'Dividendos Por Pagar',2,210,'2024-11-24 14:05:58',2,0),(21019,'Anticipos De Clientes',2,210,'2024-11-24 14:06:44',2,0),(21020,'Sueldos y Salarios Por Pagar',2,210,'2024-11-24 15:48:15',2,0),(21110,'PrÃ©stamos a Largo Plazo',2,211,'2024-11-24 16:04:29',2,0),(21111,'Obligaciones Por Pagar A Largo Plazo',2,211,'2024-11-24 16:06:56',2,0),(21112,'Hipotecas Por Pagar',2,211,'2024-11-24 16:08:19',2,0),(21113,'Bonos Por Pagar',2,211,'2024-11-24 16:08:37',2,0),(21114,'Provisiones Para Beneficios Post-empleo',2,211,'2024-11-24 16:11:13',2,0),(21115,'Provisiones Para Indemnizaciones',2,211,'2024-11-24 16:12:10',2,0),(21116,'Pasivos Diferidos a Largo Plazo',2,211,'2024-11-24 16:12:36',2,0),(21117,'Provisiones Para Contingencias',2,211,'2024-11-24 16:13:13',2,0),(31010,'Capital Social',3,310,'2024-11-24 17:18:32',2,0),(31011,'Fondo De Reserva Legal',3,310,'2024-11-24 17:18:54',2,0),(31012,'Utilidades o PÃ©rdidas Acumuladas',3,310,'2024-11-24 17:19:30',2,0),(31013,'Utilidades O PÃ©rdidas Del Ejercicion',3,310,'2024-11-24 17:21:47',2,0),(41010,'Ingresos De OperaciÃ³n O Ordinarios',4,410,'2024-11-24 17:26:12',2,0),(41011,'Ingresos Por Servicios',4,410,'2024-11-24 17:26:27',2,0),(41012,'Ingresos No Operativos O Exraordinarios',4,410,'2024-11-24 17:26:54',2,0),(41013,'Ingresos De Capital',4,410,'2024-11-24 17:27:15',2,0),(41014,'Ingresos Pasivos',4,410,'2024-11-24 17:41:53',2,0),(51010,'Gastos De Servicio',5,510,'2024-11-24 17:45:32',2,0),(51011,'Gastos De Administracion',5,510,'2024-11-24 17:45:56',2,0),(51012,'Gastos Fijos',5,510,'2024-11-24 17:46:08',2,0),(51013,'Gastos Corrientes',5,510,'2024-11-24 17:46:23',2,0),(51014,'Gastos Operativos',5,510,'2024-11-24 17:46:45',2,0),(51015,'Gastos Por Depreciacion y Amortizacion',5,510,'2024-11-24 17:47:14',2,0),(51016,'Gastos Financieros',5,510,'2024-11-24 17:47:31',2,0),(61010,'Costos De Venta',6,610,'2024-11-24 17:55:21',2,0),(61011,'Costos Fijos',6,610,'2024-11-24 17:55:34',2,0),(61012,'Costos Variables',6,610,'2024-11-24 17:55:45',2,0),(61013,'Costos Administrativos',6,610,'2024-11-24 17:56:09',2,0),(61014,'Costos Financieros',6,610,'2024-11-24 17:56:38',2,0),(1101010,'Caja Chica',1,11010,'2024-11-24 13:45:40',3,0),(1101110,'Ficohsa',1,11011,'2024-11-24 13:45:53',3,0),(1101111,'Davivienda',1,11011,'2024-11-24 13:46:20',3,0),(1101210,'Vecinos',1,11012,'2024-11-24 13:46:46',3,0),(1101310,'Almacen',1,11013,'2024-11-24 13:47:58',3,0),(1111010,'DepreciaciÃ³n Acumulada de Edificios',1,11110,'2024-11-24 13:53:01',3,0),(1111110,'Terreno No Despreciable',1,11111,'2024-11-24 13:53:45',3,0),(1111210,'DepreciaciÃ³n Acumulada de Mobiliario',1,11112,'2024-11-24 13:54:37',3,0),(1111310,'DepreaciÃ³n Acumulada de Equipo de RecreaciÃ³n',1,11113,'2024-11-24 13:56:42',3,0),(1111311,'Equipo de RecreaciÃ³n',1,11113,'2024-11-24 13:57:05',3,0),(1111410,'DepreciaciÃ³n Acumulada de Aseo',1,11114,'2024-11-24 13:58:10',3,0),(1111411,'Equipo de Aseo',1,11114,'2024-11-24 13:58:30',3,0),(1111510,'DepreciaciÃ³n Acumulada de Equipo de Vigilancia',1,11115,'2024-11-24 13:59:03',3,0),(1111511,'Equipo de Vigilancia',1,11115,'2024-11-24 13:59:44',3,0),(2101010,'Cuentas Por Pagar',2,21010,'2024-11-24 15:35:15',3,0),(2101011,'Proveedores Nacionales',2,21010,'2024-11-24 15:35:38',3,0),(2101012,'Proveedores Internacionales',2,21010,'2024-11-24 15:36:41',3,0),(2101110,'Aguinaldo Por Pagar',2,21011,'2024-11-24 15:49:06',3,0),(2101210,'Catorceavo Mes Por Pagar',2,21012,'2024-11-24 15:50:26',3,0),(2101310,'Impuestos Por Pagar',2,21013,'2024-11-24 15:50:50',3,0),(2101410,'PrÃ©stamos a Corto Plazo',2,21014,'2024-11-24 15:51:24',3,0),(2101510,'Intereses Por Pagar',2,21015,'2024-11-24 15:51:39',3,0),(2101710,'Obligaciones Sociales Por Pagar',2,21017,'2024-11-24 15:51:56',3,0),(2101810,'Dividendos Por Pagar',2,21018,'2024-11-24 15:52:28',3,0),(2101910,'Anticipos De Clientes',2,21019,'2024-11-24 15:53:14',3,0),(2102010,'Sueldos y Salarios Por Pagar',2,21020,'2024-11-24 15:48:41',3,0),(2111010,'PrÃ©stamos a Largo Plazo',2,21110,'2024-11-24 16:42:28',3,0),(2111110,'Obligaciones Por Pagar A Largo Plazo',2,21111,'2024-11-24 16:42:44',3,0),(2111210,'Hipotecas Por Pagar',2,21112,'2024-11-24 16:42:58',3,0),(2111310,'Bonos Por Pagar',2,21113,'2024-11-24 16:43:10',3,0),(2111410,'Provisiones Para Beneficios Post-empleo',2,21114,'2024-11-24 16:43:29',3,0),(2111510,'Provisiones Para Indemnizaciones',2,21115,'2024-11-24 16:43:43',3,0),(2111610,'Pasivos Diferidos a Largo Plazo',2,21116,'2024-11-24 16:43:54',3,0),(2111710,'Provisiones Para Contingencias',2,21117,'2024-11-24 17:06:25',3,0),(3101010,'Capital Social',3,31010,'2024-11-24 17:22:02',3,0),(3101011,'Capital Aportado',3,31010,'2024-11-24 17:22:26',3,0),(3101012,'Capital No Aportado',3,31010,'2024-11-24 17:22:54',3,0),(3101110,'Fondo De Reserva Legal',3,31011,'2024-11-24 17:23:09',3,0),(3101111,'Reserva Para Contiengencias',3,31011,'2024-11-24 17:23:26',3,0),(3101210,'Utilidades Acumuladas Anteriores',3,31012,'2024-11-24 17:23:58',3,0),(3101211,'PÃ©rdidas Acumuladas Anteriores',3,31012,'2024-11-24 17:24:26',3,0),(4101010,'Ingresos Por Comisiones',4,41010,'2024-11-24 17:42:31',3,0),(4101110,'Ingresos Por Honorarios',4,41011,'2024-11-24 17:42:50',3,0),(4101111,'Ingresos Por Arrendamientos',4,41011,'2024-11-24 17:43:06',3,0),(4101310,'Ingresos Por Dividendos',4,41013,'2024-11-24 17:44:10',3,0),(4101410,'Ingresos Por Subvenciones',4,41014,'2024-11-24 17:44:44',3,0),(5101010,'Gastos De Publicidad',5,51010,'2024-11-24 17:48:39',3,0),(5101011,'Gastos De Marketing',5,51010,'2024-11-24 17:48:53',3,0),(5101110,'Gastos Administrativos Generales',5,51011,'2024-11-24 17:49:13',3,0),(5101111,'Gastos Por Sueldos Y Salarios',5,51011,'2024-11-24 17:49:36',3,0),(5101210,'Gastos De Seguro',5,51012,'2024-11-24 17:49:50',3,0),(5101310,'Gastos De TelefonÃ­a',5,51013,'2024-11-24 17:50:26',3,0),(5101311,'Gastos De Viaje',5,51013,'2024-11-24 17:50:55',3,0),(5101410,'Gastos De Transporte',5,51014,'2024-11-24 17:52:02',3,0),(5101411,'Gastos De Mantenimiento De Oficina',5,51014,'2024-11-24 17:52:55',3,0),(6101010,'Costos De MercancÃ­a Vendida',6,61010,'2024-11-24 17:57:14',3,0),(6101110,'Costos De Servicios Prestados',6,61011,'2024-11-24 17:57:37',3,0),(6101210,'Costos De ProducciÃ³n',6,61012,'2024-11-24 17:57:59',3,0),(6101310,'Costos De Almacenaje',6,61013,'2024-11-24 17:59:21',3,0),(6101410,'Costos De Distribucion',6,61014,'2024-11-24 17:59:44',3,0);
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
-- Table structure for table `log_usuarios`
--

DROP TABLE IF EXISTS `log_usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `log_usuarios` (
  `id` char(36) NOT NULL DEFAULT (uuid()),
  `codigo_usuario` varchar(50) NOT NULL,
  `descripcion` varchar(500) NOT NULL,
  `fec_accion` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log_usuarios`
--

LOCK TABLES `log_usuarios` WRITE;
/*!40000 ALTER TABLE `log_usuarios` DISABLE KEYS */;
INSERT INTO `log_usuarios` VALUES ('08831dba-af72-11ef-9248-0242ac120002','USER-0001','Inicio de sesion en la plataforma','2024-11-30 17:22:57'),('1c90f408-af6e-11ef-9248-0242ac120002','USER-0001','Inicio de sesion en la plataforma','2024-11-30 16:54:53'),('1ccf2b88-ae76-11ef-87ab-0242ac120002','USER-0001','Inicio de sesion en la plataforma','2024-11-29 11:19:38'),('20bc54fd-ad3d-11ef-af8f-0242ac120002','USER-0001','Inicio de sesion en la plataforma','2024-11-27 21:59:12'),('3248be6e-af4e-11ef-9248-0242ac120002','USER-0001','Inicio de sesion en la plataforma','2024-11-30 13:06:25'),('39cbfd0a-ad3c-11ef-af8f-0242ac120002','USER-0001','Inicio de sesion en la plataforma','2024-11-27 21:52:45'),('42d711ae-ae76-11ef-87ab-0242ac120002','USER-0001','Inicio de sesion en la plataforma','2024-11-29 11:20:42'),('4661cee1-ae77-11ef-87ab-0242ac120002','USER-0001','Inicio de sesion en la plataforma','2024-11-29 11:27:57'),('5337337f-af73-11ef-9248-0242ac120002','USER-0001','Inicio de sesion en la plataforma','2024-11-30 17:32:12'),('7007acdb-af72-11ef-9248-0242ac120002','USER-0001','Inicio de sesion en la plataforma','2024-11-30 17:25:51'),('82995bd5-af52-11ef-9248-0242ac120002','USER-0001','Inicio de sesion en la plataforma','2024-11-30 13:37:18'),('e98a74fa-af6e-11ef-9248-0242ac120002','USER-0001','Inicio de sesion en la plataforma','2024-11-30 17:00:37'),('f59d84e3-ae61-11ef-87ab-0242ac120002','USER-0001','Inicio de sesion en la plataforma','2024-11-29 08:55:22');
/*!40000 ALTER TABLE `log_usuarios` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movimientos_diarios`
--

LOCK TABLES `movimientos_diarios` WRITE;
/*!40000 ALTER TABLE `movimientos_diarios` DISABLE KEYS */;
INSERT INTO `movimientos_diarios` VALUES (60,11010,'dfdsf','2024-11-25 00:00:00',5000,0,24,4),(61,1101010,'dfdsf','2024-11-25 00:00:00',0,5000,24,4),(62,11010,'dfasdasdasd','2024-11-27 00:00:00',5000,0,25,3),(63,11011,'dfsdfsdf','2024-11-27 00:00:00',0,5000,25,3),(64,1101010,'Aumento de la cuenta','2024-11-30 00:00:00',15000,0,26,3),(65,1101110,'Disminuye la cuenta','2024-11-30 00:00:00',0,10000,26,3),(66,1101111,'Disminuye la cuenta','2024-11-30 00:00:00',0,5000,26,3),(67,1101010,'dfdsfdsf','2024-11-30 00:00:00',3500,0,27,3),(68,1101111,'dsfsdfdff dfdsfdsf','2024-11-30 00:00:00',0,3500,27,3);
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
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movimientos_maestros`
--

LOCK TABLES `movimientos_maestros` WRITE;
/*!40000 ALTER TABLE `movimientos_maestros` DISABLE KEYS */;
INSERT INTO `movimientos_maestros` VALUES (24,'2024-11-25 00:00:00','2024-11-25 23:08:45','nahum.martinez',5000,5000,4),(25,'2024-11-27 00:00:00','2024-11-27 23:01:54','nahum.martinez',5000,5000,3),(26,'2024-11-30 00:00:00','2024-11-30 15:56:48','nahum.martinez',15000,15000,3),(27,'2024-11-30 00:00:00','2024-11-30 17:33:12','admin',3500,3500,3);
/*!40000 ALTER TABLE `movimientos_maestros` ENABLE KEYS */;
UNLOCK TABLES;

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
INSERT INTO `usuarios` VALUES ('5572219e-abb4-11ef-8fb3-0242ac120002','USER-0001','admin','$2b$10$ujwCP0Hsk0dYTP5zaUFIH.wcsINDxkJ/xWu9IqpGpqt4idf1te17i','Admin','System','2024-11-25 23:07:28','2024-11-25 23:07:28',1,'admin@gmail.com');
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

-- Dump completed on 2024-11-30 17:44:28
