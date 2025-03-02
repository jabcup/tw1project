use tw1project;

alter table t_datos_monedas rename column valor_respecto_dolar to precio_dolar_venta;

alter table t_datos_monedas add column precio_dolar_compra decimal (15, 4); 

alter table t_datos_monedas modify column precio_dolar_compra decimal(15,4) not null;

drop table t_eventos;
