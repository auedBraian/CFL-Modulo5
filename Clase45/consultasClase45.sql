use CFL2020_data;

SELECT * FROM e01_cliente;   
SELECT * FROM e01_producto; 
SELECT * FROM e01_telefono; /*Trae toda la tabla*/
SELECT * FROM e01_factura;
SELECT * FROM e01_detalle_factura;

/*Consultas en clase */

select marca, codigo_producto from e01_producto where codigo_producto=10;
select codigo_producto, nombre, stock from e01_producto where stock not between 60 and 100;
SELECT * FROM e01_producto where marca like '%o%';
SELECT * FROM e01_producto where marca like 'f___t';
Select nro_cliente,apellido,nombre from e01_cliente where nombre like 'jescie';
Select nro_cliente,apellido,nombre from e01_cliente where nombre like 'F%';
Select codigo_producto,nombre,stock from e01_producto where stock>=60 and stock<=90;
Select codigo_producto,nombre,stock from e01_producto where (nombre like 'fish') or (stock<=26);

/*1.Obtener todos los datos de todos los clientes*/
SELECT * FROM e01_cliente;

/*2.Obtener solo los nombres y apellidos de todos los clientes*/
SELECT nombre,apellido FROM e01_cliente;

/*3.Obtener los nombres de los diferentes productos*/
SELECT DISTINCT nombre FROM e01_producto;

/*4.Obtener los diferentes códigos de área de los teléfonos*/
SELECT DISTINCT codigo_area from e01_telefono; 

/*5.Obtener el listado de todos los productos que tengan un stock mayor a 50 y menor a 200*/ 
Select nombre,stock from e01_producto where stock>=50 and stock<=200;

/*6.Obtener los datos correspondientes al producto cuyo codigo es 50*/
SELECT * FROM e01_producto WHERE codigo_producto=50;

/*7.Obtener los datos de las facturas cuyo total (con iva incluido) sea mayor a 400.000$ y lo haya realizado el cliente número 8*/
SELECT * FROM e01_factura WHERE total_con_iva>400.000;

/*8.Obtener los datos del cliente cuyo nombre es “Ivor” y el apellido “Saunders”*/
select * from e01_cliente where nombre="Ivor" and apellido="Saunders";

/*9.Todas las Facturas pertenecientes al cliente número 10*/
select * from e01_factura where nro_cliente=10;

/*10.Todas las Facturas que superen los 500.000$*/
select * from e01_factura where total_con_iva>500.000;

/*##################           Consultas adicionales           #############################*/

/*Para ver cuantos codigos de area tengo--> da 174 */
SELECT COUNT(*) FROM (SELECT DISTINCT codigo_area from e01_telefono)
 a; 
 
/*lo uso para controlar que filtre correctamente los codigos de area --> resultado 198*/
SELECT COUNT(*) FROM e01_telefono; 

/*Marcas cuyos precios unitarios sean superiores a 500*/
SELECT MARCA,PRECIO FROM e01_producto WHERE PRECIO>500.000;

/*Cuantas son las marcas cuyo precio es superior a 500*/
SELECT COUNT(*) FROM (SELECT DISTINCT MARCA 
FROM e01_producto WHERE PRECIO>500.000) a;

/*Productos de los cuales no hay stock --> todos tienen stock*/
SELECT codigo_producto,nombre,stock FROM e01_producto WHERE STOCK=0;

/*Productos de los cuales hay un stock inferior a 20 unidades*/
SELECT codigo_producto,nombre,stock FROM e01_producto WHERE STOCK>=0 and STOCK <=20;

/*Consulto el codigo de la fruta para hacer una consulta en el paso siguiente*/
SELECT codigo_producto,nombre FROM e01_producto WHERE nombre='fruit';
/*Respuesta 67,72,89,93*/

/*facturas que incluyan fruta como concepto*/
SELECT * FROM e01_detalle_factura where codigo_producto = 67 or codigo_producto = 72
or codigo_producto=89 or codigo_producto=93;

/*Como son muchas, quiero saber cuantas son*/
SELECT COUNT(*) FROM (SELECT * FROM e01_detalle_factura where codigo_producto = 67 
or codigo_producto = 72 or codigo_producto=89 or codigo_producto=93)
 a; 
 
 /*Quienes son los clientes con mayor poder adquisitivo*/
 SELECT nro_cliente FROM e01_factura WHERE total_con_iva >1000;

/*Filtro productos que NO sean los que menciono (busqueda inversa)*/
SELECT codigo_producto,nombre FROM e01_producto WHERE nombre not like 'fruit' and nombre not like 'fresh flowers'
and nombre not like 'bag';

Select DISTINCT nro_cliente from e01_factura where fecha >= '2017-01-01' and fecha<= '2017-01-31';

Select codigo_producto from e01_producto where nombre = 'return policy';


SELECT nro_factura from e01_detalle_factura where codigo_producto = 1 or codigo_producto= 85;

SELECT * from e01_cliente where nombre = 'calvin' and apellido='hyde';

SELECT nro_factura from e01_factura where nro_cliente = 6;

SELECT * from e01_cliente where nombre like 'a%__a';

SELECT codigo_producto,nombre,stock FROM e01_producto WHERE STOCK<50 or STOCK >900 or nombre like '_ree%';
select * from e01_factura where (fecha>'2017-03-19' or  total_con_iva < 10000) and total_con_iva <>0;