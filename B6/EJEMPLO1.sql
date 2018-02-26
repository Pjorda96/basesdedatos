/*CREAMOS BASE DE DATOS*/
DROP DATABASE IF EXISTS contable;
CREATE DATABASE contable;
USE contable;

/*CREAMOS TABLAS
APUNTES*/
DROP TABLE IF EXISTS APUNTES;
CREATE TABLE APUNTES (
ASIENTO INT(8) DEFAULT 0,
LINEA SMALLINT(5) DEFAULT 0,
FECHA DATE DEFAULT '2018-01-01',
TEXTO VARCHAR(40) DEFAULT '',
CUENTA CHAR(10) DEFAULT '',
DEBE DOUBLE(10,2) DEFAULT 0,
HABER DOUBLE(10,2) DEFAULT 0,
PRIMARY KEY (ASIENTO,LINEA),
KEY K2 (CUENTA,FECHA))
ENGINE=InnoDB ROW_FORMAT=DYNAMIC;

/*SALDOS*/
DROP TABLE IF EXISTS SALDO;
CREATE TABLE SALDO (
CUENTA CHAR(10) NOT NULL DEFAULT '',
ANO SMALLINT(4) DEFAULT 0,
MES TINYINT(2) DEFAULT 0,
DEBE DOUBLE(10,2) DEFAULT 0,
HABER DOUBLE(10,2) DEFAULT 0,
PRIMARY KEY (CUENTA,ANO,MES))
ENGINE=InnoDB ROW_FORMAT=DYNAMIC;