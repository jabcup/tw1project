USE tw1project;

DROP PROCEDURE IF EXISTS pnoticia;

DELIMITER $$

CREATE PROCEDURE pnoticia (
    IN pIdFuente INT,
    IN pIdTema INT,
    IN pFecha DATE,
    IN pTitulo VARCHAR(50),
    IN pDescripcionNoticia VARCHAR(100)
)
BEGIN
    DECLARE nuevoID INT;

    -- Obtener el último ID registrado
    SELECT COALESCE(MAX(id_noticia), 0) + 1 INTO nuevoID FROM t_noticias;

    INSERT INTO t_noticias (id_noticia, id_fuente, id_tema, fecha, titulo, descripcion_noticia)
    VALUES (nuevoID, pIdFuente, pIdTema, pFecha, pTitulo, pDescripcionNoticia);
END $$

DELIMITER ;
