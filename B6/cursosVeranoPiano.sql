-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         10.1.26-MariaDB - mariadb.org binary distribution
-- SO del servidor:              Win32
-- HeidiSQL Versión:             9.5.0.5196
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Volcando estructura de base de datos para cursosveranopiano
CREATE DATABASE IF NOT EXISTS `cursosveranopiano` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_spanish_ci */;
USE `cursosveranopiano`;

-- Volcando estructura para tabla cursosveranopiano.alumno
CREATE TABLE IF NOT EXISTS `alumno` (
  `id_alumno` varchar(4) COLLATE utf8_spanish_ci NOT NULL,
  `nombre` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  `edad` int(11) DEFAULT NULL,
  `nivel` int(11) DEFAULT NULL,
  `idProf` varchar(4) COLLATE utf8_spanish_ci DEFAULT NULL,
  PRIMARY KEY (`id_alumno`),
  KEY `FK__profesor` (`idProf`),
  CONSTRAINT `FK__profesor` FOREIGN KEY (`idProf`) REFERENCES `profesor` (`idProfesor`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla cursosveranopiano.concierto
CREATE TABLE IF NOT EXISTS `concierto` (
  `id_concierto` varchar(4) COLLATE utf8_spanish_ci NOT NULL,
  `fecha_concierto` date DEFAULT NULL,
  `lugar` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `num_obras` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_concierto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla cursosveranopiano.estudia
CREATE TABLE IF NOT EXISTS `estudia` (
  `id_alumno` varchar(4) COLLATE utf8_spanish_ci NOT NULL,
  `id_obra` varchar(4) COLLATE utf8_spanish_ci NOT NULL,
  `fecha_superacion` date DEFAULT NULL,
  PRIMARY KEY (`id_alumno`,`id_obra`),
  KEY `FK__obra` (`id_obra`),
  CONSTRAINT `FK__alumno` FOREIGN KEY (`id_alumno`) REFERENCES `alumno` (`id_alumno`),
  CONSTRAINT `FK__obra` FOREIGN KEY (`id_obra`) REFERENCES `obra` (`id_obra`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla cursosveranopiano.interpreta
CREATE TABLE IF NOT EXISTS `interpreta` (
  `id_alumno` varchar(4) COLLATE utf8_spanish_ci NOT NULL,
  `id_obra` varchar(4) COLLATE utf8_spanish_ci NOT NULL,
  `id_concierto` varchar(4) COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`id_alumno`,`id_obra`,`id_concierto`),
  KEY `FK__concierto` (`id_concierto`),
  CONSTRAINT `FK__concierto` FOREIGN KEY (`id_concierto`) REFERENCES `concierto` (`id_concierto`),
  CONSTRAINT `FK__estudia` FOREIGN KEY (`id_alumno`, `id_obra`) REFERENCES `estudia` (`id_alumno`, `id_obra`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla cursosveranopiano.obra
CREATE TABLE IF NOT EXISTS `obra` (
  `id_obra` varchar(4) COLLATE utf8_spanish_ci NOT NULL,
  `titulo` varchar(120) COLLATE utf8_spanish_ci NOT NULL,
  `nivel` int(11) NOT NULL,
  PRIMARY KEY (`id_obra`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla cursosveranopiano.profesor
CREATE TABLE IF NOT EXISTS `profesor` (
  `idProfesor` varchar(4) COLLATE utf8_spanish_ci NOT NULL,
  `nombre` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  `nivel` int(11) NOT NULL,
  PRIMARY KEY (`idProfesor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para disparador cursosveranopiano.interpreta_BI_TRIGGER
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `interpreta_BI_TRIGGER` BEFORE INSERT ON `interpreta` FOR EACH ROW BEGIN
UPDATE concierto
set num_obras=num_obras+1
where id_concierto=new.id_concierto;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador cursosveranopiano.interpreta_BU_TRIGGER
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `interpreta_BU_TRIGGER` BEFORE UPDATE ON `interpreta` FOR EACH ROW BEGIN
UPDATE concierto
set num_obras=num_obras+1
where id_concierto=new.id_concierto;
UPDATE concierto
set num_obras=num_obras-1
where id_concierto=old.id_concierto;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
