USE tw1project;

DROP PROCEDURE IF EXISTS prol;

DELIMITER $$

CREATE PROCEDURE prol (
    IN pNombre VARCHAR(15)
)
BEGIN
    DECLARE nuevoID INT;

    -- Obtener el último ID registrado
    SELECT COALESCE(MAX(id_rol), 0) + 1 INTO nuevoID FROM t_roles;

    INSERT INTO t_roles (id_rol, nombre) 
    VALUES (nuevoID, pNombre);
END $$

DELIMITER ;
