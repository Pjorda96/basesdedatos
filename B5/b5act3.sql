-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         10.1.26-MariaDB - mariadb.org binary distribution
-- SO del servidor:              Win32
-- HeidiSQL Versión:             9.4.0.5125
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Volcando estructura de base de datos para b5act3
CREATE DATABASE IF NOT EXISTS `b5act3` /*!40100 DEFAULT CHARACTER SET latin1 COLLATE latin1_spanish_ci */;
USE `b5act3`;

-- Volcando estructura para tabla b5act3.alumno
CREATE TABLE IF NOT EXISTS `alumno` (
  `idPersona` int(11) NOT NULL,
  `titulacion` char(50) COLLATE latin1_spanish_ci NOT NULL,
  `codCentro` int(11) NOT NULL,
  `expediente` char(50) COLLATE latin1_spanish_ci NOT NULL,
  PRIMARY KEY (`idPersona`),
  KEY `FK_alumno_centro` (`codCentro`),
  CONSTRAINT `FK_alumno_centro` FOREIGN KEY (`codCentro`) REFERENCES `centro` (`codCentro`) ON UPDATE CASCADE,
  CONSTRAINT `FK_alumno_persona` FOREIGN KEY (`idPersona`) REFERENCES `persona` (`idPersona`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla b5act3.centro
CREATE TABLE IF NOT EXISTS `centro` (
  `codCentro` int(11) NOT NULL,
  `ubicacion` char(50) COLLATE latin1_spanish_ci DEFAULT NULL,
  PRIMARY KEY (`codCentro`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla b5act3.persona
CREATE TABLE IF NOT EXISTS `persona` (
  `idPersona` int(11) NOT NULL,
  `nombre` char(50) COLLATE latin1_spanish_ci NOT NULL,
  `direccion` char(50) COLLATE latin1_spanish_ci NOT NULL,
  `email` char(50) COLLATE latin1_spanish_ci NOT NULL,
  PRIMARY KEY (`idPersona`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla b5act3.personal
CREATE TABLE IF NOT EXISTS `personal` (
  `idPersona` int(11) NOT NULL,
  `unidad` char(50) COLLATE latin1_spanish_ci DEFAULT NULL,
  `categoria` char(50) COLLATE latin1_spanish_ci DEFAULT NULL,
  PRIMARY KEY (`idPersona`),
  CONSTRAINT `FK__personal` FOREIGN KEY (`idPersona`) REFERENCES `persona` (`idPersona`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla b5act3.profesor
CREATE TABLE IF NOT EXISTS `profesor` (
  `idPersona` int(11) NOT NULL,
  `expDocente` char(50) COLLATE latin1_spanish_ci NOT NULL,
  PRIMARY KEY (`idPersona`),
  CONSTRAINT `FK__persona` FOREIGN KEY (`idPersona`) REFERENCES `persona` (`idPersona`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla b5act3.trabaja
CREATE TABLE IF NOT EXISTS `trabaja` (
  `codCentro` int(11) NOT NULL,
  `idPersona` int(11) NOT NULL,
  PRIMARY KEY (`codCentro`,`idPersona`),
  KEY `FK__profesor` (`idPersona`),
  CONSTRAINT `FK__centro` FOREIGN KEY (`codCentro`) REFERENCES `centro` (`codCentro`) ON UPDATE CASCADE,
  CONSTRAINT `FK__profesor` FOREIGN KEY (`idPersona`) REFERENCES `profesor` (`idPersona`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

-- La exportación de datos fue deseleccionada.
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
