USE solicitudempleo;

DELIMITER //
-- En esta funcion es para obtener la edad de una persona basada en su fecha de nacimiento.
-- Ejemplo de uso: SELECT ObtenerEdad('1993-05-12');
CREATE FUNCTION ObtenerEdad(p_fecha_nacimiento DATE) RETURNS INT DETERMINISTIC
BEGIN
    -- Calcula la diferencia del año entre la diferencia de fecha de nacimiento y de la fecha actual.
    RETURN TIMESTAMPDIFF(YEAR, p_fecha_nacimiento, CURDATE());
END //
-- esta funcion es  para obtener el nombre completo de una persona usando su ID.
-- COMO USAR: Se llama a la función `ObtenerNombreCompleto` pasando como parámetro el ID de la persona.
-- Ejemplo de como usarlo: SELECT ObtenerNombreCompleto(1);
CREATE FUNCTION ObtenerNombreCompleto(p_id INT) RETURNS VARCHAR(255) DETERMINISTIC
BEGIN
    DECLARE nombre_completo VARCHAR(255);
-- Se van a concatenan los nombres y los apellidos para agrupar y formar el nombre completo.
    SELECT CONCAT(nombres, ' ', apellido_paterno, ' ', apellido_materno) 
    INTO nombre_completo 
    FROM DatosPersonales 
    WHERE id = p_id;
-- Muestra el nombre completo obtenido.
    RETURN nombre_completo;
END //
-- En esta funcion contamos los familiar agregadas a una persona.
-- Para usarlo debemos Llamar a la función `ContarFamiliares` pasando como parámetro el ID de la persona.
-- Un ejemplo de como usarlo: SELECT ContarFamiliares(1);
CREATE FUNCTION ContarFamiliares(p_id_persona INT) RETURNS INT DETERMINISTIC
BEGIN
    DECLARE total INT;
-- Esta funcion Cuenta el número de familiares agregados a la persona con el ID de la persona.
    SELECT COUNT(*) INTO total 
    FROM DatosFamiliares 
    WHERE id_persona = p_id_persona;
-- Muestra el número total de los familiares agregados.
    RETURN total;
END //

DELIMITER ;
