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


-- Volcando estructura de base de datos para velocipedos
CREATE DATABASE IF NOT EXISTS `velocipedos` /*!40100 DEFAULT CHARACTER SET latin1 COLLATE latin1_spanish_ci */;
USE `velocipedos`;

-- Volcando estructura para procedimiento velocipedos.actualizar_ganador
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizar_ganador`()
BEGIN

declare winner int;
set winner=(select id
				from ciclista
				where (tiempo_total+puntuacion)=(select min(tiempo_total+puntuacion)
				from ciclista));

insert ganador values (winner);

END//
DELIMITER ;

-- Volcando estructura para procedimiento velocipedos.actualizar_puntuacion_ciclista
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizar_puntuacion_ciclista`(
	IN `id_ciclista` INT
)
BEGIN

declare punt int;
set punt=(select sum(posicion)
from ciclistaxetapa
where ciclista=id_ciclista);

update ciclista set puntuacion=punt
where id=id_ciclista;

END//
DELIMITER ;

-- Volcando estructura para procedimiento velocipedos.actualizar_tiempo_total
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizar_tiempo_total`(
	IN `nom_ciclista` VARCHAR(50)
)
BEGIN

declare total int;
set total=(select sum(tiempo)
			from ciclistaxetapa join ciclista
			on ciclistaxetapa.ciclista=ciclista.id
			where ciclista.nombre=nom_ciclista);

update ciclista set tiempo_total=total
where nombre=nom_ciclista;

END//
DELIMITER ;

-- Volcando estructura para procedimiento velocipedos.actualizar_tiempo_total_nacion
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizar_tiempo_total_nacion`(
	IN `nom_nacion` VARCHAR(50)
)
BEGIN

declare total_nacion int;
set total_nacion=(select sum(tiempo)
from ciclistaxetapa join ciclista join nacion
on ciclistaxetapa.ciclista=ciclista.id
	 and ciclista.nacion=nacion.id
where nacion.nombre=nom_nacion);

update nacion set tiempo_total=total_nacion
where nombre=nom_nacion;

END//
DELIMITER ;

-- Volcando estructura para función velocipedos.calcula_tiempo_montanya
DELIMITER //
CREATE DEFINER=`root`@`localhost` FUNCTION `calcula_tiempo_montanya`(
	`nom_ciclista` VARCHAR(50)
) RETURNS int(11)
BEGIN

declare tiempo_montanya int;
set tiempo_montanya=(select sum(ciclistaxetapa.tiempo)
							from etapa join ciclistaxetapa join ciclista
							on etapa.id=ciclistaxetapa.etapa
								and ciclistaxetapa.ciclista=ciclista.id
							where etapa.tipo="montanya"
								and ciclista.nombre=nom_ciclista);
return tiempo_montanya;

END//
DELIMITER ;

-- Volcando estructura para tabla velocipedos.ciclista
CREATE TABLE IF NOT EXISTS `ciclista` (
  `id` int(11) NOT NULL,
  `nombre` varchar(50) COLLATE latin1_spanish_ci NOT NULL,
  `nacion` int(11) NOT NULL,
  `tiempo_total` int(11) NOT NULL,
  `puntuacion` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_CICLISTA_nacion` (`nacion`),
  CONSTRAINT `FK_CICLISTA_nacion` FOREIGN KEY (`nacion`) REFERENCES `nacion` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

-- Volcando datos para la tabla velocipedos.ciclista: ~5 rows (aproximadamente)
/*!40000 ALTER TABLE `ciclista` DISABLE KEYS */;
INSERT INTO `ciclista` (`id`, `nombre`, `nacion`, `tiempo_total`, `puntuacion`) VALUES
	(1, 'Pedro', 1, 629, 7),
	(2, 'Manuel', 1, 639, 10),
	(3, 'Perico', 1, 886, 11),
	(4, 'Cristiano', 3, 340, 3),
	(5, 'Laurent', 2, 381, 5);
/*!40000 ALTER TABLE `ciclista` ENABLE KEYS */;

-- Volcando estructura para tabla velocipedos.ciclistaxetapa
CREATE TABLE IF NOT EXISTS `ciclistaxetapa` (
  `ciclista` int(11) NOT NULL,
  `etapa` int(11) NOT NULL,
  `posicion` int(11) NOT NULL,
  `tiempo` int(11) NOT NULL,
  PRIMARY KEY (`ciclista`,`etapa`),
  KEY `FK_CICLISTAxETAPA_etapa` (`etapa`),
  CONSTRAINT `FK_CICLISTAxETAPA_ciclista` FOREIGN KEY (`ciclista`) REFERENCES `ciclista` (`id`),
  CONSTRAINT `FK_CICLISTAxETAPA_etapa` FOREIGN KEY (`etapa`) REFERENCES `etapa` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

-- Volcando datos para la tabla velocipedos.ciclistaxetapa: ~18 rows (aproximadamente)
/*!40000 ALTER TABLE `ciclistaxetapa` DISABLE KEYS */;
INSERT INTO `ciclistaxetapa` (`ciclista`, `etapa`, `posicion`, `tiempo`) VALUES
	(1, 1, 1, 120),
	(1, 2, 2, 100),
	(1, 4, 1, 89),
	(1, 6, 3, 320),
	(2, 1, 2, 150),
	(2, 2, 3, 110),
	(2, 3, 3, 79),
	(2, 6, 2, 300),
	(3, 1, 3, 180),
	(3, 3, 1, 36),
	(3, 4, 3, 120),
	(3, 5, 3, 300),
	(3, 6, 1, 250),
	(4, 2, 1, 90),
	(4, 5, 2, 250),
	(5, 3, 2, 69),
	(5, 4, 2, 112),
	(5, 5, 1, 200);
/*!40000 ALTER TABLE `ciclistaxetapa` ENABLE KEYS */;

-- Volcando estructura para tabla velocipedos.etapa
CREATE TABLE IF NOT EXISTS `etapa` (
  `id` int(11) NOT NULL,
  `nombre` varchar(50) COLLATE latin1_spanish_ci NOT NULL,
  `tipo` varchar(50) COLLATE latin1_spanish_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

-- Volcando datos para la tabla velocipedos.etapa: ~6 rows (aproximadamente)
/*!40000 ALTER TABLE `etapa` DISABLE KEYS */;
INSERT INTO `etapa` (`id`, `nombre`, `tipo`) VALUES
	(1, 'rompepiernas', 'crono'),
	(2, 'rompehuesos', 'montanya'),
	(3, 'matahombres', 'montanya'),
	(4, 'matapersonas', 'montanya'),
	(5, 'transicion', 'llana'),
	(6, 'imposible', 'llana');
/*!40000 ALTER TABLE `etapa` ENABLE KEYS */;

-- Volcando estructura para tabla velocipedos.ganador
CREATE TABLE IF NOT EXISTS `ganador` (
  `ciclista` int(11) NOT NULL,
  PRIMARY KEY (`ciclista`),
  CONSTRAINT `FK_GANADOR_ciclista` FOREIGN KEY (`ciclista`) REFERENCES `ciclista` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

-- Volcando datos para la tabla velocipedos.ganador: ~1 rows (aproximadamente)
/*!40000 ALTER TABLE `ganador` DISABLE KEYS */;
INSERT INTO `ganador` (`ciclista`) VALUES
	(4);
/*!40000 ALTER TABLE `ganador` ENABLE KEYS */;

-- Volcando estructura para tabla velocipedos.nacion
CREATE TABLE IF NOT EXISTS `nacion` (
  `id` int(11) NOT NULL,
  `nombre` varchar(50) COLLATE latin1_spanish_ci NOT NULL,
  `tiempo_total` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

-- Volcando datos para la tabla velocipedos.nacion: ~3 rows (aproximadamente)
/*!40000 ALTER TABLE `nacion` DISABLE KEYS */;
INSERT INTO `nacion` (`id`, `nombre`, `tiempo_total`) VALUES
	(1, 'ESPANYA', 2154),
	(2, 'FRANCIA', 381),
	(3, 'PORTUGAL', 340);
/*!40000 ALTER TABLE `nacion` ENABLE KEYS */;

-- Volcando estructura para tabla velocipedos.naciongana
CREATE TABLE IF NOT EXISTS `naciongana` (
  `nacion` int(11) NOT NULL,
  PRIMARY KEY (`nacion`),
  CONSTRAINT `FK_NACIONGANA_nacion` FOREIGN KEY (`nacion`) REFERENCES `nacion` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

-- Volcando datos para la tabla velocipedos.naciongana: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `naciongana` DISABLE KEYS */;
/*!40000 ALTER TABLE `naciongana` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
