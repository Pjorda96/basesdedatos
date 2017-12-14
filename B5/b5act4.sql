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


-- Volcando estructura de base de datos para b5act4
CREATE DATABASE IF NOT EXISTS `b5act4` /*!40100 DEFAULT CHARACTER SET latin1 COLLATE latin1_spanish_ci */;
USE `b5act4`;

-- Volcando estructura para tabla b5act4.arbitro
CREATE TABLE IF NOT EXISTS `arbitro` (
  `nombre` char(50) COLLATE latin1_spanish_ci NOT NULL,
  PRIMARY KEY (`nombre`),
  CONSTRAINT `FK__personaArbitro` FOREIGN KEY (`nombre`) REFERENCES `persona` (`nombre`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla b5act4.juego
CREATE TABLE IF NOT EXISTS `juego` (
  `nomParticipante` char(50) COLLATE latin1_spanish_ci NOT NULL,
  `fecha` int(11) NOT NULL,
  `sala` char(50) COLLATE latin1_spanish_ci NOT NULL,
  PRIMARY KEY (`nomParticipante`,`fecha`,`sala`),
  KEY `FK_juego_partida` (`fecha`,`sala`),
  CONSTRAINT `FK_juego_participante` FOREIGN KEY (`nomParticipante`) REFERENCES `participante` (`nombre`),
  CONSTRAINT `FK_juego_partida` FOREIGN KEY (`fecha`, `sala`) REFERENCES `partida` (`fecha`, `sala`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla b5act4.pais
CREATE TABLE IF NOT EXISTS `pais` (
  `nombre` char(50) COLLATE latin1_spanish_ci NOT NULL,
  PRIMARY KEY (`nombre`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla b5act4.participante
CREATE TABLE IF NOT EXISTS `participante` (
  `nombre` char(50) COLLATE latin1_spanish_ci NOT NULL,
  PRIMARY KEY (`nombre`),
  CONSTRAINT `FK__persona` FOREIGN KEY (`nombre`) REFERENCES `persona` (`nombre`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla b5act4.partida
CREATE TABLE IF NOT EXISTS `partida` (
  `fecha` int(11) NOT NULL,
  `arbitro` char(50) COLLATE latin1_spanish_ci NOT NULL,
  `sala` char(50) COLLATE latin1_spanish_ci NOT NULL,
  PRIMARY KEY (`fecha`,`sala`),
  KEY `FK__arbitro` (`arbitro`),
  CONSTRAINT `FK__arbitro` FOREIGN KEY (`arbitro`) REFERENCES `arbitro` (`nombre`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla b5act4.persona
CREATE TABLE IF NOT EXISTS `persona` (
  `nombre` char(50) COLLATE latin1_spanish_ci NOT NULL,
  `email` char(50) COLLATE latin1_spanish_ci DEFAULT NULL,
  `habitacion` char(50) COLLATE latin1_spanish_ci DEFAULT NULL,
  `pais` char(50) COLLATE latin1_spanish_ci DEFAULT NULL,
  PRIMARY KEY (`nombre`),
  KEY `FK__pais` (`pais`),
  CONSTRAINT `FK__pais` FOREIGN KEY (`pais`) REFERENCES `pais` (`nombre`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

-- La exportación de datos fue deseleccionada.
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
