/*CREAMOS LA TABLA employee*/
CREATE TABLE employee (
employeeNumber int(11) NOT NULL,
lastname varchar(50) NOT NULL,
PRIMARY KEY (employeeNumber)
);

/*INSERTAMOS UN PAR DE REGITROS*/
INSERT INTO employee
VALUES (1,'Monfort'),
(2,'Salvador');

/*CREAMOS LA TABLA DE AUDITORIA*/
CREATE TABLE employee_audit (
id int(11) NOT NULL AUTO_INCREMENT,
employeeNumber int(11) NOT NULL,
lastname varchar(50) NOT NULL,
changedon datetime DEFAULT NULL,
accion varchar(50) DEFAULT NULL,
PRIMARY KEY (id)
)