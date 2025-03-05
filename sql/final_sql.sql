
ALTER TABLE tw1project.t_temas DROP FOREIGN KEY T_TEMAS_T_FUENTES_FK;
ALTER TABLE tw1project.t_temas MODIFY COLUMN id_fuente VARCHAR(10) NULL;


 CALL tw1project.pt_tema("Deportes", "Noticias deportivas",0);
 CALL tw1project.pt_tema("Nacional", "Noticias en el país, generales",0);
 CALL tw1project.pt_tema("Internacional", "Cosas que pasan en el mundo", 0); 
 CALL tw1project.pt_tema("Economia", "Noticias sobre economía", 0) ;
 CALL tw1project.pt_tema("Seguridad", "Noticias sobre crimines, inseguridad y cosas", 0); 
 CALL tw1project.pt_tema("Incidentes", "Bloqueos marchas y todo eso", 0) ;


ALTER TABLE tw1project.t_noticias MODIFY COLUMN titulo varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL;

DROP PROCEDURE IF EXISTS `pnoticia`;

DELIMITER //

CREATE DEFINER=`jh`@`localhost` PROCEDURE `tw1project`.`pnoticia`(
IN pIdFuente INT,
IN pIdTema INT,
IN pFecha DATE,
IN pTitulo VARCHAR(150),
IN pDescripcionNoticia VARCHAR(200)
)
BEGIN
DECLARE nuevoID INT;

SELECT COALESCE(MAX(id_noticia), 0) + 1 INTO nuevoID FROM t_noticias;

INSERT INTO t_noticias (id_noticia, id_fuente, id_tema, fecha, titulo, descripcion_noticia)
VALUES (nuevoID, pIdFuente, pIdTema, pFecha, pTitulo, pDescripcionNoticia);
END //

DELIMITER ;


ALTER TABLE tw1project.t_noticias MODIFY COLUMN descripcion_noticia varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL NULL;

insert into t_monedas values(1, "peso boliviano", "bs", "Bolivia");

CALL tw1project.pfuente("Banco Nacional de Bolivia", "banco nacional de bolivia para datos monetarios y asi", "bcb.gob.bo", "moneda")

use tw1project;

DROP PROCEDURE IF EXISTS `pDatosMonedas`;

DELIMITER //

CREATE DEFINER=`jh`@`localhost` PROCEDURE `tw1project`.`pDatosMonedas`(
IN pIdFuente INT,
IN pIdMoneda INT,
IN pFecha DATE,
IN pPrecioDolarVenta DECIMAL(15,4),
IN pPrecioDolarCompra DECIMAL(15,4)
)
BEGIN
DECLARE nuevoID INT;

SELECT COALESCE(MAX(id_dato), 0) + 1 INTO nuevoID FROM t_datos_monedas;

INSERT INTO t_datos_monedas (
    id_dato, 
    id_fuente, 
    id_moneda, 
    fecha, 
    precio_dolar_venta,
    precio_dolar_compra
)
VALUES (
    nuevoID, 
    pIdFuente, 
    pIdMoneda, 
    pFecha, 
    pPrecioDolarVenta,
    pPrecioDolarCompra
);
END //

DELIMITER ;


CALL tw1project.pfuente("SENAMHI", "Servicio nacional de meteorologia e hidrología", "senamhi.gob.bo", "clima");


ALTER TABLE t_climas MODIFY COLUMN condiciones VARCHAR(50);

