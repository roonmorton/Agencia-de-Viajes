
/*

use master

drop database agencia_viajes_condor;

*/

go
create database agencia_viajes_condor;
go

go
use agencia_viajes_condor;
go


go 
create table linea_aerea(
codigo int identity(1,1) not null primary key, 
identificador varchar(10),
descripcion varchar(200)
);

go



go
create table destino(
codigo int identity(1,1) not null primary key,
pais varchar(25),
departamento varchar(60)
);
go



go
create table usuario(
codigo int identity(1,1) not null primary key,
nombres varchar(45),
apellidos varchar(45),
dpi varchar(13),
direccion varchar(50),
telefono varchar(12),
username varchar(30),
pass varchar(30),
tipo int
);
go

go
create table cliente(
codigo int identity(1,1) not null primary key,
nombres varchar(45),
apellidos varchar(45),
email varchar(30),
dpi varchar(13),
direccion varchar(50),
telefono varchar(12),
fecha_nacimiento date,
nit varchar(20)
);
go


go
create table item(
codigo int identity(1,1) not null primary key,
descripcion varchar(500),
precio float
);
go





-- Cruceros
go
create table puerto
(
codigo int identity(1,1) primary key,
descripcion varchar(40),
codigo_destino int,
foreign key(codigo_destino) references destino(codigo)
);
go

go
create table crucero(
codigo int identity(1,1) primary key,
descripcion varchar(100),
pasajeros int,
reservados int,
fecha_salida date,
precio float,
codigo_puerto int,
foreign key(codigo_puerto) references puerto(codigo)
);
go




-- Hoteles 


create table hotel(
codigo int identity(1,1) primary key,
descripcion varchar(100),
habitaciones int,
habitaciones_simple int,
habitaciones_doble int,
codigo_destino int,
precio float,
direccion varchar(40),
foreign key(codigo_destino) references destino(codigo)
);


-- Tablas para Vuelos

go
create table avion(
codigo int identity(1,1) not null primary key,
no_asientos int,
codigo_linea int,
foreign key (codigo_linea) references linea_aerea(codigo)
);

go


go
create table aeropuerto(
codigo int identity(1,1) primary key,
descripcion varchar(200),
codigo_destino int,
foreign key(codigo_destino) references destino(codigo)
);
go



go
create table vuelo(
codigo int identity(1,1) not null primary key,
fecha_salida date,
pasajeros_economico int,
pasajeros_primera int,
codigo_avion int,
codigo_aeropuerto int,
precio float,
foreign key(codigo_avion) references avion(codigo),
foreign key(codigo_aeropuerto) references aeropuerto(codigo)
);
go


go
create table escala(
codigo_vuelo int,
codigo_aeropuerto int,
foreign key(codigo_vuelo) references vuelo(codigo),
foreign key(codigo_aeropuerto) references aeropuerto(codigo)
);
go




-- Reseravacion 

go
create table reservacion(
codigo int identity(1,1) primary key,
tipo int,
codigo_usuario int,
codigo_vuelo int,
codigo_crucero int,
codigo_destino int,
codigo_hotel int,
personas int,
no_asiento int,
foreign key(codigo_usuario) references usuario(codigo),
foreign key(codigo_vuelo) references vuelo(codigo),
foreign key(codigo_destino) references destino(codigo),
foreign key(codigo_crucero) references crucero(codigo),
foreign key(codigo_hotel) references hotel(codigo)
);
go



-- Factura
go
create table encabezado_factura(
codigo int identity(1,1) primary key,
fecha date,
numero varchar(20),
tipo_pago int,
efectivo float,
credito float,
debito float,
total float,
codigo_reservacion int,
codigo_cliente int,
foreign key(codigo_reservacion) references reservacion(codigo),
foreign key(codigo_cliente) references cliente(codigo)
);
go

go
create table detalle_factura(
codigo_factura int,
codigo_item int,
cantidad int,
sub_total int,
foreign key(codigo_factura) references encabezado_factura(codigo),
foreign key(codigo_item) references item(codigo)
);
go

go
create table paquetes
(
codigo_reservacion int,
codigo_item int,
precio float,
cantidad int,
foreign key(codigo_reservacion) references reservacion(codigo),
foreign key(codigo_item) references item(codigo)
);
go



