/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

CREATE DATABASE IF NOT EXISTS `sigeqroo` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `sigeqroo`;

CREATE TABLE IF NOT EXISTS `caratulas` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `nombre_sujeto_obligado` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `area_administrativa` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `no_consecutivo` int NOT NULL,
  `area_generadora` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `codigo_clasificacion_archivistica` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `anio_apertura` int DEFAULT NULL,
  `anio_cierre` int DEFAULT NULL,
  `soporte_documental` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `titulo_expediente` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion_asunto_expediente` text COLLATE utf8mb4_unicode_ci,
  `ubicacion_topografica` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `no_legajo` int DEFAULT NULL,
  `no_fojas` int DEFAULT NULL,
  `valor_documental_administrativo` tinyint(1) DEFAULT '0',
  `valor_documental_legal` tinyint(1) DEFAULT '0',
  `valor_documental_contable` tinyint(1) DEFAULT '0',
  `vigencia_documental` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `anios_archivo_tramite` int DEFAULT NULL,
  `anios_archivo_concentracion` int DEFAULT NULL,
  `caracter_informacion` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_clasificacion` date DEFAULT NULL,
  `fundamento_legal` text COLLATE utf8mb4_unicode_ci,
  `periodo_reserva` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `aplicacion_periodo_reserva` text COLLATE utf8mb4_unicode_ci,
  `rubrica_titular` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_desclasificacion` date DEFAULT NULL,
  `observaciones` text COLLATE utf8mb4_unicode_ci,
  `capturador` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `caratulas` (`id`, `nombre_sujeto_obligado`, `area_administrativa`, `no_consecutivo`, `area_generadora`, `codigo_clasificacion_archivistica`, `anio_apertura`, `anio_cierre`, `soporte_documental`, `titulo_expediente`, `descripcion_asunto_expediente`, `ubicacion_topografica`, `no_legajo`, `no_fojas`, `valor_documental_administrativo`, `valor_documental_legal`, `valor_documental_contable`, `vigencia_documental`, `anios_archivo_tramite`, `anios_archivo_concentracion`, `caracter_informacion`, `fecha_clasificacion`, `fundamento_legal`, `periodo_reserva`, `aplicacion_periodo_reserva`, `rubrica_titular`, `fecha_desclasificacion`, `observaciones`, `capturador`, `created_at`, `updated_at`) VALUES
	(1, 'Archivo General del Estado de Quintana Roo', 'Dirección Archivo del Ejecutivo', 1, 'Sistemas de la informacion y comunicaciones', '1C', 2015, 2025, 'Electrónico', 'Titulo de prueba para el expendiente', 'El asunto trata de una prueba para la prueba del sistema', 'Chetumal', 5, 5, 1, 0, 1, '2', 2, 5, 'Confidencial', '2025-05-21', 'Ni idea de que es es este campo', '5', '6', 'rubrica de ejemplo', '2025-05-21', 'Ninguna', 'Jhoedy Dominguez Dominguez', '2025-05-21 17:32:20', '2025-05-21 18:40:02');

CREATE TABLE IF NOT EXISTS `catalogo_archivistico` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tipo` enum('fondo','seccion','serie','expediente') NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `codigo` varchar(100) NOT NULL,
  `descripcion` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `catalogo_archivistico` (`id`, `tipo`, `nombre`, `codigo`, `descripcion`, `created_at`) VALUES
	(1, 'fondo', 'Archivo General del Estado de Quintana Roo', 'AGE', 'Fondo principal del Archivo General del Estado', '2025-05-21 21:48:55'),
	(2, 'seccion', 'Preservación del patrimonio documental', '2S', 'Área dedicada a preservar el patrimonio documental', '2025-05-21 21:48:55'),
	(3, 'serie', 'Digitalización de Fondos y Colecciones', '2S.1', 'Serie de digitalización de archivos históricos', '2025-05-21 21:48:55'),
	(4, 'expediente', 'Digitalización del fondo Territorio Federal de Quintana Roo', '2S.1/0001/2025', 'Expediente del proyecto de digitalización del fondo del Territorio Federal', '2025-05-21 21:48:55');

CREATE TABLE IF NOT EXISTS `expedientes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_serie` int NOT NULL,
  `tiempo_conservacion` int DEFAULT NULL,
  `no_legajos` int DEFAULT NULL,
  `no_hojas` int DEFAULT NULL,
  `ubicacion_topografica` varchar(100) NOT NULL DEFAULT '',
  `no_caja` int DEFAULT NULL,
  `clasificacion` varchar(50) NOT NULL DEFAULT '',
  `caracter` varchar(50) NOT NULL DEFAULT '',
  `observacion` varchar(50) DEFAULT '',
  `nombre` varchar(255) NOT NULL,
  `codigo` varchar(100) NOT NULL,
  `estado` enum('en_tramite','en_concentracion','en_historico') DEFAULT 'en_tramite',
  `fecha_creacion` date DEFAULT NULL,
  `fecha_apertura` date DEFAULT NULL,
  `fecha_cierre` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL,
  `preservacion` varchar(50) DEFAULT NULL,
  `clave` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_serie` (`id_serie`),
  CONSTRAINT `expedientes_ibfk_1` FOREIGN KEY (`id_serie`) REFERENCES `series` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `expedientes` (`id`, `id_serie`, `tiempo_conservacion`, `no_legajos`, `no_hojas`, `ubicacion_topografica`, `no_caja`, `clasificacion`, `caracter`, `observacion`, `nombre`, `codigo`, `estado`, `fecha_creacion`, `fecha_apertura`, `fecha_cierre`, `created_at`, `updated_at`, `preservacion`, `clave`) VALUES
	(12, 2, 5, 5, 2, 'Departamento de Archivo Histórico', 53, 'Pública', 'Administrativo', 'Ninguna.', 'Digitalización de fondo "Actas de cabildo"', '2S.2/002/2025', 'en_tramite', '2025-05-30', '2025-05-30', '2030-05-30', '2025-05-30 17:51:15', '2025-05-30 17:51:15', 'Si', 'AGE/2S/2S.1/2S.2/002/2025'),
	(13, 2, 5, 5, 2, 'Departamento de Archivo Histórico', 53, 'Pública', 'Administrativo', 'Ninguna.', 'Digitalización de fondo "Actas de cabildo"', '2S.2/002/2025', 'en_concentracion', '2025-05-30', '2025-05-30', '2030-05-30', '2025-05-30 17:51:15', '2025-05-30 17:51:15', 'Si', 'AGE/2S/2S.1/2S.2/002/2025'),
	(14, 2, 5, 5, 2, 'Departamento de Archivo Histórico', 53, 'Pública', 'Administrativo', 'Ninguna.', 'Digitalización de fondo "Actas de cabildo"', '2S.2/002/2025', 'en_historico', '2025-05-30', '2025-05-30', '2030-05-30', '2025-05-30 17:51:15', '2025-05-30 17:51:15', 'Si', 'AGE/2S/2S.1/2S.2/002/2025');

CREATE TABLE IF NOT EXISTS `fondos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  `codigo` varchar(50) NOT NULL,
  `descripcion` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `fondos` (`id`, `nombre`, `codigo`, `descripcion`, `created_at`, `updated_at`) VALUES
	(2, 'Archivo General del Estado de Quintana Roo', 'AGE', 'Prueba', '2025-05-28 16:06:27', '2025-05-28 16:06:27'),
	(3, 'Secretaria de Gobierno', 'SEGOB', NULL, '2025-05-28 17:54:18', '2025-05-28 17:54:18'),
	(4, 'Prueba de modales', 'i3', NULL, '2025-05-28 21:25:13', '2025-05-28 21:25:13');

CREATE TABLE IF NOT EXISTS `secciones` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_fondo` int NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `codigo` varchar(50) NOT NULL,
  `descripcion` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_fondo` (`id_fondo`),
  CONSTRAINT `secciones_ibfk_1` FOREIGN KEY (`id_fondo`) REFERENCES `fondos` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `secciones` (`id`, `id_fondo`, `nombre`, `codigo`, `descripcion`, `created_at`, `updated_at`) VALUES
	(1, 2, 'Preservación del patrimonio documental', '2S', 'Prueba', '2025-05-28 16:44:16', '2025-05-28 16:44:16'),
	(2, 2, 'Prueba', '3S', NULL, '2025-05-28 17:50:48', '2025-05-28 17:50:48'),
	(3, 3, 'Modales test', 'T1', NULL, '2025-05-28 21:17:51', '2025-05-28 21:17:51'),
	(4, 3, 'Ppprueba', 'ds', NULL, '2025-05-28 21:21:29', '2025-05-28 21:21:29'),
	(5, 4, 'Testing modals', 'a3', NULL, '2025-05-28 21:25:23', '2025-05-28 21:25:23');

CREATE TABLE IF NOT EXISTS `series` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_seccion` int DEFAULT NULL,
  `nombre` varchar(255) NOT NULL,
  `codigo` varchar(50) NOT NULL,
  `descripcion` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_seccion` (`id_seccion`),
  CONSTRAINT `series_ibfk_1` FOREIGN KEY (`id_seccion`) REFERENCES `secciones` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `series` (`id`, `id_seccion`, `nombre`, `codigo`, `descripcion`, `created_at`, `updated_at`) VALUES
	(2, 1, 'Digitalizacion de fondos', '2S.1', NULL, '2025-05-28 17:22:55', '2025-05-28 17:22:55'),
	(3, 2, 'Prueba', '3S.1', NULL, '2025-05-28 17:51:01', '2025-05-28 17:51:01'),
	(4, 1, 'Publicacion de fondos', '5S', NULL, '2025-05-28 17:52:39', '2025-05-28 17:52:39'),
	(5, 3, 'Modal serie', 'M3', NULL, '2025-05-28 21:19:03', '2025-05-28 21:19:03');

CREATE TABLE IF NOT EXISTS `unidades_documentales` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_expediente` int NOT NULL,
  `tipo` varchar(100) NOT NULL COMMENT 'Carátula, Acta, Oficio, etc.',
  `nombre` varchar(255) NOT NULL,
  `descripcion` text,
  `archivo` varchar(255) DEFAULT NULL COMMENT 'Ruta o URL del archivo digitalizado',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_expediente` (`id_expediente`),
  CONSTRAINT `unidades_documentales_ibfk_1` FOREIGN KEY (`id_expediente`) REFERENCES `expedientes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE IF NOT EXISTS `users` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `apellido_materno` varchar(100) NOT NULL,
  `apellido_paterno` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `password` varchar(255) NOT NULL,
  `area_asignada` varchar(255) NOT NULL,
  `roles` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `users` (`id`, `nombre`, `apellido_materno`, `apellido_paterno`, `email`, `password`, `area_asignada`, `roles`, `created_at`, `updated_at`) VALUES
	(6, 'Jose Alberto', 'Lopez', 'Diaz', 'jose@jose.com', '$2y$12$ExmhBpjasfzYpdoOkzTvuuj4MXopvjSuRYdQfuJJ20oRSYRT7dFHm', 'Departamento de Tecnologías de la Información y Comunicaciones', '["editor"]', '2025-05-30 20:14:44', '2025-05-30 20:14:44'),
	(7, 'Jhoedy Indurain', 'Dominguez', 'Dominguez', 'jidd.2201@gmail.com', '$2y$12$/ZMzgxan93yAMtA.kHrGT.cjIfnBCxsdQHBRN./cX5vuL4grorrq2', 'Departamento de Tecnologías de la Información y Comunicaciones', '["administrador"]', '2025-05-30 20:15:27', '2025-05-30 21:11:49'),
	(8, 'Angel', 'Ortega', 'Sanchez', 'angel@angel.com', '$2y$12$AhoTEA35Q5S9F9r8/uaFO.o3xwONuUOJq9.R4BaTtfPNvWVCxXECG', 'Dirección General', '["lector"]', '2025-05-30 20:17:22', '2025-05-30 20:35:04'),
	(9, 'Horacio', 'Rodriguez', 'Guarneros', 'horacio@horacio.com', '$2y$12$hH1X04/.dYWxxQe8o2a.5.zJKASOeIK0w0OcR73g5W.YoRkNxrteW', 'Departamento de Archivo Histórico', '["editor"]', '2025-05-30 21:12:38', '2025-05-30 21:12:38');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
