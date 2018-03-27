#no me funciona el procedimiento. Funciona a la vez para todos los 
#empleados que temgan el mismo sueldo basico
DELIMITER $$
CREATE PROCEDURE Insertarvalores
(IN salario_basico FLOAT)
BEGIN
	DECLARE subsidio FLOAT;
	DECLARE salud FLOAT;
	DECLARE pension FLOAT;
	DECLARE bono FLOAT;
	DECLARE salario_integral FLOAT;
		SET subsidio=Calculasubsidio(salario_basico);
		SET salud=Calculasalud(salario_basico);
		SET pension=Calculapension(salario_basico);
		SET bono=Calculabono(salario_basico);
		SET salario_integral=Calculasalario_integral(salario_basico);
		
INSERT INTO empleado (subsidio,salud,pension,bono,salario_integral) 
	VALUES (subsidio,salud,pension,bono,salario_integral) 
	WHERE salario_basico=salario_basico;
END
$$
DELIMITER ;