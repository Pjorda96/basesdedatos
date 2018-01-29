DELIMITER $$
CREATE TRIGGER employee_BU_TRIGGER BEFORE UPDATE ON employee
FOR EACH ROW BEGIN
INSERT INTO employee_audit
SET accion = 'update',
	employeeNumber = OLD.employeeNumber,
	lastname = OLD.lastname,
	changedon = NOW();
END$$
DELIMITER ;