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


-- Volcando estructura de base de datos para prueba
CREATE DATABASE IF NOT EXISTS `prueba` /*!40100 DEFAULT CHARACTER SET latin1 COLLATE latin1_spanish_ci */;
USE `prueba`;

-- Volcando estructura para procedimiento prueba.Actualizarnombre
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `Actualizarnombre`(
	IN `cedula` VARCHAR(50),
	IN `nombre` VARCHAR(50)
)
BEGIN
UPDATE clientes
	SET nombre=nombre
	where cedula=cedula;
END//
DELIMITER ;

-- Volcando estructura para función prueba.Calculabono
DELIMITER //
CREATE DEFINER=`root`@`localhost` FUNCTION `Calculabono`(salario_basico float) RETURNS float
    DETERMINISTIC
BEGIN
	DECLARE bono FLOAT;
	SET bono = salario_basico*8/100;
	RETURN 	bono;
END//
DELIMITER ;

-- Volcando estructura para función prueba.Calculapension
DELIMITER //
CREATE DEFINER=`root`@`localhost` FUNCTION `Calculapension`(salario_basico float) RETURNS float
    DETERMINISTIC
BEGIN
	DECLARE pension FLOAT;
	SET pension = salario_basico*4/100;
	RETURN 	pension;
END//
DELIMITER ;

-- Volcando estructura para función prueba.Calculasalario_integral
DELIMITER //
CREATE DEFINER=`root`@`localhost` FUNCTION `Calculasalario_integral`(salario_basico float, 
salud float, pension float, bono 
float, subsidio float) RETURNS float
    DETERMINISTIC
BEGIN
	DECLARE salario_integral FLOAT;
	DECLARE salud FLOAT;
	DECLARE pension FLOAT;
	DECLARE bono FLOAT;
	DECLARE subsidio FLOAT;
	SET salario_integral = salario_basico-salud-pension+bono+subsidio;
	RETURN 	salario_integral;
END//
DELIMITER ;

-- Volcando estructura para función prueba.Calculasalud
DELIMITER //
CREATE DEFINER=`root`@`localhost` FUNCTION `Calculasalud`(salario_basico float) RETURNS float
    DETERMINISTIC
BEGIN
	DECLARE salud FLOAT;
	SET salud = salario_basico*4/100;
	RETURN 	salud;
END//
DELIMITER ;

-- Volcando estructura para función prueba.Calculasubsidio
DELIMITER //
CREATE DEFINER=`root`@`localhost` FUNCTION `Calculasubsidio`(
	`salario_basico` float
) RETURNS float
    DETERMINISTIC
BEGIN
	DECLARE subsidio FLOAT;
	SET subsidio = salario_basico*7/100;
	RETURN 	subsidio;
END//
DELIMITER ;

-- Volcando estructura para tabla prueba.clientes
CREATE TABLE IF NOT EXISTS `clientes` (
  `cedula` varchar(50) COLLATE latin1_spanish_ci NOT NULL,
  `nombre` varchar(50) COLLATE latin1_spanish_ci NOT NULL,
  `apellido` varchar(50) COLLATE latin1_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

-- Volcando datos para la tabla prueba.clientes: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;

-- Volcando estructura para procedimiento prueba.Decidirdimension
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `Decidirdimension`(IN altura INTEGER)
BEGIN
	DECLARE variable1 CHAR(15);
		IF altura >10 THEN
			SET variable1 = 'grande';
		ELSE
			IF altura >5 THEN
				SET variable1 = 'mediano';
			ELSE
				SET variable1 = 'pequeño';
			END IF;
		END IF;
	INSERT INTO dimension VALUES (altura, variable1);
END//
DELIMITER ;

-- Volcando estructura para tabla prueba.dimension
CREATE TABLE IF NOT EXISTS `dimension` (
  `altura` int(11) NOT NULL,
  `tamano` varchar(15) COLLATE latin1_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

-- Volcando datos para la tabla prueba.dimension: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `dimension` DISABLE KEYS */;
/*!40000 ALTER TABLE `dimension` ENABLE KEYS */;

-- Volcando estructura para procedimiento prueba.Eliminarcliente
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `Eliminarcliente`(IN cedula VARCHAR(50))
BEGIN
	DELETE FROM clientes
	WHERE cedula=cedula;
END//
DELIMITER ;

-- Volcando estructura para tabla prueba.empleado
CREATE TABLE IF NOT EXISTS `empleado` (
  `cedula` varchar(50) COLLATE latin1_spanish_ci NOT NULL,
  `nombre` varchar(50) COLLATE latin1_spanish_ci NOT NULL,
  `salario_basico` float NOT NULL,
  `subsidio` float NOT NULL,
  `salud` float NOT NULL,
  `pension` float NOT NULL,
  `bono` float NOT NULL,
  `salario_integral` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

-- Volcando datos para la tabla prueba.empleado: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `empleado` DISABLE KEYS */;
/*!40000 ALTER TABLE `empleado` ENABLE KEYS */;

-- Volcando estructura para procedimiento prueba.Insertarcliente
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `Insertarcliente`(IN cedula VARCHAR(50),
IN nombre VARCHAR(50),
IN apellido VARCHAR(50))
BEGIN
	INSERT INTO clientes VALUES (cedula, nombre, apellido);
END//
DELIMITER ;

-- Volcando estructura para procedimiento prueba.Insertarvalores
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `Insertarvalores`(
	IN `cedula` VARCHAR(50),
	IN `nombre` VARCHAR(50),
	IN `salario_basico` FLOAT
)
BEGIN
INSERT INTO empleado VALUES (cedula, nombre, salario_basico, Calculasubsidio(salario_basico),Calculasalud(salario_basico),
	Calculapension(salario_basico),Calculabono(salario_basico),
	Calculasalario_integral(salario_basico));
END//
DELIMITER ;

-- Volcando estructura para tabla prueba.persona
CREATE TABLE IF NOT EXISTS `persona` (
  `peso` int(11) NOT NULL,
  `estado` varchar(15) COLLATE latin1_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

-- Volcando datos para la tabla prueba.persona: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `persona` DISABLE KEYS */;
/*!40000 ALTER TABLE `persona` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
