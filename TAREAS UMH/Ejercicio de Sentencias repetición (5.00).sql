-- craando la base de datos 
CREATE DATABASE IF NOT EXISTS simulador_ahorro;
-- vamos a usar la base de datos 
USE simulador_ahorro;

-- creamos una tabla para almacenar los resultados 
CREATE TABLE IF NOT EXISTS ahorro_simulado (
    id INT AUTO_INCREMENT PRIMARY KEY,
    numero_mes INT NOT NULL, -- guarda el numero de mes que corresponde al ahorro 
    monto DECIMAL(10,2) NOT NULL, -- indica el monto ahorrado cada mes 
    saldo_acumulado DECIMAL(10,2) NOT NULL -- el total de los ahorros acumulados hasta ese mes 
);

-- EL PRCEDIMIENTO ALMACENADO 
-- creamos un precedimiento llamado simulador_ahorro que recibe dos normas, monto y meses.
DELIMITER //
CREATE PROCEDURE simular_ahorro(
    IN monto DECIMAL(10,2),
    IN meses INT
)
BEGIN
    DECLARE contador INT DEFAULT 1;-- definimos una variable que usaremos para contar los meses empezando en 1
    DECLARE saldo DECIMAL(10,2) DEFAULT 0; -- definimos la variable saldo, este almacenara el ahorro acumulado. 
    
    TRUNCATE TABLE ahorro_simulado;-- borramos todos los registros de la tabla, para no evitar datos repetidos
    
    -- codigo para calcular el ahorro mes a mes 
    WHILE contador <= meses DO-- inicia un ciclo que se repetira mientras contador sea menor o igual que meses.
        SET saldo = saldo + monto; -- sumamos el monto ahorrado y el saldo acumulado 
        
        INSERT INTO ahorro_simulado (numero_mes, monto, saldo_acumulado)
        VALUES (contador, monto, saldo); -- guardamos en la tabla ahorro_simulador el numero de mes, el monto mensual y el saldo acumulado hasta ese mes. 
        
        SET contador = contador + 1; -- incrementamos el contador para pasar al siguiente mes. 
    END WHILE;
END // -- finalizamos la definicion del procedimiento 
DELIMITER ;
-- pruebas 
-- ejecutamos 
CALL simular_ahorro(100.00, 12);

SELECT * FROM ahorro_simulado;