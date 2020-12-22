use cfl2020_data;

create view xxx as
select p.codigo_producto,p.marca,p.nombre,p.stock,sum(df.cantidad) as vendido
from e01_producto p
inner join e01_detalle_factura df on p.codigo_producto = df.codigo_producto
group by p.codigo_producto,p.marca,p.nombre,p.stock
having p.stock < sum(df.cantidad);

select * from xxx;   -- me trae toda la vista creada anteriormente

create view yyy as
select x.codigo_producto,x.nombre, x.marca,x.vendido, count(distinct f.nro_factura) as cant_facturas
from xxx x 
inner join
e01_detalle_factura df on x.codigo_producto = df.codigo_producto
inner join e01_factura f on f.nro_factura = df.nro_factura
group by x.codigo_producto,x.nombre, x.marca,x.vendido;

select * from yyy;





-- triggers 

CREATE DEFINER=`root`@`localhost` TRIGGER `e01_detalle_factura_BEFORE_UPDATE` BEFORE UPDATE ON `e01_detalle_factura` FOR EACH ROW BEGIN
    declare v_precio float;
    declare v_precio_final float;
    declare v_precio_anterior float;
    declare v_Total_c_iva float;
    declare v_Total_s_iva float;
   
	if  old.cantidad <> new.cantidad then
		-- buscar el precio del producto con el codigo_producto y hacer el nuevo total
        set v_precio = (select precio from e01_producto where codigo_producto = new.codigo_producto);
        if new.cantidad > 10 then
			SET v_precio_final=v_precio*0.9* new.cantidad;
            Set v_precio_anterior = v_precio*0.9* old.cantidad;
		elseif new_cantidad > 5 then
			SET v_precio_final=v_precio*0.95* new.cantidad;
            Set v_precio_anterior = v_precio*0.95* old.cantidad;        
		else 
			SET v_precio_final=v_precio* new.cantidad;
            Set v_precio_anterior = v_precio* old.cantidad;
		end if;
        set v_Total_c_iva = (select total_con_iva from e01_factura where nro_factura = new.nro_factura);
        set v_Total_s_iva = (select total_sin_iva from e01_factura where nro_factura = new.nro_factura);
        set v_Total_c_iva = v_Total_c_iva - v_precio_anterior + v_precio_final;
        set v_Total_s_iva = v_Total_s_iva - v_precio_anterior + v_precio_final;
        update e01_factura set total_con_iva = v_Total_c_iva, total_sin_iva = v_Total_s_iva
        where nro_factura = new.nro_factura;
    end if;
END
