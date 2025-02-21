USE tw1project;

DROP PROCEDURE IF EXISTS pt_taux_temas;

DELIMITER $$

CREATE PROCEDURE pt_taux_temas (
    IN pIdUsuario INT,
    IN pIdTema INT
)
BEGIN
    -- Insertar la relación entre usuario y tema
    INSERT INTO taux_temas (id_usuario, id_tema)
    VALUES (pIdUsuario, pIdTema);
END $$

DELIMITER ;
