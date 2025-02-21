/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19-11.6.2-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: tw1project
-- ------------------------------------------------------
-- Server version	11.6.2-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*M!100616 SET @OLD_NOTE_VERBOSITY=@@NOTE_VERBOSITY, NOTE_VERBOSITY=0 */;

--
-- Table structure for table `TAUX_TEMAS`
--

DROP TABLE IF EXISTS `TAUX_TEMAS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `TAUX_TEMAS` (
  `id_usuario` int(11) NOT NULL,
  `id_tema` int(11) NOT NULL,
  KEY `TAUX_TEMAS_T_USUARIO` (`id_usuario`),
  KEY `TAUX_TEMAS_T_TEMAS` (`id_tema`),
  CONSTRAINT `TAUX_TEMAS_T_TEMAS` FOREIGN KEY (`id_tema`) REFERENCES `T_TEMAS` (`id_fuente`),
  CONSTRAINT `TAUX_TEMAS_T_USUARIO` FOREIGN KEY (`id_usuario`) REFERENCES `T_USUARIOS` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TAUX_TEMAS`
--

LOCK TABLES `TAUX_TEMAS` WRITE;
/*!40000 ALTER TABLE `TAUX_TEMAS` DISABLE KEYS */;
/*!40000 ALTER TABLE `TAUX_TEMAS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `T_CLIMAS`
--

DROP TABLE IF EXISTS `T_CLIMAS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `T_CLIMAS` (
  `id_clima` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `id_ubicacion` int(11) NOT NULL,
  `t_max` int(11) NOT NULL,
  `t_min` int(11) NOT NULL,
  `condiciones` enum('soleado','nublado','lluvia','tormenta','granizo','feo') DEFAULT NULL,
  `precipitacion` decimal(5,2) DEFAULT NULL,
  `humedad` tinyint(4) DEFAULT NULL,
  `id_fuente` int(11) NOT NULL,
  PRIMARY KEY (`id_clima`),
  KEY `T_UBICACION_T_CLIMA_FK` (`id_ubicacion`),
  KEY `T_FUENTE_TCLIMA_FK` (`id_fuente`),
  CONSTRAINT `T_FUENTE_TCLIMA_FK` FOREIGN KEY (`id_fuente`) REFERENCES `T_FUENTES` (`id_fuente`),
  CONSTRAINT `T_UBICACION_T_CLIMA_FK` FOREIGN KEY (`id_ubicacion`) REFERENCES `T_UBICACIONES` (`id_ubicacion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `T_CLIMAS`
--

LOCK TABLES `T_CLIMAS` WRITE;
/*!40000 ALTER TABLE `T_CLIMAS` DISABLE KEYS */;
/*!40000 ALTER TABLE `T_CLIMAS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `T_DATOS_MONEDAS`
--

DROP TABLE IF EXISTS `T_DATOS_MONEDAS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `T_DATOS_MONEDAS` (
  `id_dato` int(11) NOT NULL,
  `id_fuente` int(11) NOT NULL,
  `id_moneda` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `valor_respecto_dolar` decimal(15,4) NOT NULL,
  PRIMARY KEY (`id_dato`),
  KEY `T_DATOS_MONEDAS_T_FUENTES_FK` (`id_fuente`),
  KEY `T_DATOS_MONEDAS_T_MONEDA_FK` (`id_moneda`),
  CONSTRAINT `T_DATOS_MONEDAS_T_FUENTES_FK` FOREIGN KEY (`id_fuente`) REFERENCES `T_FUENTES` (`id_fuente`),
  CONSTRAINT `T_DATOS_MONEDAS_T_MONEDA_FK` FOREIGN KEY (`id_moneda`) REFERENCES `T_MONEDAS` (`id_moneda`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `T_DATOS_MONEDAS`
--

LOCK TABLES `T_DATOS_MONEDAS` WRITE;
/*!40000 ALTER TABLE `T_DATOS_MONEDAS` DISABLE KEYS */;
/*!40000 ALTER TABLE `T_DATOS_MONEDAS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `T_EVENTOS`
--

DROP TABLE IF EXISTS `T_EVENTOS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `T_EVENTOS` (
  `id_evento` int(11) NOT NULL,
  `direccion` varchar(100) DEFAULT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `tipo` varchar(25) NOT NULL,
  `fecha` date NOT NULL,
  `contacto` varchar(100) DEFAULT NULL,
  `id_fuente` int(11) NOT NULL,
  `url` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_evento`),
  KEY `T_EVENTOS_T_FUENTES_FK` (`id_fuente`),
  CONSTRAINT `T_EVENTOS_T_FUENTES_FK` FOREIGN KEY (`id_fuente`) REFERENCES `T_FUENTES` (`id_fuente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `T_EVENTOS`
--

LOCK TABLES `T_EVENTOS` WRITE;
/*!40000 ALTER TABLE `T_EVENTOS` DISABLE KEYS */;
/*!40000 ALTER TABLE `T_EVENTOS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `T_FUENTES`
--

DROP TABLE IF EXISTS `T_FUENTES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `T_FUENTES` (
  `id_fuente` int(11) NOT NULL,
  `nombre_fuente` varchar(25) NOT NULL,
  `descripcion_fuente` varchar(100) NOT NULL,
  `ulr` varchar(100) NOT NULL,
  `dato_provisto` varchar(25) NOT NULL,
  PRIMARY KEY (`id_fuente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `T_FUENTES`
--

LOCK TABLES `T_FUENTES` WRITE;
/*!40000 ALTER TABLE `T_FUENTES` DISABLE KEYS */;
/*!40000 ALTER TABLE `T_FUENTES` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `T_INCIDENTES`
--

DROP TABLE IF EXISTS `T_INCIDENTES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `T_INCIDENTES` (
  `id_incidente` int(11) NOT NULL,
  `lugar` varchar(25) DEFAULT NULL,
  `tipo` varchar(25) NOT NULL,
  `descripcion_incidente` varchar(100) DEFAULT NULL,
  `fecha` date NOT NULL,
  `hora` time DEFAULT NULL,
  `id_fuente` int(11) NOT NULL,
  `url` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_incidente`),
  KEY `T_INCIDENTES_T_FUENTES_FK` (`id_fuente`),
  CONSTRAINT `T_INCIDENTES_T_FUENTES_FK` FOREIGN KEY (`id_fuente`) REFERENCES `T_FUENTES` (`id_fuente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `T_INCIDENTES`
--

LOCK TABLES `T_INCIDENTES` WRITE;
/*!40000 ALTER TABLE `T_INCIDENTES` DISABLE KEYS */;
/*!40000 ALTER TABLE `T_INCIDENTES` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `T_MONEDAS`
--

DROP TABLE IF EXISTS `T_MONEDAS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `T_MONEDAS` (
  `id_moneda` int(11) NOT NULL,
  `nombre_moneda` varchar(25) NOT NULL,
  `denominacion` varchar(5) NOT NULL,
  `pais` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`id_moneda`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `T_MONEDAS`
--

LOCK TABLES `T_MONEDAS` WRITE;
/*!40000 ALTER TABLE `T_MONEDAS` DISABLE KEYS */;
/*!40000 ALTER TABLE `T_MONEDAS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `T_NOTICIAS`
--

DROP TABLE IF EXISTS `T_NOTICIAS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `T_NOTICIAS` (
  `id_noticia` int(11) NOT NULL,
  `id_fuente` int(11) NOT NULL,
  `id_tema` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `titulo` varchar(50) NOT NULL,
  `descripcion_noticia` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_noticia`),
  KEY `T_NOTICIAS_T_TEMAS_fk` (`id_fuente`),
  CONSTRAINT `T_NOTICIAS_T_FUENTES_FK` FOREIGN KEY (`id_fuente`) REFERENCES `T_FUENTES` (`id_fuente`),
  CONSTRAINT `T_NOTICIAS_T_TEMAS_fk` FOREIGN KEY (`id_fuente`) REFERENCES `T_TEMAS` (`id_tema`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `T_NOTICIAS`
--

LOCK TABLES `T_NOTICIAS` WRITE;
/*!40000 ALTER TABLE `T_NOTICIAS` DISABLE KEYS */;
/*!40000 ALTER TABLE `T_NOTICIAS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `T_PREFERENCIAS`
--

DROP TABLE IF EXISTS `T_PREFERENCIAS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `T_PREFERENCIAS` (
  `id_preferencia` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_ubicacion` int(11) NOT NULL,
  `notification_time` time DEFAULT '08:00:00',
  PRIMARY KEY (`id_preferencia`),
  KEY `T_PREFERENCIAS_T_USUARIOS_FK` (`id_usuario`),
  KEY `T_PREFERENCIAS_T_UBICACIONES_FK` (`id_ubicacion`),
  CONSTRAINT `T_PREFERENCIAS_T_UBICACIONES_FK` FOREIGN KEY (`id_ubicacion`) REFERENCES `T_UBICACIONES` (`id_ubicacion`),
  CONSTRAINT `T_PREFERENCIAS_T_USUARIOS_FK` FOREIGN KEY (`id_usuario`) REFERENCES `T_USUARIOS` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `T_PREFERENCIAS`
--

LOCK TABLES `T_PREFERENCIAS` WRITE;
/*!40000 ALTER TABLE `T_PREFERENCIAS` DISABLE KEYS */;
/*!40000 ALTER TABLE `T_PREFERENCIAS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `T_ROLES`
--

DROP TABLE IF EXISTS `T_ROLES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `T_ROLES` (
  `nombre` varchar(15) NOT NULL,
  `id_rol` int(11) NOT NULL,
  PRIMARY KEY (`id_rol`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `T_ROLES`
--

LOCK TABLES `T_ROLES` WRITE;
/*!40000 ALTER TABLE `T_ROLES` DISABLE KEYS */;
/*!40000 ALTER TABLE `T_ROLES` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `T_TEMAS`
--

DROP TABLE IF EXISTS `T_TEMAS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `T_TEMAS` (
  `id_tema` int(11) NOT NULL,
  `nombre_tema` varchar(25) NOT NULL,
  `descripcion_tema` varchar(100) NOT NULL,
  `id_fuente` int(11) NOT NULL,
  PRIMARY KEY (`id_tema`),
  KEY `T_TEMAS_T_FUENTES_FK` (`id_fuente`),
  CONSTRAINT `T_TEMAS_T_FUENTES_FK` FOREIGN KEY (`id_fuente`) REFERENCES `T_FUENTES` (`id_fuente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `T_TEMAS`
--

LOCK TABLES `T_TEMAS` WRITE;
/*!40000 ALTER TABLE `T_TEMAS` DISABLE KEYS */;
/*!40000 ALTER TABLE `T_TEMAS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `T_UBICACIONES`
--

DROP TABLE IF EXISTS `T_UBICACIONES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `T_UBICACIONES` (
  `id_ubicacion` int(11) NOT NULL,
  `nombre_ubicacion` varchar(25) NOT NULL,
  PRIMARY KEY (`id_ubicacion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `T_UBICACIONES`
--

LOCK TABLES `T_UBICACIONES` WRITE;
/*!40000 ALTER TABLE `T_UBICACIONES` DISABLE KEYS */;
/*!40000 ALTER TABLE `T_UBICACIONES` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `T_USUARIOS`
--

DROP TABLE IF EXISTS `T_USUARIOS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `T_USUARIOS` (
  `id_usuario` int(11) NOT NULL,
  `nombres_usuario` varchar(25) NOT NULL,
  `apellidos_usuario` varchar(25) NOT NULL,
  `usuario` varchar(10) NOT NULL,
  `password` varchar(25) NOT NULL,
  `id_rol` int(11) NOT NULL,
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `T_USUARIOS_UNIQUE` (`usuario`),
  KEY `T_USUARIOS_T_ROLES_FK` (`id_rol`),
  CONSTRAINT `T_USUARIOS_T_ROLES_FK` FOREIGN KEY (`id_rol`) REFERENCES `T_ROLES` (`id_rol`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `T_USUARIOS`
--

LOCK TABLES `T_USUARIOS` WRITE;
/*!40000 ALTER TABLE `T_USUARIOS` DISABLE KEYS */;
/*!40000 ALTER TABLE `T_USUARIOS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'tw1project'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*M!100616 SET NOTE_VERBOSITY=@OLD_NOTE_VERBOSITY */;

-- Dump completed on 2025-02-19 17:07:06
