USE tw1project;

DROP PROCEDURE IF EXISTS pEvento;

DELIMITER $$

CREATE PROCEDURE pEvento (
    IN pDireccion VARCHAR(100),
    IN pNombre VARCHAR(50),
    IN pTipo VARCHAR(25),
    IN pFecha DATE,
    IN pContacto VARCHAR(100),
    IN pIdFuente INT,
    IN pUrl VARCHAR(100)
)
BEGIN
    DECLARE nuevoID INT;

    -- Obtener el último ID registrado
    SELECT COALESCE(MAX(id_evento), 0) + 1 INTO nuevoID FROM t_eventos;

    INSERT INTO t_eventos (id_evento, direccion, nombre, tipo, fecha, contacto, id_fuente, url) 
    VALUES (nuevoID, pDireccion, pNombre, pTipo, pFecha, pContacto, pIdFuente, pUrl);
END $$

DELIMITER ;
