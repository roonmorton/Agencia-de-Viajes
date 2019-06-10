/*
-- Inserciones a la Base de Datos

insert into destino values('El salvador','San Salvador');
insert into destino values('Guatemala','Guatemala');
insert into destino values('Costa Rica','prueba');
insert into destino values('Guatemala','Izabal');
insert into destino values('El Salvador','Estereo');
insert into destino values('El Salvador','Vicente');

insert into linea_aerea values('Taca','Taca');
insert into linea_aerea values('AirLine','AirLine');

insert into avion values(120,1);
insert into avion values(80,1);
insert into avion values(90,1);
insert into avion values(60,2);
insert into avion values(50,2);
insert into avion values(50,1);
insert into avion values(80,1);

insert into aeropuerto values('Aeropuerto Internacional La Aurora',2);
insert into aeropuerto values('Aeropuerto Internacion Commit ',1);
insert into aeropuerto values('Aeropuerto en Costa Rica',3);

select * from destino


insert into vuelo values('2015-11-21',0,0,1,1,2500);
insert into vuelo values('2015-11-21',0,0,2,1,2500);
insert into vuelo values('2015-11-21',0,0,3,2,2000);

insert into vuelo values('2015-11-07',0,0,4,2,1800);

insert into vuelo values('2015-11-07',0,0,5,3,1500);
insert into vuelo values('2015-11-07',0,0,6,3,2220);

select * from puerto
select * from vuelo
select * from avion
select * from aeropuerto 

select * from escala

insert into escala values(1,2);
insert into escala values(2,2);
insert into escala values(3,1);

insert into escala values(4,1);
insert into escala values(5,1);
insert into escala values(6,1);




select * from vuelo vu
join escala es
on es.codigo_vuelo = vu.codigo 
join aeropuerto ae
on es.codigo_aeropuerto = ae.codigo

select * from vuelo
join aeropuerto as ae
on vuelo.codigo_aeropuerto = ae.codigo

select * from aeropuerto 
select * from escala


select * from aeropuerto
join destino de
on aeropuerto.codigo_destino = de.codigo 

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

select * from destino




insert into crucero values('Viña del Mar','800',0,'2015-11-21','1150','1');
insert into crucero values('Titabikc','900',0,'2015-11-21','2000','2');
insert into crucero values('Marbella','500',0,'2015-11-21','500','2');
insert into crucero values('Marilu','700',0,'2015-11-21','450','2');
insert into crucero values('Martita ','650',0,'2015-11-21','450','3');


 
 select * from encabezado_factura 
select * from crucero
select * from hotel
select * from item
select * from paquetes
select * from escala
select * from avion
select * from aeropuerto
select * from destino
select * from vuelo

join avion
on vuelo.codigo_avion = avion.codigo
select * from detalle_factura



-- Procedimientos Almacenador ---------------------------------------------------------------------



exec salida @query = 'guatemala'





exec destinos @query = 'guate'





exec vuelos
@fecha = '2015-11-07',
@codigo_aeropuerto = 2,
@codigo_destino = 2,
@asientos = 4,
@tipo = 2



--Vuelo
insert into reservacion(1,'cliente','usuario','vuelo',null,1,null);

--Crucero
insert into reservacion(2,'cliente','usuario',null,'Crucero',1,null);

-- Vuelo + Hotel + desayuno
insert into reservacion(3,'cliente','usuario','vuelo',null,1,'Hotel');

-- Vuelo + Hotel + desayuno + traslados
insert into reservacion(4,'cliente','usuario','vuelo',null,1,'Hotel');







select * from reservacion

go



exec reservarVuelo @tipo = 2, @vuelo = 1, @destino = 1, @usuario = 1, @pasajeros =1

select * from vuelo
select * from reservacion
select * from paquetes
select * from item

delete paquetes
select * from reservacion


select * from vuelo

go 


exec detalleVuelo @vuelo = 11 

select * from cliente



exec buscarCliente @dpi = 123456

select * from cliente



exec agregarCliente
@nombres = 'prueba',
@apellidos = 'apellido',
@email = 'email@email.com',
@dpi = '1234567890',
@direccion = 'gt,escuintola',
@telefono = '78541203',
@nacimiento = '1990-10-15',
@nit = '548712356'


select * from cliente



exec obtenerReservacion
@codigo = 11

select * from reservacion 

select * from detalle_factura

delete detalle_factura
delete encabezado_factura  





select * from paquetes

exec ticket_Vuelo_E @factura = 16

select * from detalle_factura 
select * from item 
select * from reservacion
select * from paquetes


exec ubicar_crucero @query = 'gu'




exec ticket_Vuelo_E 
@factura = 16
/*
delete detalle_factura;
delete encabezado_factura ;
delete paquetes
delete reservacion ;
select * from paquetes

create table prueba (
icod int,
name varchar(20)
);

insert into prueba values(0,'a'),(1,'b'),(2,'c')

insert into p2 select *,'h' from prueba
insert into p2(icod,name) select icod,(1+11) from prueba where icod =1

select * from p2
select * from prueba 

delete from p2

create table p2(
icod int,
name varchar(20),
apel varchar(20)
);
*/











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
*/