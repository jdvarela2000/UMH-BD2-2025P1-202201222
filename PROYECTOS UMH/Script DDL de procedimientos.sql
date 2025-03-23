use solicitudempleo;

DELIMITER //
    -- ESTE PROCEDIMEIENTO ACTUALIZA LOS DATOS PERSONALES.
-- Uso: CALL ActualizarDatosPersonales(id, 'nuevo_telefono', 'nuevo_movil');
CREATE PROCEDURE ActualizarDatosPersonales(IN p_id INT, IN p_telefono VARCHAR(20), IN p_movil VARCHAR(20))
BEGIN
    UPDATE DatosPersonales SET telefono = p_telefono, movil = p_movil WHERE id = p_id;
END //
-- CON ESTE PROCEDIMIENTO ACTUALIZAMOS LA DOCUMENTACION.
-- Uso: CALL ActualizarDocumentacion(id, 'nueva_curp', 'nuevo_pasaporte');
CREATE PROCEDURE ActualizarDocumentacion(IN p_id INT, IN p_curp VARCHAR(18), IN p_pasaporte VARCHAR(20))
BEGIN
    UPDATE Documentacion SET curp = p_curp, pasaporte = p_pasaporte WHERE id = p_id;
END //
-- CON ESTE PROCEDIMIENTO ACTUALIZAMOS EL NIVEL DE ESCOLARIDAD.
-- Uso: CALL ActualizarEscolaridad(id, 'NuevoNivel');
-- Nota: 'NuevoNivel' debe ser uno de los valores permitidos: 'Primaria', 'Secundaria', 'Preparatoria', 'Profesional', 'Comercial'.
CREATE PROCEDURE ActualizarEscolaridad(IN p_id INT, IN p_nivel ENUM('Primaria', 
'Secundaria', 'Preparatoria', 'Profesional', 'Comercial'))
BEGIN
    UPDATE Escolaridad SET nivel = p_nivel WHERE id = p_id;
END //
DELIMITER ;
