use CFL2020_data;

-- ----------------------- clase 46 ---------------------------

	Select * from e01_cliente
	where nro_cliente in(
	select nro_cliente from e01_factura
	where e01_factura.nro_cliente = e01_cliente.nro_cliente
	and total_con_iva>500000);

	Select * from e01_cliente
	where nro_cliente not in(
	select nro_cliente from e01_factura
	where e01_factura.nro_cliente = e01_cliente.nro_cliente
	and total_con_iva>500000);

	select  * from e01_cliente
	where nro_cliente = any(
	select nro_cliente from e01_factura);
    
    -- Clientes q tienen al menos 1 factura
    SELECT nombre, apellido FROM e01_cliente 
	WHERE EXISTS (SELECT * FROM e01_factura
	WHERE nro_cliente = e01_cliente.nro_cliente);

	-- Clientes q NO tienen  facturas
	SELECT nombre, apellido FROM e01_cliente 
	WHERE NOT EXISTS (SELECT * FROM e01_factura
	WHERE nro_cliente = e01_cliente.nro_cliente);

	-- Ver datos de los clientes que tienen al menos 1 factura
    SELECT * FROM e01_cliente WHERE nro_cliente = ANY 
	(SELECT nro_cliente FROM e01_factura);


/*1.Listar todas las Facturas que hayan sido compradas por el cliente de nombre "Pandora" y apellido "Tate".*/

	Select * from e01_factura where nro_cliente = (
	select nro_cliente from e01_cliente 
	where nombre = "Pandora" and apellido = "Tate");

-- 2.Listar todas las Facturas que contengan productos de la marca "In Faucibus Inc."

	Select * from e01_factura where nro_factura in (
	select nro_factura from e01_detalle_factura where
	codigo_producto in 	(select codigo_producto
	from e01_producto where marca = "In Faucibus Inc."));

-- 3 - listar todos los clientes que tengan codigo de área 296

	Select * from e01_cliente where nro_cliente in (
	select nro_cliente from e01_telefono where codigo_area = 296);

-- 4 - mostrarme todos los clientes que compraron el producto cuyo nombre = 'scales'
    
    select * from e01_cliente where nro_cliente in(
	select nro_cliente from e01_factura where nro_factura in(
	select nro_factura from e01_detalle_factura where codigo_producto in(
	select codigo_producto from e01_producto where nombre like 'scales' )));
-- Ceci lo tiene hecho con exist
    
    
    
    
    

-- 5 - alguno de los anteriores resolverlo con EXIST (NOT EXIST) y con ANY
	
    -- Punto 4 resuelto con any
	Select * from e01_cliente where nro_cliente = any (
	select nro_cliente from e01_detalle_factura where codigo_producto
	=  (Select codigo_producto from e01_producto where nombre = 'scales'));

-- 6 - mostrar los codigos de área de los clientes del punto 4

	Select codigo_area, nro_cliente from e01_telefono where nro_cliente in (
    Select nro_cliente from e01_cliente where nro_cliente in (
	select nro_cliente from e01_detalle_factura where codigo_producto
	= (Select codigo_producto from e01_producto where nombre = 'scales')));

----------------------------------- Consultas adicionales --------------------------------------------

-- seleccionar nro de factura de los clientes que tengan codigo de area 296 
	select nro_factura from e01_factura where nro_cliente in(
	select nro_cliente from e01_telefono where codigo_area=296);

-- ver detalles de las facturas anteriores ( o sea de los clientes con codigo de area 296
	(select nro_factura,codigo_producto,nro_item from e01_detalle_factura where nro_factura in(
	select nro_factura from e01_factura where nro_cliente in(
	select nro_cliente from e01_telefono where codigo_area=296)));
    
-- ver descripcion de los productos de las facturas consultadas anteriormente
		select * from e01_producto where codigo_producto in(
	    (select codigo_producto from e01_detalle_factura where nro_factura in(
	    select nro_factura from e01_factura where nro_cliente in(
	    select nro_cliente from e01_telefono where codigo_area=296))));