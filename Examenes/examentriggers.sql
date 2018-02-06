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


-- Volcando estructura de base de datos para examentriggers
CREATE DATABASE IF NOT EXISTS `examentriggers` /*!40100 DEFAULT CHARACTER SET latin1 COLLATE latin1_spanish_ci */;
USE `examentriggers`;

-- Volcando estructura para tabla examentriggers.contrato
CREATE TABLE IF NOT EXISTS `contrato` (
  `id_empleado` int(11) NOT NULL,
  `id_dpto` int(11) NOT NULL,
  `sueldo` int(11) NOT NULL,
  PRIMARY KEY (`id_empleado`,`id_dpto`),
  KEY `dpto` (`id_dpto`),
  CONSTRAINT `dpto` FOREIGN KEY (`id_dpto`) REFERENCES `departamento` (`id_dpto`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `empleado` FOREIGN KEY (`id_empleado`) REFERENCES `empleado` (`id_empleado`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla examentriggers.departamento
CREATE TABLE IF NOT EXISTS `departamento` (
  `id_dpto` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) COLLATE latin1_spanish_ci DEFAULT NULL,
  `dispendio` int(11) DEFAULT '0',
  `total` int(11) DEFAULT '0',
  `media_hijos` int(11) DEFAULT '0',
  PRIMARY KEY (`id_dpto`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla examentriggers.empleado
CREATE TABLE IF NOT EXISTS `empleado` (
  `id_empleado` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) COLLATE latin1_spanish_ci DEFAULT NULL,
  `cantidad` int(11) DEFAULT '0',
  `hijos` int(11) DEFAULT '0',
  PRIMARY KEY (`id_empleado`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para disparador examentriggers.contrato_AD_TRIGGER
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `contrato_AD_TRIGGER` AFTER DELETE ON `contrato` FOR EACH ROW BEGIN
UPDATE departamento
set total=total-1
where id_dpto=old.id_empleado;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador examentriggers.contrato_AI_TRIGGER
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `contrato_AI_TRIGGER` AFTER INSERT ON `contrato` FOR EACH ROW BEGIN
UPDATE departamento
set dispendio=dispendio+new.sueldo
where id_dpto=new.id_dpto;
UPDATE empleado
set cantidad=cantidad+new.sueldo
where id_empleado=new.id_empleado;
UPDATE departamento
set total=total+1
where id_dpto=new.id_dpto;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador examentriggers.contrato_AU_TRIGGER
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `contrato_AU_TRIGGER` AFTER UPDATE ON `contrato` FOR EACH ROW BEGIN
UPDATE departamento
set dispendio=dispendio+new.sueldo-old.sueldo
where id_dpto=new.id_dpto;

UPDATE empleado
set cantidad=cantidad+new.sueldo-old.sueldo
where id_empleado=new.id_empleado;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador examentriggers.empleado_AU_TRIGGER
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `empleado_AU_TRIGGER` AFTER UPDATE ON `empleado` FOR EACH ROW BEGIN
DECLARE mediaHijos FLOAT;
select avg(hijos) into mediaHijos from departamento natural join contrato;
UPDATE departamento
set media_hijos=mediaHijos;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
