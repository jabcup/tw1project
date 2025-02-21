
create table T_CLIMA(
	id_clima int not null,
	fecha date not null,
	id_ubicacion int not null,
	t_max int not null,
	t_min int not null,
	condiciones enum ('soleado', 'nublado', 'lluvia', 'tormenta', 'granizo', 'feo'), 
	precipitacion decimal(5,2),
	humedad tinyint,
	id_fuente int not null,
	constraint T_CLIMA_PK primary key (id_clima),
	constraint T_UBICACION_T_CLIMA_FK foreign key (id_ubicacion) references tw1project.T_UBICACIONES (id_ubicacion),
	constraint T_FUENTE_TCLIMA_FK foreign key (id_fuente) references tw1project.T_FUENTES (id_fuente)
);
