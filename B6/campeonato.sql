-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         5.6.16 - MySQL Community Server (GPL)
-- SO del servidor:              Win32
-- HeidiSQL Versión:             9.3.0.4984
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Volcando estructura de base de datos para campeonato
CREATE DATABASE IF NOT EXISTS `campeonato` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci */;
USE `campeonato`;


-- Volcando estructura para tabla campeonato.circuito
CREATE TABLE IF NOT EXISTS `circuito` (
  `codcir` int(11) NOT NULL,
  `nomc` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ciudad` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `km` float DEFAULT NULL,
  PRIMARY KEY (`codcir`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Volcando datos para la tabla campeonato.circuito: ~6 rows (aproximadamente)
/*!40000 ALTER TABLE `circuito` DISABLE KEYS */;
INSERT INTO `circuito` (`codcir`, `nomc`, `ciudad`, `km`) VALUES
	(1, 'Albert Park', 'Melbourne', 5.3),
	(2, 'Montmeló', 'Montmelo', 4.6),
	(3, 'Montecarlo', 'Mónaco', 3.3),
	(4, 'Silverstone', 'Gran Bretaña', 5891),
	(5, 'Monza', 'Italia', 5793),
	(6, 'Interlagos', 'Brazil', 4309);
/*!40000 ALTER TABLE `circuito` ENABLE KEYS */;


-- Volcando estructura para tabla campeonato.equipo
CREATE TABLE IF NOT EXISTS `equipo` (
  `codeq` int(11) NOT NULL,
  `nomeq` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pais` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`codeq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Volcando datos para la tabla campeonato.equipo: ~7 rows (aproximadamente)
/*!40000 ALTER TABLE `equipo` DISABLE KEYS */;
INSERT INTO `equipo` (`codeq`, `nomeq`, `pais`) VALUES
	(1, 'McLaren', 'Reino Unido'),
	(2, 'Renault', 'Francia'),
	(3, 'Toyota', 'Japón'),
	(4, 'Williams', 'Alemania'),
	(5, 'Ferrari', 'Italia'),
	(6, 'Redbull', 'Reino Unido'),
	(7, 'Toro Rosso', 'Italia');
/*!40000 ALTER TABLE `equipo` ENABLE KEYS */;


-- Volcando estructura para tabla campeonato.participa
CREATE TABLE IF NOT EXISTS `participa` (
  `anyo` int(11) NOT NULL,
  `codcir` int(11) NOT NULL,
  `num` int(11) NOT NULL,
  `puntos` float DEFAULT NULL,
  PRIMARY KEY (`anyo`,`codcir`,`num`),
  KEY `FK__piloto` (`num`),
  CONSTRAINT `FK__piloto` FOREIGN KEY (`num`) REFERENCES `piloto` (`num`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK__prueba` FOREIGN KEY (`anyo`, `codcir`) REFERENCES `prueba` (`anyo`, `codcir`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Volcando datos para la tabla campeonato.participa: ~9 rows (aproximadamente)
/*!40000 ALTER TABLE `participa` DISABLE KEYS */;
INSERT INTO `participa` (`anyo`, `codcir`, `num`, `puntos`) VALUES
	(2014, 1, 1, 5),
	(2014, 1, 2, 10),
	(2014, 1, 3, 20),
	(2014, 1, 6, 12),
	(2015, 3, 4, 8),
	(2015, 3, 5, 10),
	(2015, 3, 7, 5),
	(2016, 2, 1, 15),
	(2016, 2, 2, 20);
/*!40000 ALTER TABLE `participa` ENABLE KEYS */;


-- Volcando estructura para tabla campeonato.piloto
CREATE TABLE IF NOT EXISTS `piloto` (
  `num` int(11) NOT NULL,
  `nomp` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fecha_n` date DEFAULT NULL,
  `codeq` int(11) DEFAULT NULL,
  PRIMARY KEY (`num`),
  KEY `FK_piloto_equipo` (`codeq`),
  CONSTRAINT `FK_piloto_equipo` FOREIGN KEY (`codeq`) REFERENCES `equipo` (`codeq`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Volcando datos para la tabla campeonato.piloto: ~7 rows (aproximadamente)
/*!40000 ALTER TABLE `piloto` DISABLE KEYS */;
INSERT INTO `piloto` (`num`, `nomp`, `fecha_n`, `codeq`) VALUES
	(1, 'Fernando Alonso', '1981-05-25', 5),
	(2, 'Lewis Hamilton', '1983-05-02', 1),
	(3, 'Nico Rosberg', '1999-03-14', 1),
	(4, 'Sebastian Vettel', '1990-05-25', 5),
	(5, 'Daniel Ricciardo', '1991-07-13', 6),
	(6, 'Max Verstappen', '1993-08-12', 6),
	(7, 'Carlos Sainz Jr', '1989-03-19', 7);
/*!40000 ALTER TABLE `piloto` ENABLE KEYS */;


-- Volcando estructura para tabla campeonato.prueba
CREATE TABLE IF NOT EXISTS `prueba` (
  `anyo` int(11) NOT NULL,
  `codcir` int(11) NOT NULL,
  `fecha` date DEFAULT NULL,
  `num_pilotos` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`anyo`,`codcir`),
  KEY `FK__circuito` (`codcir`),
  CONSTRAINT `FK__circuito` FOREIGN KEY (`codcir`) REFERENCES `circuito` (`codcir`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Volcando datos para la tabla campeonato.prueba: ~6 rows (aproximadamente)
/*!40000 ALTER TABLE `prueba` DISABLE KEYS */;
INSERT INTO `prueba` (`anyo`, `codcir`, `fecha`, `num_pilotos`) VALUES
	(2014, 1, '2014-06-04', 0),
	(2014, 2, '2014-08-12', 0),
	(2015, 2, '2015-12-07', 0),
	(2015, 3, '2015-07-26', 0),
	(2016, 1, '2016-09-15', 0),
	(2016, 2, '2016-06-17', 0);
/*!40000 ALTER TABLE `prueba` ENABLE KEYS */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
