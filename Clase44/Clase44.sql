use cfl2020
CREATE TABLE IF NOT EXISTS `E01_PRODUCTO` (
`codigo_producto` INT NOT NULL,
`marca` VARCHAR(45),
`nombre` VARCHAR(45),
`descripcion` VARCHAR(45),
`precio` FLOAT,
`stock` INT,
PRIMARY KEY (`codigo_producto`)
);

CREATE TABLE IF NOT EXISTS `E01_CLIENTE` (
`nro_cliente` INT NOT NULL,
`nombre` VARCHAR(45),
`apellido` VARCHAR(45),
`direccion` VARCHAR(45),
`activo` TINYINT,
PRIMARY KEY (`nro_cliente`)
);


CREATE TABLE IF NOT EXISTS `E01_TELEFONO` (
`id_telefono` INT NOT NULL,
`codigo_area` INT(3),
`nro_telefono` INT(7),
`tipo` CHAR(1),
`nro_cliente` INT,
PRIMARY KEY (`id_telefono`),
CONSTRAINT FK_E01_TELEFONO_CLIENTE FOREIGN KEY (nro_cliente) REFERENCES E01_CLIENTE(nro_cliente)
);



CREATE TABLE IF NOT EXISTS `E01_FACTURA` (
`nro_factura` INT,
`fecha` DATE,
`total_sin_iva` DOUBLE,
`iva` DOUBLE,
`total_con_iva` DOUBLE,
`nro_cliente` INT,
PRIMARY KEY (`nro_factura`),
CONSTRAINT FK_E01_FACTURA_CLIENTE FOREIGN KEY (nro_cliente) REFERENCES E01_CLIENTE(nro_cliente)
);

CREATE TABLE IF NOT EXISTS `E01_DETALLE_FACTURA` (
`nro_factura` INT,
`nro_item` INT,
`cantidad` FLOAT,
`codigo_producto` INT,
CONSTRAINT FK_E01_CODIGO_PRODUCTO FOREIGN KEY (codigo_producto) REFERENCES E01_PRODUCTO(codigo_producto),
CONSTRAINT FK_E01_DETALLE_FACTURA FOREIGN KEY (nro_factura) REFERENCES E01_FACTURA(nro_factura)
);

/*Elimino columnas y las vuelvo a crear como PK*/
ALTER TABLE E01_TELEFONO DROP COLUMN id_telefono;
ALTER TABLE E01_TELEFONO DROP COLUMN codigo_area;
ALTER TABLE E01_TELEFONO DROP COLUMN nro_telefono;

ALTER TABLE E01_TELEFONO ADD codigo_area INT(3) NOT NULL AUTO_INCREMENT,
ADD PRIMARY KEY (codigo_area); 

ALTER TABLE E01_TELEFONO ADD nro_telefono INT(7) NOT NULL AUTO_INCREMENT,
ADD PRIMARY KEY (nro_telefono); 


/*La elimino*/
DROP TABLE E01_TELEFONO;

/*la creo de nuevo porque no pude modificarla;*/
CREATE TABLE IF NOT EXISTS `E01_TELEFONO` (
`codigo_area` INT(3),
`nro_telefono` INT(7),
`tipo` CHAR(1),
`nro_cliente` INT,
CONSTRAINT PK_E01_TELEFONO PRIMARY KEY (codigo_area, nro_telefono),
CONSTRAINT FK_E01_TELEFONO_CLIENTE FOREIGN KEY (nro_cliente) REFERENCES E01_CLIENTE(nro_cliente)
);

/*la ELIMINO y la creo de nuevo modificada;*/
DROP TABLE E01_DETALLE_FACTURA;

CREATE TABLE IF NOT EXISTS `E01_DETALLE_FACTURA` (
`nro_factura` INT,
`nro_item` INT,
`cantidad` FLOAT,
`codigo_producto` INT,
CONSTRAINT FK_E01_CODIGO_PRODUCTO FOREIGN KEY (codigo_producto) REFERENCES E01_PRODUCTO(codigo_producto),
CONSTRAINT FK_E01_DETALLE_FACTURA FOREIGN KEY (nro_factura) REFERENCES E01_FACTURA(nro_factura)
);

   
/*Inserto algunos clientes*/
INSERT INTO E01_CLIENTE(nro_cliente,nombre,apellido,direccion,activo) VALUES (1,'Braian','Aued','Costa Rica 456',true);
INSERT INTO E01_CLIENTE(nro_cliente,nombre,apellido,direccion,activo) VALUES (2,'Juan','Perez','Falucho 1023',true);

/*Este cliente lo voy a eliminar mas adelante*/
INSERT INTO E01_CLIENTE(nro_cliente,nombre,apellido,direccion,activo) VALUES (3,'Jose','Gonzales','Maipu 356',true);
INSERT INTO E01_CLIENTE(nro_cliente,nombre,apellido,direccion,activo) VALUES (4,'Agustin','Rojas','Belgrano 1023',true);


/*Inserto algunos telefonos*/
INSERT INTO E01_TELEFONO(nro_telefono,tipo,codigo_area,nro_cliente) VALUES (4547894,'M',249,1);

/*Inserto algunos productos*/
INSERT INTO E01_PRODUCTO(codigo_producto,marca,nombre,descripcion,precio,stock) VALUES (1111,'Playadito','Yerba','Yerba mate',160,1000);
INSERT INTO E01_PRODUCTO(codigo_producto,marca,nombre,descripcion,precio,stock) VALUES (2222,'Yogurisimo','Yogurt','Yogurt bebible vainilla',130,3330);

/*Actualizo al cliente con id 1*/
UPDATE E01_CLIENTE SET nombre = 'Braian2' WHERE nro_cliente = 1;

/*Eliminoo al cliente con id 3*/
DELETE FROM E01_CLIENTE WHERE nro_cliente = 3;

/*Ejercicio de clase*/
INSERT INTO E01_PRODUCTO(codigo_producto,marca,nombre,descripcion,precio,stock) VALUES (1234,'Turron','Misky','Turron de mani',4,100);

/*Inserto algunos telefonos para poder modificarlos*/
INSERT INTO E01_TELEFONO(nro_telefono,tipo,codigo_area,nro_cliente) VALUES (45555,'M',526,1);
INSERT INTO E01_TELEFONO(nro_telefono,tipo,codigo_area,nro_cliente) VALUES (45666,'M',526,2);

UPDATE e01_telefono SET codigo_area= 526 WHERE codigo_area = 551;

/*borrar el producto insertado en 1 */
DELETE FROM e01_producto WHERE codigo_producto = 1111;


/*cargo varios datos a todas las tablas*/
INSERT INTO E01_CLIENTE(nro_cliente,nombre,apellido,direccion,activo) 
VALUES (5,'Marcela','Fernandez','Beiro 256',true),
(6,'Gonzalo','Gonzales','Avellaneda 2024',true),
(7,'Nestor','Palmieri','Panama 554',true),
(8,'Juan','Perez','Falucho 1023',true);


INSERT INTO E01_TELEFONO(nro_telefono,tipo,codigo_area,nro_cliente)
 VALUES (12345,'M',526,2),(12244,'M',524,4),(22144,'M',524,4),
 (44122,'M',524,5),(42124,'M',524,5),
 (47172,'M',524,6),(42177,'M',524,6),
 (48122,'M',524,7),(42188,'M',524,7),
 (97129,'M',524,8),(99324,'M',524,8);

INSERT INTO E01_PRODUCTO(codigo_producto,marca,nombre,descripcion,precio,stock) 
VALUES (1,'Cagnoli','Salamin','Picado Fino',190,250),
(2,'Branca','Fernet','Edicion Limitada',550,800),
(3,'Coca Cola','Gaseosa cola','2.5 litros',790,150),
(4,'Don Satur','Salados','400 gr',70,2000),
(5,'Milka','Alfajor','Triple',120,1230),
(6,'Frutigram','Galletitas','Con chips de chocolate',160,2330),
(7,'Casamcrem','Queso Untable','1kg',200,345);


/*problema con las fechas--> ver la tabla completa*/
INSERT INTO E01_FACTURA(nro_factura,fecha,total_sin_iva,iva,total_con_iva,nro_cliente)
VALUES (10,'2020-01-01',2000,420,2420,1);

INSERT INTO E01_FACTURA(nro_factura,fecha,total_sin_iva,iva,total_con_iva,nro_cliente)
VALUES(11,'2020-02-01',4000,840,4840,1);

INSERT INTO E01_FACTURA(nro_factura,fecha,total_sin_iva,iva,total_con_iva,nro_cliente)
VALUES(12,'2020-12-01',200,42,242,2);

INSERT INTO E01_FACTURA(nro_factura,fecha,total_sin_iva,iva,total_con_iva,nro_cliente)
VALUES (13,'2020-01-13',400,84,484,2);

INSERT INTO E01_FACTURA(nro_factura,fecha,total_sin_iva,iva,total_con_iva,nro_cliente)
VALUES(14,'2020-01-14',1000,210,1210,4);
INSERT INTO E01_FACTURA(nro_factura,fecha,total_sin_iva,iva,total_con_iva,nro_cliente)
VALUES(15,'2020-01-15',100,21,121,4);
INSERT INTO E01_FACTURA(nro_factura,fecha,total_sin_iva,iva,total_con_iva,nro_cliente)
VALUES(16,'2020-01-16',500,105,605,5);
INSERT INTO E01_FACTURA(nro_factura,fecha,total_sin_iva,iva,total_con_iva,nro_cliente)
VALUES(17,'2020-01-16',5000,1050,6050,5);
INSERT INTO E01_FACTURA(nro_factura,fecha,total_sin_iva,iva,total_con_iva,nro_cliente)
VALUES(18,'2020-01-17',50,10.5,60.5,6);
INSERT INTO E01_FACTURA(nro_factura,fecha,total_sin_iva,iva,total_con_iva,nro_cliente)
VALUES(19,'2020-01-17',400,84,484,6);
INSERT INTO E01_FACTURA(nro_factura,fecha,total_sin_iva,iva,total_con_iva,nro_cliente)
VALUES(20,'2020-01-19',3000,630,3630,7);
INSERT INTO E01_FACTURA(nro_factura,fecha,total_sin_iva,iva,total_con_iva,nro_cliente)
VALUES(21,'2020-01-20',400,84,484,7);
INSERT INTO E01_FACTURA(nro_factura,fecha,total_sin_iva,iva,total_con_iva,nro_cliente)
VALUES(22,'2020-01-20',40,840,4840,8);
INSERT INTO E01_FACTURA(nro_factura,fecha,total_sin_iva,iva,total_con_iva,nro_cliente)
VALUES(23,'2020-01-21',100,21,121,8);


INSERT INTO E01_DETALLE_FACTURA(nro_factura,nro_item,cantidad,codigo_producto)
VALUES (10,1,5,1),(10,2,6,4),(11,1,4,4),(11,2,8,2),(12,1,2,3),(12,2,6,4),(13,1,9,5),
(13,2,6,4),(14,1,9,5),(14,2,7,6),(15,1,9,6),(15,2,7,6),(16,1,9,6),(16,2,2,7),(17,1,2,3),
(17,2,6,4),(18,1,4,4),(18,2,7,5),(19,1,1,3),(19,2,7,5),(20,1,1,3),(20,2,3,4),(21,1,5,2),
(21,2,3,4),(22,1,5,2),(22,2,8,3),(23,1,4,4),(23,2,8,3);

/*para blanquear la tabla*/
DELETE FROM e01_detalle_factura  WHERE nro_factura>0;
DELETE FROM e01_factura  WHERE nro_factura>0;