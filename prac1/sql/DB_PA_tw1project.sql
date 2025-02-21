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

DROP PROCEDURE IF EXISTS pDatosMonedas;

DELIMITER $$

CREATE PROCEDURE pDatosMonedas (
    IN pIdFuente INT,
    IN pIdMoneda INT,
    IN pFecha DATE,
    IN pValorRespectoDolar DECIMAL(15,4)
)
BEGIN
    DECLARE nuevoID INT;

    -- Obtener el último ID registrado
    SELECT COALESCE(MAX(id_dato), 0) + 1 INTO nuevoID FROM t_datos_monedas;

    INSERT INTO t_datos_monedas (id_dato, id_fuente, id_moneda, fecha, valor_respecto_dolar) 
    VALUES (nuevoID, pIdFuente, pIdMoneda, pFecha, pValorRespectoDolar);
END $$

DELIMITER ;

DROP PROCEDURE IF EXISTS pEvento;

DELIMITER $$

CREATE PROCEDURE pEvento (
    IN pDireccion VARCHAR(100),
    IN pNombre VARCHAR(50),
    IN pTipo VARCHAR(25),
    IN pFecha DATE,
    IN pContacto VARCHAR(100),
    IN pIdFuente INT,
    IN pUrl VARCHAR(100)
)
BEGIN
    DECLARE nuevoID INT;

    -- Obtener el último ID registrado
    SELECT COALESCE(MAX(id_evento), 0) + 1 INTO nuevoID FROM t_eventos;

    INSERT INTO t_eventos (id_evento, direccion, nombre, tipo, fecha, contacto, id_fuente, url) 
    VALUES (nuevoID, pDireccion, pNombre, pTipo, pFecha, pContacto, pIdFuente, pUrl);
END $$

DELIMITER ;

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

DROP PROCEDURE IF EXISTS pincidente;

DELIMITER $$

CREATE PROCEDURE pincidente (
    IN pLugar VARCHAR(25),
    IN pTipo VARCHAR(25),
    IN pDescripcionIncidente VARCHAR(100),
    IN pFecha DATE,
    IN pHora TIME,
    IN pIdFuente INT,
    IN pURL VARCHAR(100)
)
BEGIN
    DECLARE nuevoID INT;

    -- Obtener el último ID registrado
    SELECT COALESCE(MAX(id_incidente), 0) + 1 INTO nuevoID FROM t_incidentes;

    INSERT INTO t_incidentes (id_incidente, lugar, tipo, descripcion_incidente, fecha, hora, id_fuente, url) 
    VALUES (nuevoID, pLugar, pTipo, pDescripcionIncidente, pFecha, pHora, pIdFuente, pURL);
END $$

DELIMITER ;

DROP PROCEDURE IF EXISTS pmoneda;

DELIMITER $$

CREATE PROCEDURE pmoneda (
    IN pNombreMoneda VARCHAR(25),
    IN pDenominacion VARCHAR(5),
    IN pPais VARCHAR(25)
)
BEGIN
    DECLARE nuevoID INT;

    -- Obtener el último ID registrado
    SELECT COALESCE(MAX(id_moneda), 0) + 1 INTO nuevoID FROM t_monedas;

    INSERT INTO t_monedas (id_moneda, nombre_moneda, denominacion, pais)
    VALUES (nuevoID, pNombreMoneda, pDenominacion, pPais);
END $$

DELIMITER ;

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

    -- Obtener el último id_usuario registrado
    SELECT COALESCE(MAX(id_usuario), 0) + 1 INTO nuevoID FROM t_usuarios;

    -- Insertar el nuevo usuario
    INSERT INTO t_usuarios (id_usuario, nombres_usuario, apellidos_usuario, usuario, password, id_rol) 
    VALUES (nuevoID, p_nombres_usuario, p_apellidos_usuario, p_usuario, p_password, 2);
END $$

DELIMITER ;