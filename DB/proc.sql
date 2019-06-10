



-- Procedimiento que retorna una tabla con la informacion de los aeropuertos de Salida
go
create procedure salida
@query varchar(50)
as
select a.codigo as codigo_aeropuerto,
a.descripcion as descripcion,
d.codigo as codigo_destino,
d.pais as pais
,d.pais + ', '+a.descripcion as ubicacion from aeropuerto  as a
join destino as d
on a.codigo_destino = d.codigo
where a.descripcion like '%'+@query+'%' or d.pais like '%'+@query+'%'
go








--Procedimiento Almacenado que retorna una tabla con la lista de destinos
go
create procedure destinos
@query varchar(60)
as
select *, d.pais+', '+d.departamento as descripcion_t from destino as d
where d.pais like '%'+@query+'%' or d.departamento like '%'+@query+'%'
go









/* Procedimiento alamacenado que busca la disponibilidad de vuelos para los clientes*/
go
create procedure vuelos
@fecha date,
@codigo_aeropuerto int,
@codigo_destino int,
@asientos int,
@tipo int
as
if (@tipo = 2 )
select v.codigo as codigo_vuelo, v.fecha_salida, v.pasajeros_economico , v.pasajeros_primera ,
av.no_asientos , de.codigo as destino,
(
select de.pais + ', '+de.departamento +', '+ae.descripcion   from vuelo as vu
join aeropuerto as ae
on vu.codigo_aeropuerto = ae.codigo 
join destino as de
on ae.codigo_destino = de.codigo
where vu.codigo = v.codigo
) as aeropuerto_salida,
(
select de.pais + ', '+de.departamento +', '+ae.descripcion from vuelo as vu
join escala as es
on es.codigo_vuelo = vu.codigo 
join aeropuerto as ae
on es.codigo_aeropuerto = ae.codigo
join destino as de
on ae.codigo_destino = de.codigo
where vu.codigo = v.codigo
) as aeropuerto_llegada,
(@tipo) as tipo,
v.precio+400 as precio_vuelo

from vuelo as v
join escala as e
on e.codigo_vuelo = v.codigo
join avion as av
on v.codigo_avion = av.codigo
join linea_aerea as li
on av.codigo_linea = li.codigo 
join aeropuerto as ae
on v.codigo_aeropuerto = ae.codigo 
join destino as de
on ae.codigo = de.codigo 
where v.fecha_salida between @fecha and @fecha  and v.codigo_aeropuerto = @codigo_aeropuerto and de.codigo = @codigo_destino
and (v.pasajeros_primera - av.no_asientos/2) < @asientos 
else

select v.codigo as codigo_vuelo, v.fecha_salida, v.pasajeros_economico , v.pasajeros_primera ,
av.no_asientos , de.codigo as destino,
(
select de.pais + ', '+de.departamento +', '+ae.descripcion   from vuelo as vu
join aeropuerto as ae
on vu.codigo_aeropuerto = ae.codigo 
join destino as de
on ae.codigo_destino = de.codigo
where vu.codigo = v.codigo
) as aeropuerto_salida,
(
select de.pais + ', '+de.departamento +', '+ae.descripcion from vuelo as vu
join escala as es
on es.codigo_vuelo = vu.codigo 
join aeropuerto as ae
on es.codigo_aeropuerto = ae.codigo
join destino as de
on ae.codigo_destino = de.codigo
where vu.codigo = v.codigo
) as aeropuerto_llegada,
(@tipo) as tipo,
v.precio as precio_vuelo

from vuelo as v
join escala as e
on e.codigo_vuelo = v.codigo
join avion as av
on v.codigo_avion = av.codigo
join linea_aerea as li
on av.codigo_linea = li.codigo 
join aeropuerto as ae
on v.codigo_aeropuerto = ae.codigo 
join destino as de
on ae.codigo = de.codigo 
where v.fecha_salida between @fecha and @fecha and v.codigo_aeropuerto = @codigo_aeropuerto and de.codigo = @codigo_destino 
and (v.pasajeros_economico-av.no_asientos/2) < @asientos








/*Procedimiento Almacenado para reservar vuelo*/
go
create procedure reservarVuelo
@tipo varchar(10),
@vuelo varchar(20),
@destino varchar(20),
@usuario varchar(20),
@pasajeros int
as
declare @res int
if (@tipo = 1)
begin
	insert into reservacion values(1,@usuario,@vuelo,null,@destino,null,@pasajeros,(select pasajeros_economico from vuelo where codigo = @vuelo))
	select @res = scope_identity()
	insert into paquetes values(@res,2,(select vuelo.precio from vuelo where codigo = @vuelo ),@pasajeros)
	update vuelo set pasajeros_economico = @pasajeros + pasajeros_economico where codigo = @vuelo
end
else if (@tipo = 2)
begin
	insert into reservacion values(2,@usuario,@vuelo,null,@destino,null,@pasajeros,(select pasajeros_primera from vuelo where codigo = @vuelo))
	select @res = scope_identity()
	insert into paquetes values(@res,1,((select vuelo.precio from vuelo where codigo = @vuelo )+400),@pasajeros)
	update vuelo set pasajeros_primera = @pasajeros + pasajeros_primera where codigo = @vuelo 
end
select @res as Codigo
go











/*Procedimiento para Detalle del vuelo solicitado*/


go
create procedure detalleVuelo
@vuelo varchar(10)
as
select 
r.codigo,r.tipo,p.cantidad as personas ,p.precio,i.descripcion,
(
select de.pais + ', '+de.departamento +', '+ae.descripcion   from vuelo as vu
join aeropuerto as ae
on vu.codigo_aeropuerto = ae.codigo 
join destino as de
on ae.codigo_destino = de.codigo
join reservacion as res
on res.codigo_vuelo = vu.codigo 
where res.codigo = @vuelo
) as aeropuerto_salida,
(
select de.pais + ', '+de.departamento +', '+ae.descripcion from vuelo as vu
join escala as es
on es.codigo_vuelo = vu.codigo 
join aeropuerto as ae
on es.codigo_aeropuerto = ae.codigo
join destino as de
on ae.codigo_destino = de.codigo
join reservacion as res
on res.codigo_vuelo = vu.codigo
where res.codigo = @vuelo
) as aeropuerto_llegada,
(p.cantidad *p.precio) as subTotal

 from reservacion as r
join paquetes as p 
on p.codigo_reservacion = r.codigo
join item as i
on p.codigo_item = i.codigo 
where r.codigo = @vuelo
go







/*Procedimiento para buscar la persona*/

go
create procedure buscarCliente
@dpi varchar(50)
as
select codigo,nombres, apellidos,email,dpi, direccion, telefono, CONVERT(VARCHAR(20),fecha_nacimiento,126) as fecha_nacimiento,nit from cliente 
where dpi = @dpi
go









/*Procedimiento para agregar Cliente */

go
create procedure AgregarCliente
@nombres varchar(50),
@apellidos varchar(50),
@email varchar(50),
@dpi varchar(15),
@direccion varchar(60),
@telefono varchar(10),
@nacimiento varchar(10),
@nit varchar(10)
as
declare @codigo int;
insert into cliente values(@nombres,@apellidos,@email,@dpi,@direccion,@telefono,@nacimiento,@nit);
select @codigo = scope_identity();
select @codigo as cliente;
go





/*Procedimiento para obtener tipo de Reservacion*/
go
create procedure obtenerReservacion
@codigo varchar(20)
as
select tipo from reservacion where codigo = @codigo
go









/* Procedimiento Almacenado para facturar Vuelo Economico */

go
create procedure facturar_vuelo_economico
@reservacion int,
@fecha varchar(10),
@t_pago int,
@efectivo varchar(10),
@credito varchar(10),
@debito varchar(10),
@cliente int
as
declare @fac int,
@persona int;
insert into encabezado_factura values(@fecha,'xxx',@t_pago,@efectivo,@credito,@debito,'0',@reservacion,@cliente);
select @fac = scope_identity();
insert into detalle_factura(codigo_factura,codigo_item,cantidad) values(@fac,'2',(select r.personas from reservacion as r where r.codigo = @reservacion ));
select @fac as codigo_factura
go




/*Procedimiento para facturar vuelo Primera Clase*/

go
create procedure facturar_vuelo_primera_clase
@reservacion int,
@fecha varchar(10),
@t_pago int,
@efectivo varchar(10),
@credito varchar(10),
@debito varchar(10),
@cliente int
as
declare @fac int,
@persona int;
insert into encabezado_factura values(@fecha,'xxx',@t_pago,@efectivo,@credito,@debito,'0',@reservacion,@cliente);
select @fac = scope_identity();
insert into detalle_factura(codigo_factura,codigo_item,cantidad) values(@fac,'1',(select r.personas from reservacion as r where r.codigo = @reservacion ));
select @fac as codigo_factura
go





/*Procedimiento que genera ticket de vuelo economico,primera clase */

go
create procedure ticket_Vuelo_E
@factura int
as
select re.codigo, re.tipo, re.personas, re.codigo_vuelo, re.no_asiento ,
it.descripcion , 
pa.precio ,
v.fecha_salida,
ef.codigo as codigo_factura,ef.fecha, ef.credito , ef.debito,ef.efectivo ,
cl.nombres,cl.apellidos, cl.nit ,
(
select de.pais + ', '+de.departamento +', '+ae.descripcion   from vuelo as vu
join aeropuerto as ae
on vu.codigo_aeropuerto = ae.codigo 
join destino as de
on ae.codigo_destino = de.codigo
where vu.codigo = v.codigo
) as aeropuerto_salida,
(
select de.pais + ', '+de.departamento +', '+ae.descripcion from vuelo as vu
join escala as es
on es.codigo_vuelo = vu.codigo 
join aeropuerto as ae
on es.codigo_aeropuerto = ae.codigo
join destino as de
on ae.codigo_destino = de.codigo
where vu.codigo = v.codigo
) as aeropuerto_llegada
 from reservacion as re
join paquetes as pa
on pa.codigo_reservacion = re.codigo 
join item as it
on pa.codigo_item = it.codigo
join vuelo as v
on re.codigo_vuelo = v.codigo
join encabezado_factura as ef
on ef.codigo_reservacion = re.codigo 
join cliente as cl
on ef.codigo_cliente = cl.codigo
where ef.codigo = @factura order by it.codigo asc
go





/* Procedimientos para listar los hoteles */

go
create procedure lista_hotel
@destino int,
@doble int,
@simple int
as
if @doble > 0 and @simple > 0	
	select h.codigo as codigo_hotel,
	h.descripcion ,
	h.habitaciones,
	h.habitaciones_doble,
	h.habitaciones_simple,
	(select i.precio from item as i
	where i.codigo = 3
	)+h.precio as p_habitacion_simple,
	(select i.precio from item as i
	where i.codigo = 4
	)+h.precio as p_habitacion_doble,

	h.direccion,
	d.pais,d.departamento 
	from hotel as h
	join destino as d
	on h.codigo_destino = d.codigo
	where  d.codigo = @destino and h.habitaciones/2 >= (h.habitaciones_simple+@simple) and h.habitaciones/2 >= (h.habitaciones_doble +@doble ) ;
else if @doble > 0
	select h.codigo as codigo_hotel,
	h.descripcion ,
	h.habitaciones,
	h.habitaciones_doble,
	h.habitaciones_simple,
	
	(select i.precio from item as i
	where i.codigo = 3
	)+h.precio  as p_habitacion_simple,
	(select i.precio from item as i
	where i.codigo = 4
	)+ h.precio as p_habitacion_doble,

	h.direccion,
	d.pais,d.departamento 
	from hotel as h
	join destino as d
	on h.codigo_destino = d.codigo
	where  d.codigo = @destino and h.habitaciones/2 >= (h.habitaciones_doble +@doble ) ;
else if @simple > 0
	select h.codigo as codigo_hotel,
	h.descripcion ,
	h.habitaciones,
	h.habitaciones_doble,
	h.habitaciones_simple,
	
	(select i.precio from item as i
	where i.codigo = 3
	)+h.precio as p_habitacion_simple,
	(select i.precio from item as i
	where i.codigo = 4
	)+h.precio as p_habitacion_doble,

	h.direccion,
	d.pais,d.departamento 
	from hotel as h
	join destino as d
	on h.codigo_destino = d.codigo
	where  d.codigo = @destino and h.habitaciones/2 >= (h.habitaciones_simple +@simple) ;
go



go
create procedure reservar_vuelo_Hotel_Traslado_e
@destino int,
@vuelo int,
@pasajeros int,
@desayuno int,
@habitacion_s int,
@habitacion_d int,
@hotel int,
@usuario int
as
declare @id int;
insert into reservacion values(3,@usuario,@vuelo,null,@destino,@hotel,@pasajeros,(select pasajeros_economico from vuelo where codigo = @vuelo));
select @id = SCOPE_IDENTITY()
insert into paquetes values(@id,2,(select vuelo.precio from vuelo where codigo = @vuelo ),@pasajeros );
insert into paquetes values(@id,7,(select item.precio from item where codigo = 7 ),1 );
if @desayuno = 1
begin
	insert into paquetes values(@id,6,(select item.precio from item where item.codigo = 6),@pasajeros)
end
else if @desayuno = 2
begin
	insert into paquetes values(@id,5,(select item.precio from item where item.codigo = 5),@pasajeros)
end

if @habitacion_d > 0 
begin
	insert into paquetes values(@id,4,(select item.precio from item where item.codigo = 4)+(select hotel.precio from hotel where codigo = @hotel),@habitacion_d);
end
if @habitacion_s > 0
begin
	insert into paquetes values(@id,3,(select item.precio from item where item.codigo = 3)+(select hotel.precio from hotel where codigo = @hotel),@habitacion_s);
end
update vuelo set pasajeros_economico = @pasajeros + pasajeros_economico where codigo = @vuelo;
update hotel set 
habitaciones_doble = (habitaciones_doble +@habitacion_d ), 
habitaciones_simple = (habitaciones_simple + @habitacion_s) where codigo = @hotel; 
select @id as Codigo
go


/* Procedimiento para alamacenar vuelo primera clase, hotel, traslado*/


go
create procedure reservar_vuelo_Hotel_Traslado_p
@destino int,
@vuelo int,
@pasajeros int,
@desayuno int,
@habitacion_s int,
@habitacion_d int,
@hotel int,
@usuario int
as
declare @id int;
insert into reservacion values(4,@usuario,@vuelo,null,@destino,@hotel,@pasajeros,(select pasajeros_economico from vuelo where codigo = @vuelo));
select @id = SCOPE_IDENTITY()
insert into paquetes values(@id,1,(select vuelo.precio from vuelo where codigo = @vuelo )+200,@pasajeros );
insert into paquetes values(@id,7,(select item.precio from item where codigo = 7 ),1 );
if @desayuno = 1
begin
	insert into paquetes values(@id,6,(select item.precio from item where item.codigo = 6),@pasajeros)
end
else if @desayuno = 2
begin
	insert into paquetes values(@id,5,(select item.precio from item where item.codigo = 5),@pasajeros)
end

if @habitacion_d > 0 
begin
	insert into paquetes values(@id,4,(select item.precio from item where item.codigo = 4)+(select hotel.precio from hotel where codigo = @hotel),@habitacion_d);
end
if @habitacion_s > 0
begin
	insert into paquetes values(@id,3,(select item.precio from item where item.codigo = 3)+(select hotel.precio from hotel where codigo = @hotel),@habitacion_s);
end
update vuelo set pasajeros_economico = @pasajeros + pasajeros_economico where codigo = @vuelo;
update hotel set 
habitaciones_doble = (habitaciones_doble +@habitacion_d ), 
habitaciones_simple = (habitaciones_simple + @habitacion_s) where codigo = @hotel; 
select @id as Codigo
go



/* procedimiento para reservar hotel,vuelo economico */

go
create procedure reservar_vuelo_Hotel_e
@destino int,
@vuelo int,
@pasajeros int,
@desayuno int,
@habitacion_s int,
@habitacion_d int,
@hotel int,
@usuario int
as
declare @id int;
insert into reservacion values(5,@usuario,@vuelo,null,@destino,@hotel,@pasajeros,(select pasajeros_economico from vuelo where codigo = @vuelo));
select @id = SCOPE_IDENTITY()
insert into paquetes values(@id,2,(select vuelo.precio from vuelo where codigo = @vuelo),@pasajeros );
if @desayuno = 1
begin
	insert into paquetes values(@id,6,(select item.precio from item where item.codigo = 6),@pasajeros)
end
else if @desayuno = 2
begin
	insert into paquetes values(@id,5,(select item.precio from item where item.codigo = 5),@pasajeros)
end

if @habitacion_d > 0 
begin
	insert into paquetes values(@id,4,(select item.precio from item where item.codigo = 4)+(select hotel.precio from hotel where codigo = @hotel),@habitacion_d);
end
if @habitacion_s > 0
begin
	insert into paquetes values(@id,3,(select item.precio from item where item.codigo = 3)+(select hotel.precio from hotel where codigo = @hotel),@habitacion_s);
end
update vuelo set pasajeros_economico = @pasajeros + pasajeros_economico where codigo = @vuelo;
update hotel set 
habitaciones_doble = (habitaciones_doble +@habitacion_d ), 
habitaciones_simple = (habitaciones_simple + @habitacion_s) where codigo = @hotel; 
select @id as Codigo
go


/* Procedimiento para reservar vuelo primera clase, hotel*/

go
create procedure reservar_vuelo_Hotel_p
@destino int,
@vuelo int,
@pasajeros int,
@desayuno int,
@habitacion_s int,
@habitacion_d int,
@hotel int,
@usuario int
as
declare @id int;
insert into reservacion values(6,@usuario,@vuelo,null,@destino,@hotel,@pasajeros,(select pasajeros_economico from vuelo where codigo = @vuelo));
select @id = SCOPE_IDENTITY()
insert into paquetes values(@id,1,(select vuelo.precio from vuelo where codigo = @vuelo )+200,@pasajeros );
if @desayuno = 1
begin
	insert into paquetes values(@id,6,(select item.precio from item where item.codigo = 6),@pasajeros)
end
else if @desayuno = 2
begin
	insert into paquetes values(@id,5,(select item.precio from item where item.codigo = 5),@pasajeros)
end
if @habitacion_d > 0 
begin
	insert into paquetes values(@id,4,(select item.precio from item where item.codigo = 4)+(select hotel.precio from hotel where codigo = @hotel),@habitacion_d);
end
if @habitacion_s > 0
begin
	insert into paquetes values(@id,3,(select item.precio from item where item.codigo = 3)+(select hotel.precio from hotel where codigo = @hotel),@habitacion_s);
end
update vuelo set pasajeros_economico = @pasajeros + pasajeros_economico where codigo = @vuelo;
update hotel set 
habitaciones_doble = (habitaciones_doble +@habitacion_d ), 
habitaciones_simple = (habitaciones_simple + @habitacion_s) where codigo = @hotel; 
select @id as Codigo
go


/* Facturar Vuelo economico,hotel,traslado*/

go
create procedure Facturar
@reservacion int,
@fecha varchar(10),
@t_pago int,
@efectivo varchar(10),
@credito varchar(10),
@debito varchar(10),
@cliente int
as
declare @fac int;
insert into encabezado_factura values(@fecha,'xxx',@t_pago,@efectivo,@credito,@debito,'0',@reservacion,@cliente)
select @fac = SCOPE_IDENTITY()
insert into detalle_factura(codigo_factura,codigo_item,cantidad) select (@fac),p.codigo_item,p.cantidad from paquetes as p where p.codigo_reservacion = @reservacion  
select @fac as codigo_factura
go


/* Procedimiento para ubicar crucero */
go
create procedure ubicar_crucero
@query varchar(30)
as
select 
p.codigo codigo_puerto,p.descripcion+ '... ' + d.departamento + ', ' + d.pais as crucero
from puerto as p
join destino as d
on p.codigo_destino = d.codigo 
where p.descripcion like '%'+@query +'%' or 
d.departamento like '%'+@query +'%' 
or d.pais like '%'+@query+'%'
go



/* Procedimiento para listar los cruceros */

go
create procedure listar_cruceros
@puerto int,
@fecha varchar(10),
@pasajeros int
as
select 
c.codigo as codigo_crucero, c.fecha_salida, c.pasajeros, c.precio,c.reservados,c.descripcion as d_crucero,
(p.descripcion + '... ' + d.departamento + ', ' + d.pais ) as salida
 from crucero as c
join puerto as p
on c.codigo_puerto = p.codigo 
join destino as d
on p.codigo_destino = d.codigo 
where c.codigo_puerto = @puerto and c.fecha_salida = @fecha and c.pasajeros >= (c.reservados  + @pasajeros )
go


/* Procedimiento para reservar Crucero */

go
create procedure reservar_crucero
@usuario int,
@crucero int,
@pasajeros int
as
declare @id int;
insert into reservacion values(7,@usuario,null,@crucero,null,null,@pasajeros,(select reservados  from crucero where codigo = @crucero));
select @id = SCOPE_IDENTITY();
update crucero set reservados = (reservados + @pasajeros);
insert into paquetes values(@id,8,(select precio from crucero where codigo = @crucero),@pasajeros),(@id,5,0,@pasajeros);
select @id as reservacion
go




/* Procedimiento Almacenado para armar ticket de vuelo+hotel+traslado */

go
create procedure ticket_Vuelo_Hotel
@factura int
as
select re.codigo, re.tipo, re.personas, re.codigo_vuelo, re.no_asiento ,
it.descripcion as descripcion_item , it.codigo as codigo_item,
pa.precio,pa.cantidad ,
v.fecha_salida,
h.descripcion as descripcion_hotel,h.direccion , (de.departamento + ', '+ de.pais) as dir_hotel,
ef.codigo as codigo_factura,ef.fecha, ef.credito , ef.debito,ef.efectivo ,
cl.nombres,cl.apellidos, cl.nit ,
(
	select de.pais + ', '+de.departamento +', '+ae.descripcion   from vuelo as vu
	join aeropuerto as ae
	on vu.codigo_aeropuerto = ae.codigo 
	join destino as de
	on ae.codigo_destino = de.codigo
	where vu.codigo = v.codigo
) as aeropuerto_salida,
(
	select de.pais + ', '+de.departamento +', '+ae.descripcion from vuelo as vu
	join escala as es
	on es.codigo_vuelo = vu.codigo 
	join aeropuerto as ae
	on es.codigo_aeropuerto = ae.codigo
	join destino as de
	on ae.codigo_destino = de.codigo
	where vu.codigo = v.codigo
) as aeropuerto_llegada
	 from reservacion as re
	join paquetes as pa
	on pa.codigo_reservacion = re.codigo 
	join item as it
	on pa.codigo_item = it.codigo
	join vuelo as v
	on re.codigo_vuelo = v.codigo
	join encabezado_factura as ef
	on ef.codigo_reservacion = re.codigo 
	join cliente as cl
	on ef.codigo_cliente = cl.codigo
	join hotel as h
	on re.codigo_hotel = h.codigo 
	join destino de
	on h.codigo_destino =de.codigo
	where ef.codigo = @factura order by it.codigo asc
go


/* Procedimiento almacenado para  armar ticket del Crucero*/

go
create procedure ticket_crucero
@factura int
as
select 
ef.codigo as codigo_factura, ef.fecha,
cr.descripcion as crucero, cr.fecha_salida,
pa.cantidad,pa.precio,it.descripcion as item,
cl.nombres,cl.apellidos,cl.nit,cr.codigo as codigo_crucero   
,(
	select (pu.descripcion + '... '+de.pais + ', '+de.departamento   ) from crucero c
	join puerto pu
	on c.codigo_puerto = pu.codigo 
	join destino de
	on pu.codigo_destino = de.codigo
	where c.codigo = cr.codigo 
) as puerto
 from encabezado_factura ef
join reservacion re
on ef.codigo_reservacion = re.codigo 
join paquetes pa
on pa.codigo_reservacion = re.codigo
join item it
on pa.codigo_item = it.codigo 
join crucero cr
on re.codigo_crucero = cr.codigo 
join cliente cl
on ef.codigo_cliente = cl.codigo 
where ef.codigo = @factura
go


create procedure login
@pass varchar(20),
@user varchar(40)
as
select * from usuario
where pass= @pass and username = @user;
go




insert into destino values('El salvador','San Salvador');
insert into destino values('Guatemala','Guatemala');
insert into destino values('Costa Rica','prueba');
insert into destino values('Guatemala','Izabal');
insert into destino values('El Salvador','Estereo');
insert into destino values('El Salvador','Vicente');

insert into linea_aerea values('Taca','Taca');

insert into avion values(120,1);
insert into avion values(80,1);
insert into avion values(90,1);

insert into aeropuerto values('Aeropuerto Internacional La Aurora',2);
insert into aeropuerto values('Aeropuerto Internacion Commit ',1);
insert into aeropuerto values('Aeropuerto en Costa Rica',3);




insert into vuelo values('2015-11-21',0,0,1,1,2500);
insert into vuelo values('2015-11-21',0,0,2,1,2500);
insert into vuelo values('2015-11-21',0,0,3,2,2000);




insert into escala values(1,2);
insert into escala values(2,2);
insert into escala values(3,1);


insert into item values('Boleto Aereo Primera Clase',0),
('Boleto Aereo Economico',0),
('Hotel con Habitacion Simple','1000'),
('Hotel con Habitacion Doble','1200'),
('Desayuno Buffet','350'),
('Desayuno Normal','100'),
('Traslados','850'),
('Crucero',0);


insert into usuario values('Juan Ronaldo','Lemus Quevedo','1000200030000','Escuinta, Guatemala','52104578','roon','1234',3); 

insert into cliente values('Juan Ronaldo','Lemus Quevedo','roon@gmail.com','123456','Escuintla, Guatemala','78541201','1994-11-07','0000123');
insert into usuario values('Jorge Luis','Morales Arriola','4521032145789','Guatemala,Guatemala','78541265','jorge','1111',2);

insert into hotel values('Hotel EL sol','80','0','0','1','200','20 calle 8-16, Sector Marilu '),('Hotel Flor del Mar','60','0','0','1','150','1 calle 1-11, Esquivel');

insert into hotel values('Tikal Hotel','90','0','0','2','450','8-12 9 calle,Villa Nueva'),('Hotel Huawei','30','0','0','2','100','5-45 zona 10, Mixco');
insert into hotel values('Motil Hotel','80','0','0','2','450','8-12 9 calle,Vista Hermosa'),('Mora Hotel','30','0','0','2','100','5-45 zona 10, Santa Ana');

insert into hotel values('Palace Hotel','90','0','0','3','450','Secto los Almendros, Botic'),('Monster Hotel','80','0','0','3','100','Maril tolik');




insert into puerto values('Puerto Guatemala','4');
insert into puerto values('Puerto El salvador','5');
insert into puerto values('Puerto 2 El Salvador','6');



insert into crucero values('Viña del Mar','800',0,'2015-11-21','1150','1');
insert into crucero values('Titabikc','900',0,'2015-11-21','2000','2');
insert into crucero values('Marbella','500',0,'2015-11-21','500','2');
insert into crucero values('Marilu','700',0,'2015-11-21','450','2');
insert into crucero values('Martita ','650',0,'2015-11-21','450','3');

