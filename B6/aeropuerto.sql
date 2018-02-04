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


-- Volcando estructura de base de datos para aeropuerto
CREATE DATABASE IF NOT EXISTS `aeropuerto` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `aeropuerto`;

-- Volcando estructura para tabla aeropuerto.asistencia_vuelo
CREATE TABLE IF NOT EXISTS `asistencia_vuelo` (
  `cod_personal` varchar(6) NOT NULL,
  `cod_vuelo` varchar(8) NOT NULL,
  `funcion` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`cod_personal`,`cod_vuelo`),
  KEY `FK_asistencia_vuelo_vuelo` (`cod_vuelo`),
  CONSTRAINT `FK__personal_cabina` FOREIGN KEY (`cod_personal`) REFERENCES `personal_cabina` (`cod_personal`),
  CONSTRAINT `FK_asistencia_vuelo_vuelo` FOREIGN KEY (`cod_vuelo`) REFERENCES `vuelo` (`cod_vuelo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla aeropuerto.avion
CREATE TABLE IF NOT EXISTS `avion` (
  `cod_avion` varchar(8) NOT NULL,
  `modelo` varchar(15) NOT NULL,
  `plazas` int(11) NOT NULL,
  `fecha_rev` date NOT NULL,
  `cod_comp` varchar(4) NOT NULL,
  PRIMARY KEY (`cod_avion`),
  KEY `FK__companyia` (`cod_comp`),
  CONSTRAINT `FK__companyia` FOREIGN KEY (`cod_comp`) REFERENCES `companyia` (`cod_comp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla aeropuerto.companyia
CREATE TABLE IF NOT EXISTS `companyia` (
  `cod_comp` varchar(4) NOT NULL,
  `nombre` varchar(20) DEFAULT NULL,
  `telefono` varchar(9) DEFAULT NULL,
  PRIMARY KEY (`cod_comp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla aeropuerto.destino
CREATE TABLE IF NOT EXISTS `destino` (
  `aeropuerto` varchar(20) NOT NULL,
  `ciudad` varchar(60) NOT NULL,
  `pais` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`aeropuerto`,`ciudad`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla aeropuerto.personal_cabina
CREATE TABLE IF NOT EXISTS `personal_cabina` (
  `cod_personal` varchar(6) NOT NULL,
  `nombre` varchar(20) NOT NULL,
  `direccion` varchar(40) NOT NULL,
  `telefono` varchar(9) NOT NULL,
  PRIMARY KEY (`cod_personal`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla aeropuerto.piloto
CREATE TABLE IF NOT EXISTS `piloto` (
  `cod_piloto` varchar(6) NOT NULL,
  `nombre` varchar(20) NOT NULL,
  `direccion` varchar(20) NOT NULL,
  `telefono` varchar(20) NOT NULL,
  `horas_vuelo` float NOT NULL,
  PRIMARY KEY (`cod_piloto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla aeropuerto.vuelo
CREATE TABLE IF NOT EXISTS `vuelo` (
  `cod_vuelo` varchar(8) NOT NULL,
  `cod_avion` varchar(8) DEFAULT NULL,
  `cod_piloto` varchar(6) DEFAULT NULL,
  `fecha_salida` date DEFAULT NULL,
  `duracion` float DEFAULT NULL,
  `aeropuerto` varchar(50) DEFAULT NULL,
  `ciudad` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`cod_vuelo`),
  KEY `FK__avion` (`cod_avion`),
  KEY `FK__piloto` (`cod_piloto`),
  KEY `FK__destino` (`aeropuerto`,`ciudad`),
  CONSTRAINT `FK__avion` FOREIGN KEY (`cod_avion`) REFERENCES `avion` (`cod_avion`),
  CONSTRAINT `FK__destino` FOREIGN KEY (`aeropuerto`, `ciudad`) REFERENCES `destino` (`aeropuerto`, `ciudad`),
  CONSTRAINT `FK__piloto` FOREIGN KEY (`cod_piloto`) REFERENCES `piloto` (`cod_piloto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para disparador aeropuerto.vuelo_AI_TRIGGER
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `vuelo_AI_TRIGGER` AFTER INSERT ON `vuelo` FOR EACH ROW BEGIN
UPDATE piloto
set piloto.horas_vuelo=piloto.horas_vuelo+new.duracion
where cod_piloto=new.cod_piloto;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador aeropuerto.vuelo_AU_TRIGGER
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `vuelo_AU_TRIGGER` BEFORE UPDATE ON `vuelo` FOR EACH ROW BEGIN
UPDATE piloto
set piloto.horas_vuelo=piloto.horas_vuelo+(new.duracion-old.duracion)
where cod_piloto=new.cod_piloto;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
