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


-- Volcando estructura de base de datos para centro
CREATE DATABASE IF NOT EXISTS `centro` /*!40100 DEFAULT CHARACTER SET latin1 COLLATE latin1_spanish_ci */;
USE `centro`;

-- Volcando estructura para tabla centro.alumno
CREATE TABLE IF NOT EXISTS `alumno` (
  `idAlumno` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) COLLATE latin1_spanish_ci DEFAULT '0',
  `calificacion` double DEFAULT '0',
  PRIMARY KEY (`idAlumno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla centro.asignatura
CREATE TABLE IF NOT EXISTS `asignatura` (
  `idAsignatura` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) COLLATE latin1_spanish_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`idAsignatura`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla centro.nota
CREATE TABLE IF NOT EXISTS `nota` (
  `idAlumno` int(11) NOT NULL,
  `idAsignatura` int(11) NOT NULL,
  `nota` int(11) DEFAULT NULL,
  PRIMARY KEY (`idAlumno`,`idAsignatura`),
  KEY `asignatura` (`idAsignatura`),
  CONSTRAINT `alumno` FOREIGN KEY (`idAlumno`) REFERENCES `alumno` (`idAlumno`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `asignatura` FOREIGN KEY (`idAsignatura`) REFERENCES `asignatura` (`idAsignatura`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para disparador centro.nota_BI_TRIGGER
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `nota_BI_TRIGGER` BEFORE INSERT ON `nota` FOR EACH ROW BEGIN
DECLARE notaMedia FLOAT;
DECLARE comentario VARCHAR(100);

select avg(mark) into notaMedia from nota where idAlumno=new.idAlumno;
if notaMedia<5 then set comentario='Suspenso';
elseif notaMedia>=5 and notaMedia<6 then set comentario='Suficiente';
elseif notaMedia>=6 and notaMedia<7 then set comentario='Bien';
elseif notaMedia>=7 and notaMedia<9 then set comentario='Notable';
elseif notaMedia>=9 and notaMedia<=10 then set comentario='Sobresaliente';
end if;
UPDATE alumno set calificacion=comentario where idAlumno=new.idAlumno;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
