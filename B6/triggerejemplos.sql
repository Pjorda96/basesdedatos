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


-- Volcando estructura de base de datos para triggersejemplos
CREATE DATABASE IF NOT EXISTS `triggersejemplos` /*!40100 DEFAULT CHARACTER SET latin1 COLLATE latin1_spanish_ci */;
USE `triggersejemplos`;

-- Volcando estructura para tabla triggersejemplos.historico_jugador
CREATE TABLE IF NOT EXISTS `historico_jugador` (
  `id_jugador` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) COLLATE latin1_spanish_ci DEFAULT '0',
  `sueldo` int(11) NOT NULL DEFAULT '0',
  `date_mod` date DEFAULT NULL,
  PRIMARY KEY (`id_jugador`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla triggersejemplos.jugador
CREATE TABLE IF NOT EXISTS `jugador` (
  `id_jugador` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) COLLATE latin1_spanish_ci DEFAULT '0',
  `sueldo` int(11) DEFAULT '0',
  PRIMARY KEY (`id_jugador`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para disparador triggersejemplos.jugador_BD_TRIGGER
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `jugador_BD_TRIGGER` BEFORE DELETE ON `jugador` FOR EACH ROW BEGIN
insert into historico_jugador
SET nombre=OLD.nombre,
	sueldo=OLD.sueldo,
	date_mod=NOW();
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador triggersejemplos.jugador_BI_TRIGGER
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `jugador_BI_TRIGGER` BEFORE INSERT ON `jugador` FOR EACH ROW BEGIN
IF NEW.sueldo < 1000 THEN
SET NEW.sueldo = 1000;
ELSEIF NEW.sueldo>3000 THEN
SET NEW.sueldo=3000;
END IF;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador triggersejemplos.jugador_BU_TRIGGER
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `jugador_BU_TRIGGER` BEFORE UPDATE ON `jugador` FOR EACH ROW BEGIN
IF NEW.sueldo < 1000 THEN
SET NEW.sueldo = 1000;
ELSEIF NEW.sueldo>3000 THEN
SET NEW.sueldo=3000;
END IF;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
