
use CFL2020_data;
-- ----------------------- clase 48 ---------------------------

-- Obtener el promedio del precio de los productos cuyo nombre es “fish”
	SELECT AVG(precio) 
    FROM e01_producto 
    WHERE nombre LIKE 'fish';
    
    SELECT AVG(precio), 
    AVG(stock) 
    FROM e01_producto 
    WHERE nombre LIKE 'fish'; -- promedio precio y stock

-- Obtener el número total de productos cuyo nombre es “fish”
	SELECT COUNT(*) 
    FROM e01_producto 
    WHERE nombre LIKE 'fish';

-- devuelve cantidad de producto
	Select count(*) 
    from e01_producto; 

-- Seleccionar el precio del producto más caro
	SELECT MAX(precio), nombre, marca 
    FROM e01_producto;

-- Seleccionar el precio del producto más caro
	SELECT MIN(precio)
    FROM e01_producto;

-- Listar todos los productos junto con la cantidad que hay de cada uno.
	SELECT nombre,COUNT(nombre)
    FROM e01_producto GROUP BY nombre;

	SELECT nombre,COUNT(nombre)
    FROM e01_producto 
    WHERE nombre like 'f%' -- que arranque con f
    GROUP BY nombre;
        
    SELECT nombre, COUNT(codigo_producto)
	FROM e01_producto
	GROUP BY nombre;

-- conjunto de conjunto --	
-- quiero ver el stock que tiene el producto household goods cuyo precio es el maximo
	SELECT p.* 
    FROM e01_producto p
	INNER JOIN 
    (SELECT nombre, count(*), MAX(precio) as maxprecio
    FROM e01_producto
    where nombre='household goods'
    group by nombre) x 
    on p.nombre = x.nombre and x.maxprecio=p.precio;
    
-- quiero ver el stock que tienen los productos de la lista cuyos precios son los maximos
	SELECT p.* 
    FROM e01_producto p
	INNER JOIN 
    (SELECT nombre, MAX(precio) as maxprecio
    FROM e01_producto
    group by nombre) x 
    on p.nombre = x.nombre and x.maxprecio=p.precio;    


-- cuantas factura tiene cada cliente

	Select distinct c.nro_cliente,c.nombre,c.apellido, 
	count(*) as cuantas_facturas_tiene
	from e01_cliente c
	left join e01_factura f 
	on (c.nro_cliente = f.nro_cliente)
	where f.nro_cliente 
	group by c.nro_cliente,c.nombre,c.apellido;

-- group by con left join 

	SELECT c.*, COUNT(f.nro_factura)
	FROM e01_cliente c LEFT JOIN    
	e01_factura f
	ON (c.nro_cliente = f.nro_cliente)
	GROUP BY c.nro_cliente;

-- Listar todas las marcas, cuyos productos tengan un stock inferior a 50 unidades
-- el having debe ir si o si despues de un group by, es un segundo filtro
	SELECT marca, SUM(stock)
	FROM e01_producto
	GROUP BY marca
	HAVING SUM(stock)<50;
    
    
    SELECT marca, SUM(stock)
	FROM e01_producto
	WHERE marca like '%c' -- que la marca termine en c
    GROUP BY marca
	HAVING SUM(stock)<50;
    
-- Listar datos de los clientes ordenados por apellido y nombre

	SELECT *
	FROM e01_cliente
	ORDER BY apellido, nombre ASC;
    
-- Quiero obtener los 3 productos mas caros

	SELECT *
	FROM e01_producto
	ORDER BY precio DESC  -- ordeno por precio descendente
	LIMIT 3;     -- limito la tabla a 3 filas
    
-- Sentencia limit, para limitar la cantidad de filas que te trae

	SELECT *
	FROM e01_cliente
	ORDER BY apellido, nombre DESC
    limit 10;
    
-- Sentencia SELECT completa     
/*
	SELECT [ALL | DISTINCT | DISTINCTROW] 
	lista_atributos
	FROM nombre_tabla
	[WHERE condición]
	[GROUP BY {nombre_columna | expresión} 
	[ASC | DESC], ... 
	[WITH ROLLUP]] [HAVING where_condicion]
	[ORDER BY {nombre_columna | expr |
	position}
	[ASC | DESC], ...] 
	[LIMIT {[offset,] row_count | row_count 
	OFFSET offset}]  */

-- 1 -- obtener el numero total de clientes que se encuentran registrados en la base de datos.
	SELECT count(nro_cliente) 
    FROM e01_cliente;
    -- si quiero agregar un nombre agrego el comando where nombre like nombre
	
-- 2 -- Listar el precio promedio de cada marca
    SELECT DISTINCT  p.nombre, AVG(p.precio)
    FROM e01_producto p
	GROUP BY p.nombre;

-- 3 -- listar el nombre junto con el precio promedio de los 10 primeros productos ordenados por promedio de precios
    SELECT DISTINCT AVG(precio), nombre
    FROM e01_producto 
	GROUP BY nombre
	ORDER BY avg(precio) desc
	LIMIT 10;
    
-- 4-- Listar lo que gastó cada cliente, mostrando el número de cliente y la suma total
    Select c.nro_cliente,c.nombre,c.apellido,sum(f.total_con_iva)
    from e01_cliente c
    inner join e01_factura f
    on c.nro_cliente = f.nro_cliente
    group by c.nro_cliente,c.nombre,c.apellido;

 -- 5--   Listar las marcas cuyo promedio de precios sea mayor a 600$
	SELECT marca, AVG(p.precio)  
	FROM e01_producto p
    group by marca
	HAVING AVG(p.precio)>600
    order by avg(precio) desc;
 
-- 6 -- Determinar cuál o cuáles son las áreas telefónicas más populares
    Select t.codigo_area,count(t.nro_cliente) 
    from e01_telefono t
    group by t.codigo_area
    order by count(t.nro_cliente) desc;
    
-- 7 -- contar cuántos productos distintos tiene cada cliente (por nro_cliente)
	Select f.nro_cliente, count(distinct d.codigo_producto)
    from e01_factura f
    inner join e01_detalle_factura d
    on d.nro_factura = f.nro_factura
    group by f.nro_cliente
    order by f.nro_cliente;
	
-- 8 --	Del punto anterior, mostrar cada cliente con su nombre y apellido que tenga más de un teléfono
    Select t.nro_cliente, count(distinct t.nro_telefono), count(distinct d.codigo_producto)
    from e01_telefono t
    inner join e01_cliente c on c.nro_cliente = t.nro_cliente
    inner join e01_factura f on f.nro_cliente = c.nro_cliente
    inner join e01_detalle_factura d on d.nro_factura = f.nro_factura
    group by t.nro_cliente
    order by nro_cliente;

-- 9 --	Cual son las 5 facturas más caras
    Select f.total_con_iva, c.nombre, c.apellido
    from e01_factura f
    inner join e01_cliente c on f.nro_cliente = c.nro_cliente 
    group by f.total_con_iva, c.nombre, c.apellido
    order by total_con_iva desc
	limit 5;

-- 10 -- Cuales clientes han facturado más (mostrar los 5 primeros) 
    Select c.nro_cliente,sum(f.total_con_iva)
    from e01_cliente c 
    inner join e01_factura f on (c.nro_cliente = f.nro_cliente)
    group by c.nro_cliente
    order by sum(f.total_con_iva) desc
    limit 5;
 
-- 11 -- Cuanto suman las compras de los clientes que tienen activo igual a 52. Y a cuánto asciende el iva de estas compras.
	Select c.nro_cliente,sum(f.total_con_iva),sum(f.total_sin_iva)
    from e01_cliente c
    inner join e01_factura f
    on c.nro_cliente=f.nro_cliente
    where c.activo = 52
    group by c.nro_cliente;

-- 12 -- Mostrar el cliente con la máxima facturación promedio de todas las facturaciones
	Select c.nombre,c.apellido,c.nro_cliente,f.nro_factura, avg(total_con_iva)
    from e01_cliente c
    inner join e01_factura f
    on f.nro_cliente = c.nro_cliente
    group by c.nro_cliente
    order by avg(total_con_iva) desc
	limit 1;
    
    
-- 13 -- Cuál fue el producto que fue facturado más veces?
	select codigo_producto, nombre, max(cantidad_veces_facturado) as maximo
    from (select p.codigo_producto,p.nombre,
    count(distinct d.nro_factura) as cantidad_veces_facturado
    from e01_producto p
	inner join e01_detalle_factura d
	on p.codigo_producto = d.codigo_producto
	group by p.codigo_producto,p.nombre)x
    group by codigo_producto,nombre
    order by maximo desc;

-- 14 -- ¿Qué productos no fueron facturados?
		select distinct c.nombre,f.nro_factura
		from e01_cliente c
        left join e01_factura f
        on c.nro_cliente = f.nro_cliente
        where f.nro_cliente is null;
    
-- 15 -- ¿Que clientes pagaron más de 3 millones de pesos en el total de sus compras?
	    Select sum(f.total_con_iva), f.nro_cliente from e01_factura f
		group by nro_cliente
		having sum(total_con_iva)>3000000;
       
-- 16 -- ¿Cuántas facturas se realizaron en los 3 primeros meses del año 2016?
		Select count(*)  
		from e01_factura 
		where month(fecha) between 1 and 3 and year(fecha)= 2016;

-- 17 -- Liste el total mensual de facturación del año 2017
		select year(f.fecha),month(f.fecha),sum(f.total_con_iva)
        from e01_factura f
        group by month(f.fecha),year(f.fecha)
		order by month(f.fecha);
        
-- 18 -- Liste la cantidad mínima, máxima y promedio de productos facturados en el mes de junio de 2016
		Select p.codigo_producto, max(d.cantidad), min(d.cantidad), avg(d.cantidad)
        from e01_detalle_factura d
        inner join e01_producto p on d.codigo_producto = p.codigo_producto
        inner join e01_factura f on d.nro_factura = f.nro_factura
        where year(f.fecha) = 2016 and month(f.fecha)=6
        group by p.codigo_producto;
	
-- 19 -- Que tipo de teléfono corresponde a las áreas determinadas en el ejercicio 6.
	
	select count(distinct codigo_area),tipo
    from e01_telefono
    group by tipo
    order by count(distinct codigo_area) desc;