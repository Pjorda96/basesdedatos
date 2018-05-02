-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         5.7.12-log - MySQL Community Server (GPL)
-- SO del servidor:              Win64
-- HeidiSQL Versión:             9.3.0.4984
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8mb4 */;
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

-- Volcando datos para la tabla aeropuerto.asistencia_vuelo: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `asistencia_vuelo` DISABLE KEYS */;
INSERT INTO `asistencia_vuelo` (`cod_personal`, `cod_vuelo`, `funcion`) VALUES
	('A12365', 'V887', 'Sobrecargo'),
	('A55444', 'V856', 'Asistente 2'),
	('A55444', 'V887', 'Asistente'),
	('A88991', 'V856', NULL),
	('A90239', 'V887', NULL);
/*!40000 ALTER TABLE `asistencia_vuelo` ENABLE KEYS */;


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

-- Volcando datos para la tabla aeropuerto.avion: ~5 rows (aproximadamente)
/*!40000 ALTER TABLE `avion` DISABLE KEYS */;
INSERT INTO `avion` (`cod_avion`, `modelo`, `plazas`, `fecha_rev`, `cod_comp`) VALUES
	('AN8889', 'Boeing 737', 242, '2016-05-04', 'ANS'),
	('GK1040', 'NULL', 0, '2016-05-04', 'GKR'),
	('GK9051', 'Airbus 380', 525, '2016-05-04', 'GKR'),
	('IB535', 'Airbus 320', 200, '2016-05-04', 'IBR'),
	('IB889', 'Boeing 787', 250, '2016-05-04', 'IBR');
/*!40000 ALTER TABLE `avion` ENABLE KEYS */;


-- Volcando estructura para tabla aeropuerto.companyia
CREATE TABLE IF NOT EXISTS `companyia` (
  `cod_comp` varchar(4) NOT NULL,
  `nombre` varchar(20) DEFAULT NULL,
  `telefono` varchar(9) DEFAULT NULL,
  PRIMARY KEY (`cod_comp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla aeropuerto.companyia: ~4 rows (aproximadamente)
/*!40000 ALTER TABLE `companyia` DISABLE KEYS */;
INSERT INTO `companyia` (`cod_comp`, `nombre`, `telefono`) VALUES
	('ANS', 'AIR NOSTRE', '2334'),
	('BTW', 'BIT AIRWAY', '35546'),
	('GKR', 'GREEK AIR', '22334'),
	('IBR', 'SIBERIA', '11353');
/*!40000 ALTER TABLE `companyia` ENABLE KEYS */;


-- Volcando estructura para tabla aeropuerto.destino
CREATE TABLE IF NOT EXISTS `destino` (
  `aeropuerto` varchar(20) NOT NULL,
  `ciudad` varchar(60) NOT NULL,
  `pais` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`aeropuerto`,`ciudad`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla aeropuerto.destino: ~3 rows (aproximadamente)
/*!40000 ALTER TABLE `destino` DISABLE KEYS */;
INSERT INTO `destino` (`aeropuerto`, `ciudad`, `pais`) VALUES
	('Gatwick', 'Londres', 'Gran Bretaña'),
	('Heathrow', 'Londres', 'Gran Bretaña'),
	('John Wayne', 'Los Ángeles', 'EEUU'),
	('John Wayne', 'Springfield', 'EEUU'),
	('Manises', 'Valencia', 'España');
/*!40000 ALTER TABLE `destino` ENABLE KEYS */;


-- Volcando estructura para tabla aeropuerto.personal_cabina
CREATE TABLE IF NOT EXISTS `personal_cabina` (
  `cod_personal` varchar(6) NOT NULL,
  `nombre` varchar(20) NOT NULL,
  `direccion` varchar(40) NOT NULL,
  `telefono` varchar(9) NOT NULL,
  PRIMARY KEY (`cod_personal`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla aeropuerto.personal_cabina: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `personal_cabina` DISABLE KEYS */;
INSERT INTO `personal_cabina` (`cod_personal`, `nombre`, `direccion`, `telefono`) VALUES
	('A12365', 'Antonia Martina', 'avd. Baleares, 106', '43545'),
	('A55444', 'Felipe', 'c/el cid', '333'),
	('A88991', 'Sergio Domos', 'C/ Soldador', '45665'),
	('A90239', 'María Seguí', 'c/labrador', '46466');
/*!40000 ALTER TABLE `personal_cabina` ENABLE KEYS */;


-- Volcando estructura para tabla aeropuerto.piloto
CREATE TABLE IF NOT EXISTS `piloto` (
  `cod_piloto` varchar(6) NOT NULL,
  `nombre` varchar(20) NOT NULL,
  `direccion` varchar(20) NOT NULL,
  `telefono` varchar(20) NOT NULL,
  `horas_vuelo` float NOT NULL,
  PRIMARY KEY (`cod_piloto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla aeropuerto.piloto: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `piloto` DISABLE KEYS */;
INSERT INTO `piloto` (`cod_piloto`, `nombre`, `direccion`, `telefono`, `horas_vuelo`) VALUES
	('P12345', 'Sonia Mares', 'Avda La paz, 58', '33553', 0),
	('P20809', 'Manolo Llamas', 'c/perdidos 7', '235535', 0),
	('P21592', 'Pedro Peñas', 'c/colón', '3545', 0),
	('P54321', 'María Ros', 'c/Laurel', '56677', 0);
/*!40000 ALTER TABLE `piloto` ENABLE KEYS */;


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

-- Volcando datos para la tabla aeropuerto.vuelo: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `vuelo` DISABLE KEYS */;
INSERT INTO `vuelo` (`cod_vuelo`, `cod_avion`, `cod_piloto`, `fecha_salida`, `duracion`, `aeropuerto`, `ciudad`) VALUES
	('V856', 'AN8889', 'P12345', '2016-05-04', 10, 'John Wayne', 'Springfield'),
	('V886', 'IB535', 'P21592', '2016-05-04', 3.5, 'Manises', 'Valencia'),
	('V887', 'GK9051', 'P20809', '2016-05-04', 2, 'Gatwick', 'Londres'),
	('V888', 'IB535', 'P21592', '2016-05-04', 12, 'John Wayne', 'Los Ángeles');
/*!40000 ALTER TABLE `vuelo` ENABLE KEYS */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
