USE tw1project;

DROP PROCEDURE IF EXISTS pincidente;

DELIMITER $$

CREATE PROCEDURE pincidente (
    IN pLugar VARCHAR(25),
    IN pTipo VARCHAR(25),
    IN pDescripcionIncidente VARCHAR(100),
    IN pFecha DATE,
    IN pHora TIME,
    IN pIdFuente INT,
    IN pURL VARCHAR(100)
)
BEGIN
    DECLARE nuevoID INT;

    -- Obtener el último ID registrado
    SELECT COALESCE(MAX(id_incidente), 0) + 1 INTO nuevoID FROM t_incidentes;

    INSERT INTO t_incidentes (id_incidente, lugar, tipo, descripcion_incidente, fecha, hora, id_fuente, url) 
    VALUES (nuevoID, pLugar, pTipo, pDescripcionIncidente, pFecha, pHora, pIdFuente, pURL);
END $$

DELIMITER ;
