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

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla campeonato.equipo
CREATE TABLE IF NOT EXISTS `equipo` (
  `codeq` int(11) NOT NULL,
  `nomeq` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pais` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`codeq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- La exportación de datos fue deseleccionada.
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

-- La exportación de datos fue deseleccionada.
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

-- La exportación de datos fue deseleccionada.
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

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para disparador campeonato.participa_BI_TRIGGER
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `participa_BI_TRIGGER` BEFORE INSERT ON `participa` FOR EACH ROW BEGIN
UPDATE prueba
set num_pilotos=num_pilotos+1
where codcir=new.codcir and anyo=new.anyo;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
