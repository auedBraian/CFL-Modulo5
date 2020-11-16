use CFL2020_data;

-- ----------------------- clase 47 ---------------------------
-- Ver los clientes con sus numeros de telefono
SELECT e01_cliente.nombre, 
e01_cliente.apellido, 
e01_telefono.nro_telefono
FROM e01_cliente
	INNER JOIN e01_telefono
	ON e01_cliente.nro_cliente =
	e01_telefono.nro_cliente;

-- Ver numeros de telefono del cliente Xerxes
SELECT e01_cliente.nombre, 
e01_cliente.apellido, 
e01_telefono.nro_telefono
FROM e01_cliente
	INNER JOIN e01_telefono
	ON e01_cliente.nro_cliente =
	e01_telefono.nro_cliente where
    e01_cliente.nombre= 'Xerxes';

-- Devolver todos los clientes, indicando las facturas que tienen registradas. 

	select c.*, f.* from e01_cliente c left join e01_factura f
	on c.nro_cliente = f.nro_cliente;

-- Devolver todos las facturas, indicando los clientes a los que les corresponde. 

	select f.*, c.* from e01_factura f left join  e01_cliente c
	on c.nro_cliente = f.nro_cliente;

-- Devolver todos los clientes, indicando las facturas que tienen registradas. 
/* trae todo lo de la derecha, y lo de la izquierda que coincida con lo de la derecha*/

	select * from e01_factura f right join e01_cliente c
	on c.nro_cliente = f.nro_cliente;

-- Clientes que no tienen facturas

	select c.* from e01_cliente c left join e01_factura f
	on c.nro_cliente = f.nro_cliente
	where f.nro_cliente is null;

-- Clientes que si tienen facturas
	select c.*,f.* from e01_cliente c left join e01_factura f
	on c.nro_cliente = f.nro_cliente
	where f.nro_cliente is not null;

-- Ejemplo anterior mejorado

	SELECT DISTINCT
	c.*, 
	CASE WHEN f.nro_factura IS NULL 
	THEN 'no tiene factura'
	ELSE 'tiene factura'
	END AS Factura
	FROM e01_cliente c LEFT JOIN    e01_factura f
	ON (c.nro_cliente = f.nro_cliente);


-- 1.Mostrar cada teléfono junto con los datos del cliente.
	/*Muestro todos los datos de los clientes porque puse el *,
	si quisiera alguna columna particular pongo el nombre de esa columna*/
	
    Select t.codigo_area, t.nro_telefono,c.* from e01_telefono t 
	inner join e01_cliente c 
	on c.nro_cliente = t.nro_cliente
    order by codigo_area;
    
    Select c.*, t.nro_telefono from e01_cliente c  
	inner join e01_telefono t 
	on c.nro_cliente = t.nro_cliente;

-- 2.Mostrar todos los teléfonos del cliente número 30 junto con todos sus datos personales.

	Select nro_telefono,codigo_area,c.* 
	from e01_telefono t
	inner join e01_cliente c
    on t.nro_cliente=c.nro_cliente
	where c.nro_cliente =30;

-- 3.Mostrar nombre y apellido de cada cliente junto con lo que gastó en total (con iva incluido).

	Select nombre,apellido,total_con_iva from e01_cliente c
	inner join e01_factura f
	where c.nro_cliente = f.nro_cliente;

-- 4.Listar todas las facturas que hayan sido compradas por el cliente de nombre "Pandora" y apellido "Tate".
	
    Select c.nombre, c.apellido,f.* 
	from e01_cliente c
    inner join e01_factura f
    on c.nro_cliente = f.nro_cliente
	where c.nombre="Pandora" and c.apellido="Tate";
   

-- 5.Listar todas las Facturas que contengan productos de la marca "In Faucibus Inc."
	
    Select p.nombre,p.marca, f.nro_factura,f.fecha
    from e01_factura f
    inner join e01_detalle_factura d
    on d.nro_factura=f.nro_factura
    inner join e01_producto p on
    d.codigo_producto=p.codigo_producto
	where p.marca="In Faucibus Inc.";
    
-- 6.listar todos los clientes que tengan código de área 296

	Select c.nombre,c.apellido from e01_cliente c 
    inner join e01_telefono t
	on c.nro_cliente = t.nro_cliente 
	where t.codigo_area = 296;
    
-- 7.mostrarme todos los clientes que compraron el producto cuyo nombre = 'scales'
	Select distinct c.* from e01_cliente c 
    inner join e01_factura f
    on c.nro_cliente = f.nro_cliente
	inner join e01_detalle_factura d on
    d.nro_factura = f.nro_factura inner join
    e01_producto p 
	on p.codigo_producto = d.codigo_producto
    where p.nombre ='scales';

-- 8.mostrar los códigos de área de los clientes del punto anterior

	Select distinct codigo_area,c.* from e01_telefono t
	inner join e01_cliente c
    on c.nro_cliente = t.nro_cliente
    inner join e01_factura f
    on c.nro_cliente = f.nro_cliente
	inner join e01_detalle_factura d on
    d.nro_factura = f.nro_factura inner join
    e01_producto p 
	on p.codigo_producto = d.codigo_producto
    where p.nombre ='scales';

-- 9.Mostrar los clientes sin teléfonos

	Select c.* from e01_cliente c
    left join e01_telefono t on
    c.nro_cliente = t.nro_cliente
    where t.nro_cliente is null
    order by nro_cliente;
    
-- 10.Mostrar los código de teléfono de los clientes que no tienen facturas

    Select codigo_area,c.* from e01_telefono t
    inner join e01_cliente c
    on t.nro_cliente = c.nro_cliente
    left join e01_factura f
    on c.nro_cliente = f.nro_cliente
	where f.nro_factura is null;

-- 11.Mostrar las facturas que no tienen productos asociados

	Select f.* from e01_factura f
	left join e01_detalle_factura d
	on d.nro_factura = f.nro_factura
	where d.codigo_producto is null;

-- 12.Mostrar los clientes que tienen facturas sin productos

	Select distinct c.nombre,c.apellido from e01_cliente c 
	inner join e01_factura f on
    c.nro_cliente = f.nro_cliente
    left join e01_detalle_factura d
    on f.nro_factura = d.nro_factura
    where d.codigo_producto is null;
