USE tw1project;

DROP PROCEDURE IF EXISTS p_usuario;

DELIMITER $$

CREATE PROCEDURE p_usuario (
    IN p_nombres_usuario VARCHAR(25),
    IN p_apellidos_usuario VARCHAR(25),
    IN p_usuario VARCHAR(10),
    IN p_password VARCHAR(25)
)
BEGIN
    DECLARE nuevoID INT;

    SELECT COALESCE(MAX(id_usuario), 0) + 1 INTO nuevoID FROM t_usuarios;

    INSERT INTO t_usuarios (id_usuario, nombres_usuario, apellidos_usuario, usuario, password, id_rol) 
    VALUES (nuevoID, p_nombres_usuario, p_apellidos_usuario, p_usuario, p_password, 2);

    -- Devolver el id del nuevo usuario
    SELECT nuevoID AS id_usuario;
END $$

DELIMITER ;
