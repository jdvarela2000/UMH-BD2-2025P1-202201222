-- CREAR UNA BASE DE DAROS LLAMADA PROCEDIMIENTO ALMANECADO 
CREATE DATABASE procedimiento_almacenado;
USE procedimiento_almacenado;

DROP TABLE IF EXISTS Transacciones;
DROP TABLE IF EXISTS Cuentas;

-- CREACION DE LA TABLA CUENTAS
CREATE TABLE Cuentas (
    Cuenta INT PRIMARY KEY,
    TotalCreditos DECIMAL(10,2) DEFAULT 0.00,
    TotalDebitos DECIMAL(10,2) DEFAULT 0.00,
    Saldo DECIMAL(10,2) DEFAULT 0.00
);
-- CREACION DE LA TABLA TRANSACCIONES
CREATE TABLE Transacciones (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Cuenta INT,
    Fecha DATE,
    Credito DECIMAL(10,2) DEFAULT 0.00,
    Debito DECIMAL(10,2) DEFAULT 0.00,
    FOREIGN KEY (Cuenta) REFERENCES Cuentas(Cuenta)
);
-- INSERTE LOS DATOS EN LA TABLA CUENTAS
INSERT INTO Cuentas (Cuenta, TotalCreditos, TotalDebitos, Saldo) VALUES
(20010001, 800.00, 0.00, 800.00),
(20010002, 560.00, 0.00, 560.00),
(20010003, 1254.00, 0.00, 1254.00),
(20010004, 15000.00, 0.00, 15000.00),
(20010005, 256.00, 0.00, 256.00);


DROP PROCEDURE IF EXISTS RegistrarTransaccion;
DELIMITER $$
-- CREACION DEL PROCEDIMIENTO ALMACENADO 
CREATE PROCEDURE RegistrarTransaccion (
    IN p_Cuenta INT,
    IN p_Monto DECIMAL(10,2),
    IN p_Tipo CHAR(1) -- 'C' para crédito, 'D' para débito
)
BEGIN
    DECLARE v_SaldoActual DECIMAL(10,2);
    DECLARE v_TotalCreditos DECIMAL(10,2);
    DECLARE v_TotalDebitos DECIMAL(10,2);
    
IF NOT EXISTS (SELECT 1 FROM Cuentas WHERE Cuenta = p_Cuenta) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La cuenta no existe';
    END IF;
    IF p_Tipo = 'C' THEN
        INSERT INTO Transacciones (Cuenta, Fecha, Credito, Debito)
        VALUES (p_Cuenta, CURDATE(), p_Monto, 0.00);
        
        UPDATE Cuentas
        SET TotalCreditos = TotalCreditos + p_Monto,
            Saldo = Saldo + p_Monto
        WHERE Cuenta = p_Cuenta;
    ELSEIF p_Tipo = 'D' THEN
        SELECT Saldo INTO v_SaldoActual FROM Cuentas WHERE Cuenta = p_Cuenta;
        
        IF v_SaldoActual < p_Monto THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Saldo insuficiente';
        END IF;
        
        INSERT INTO Transacciones (Cuenta, Fecha, Credito, Debito)
        VALUES (p_Cuenta, CURDATE(), 0.00, p_Monto);
        
        UPDATE Cuentas
        SET TotalDebitos = TotalDebitos + p_Monto,
            Saldo = Saldo - p_Monto
        WHERE Cuenta = p_Cuenta;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Tipo de transacción inválido';
    END IF;
END $$
DELIMITER ;

-- LLAMADAS AL PROCEDIMIENTO ALMACENADO
CALL RegistrarTransaccion(20010001, 500.00, 'C');

CALL RegistrarTransaccion(20010002, 100.00, 'D');

CALL RegistrarTransaccion(20010001, 564.00, 'C');

CALL RegistrarTransaccion(20010004, 254.00, 'D');

CALL RegistrarTransaccion(20010003, 20000054.00, 'C');

-- CONSULTAS PARA VER LOS DATOS 
SELECT * FROM Transacciones;

SELECT * FROM Transacciones WHERE Cuenta = 20010003;

SELECT * FROM Cuentas;
