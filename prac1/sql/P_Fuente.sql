USE tw1project;

DROP PROCEDURE IF EXISTS pfuente;

DELIMITER $$

CREATE PROCEDURE pfuente (
    IN pNombre VARCHAR(25),
    IN pDescripcion VARCHAR(100),
    IN pURL VARCHAR(100),
    IN pDatoProvisto VARCHAR(25)
)
BEGIN
    DECLARE nuevoID INT;

    -- Obtener el último ID registrado
    SELECT COALESCE(MAX(id_fuente), 0) + 1 INTO nuevoID FROM t_fuentes;

    INSERT INTO t_fuentes (id_fuente, nombre_fuente, descripcion_fuente, ulr, dato_provisto) 
    VALUES (nuevoID, pNombre, pDescripcion, pURL, pDatoProvisto);
END $$

DELIMITER ;
