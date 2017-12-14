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


-- Volcando estructura de base de datos para b5act1
CREATE DATABASE IF NOT EXISTS `b5act1` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `b5act1`;

-- Volcando estructura para tabla b5act1.oficio
CREATE TABLE IF NOT EXISTS `oficio` (
  `oficio` char(20) NOT NULL,
  `descripcion` char(40) DEFAULT NULL,
  PRIMARY KEY (`oficio`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla b5act1.oficioempleado
CREATE TABLE IF NOT EXISTS `oficioempleado` (
  `nombre` char(20) NOT NULL,
  `calificacion` char(20) DEFAULT NULL,
  `oficio` char(20) NOT NULL,
  PRIMARY KEY (`nombre`,`oficio`),
  KEY `fk_oficio` (`oficio`),
  CONSTRAINT `fk_oficio` FOREIGN KEY (`oficio`) REFERENCES `oficio` (`oficio`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla b5act1.vivienda
CREATE TABLE IF NOT EXISTS `vivienda` (
  `alojamiento` char(20) NOT NULL,
  `nombrecompleto` char(20) DEFAULT NULL,
  `responsable` char(20) DEFAULT NULL,
  `direccion` char(40) DEFAULT NULL,
  PRIMARY KEY (`alojamiento`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- La exportación de datos fue deseleccionada.
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
