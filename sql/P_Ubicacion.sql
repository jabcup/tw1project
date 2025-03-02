USE tw1project;

DROP PROCEDURE IF EXISTS pt_ubicacion;

DELIMITER $$

CREATE PROCEDURE pt_ubicacion (
    IN pNombreUbicacion VARCHAR(25)
)
BEGIN
    DECLARE nuevoID INT;

    -- Obtener el último ID registrado
    SELECT COALESCE(MAX(id_ubicacion), 0) + 1 INTO nuevoID FROM t_ubicaciones;

    INSERT INTO t_ubicaciones (id_ubicacion, nombre_ubicacion)
    VALUES (nuevoID, pNombreUbicacion);
END $$

DELIMITER ;
