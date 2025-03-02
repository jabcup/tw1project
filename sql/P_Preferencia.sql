USE tw1project;

DROP PROCEDURE IF EXISTS ppreferencia;

DELIMITER $$

CREATE PROCEDURE ppreferencia (
    IN pIdUsuario INT,
    IN pIdUbicacion INT,
    IN pNotificationTime TIME
)
BEGIN
    DECLARE nuevoID INT;

    -- Obtener el último ID registrado
    SELECT COALESCE(MAX(id_preferencia), 0) + 1 INTO nuevoID FROM t_preferencias;

    INSERT INTO t_preferencias (id_preferencia, id_usuario, id_ubicacion, notification_time)
    VALUES (nuevoID, pIdUsuario, pIdUbicacion, pNotificationTime);
END $$

DELIMITER ;
