

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Volcando estructura de base de datos para premios_nobel
DROP DATABASE IF EXISTS `premios_nobel`;
CREATE DATABASE IF NOT EXISTS `premios_nobel` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `premios_nobel`;


-- Volcando estructura para tabla premios_nobel.categoria
DROP TABLE IF EXISTS `categoria`;
CREATE TABLE IF NOT EXISTS `categoria` (
  `cat_id` char(1) NOT NULL,
  `descripcion` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`cat_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla premios_nobel.categoria: ~6 rows (aproximadamente)
DELETE FROM `categoria`;
/*!40000 ALTER TABLE `categoria` DISABLE KEYS */;
INSERT INTO `categoria` (`cat_id`, `descripcion`) VALUES
	('E', 'Economía'),
	('F', 'Física'),
	('L', 'Literatura'),
	('M', 'Fisiología o Medicina'),
	('P', 'Paz'),
	('Q', 'Química');
/*!40000 ALTER TABLE `categoria` ENABLE KEYS */;


-- Volcando estructura para tabla premios_nobel.comite
DROP TABLE IF EXISTS `comite`;
CREATE TABLE IF NOT EXISTS `comite` (
  `cat_id` char(1) NOT NULL,
  `anyo` int(11) NOT NULL,
  `jurado_id` int(11) NOT NULL,
  `cargo` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`cat_id`,`anyo`,`jurado_id`),
  KEY `FK_comite_jurado` (`jurado_id`),
  CONSTRAINT `FK_comite_jurado` FOREIGN KEY (`jurado_id`) REFERENCES `jurado` (`jurado_id`),
  CONSTRAINT `FK_comite_edicion` FOREIGN KEY (`cat_id`, `anyo`) REFERENCES `edicion` (`cat_id`, `anyo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla premios_nobel.comite: ~2 rows (aproximadamente)
DELETE FROM `comite`;
/*!40000 ALTER TABLE `comite` DISABLE KEYS */;
INSERT INTO `comite` (`cat_id`, `anyo`, `jurado_id`, `cargo`) VALUES
	('P', 2007, 1, NULL),
	('P', 2007, 2, 'Presidente');
/*!40000 ALTER TABLE `comite` ENABLE KEYS */;


-- Volcando estructura para tabla premios_nobel.edicion
DROP TABLE IF EXISTS `edicion`;
CREATE TABLE IF NOT EXISTS `edicion` (
  `cat_id` char(1) NOT NULL,
  `anyo` int(10) NOT NULL,
  `contribucion` varchar(50) NOT NULL,
  PRIMARY KEY (`cat_id`,`anyo`),
  CONSTRAINT `FK_edicion_categoria` FOREIGN KEY (`cat_id`) REFERENCES `categoria` (`cat_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla premios_nobel.edicion: ~5 rows (aproximadamente)
DELETE FROM `edicion`;
/*!40000 ALTER TABLE `edicion` DISABLE KEYS */;
INSERT INTO `edicion` (`cat_id`, `anyo`, `contribucion`) VALUES
	('F', 1903, 'Fenómenos de radiación'),
	('F', 1921, 'Efecto fotoeléctrico'),
	('L', 2007, 'Experiencia femenina'),
	('P', 2007, 'Cambio climático'),
	('Q', 1911, 'Descubrimiento polonio y radio');
/*!40000 ALTER TABLE `edicion` ENABLE KEYS */;


-- Volcando estructura para tabla premios_nobel.jurado
DROP TABLE IF EXISTS `jurado`;
CREATE TABLE IF NOT EXISTS `jurado` (
  `jurado_id` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  PRIMARY KEY (`jurado_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla premios_nobel.jurado: ~4 rows (aproximadamente)
DELETE FROM `jurado`;
/*!40000 ALTER TABLE `jurado` DISABLE KEYS */;
INSERT INTO `jurado` (`jurado_id`, `nombre`) VALUES
	(1, 'Berge Ragnar Furre'),
	(2, 'Ole Danbolt Mjos'),
	(3, 'Hans Jörnvall'),
	(4, 'Gunnar von Heijne');
/*!40000 ALTER TABLE `jurado` ENABLE KEYS */;


-- Volcando estructura para tabla premios_nobel.nominado
DROP TABLE IF EXISTS `nominado`;
CREATE TABLE IF NOT EXISTS `nominado` (
  `cod` int(11) NOT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `cod_pais` char(4) DEFAULT NULL,
  `anyo_nac` year(4) DEFAULT NULL,
  PRIMARY KEY (`cod`),
  KEY `FK_nominado_pais` (`cod_pais`),
  CONSTRAINT `FK_nominado_pais` FOREIGN KEY (`cod_pais`) REFERENCES `pais` (`cod_pais`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla premios_nobel.nominado: ~7 rows (aproximadamente)
DELETE FROM `nominado`;
/*!40000 ALTER TABLE `nominado` DISABLE KEYS */;
INSERT INTO `nominado` (`cod`, `nombre`, `cod_pais`, `anyo_nac`) VALUES
	(1, 'Doris Lessing', 'UK', '1919'),
	(2, 'Albert Einstein', 'GER', '0000'),
	(3, 'Roger B. Myerson', 'USA', '1951'),
	(4, 'Albert A. Gore', 'USA', '1948'),
	(5, 'Maria Curie', 'FR', '0000'),
	(6, 'Pierre Curie', 'FR', '0000'),
	(7, 'Antoine H. Becquerel', 'FR', '0000');
/*!40000 ALTER TABLE `nominado` ENABLE KEYS */;


-- Volcando estructura para tabla premios_nobel.pais
DROP TABLE IF EXISTS `pais`;
CREATE TABLE IF NOT EXISTS `pais` (
  `cod_pais` char(4) NOT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `num_premios` int(10) DEFAULT NULL,
  PRIMARY KEY (`cod_pais`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla premios_nobel.pais: ~5 rows (aproximadamente)
DELETE FROM `pais`;
/*!40000 ALTER TABLE `pais` DISABLE KEYS */;
INSERT INTO `pais` (`cod_pais`, `nombre`, `num_premios`) VALUES
	('ES', 'España', 0),
	('FR', 'Francia', 4),
	('GER', 'Alemania', 1),
	('UK', 'Reino Unido', 1),
	('USA', 'Estados Unidos', 1);
/*!40000 ALTER TABLE `pais` ENABLE KEYS */;


-- Volcando estructura para tabla premios_nobel.premiado
DROP TABLE IF EXISTS `premiado`;
CREATE TABLE IF NOT EXISTS `premiado` (
  `cat_id` char(1) NOT NULL,
  `anyo` int(11) NOT NULL,
  `cod` int(11) NOT NULL,
  PRIMARY KEY (`cat_id`,`anyo`,`cod`),
  KEY `FK_premiado_nominado` (`cod`),
  CONSTRAINT `FK_premiado_nominado` FOREIGN KEY (`cod`) REFERENCES `nominado` (`cod`),
  CONSTRAINT `FK_premiado_edicion` FOREIGN KEY (`cat_id`, `anyo`) REFERENCES `edicion` (`cat_id`, `anyo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla premios_nobel.premiado: ~7 rows (aproximadamente)
DELETE FROM `premiado`;
/*!40000 ALTER TABLE `premiado` DISABLE KEYS */;
INSERT INTO `premiado` (`cat_id`, `anyo`, `cod`) VALUES
	('L', 2007, 1),
	('F', 1903, 2),
	('F', 1921, 2),
	('P', 2007, 4),
	('F', 1903, 5),
	('Q', 1911, 5),
	('F', 1903, 6);
/*!40000 ALTER TABLE `premiado` ENABLE KEYS */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
