USE tw1project;

DROP PROCEDURE IF EXISTS pmoneda;

DELIMITER $$

CREATE PROCEDURE pmoneda (
    IN pNombreMoneda VARCHAR(25),
    IN pDenominacion VARCHAR(5),
    IN pPais VARCHAR(25)
)
BEGIN
    DECLARE nuevoID INT;

    -- Obtener el último ID registrado
    SELECT COALESCE(MAX(id_moneda), 0) + 1 INTO nuevoID FROM t_monedas;

    INSERT INTO t_monedas (id_moneda, nombre_moneda, denominacion, pais)
    VALUES (nuevoID, pNombreMoneda, pDenominacion, pPais);
END $$

DELIMITER ;
