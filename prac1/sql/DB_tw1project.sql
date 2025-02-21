create database tw1project;
use tw1project;
-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: localhost    Database: tw1project
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
-- Table structure for table `t_climas`
--

DROP TABLE IF EXISTS `t_climas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_climas` (
  `id_clima` int NOT NULL,
  `fecha` date NOT NULL,
  `id_ubicacion` int NOT NULL,
  `t_max` int NOT NULL,
  `t_min` int NOT NULL,
  `condiciones` enum('soleado','nublado','lluvia','tormenta','granizo','feo') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `precipitacion` decimal(5,2) DEFAULT NULL,
  `humedad` tinyint DEFAULT NULL,
  `id_fuente` int NOT NULL,
  PRIMARY KEY (`id_clima`),
  KEY `T_UBICACION_T_CLIMA_FK` (`id_ubicacion`),
  KEY `T_FUENTE_TCLIMA_FK` (`id_fuente`),
  CONSTRAINT `T_FUENTE_TCLIMA_FK` FOREIGN KEY (`id_fuente`) REFERENCES `t_fuentes` (`id_fuente`),
  CONSTRAINT `T_UBICACION_T_CLIMA_FK` FOREIGN KEY (`id_ubicacion`) REFERENCES `t_ubicaciones` (`id_ubicacion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_datos_monedas`
--

DROP TABLE IF EXISTS `t_datos_monedas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_datos_monedas` (
  `id_dato` int NOT NULL,
  `id_fuente` int NOT NULL,
  `id_moneda` int NOT NULL,
  `fecha` date NOT NULL,
  `valor_respecto_dolar` decimal(15,4) NOT NULL,
  PRIMARY KEY (`id_dato`),
  KEY `T_DATOS_MONEDAS_T_FUENTES_FK` (`id_fuente`),
  KEY `T_DATOS_MONEDAS_T_MONEDA_FK` (`id_moneda`),
  CONSTRAINT `T_DATOS_MONEDAS_T_FUENTES_FK` FOREIGN KEY (`id_fuente`) REFERENCES `t_fuentes` (`id_fuente`),
  CONSTRAINT `T_DATOS_MONEDAS_T_MONEDA_FK` FOREIGN KEY (`id_moneda`) REFERENCES `t_monedas` (`id_moneda`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_eventos`
--

DROP TABLE IF EXISTS `t_eventos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_eventos` (
  `id_evento` int NOT NULL,
  `direccion` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nombre` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tipo` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha` date NOT NULL,
  `contacto` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_fuente` int NOT NULL,
  `url` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_evento`),
  KEY `T_EVENTOS_T_FUENTES_FK` (`id_fuente`),
  CONSTRAINT `T_EVENTOS_T_FUENTES_FK` FOREIGN KEY (`id_fuente`) REFERENCES `t_fuentes` (`id_fuente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_fuentes`
--

DROP TABLE IF EXISTS `t_fuentes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_fuentes` (
  `id_fuente` int NOT NULL,
  `nombre_fuente` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion_fuente` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ulr` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `dato_provisto` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id_fuente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_incidentes`
--

DROP TABLE IF EXISTS `t_incidentes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_incidentes` (
  `id_incidente` int NOT NULL,
  `lugar` varchar(25) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tipo` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion_incidente` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha` date NOT NULL,
  `hora` time DEFAULT NULL,
  `id_fuente` int NOT NULL,
  `url` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_incidente`),
  KEY `T_INCIDENTES_T_FUENTES_FK` (`id_fuente`),
  CONSTRAINT `T_INCIDENTES_T_FUENTES_FK` FOREIGN KEY (`id_fuente`) REFERENCES `t_fuentes` (`id_fuente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_monedas`
--

DROP TABLE IF EXISTS `t_monedas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_monedas` (
  `id_moneda` int NOT NULL,
  `nombre_moneda` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL,
  `denominacion` varchar(5) COLLATE utf8mb4_unicode_ci NOT NULL,
  `pais` varchar(25) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_moneda`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_noticias`
--

DROP TABLE IF EXISTS `t_noticias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_noticias` (
  `id_noticia` int NOT NULL,
  `id_fuente` int NOT NULL,
  `id_tema` int NOT NULL,
  `fecha` date NOT NULL,
  `titulo` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion_noticia` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_noticia`),
  KEY `T_NOTICIAS_T_TEMAS_fk` (`id_fuente`),
  CONSTRAINT `T_NOTICIAS_T_FUENTES_FK` FOREIGN KEY (`id_fuente`) REFERENCES `t_fuentes` (`id_fuente`),
  CONSTRAINT `T_NOTICIAS_T_TEMAS_fk` FOREIGN KEY (`id_fuente`) REFERENCES `t_temas` (`id_tema`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_preferencias`
--

DROP TABLE IF EXISTS `t_preferencias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_preferencias` (
  `id_preferencia` int NOT NULL,
  `id_usuario` int NOT NULL,
  `id_ubicacion` int NOT NULL,
  `notification_time` time DEFAULT '08:00:00',
  PRIMARY KEY (`id_preferencia`),
  KEY `T_PREFERENCIAS_T_USUARIOS_FK` (`id_usuario`),
  KEY `T_PREFERENCIAS_T_UBICACIONES_FK` (`id_ubicacion`),
  CONSTRAINT `T_PREFERENCIAS_T_UBICACIONES_FK` FOREIGN KEY (`id_ubicacion`) REFERENCES `t_ubicaciones` (`id_ubicacion`),
  CONSTRAINT `T_PREFERENCIAS_T_USUARIOS_FK` FOREIGN KEY (`id_usuario`) REFERENCES `t_usuarios` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_roles`
--

DROP TABLE IF EXISTS `t_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_roles` (
  `nombre` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_rol` int NOT NULL,
  PRIMARY KEY (`id_rol`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_temas`
--

DROP TABLE IF EXISTS `t_temas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_temas` (
  `id_tema` int NOT NULL,
  `nombre_tema` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion_tema` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_fuente` int NOT NULL,
  PRIMARY KEY (`id_tema`),
  KEY `T_TEMAS_T_FUENTES_FK` (`id_fuente`),
  CONSTRAINT `T_TEMAS_T_FUENTES_FK` FOREIGN KEY (`id_fuente`) REFERENCES `t_fuentes` (`id_fuente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_ubicaciones`
--

DROP TABLE IF EXISTS `t_ubicaciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_ubicaciones` (
  `id_ubicacion` int NOT NULL,
  `nombre_ubicacion` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id_ubicacion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_usuarios`
--

DROP TABLE IF EXISTS `t_usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_usuarios` (
  `id_usuario` int NOT NULL,
  `nombres_usuario` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL,
  `apellidos_usuario` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL,
  `usuario` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_rol` int NOT NULL,
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `T_USUARIOS_UNIQUE` (`usuario`),
  KEY `T_USUARIOS_T_ROLES_FK` (`id_rol`),
  CONSTRAINT `T_USUARIOS_T_ROLES_FK` FOREIGN KEY (`id_rol`) REFERENCES `t_roles` (`id_rol`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `taux_temas`
--

DROP TABLE IF EXISTS `taux_temas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `taux_temas` (
  `id_usuario` int NOT NULL,
  `id_tema` int NOT NULL,
  KEY `TAUX_TEMAS_T_USUARIO` (`id_usuario`),
  KEY `TAUX_TEMAS_T_TEMAS` (`id_tema`),
  CONSTRAINT `TAUX_TEMAS_T_TEMAS` FOREIGN KEY (`id_tema`) REFERENCES `t_temas` (`id_tema`),
  CONSTRAINT `TAUX_TEMAS_T_USUARIO` FOREIGN KEY (`id_usuario`) REFERENCES `t_usuarios` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-02-20 21:47:08
