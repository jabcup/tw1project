USE tw1project;

DROP PROCEDURE IF EXISTS pt_tema;

DELIMITER $$

CREATE PROCEDURE pt_tema (
    IN pNombreTema VARCHAR(25),
    IN pDescripcionTema VARCHAR(100),
    IN pIdFuente INT
)
BEGIN
    DECLARE nuevoID INT;

    -- Obtener el último ID registrado
    SELECT COALESCE(MAX(id_tema), 0) + 1 INTO nuevoID FROM t_temas;

    INSERT INTO t_temas (id_tema, nombre_tema, descripcion_tema, id_fuente)
    VALUES (nuevoID, pNombreTema, pDescripcionTema, pIdFuente);
END $$

DELIMITER ;
