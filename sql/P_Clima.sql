USE tw1project;

DROP PROCEDURE IF EXISTS pclima;

DELIMITER $$

CREATE PROCEDURE pclima (
    IN pFecha DATE,
    IN pIdUbicacion INT,
    IN pTMax INT,
    IN pTMin INT,
    IN pCondiciones ENUM('soleado','nublado','lluvia','tormenta','granizo','feo'),
    IN pPrecipitacion DECIMAL(5,2),
    IN pHumedad TINYINT,
    IN pIdFuente INT
)
BEGIN
    DECLARE nuevoID INT;

    -- Obtener el último ID registrado
    SELECT COALESCE(MAX(id_clima), 0) + 1 INTO nuevoID FROM t_climas;

    INSERT INTO t_climas (id_clima, fecha, id_ubicacion, t_max, t_min, condiciones, precipitacion, humedad, id_fuente) 
    VALUES (nuevoID, pFecha, pIdUbicacion, pTMax, pTMin, pCondiciones, pPrecipitacion, pHumedad, pIdFuente);
END $$

DELIMITER ;
