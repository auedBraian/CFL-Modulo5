create database CFL2020_vistas;
use CFL2020_vistas;
use CFL2020_data; -- usar esta base


create view clientes_sin_factura as
select c.nro_cliente, c.nombre, c.apellido
from e01_cliente c
left join e01_factura f on f.nro_cliente = c.nro_cliente
where f.nro_cliente is null;

select * from clientes_sin_factura c
inner join e01_telefono t
on c.nro_cliente = t.nro_cliente;

select * from clientes_sin_factura c
where nombre like 'k%';

-- con el alter se puede editar la vista
-- se puede hacer una vista de esa vista
-- se puede actualizar (insertarle elementos) (ver requisitos en la filmina)

-- pongo lo que yo quiero que se vea, es para encapsular datos
create view facturas_simplificada as
select f.nro_cliente,f.fecha,f.nro_factura
from e01_factura f;


select * from facturas_simplificada;


CREATE TABLE PROVEEDOR(
	id_proveedor   INT		      NOT NULL,
    nombre         VARCHAR(45)    NOT NULL,
    rubro	       VARCHAR(45)    NOT NULL,
    ciudad	       VARCHAR(45)    NOT NULL,
	CONSTRAINT PK_PROVEEDOR PRIMARY KEY (id_proveedor)
);

CREATE TABLE ENVIO(
	cantidad   		NUMERIC	      NOT NULL,
    id_proveedor     INT	      NOT NULL,
    id_articulo	     INT	      NOT NULL
);

CREATE TABLE ARTICULO(
	id_articulo	     INT	      NOT NULL,
    descripcion   	VARCHAR(45)   NOT NULL,
    peso		     NUMERIC      NOT NULL,
    ciudad			VARCHAR(45)   NOT NULL,
    CONSTRAINT PK_ENVIO PRIMARY KEY (id_articulo)
);

ALTER TABLE ENVIO ADD CONSTRAINT FK_ENVIO
    FOREIGN KEY (id_proveedor)
    REFERENCES PROVEEDOR(id_proveedor)
;

ALTER TABLE ENVIO ADD CONSTRAINT FK_ARTICULO
    FOREIGN KEY (id_articulo)
    REFERENCES ARTICULO(id_articulo)
;


INSERT INTO `PROVEEDOR` (`id_proveedor`,`nombre`,`rubro`,`ciudad`) VALUES (1,"Golopolis","Golosinas","Tandil");
INSERT INTO `PROVEEDOR` (`id_proveedor`,`nombre`,`rubro`,`ciudad`) VALUES (2,"Diarco","Consumo Masivo","Azul");
INSERT INTO `PROVEEDOR` (`id_proveedor`,`nombre`,`rubro`,`ciudad`) VALUES (3,"Matelec","Herramientas","Olavarria");

INSERT INTO `ARTICULO` (`id_articulo`,`descripcion`,`peso`,`ciudad`) VALUES (1,"Alfajor","Grandote",200,"Tandil");
INSERT INTO `ARTICULO` (`id_articulo`,`descripcion`,`peso`,`ciudad`) VALUES (2,"Yerba","Playadito",1000,"Azul");
INSERT INTO `ARTICULO` (`id_articulo`,`descripcion`,`peso`,`ciudad`) VALUES (3,"Taladro","Makita",1,"Olavarria");


-- ENVIOS500 con los envíos de más de 500 unidades de algún artículo (a partir de ENVIO)
CREATE VIEW ENVIOS500 AS
SELECT * FROM ENVIO  where EN.CANTIDAD>500;

-- PRODUCTOS_MAS_PEDIDOS​ con los diferentes artículos que han tenido 
-- al menos un envío de más de 500 unidades (a partir de ENVIOS500)
CREATE VIEW productos_mas_pedidos AS
SELECT ARTICULO.id_articulo FROM ENVIOS500
group by ARTICULO.id_articulo
having count(ARTICULO.id_articulo)>=1;

-- ENVIOS_PROV ​con los diferentes id de proveedor y la cantidad total de
-- unidades enviadas (a partir de Envio)
CREATE VIEW ENVIOS_PROV as select PROVEEDOR.id_proveedor, sum(cantidad) from ENVIO
group by PROVEEDOR_id_proveedor;


-- DETALLE_ENVIOS que contenga, para cada envío de más de 500
-- unidades, la descripción y el peso del artículo, el nombre del proveedor
-- y la cantidad enviada (a partir de Proveedor, Artículo, ENVIOS​500​)

CREATE VIEW DETALLE_ENVIOS as select ARTICULO.peso, PROVEEDOR.nombre, ENVIOS500.cantidad 
from ARTICULO inner join ENVIOS500 ON ARTICULO.id_articulo = ENVIOS500.id_articulo
inner join PROVEEDOR ON ENVIOS500.id_proveedor = PROVEEDOR.id_proveedor;





