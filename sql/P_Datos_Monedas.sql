USE tw1project;

DROP PROCEDURE IF EXISTS pDatosMonedas;

DELIMITER $$

CREATE PROCEDURE pDatosMonedas (
    IN pIdFuente INT,
    IN pIdMoneda INT,
    IN pFecha DATE,
    IN pValorRespectoDolar DECIMAL(15,4)
)
BEGIN
    DECLARE nuevoID INT;

    -- Obtener el último ID registrado
    SELECT COALESCE(MAX(id_dato), 0) + 1 INTO nuevoID FROM t_datos_monedas;

    INSERT INTO t_datos_monedas (id_dato, id_fuente, id_moneda, fecha, valor_respecto_dolar) 
    VALUES (nuevoID, pIdFuente, pIdMoneda, pFecha, pValorRespectoDolar);
END $$

DELIMITER ;
