use master;
drop database if exists Empresa;
create database Empresa;

use Empresa

create table alojamiento(
	numero int not null,
	tipo_alojamiento int not null,
	num_ocupantes int not null,
	descripcion varchar(400),
	primary key (numero)
);

create table tipo_alojamiento(
	id int identity(1,1) not null,
	nombre varchar(50) not null,
	primary key (id)
);

create table reserva(
	id int identity(1,1) not null,
	fecha_entrada date not null,
	fecha_salida date not null,
	comentarios varchar(100),
	estado int not null,
	coste int not null,
	tipo_pago varchar(10) not null,
	pagado bit not null,
	num_personas int not null
	primary key (id)
);

create table reserva_estado(
	id int identity(1,1) not null,
	nombre varchar(100) not null,
	primary key (id)
);

create table alojamiento_reserva(
	id_reserva int not null,
	id_alojamiento int not null
);

create table cuenta_bancaria(
	id int identity(1,1) not null,
	numero char(22) not null,
	cantidad_importada int,
	cantidad_exportada int
	primary key (id)
);

create table cliente(
	id int identity(1,1) not null,
	dni char(9) not null,
	nombre varchar(100) not null,
	apellidos varchar(100),
	nr_reservas int,
	cuenta_bancaria int
	primary key (id)
);

create table reservas_cliente(
	id_cliente int not null,
	id_reserva int not null
);

create table trabajador(
	id int identity(1,1) not null,
	dni char(9) not null,
	nombre varchar(100) not null,
	apellidos varchar(100),
	cuenta_bancaria int not null,
	puesto int not null
	primary key (id)
);

create table municipio (
	id int identity(1,1) not null,
	nombre varchar(100) not null,
	ciudad varchar(100) not null,
	provincia varchar(100) not null,
	comunidad_autonoma varchar(100)
	primary key (id)
);

create table domicilio(
	id int identity(1,1) not null,
	codigo_postal char(5) not null,
	calle varchar(100) not null,
	numero int not null,
	puerta varchar(100),
	municipio int not null
	primary key (id)
);

create table cliente_domicilio(
	id_cliente int not null,
	id_domicilio int not null,
);

create table plan_ (
	id int identity(1,1) not null,
	nombre varchar(100) not null,
	descripcion varchar(100),
	min_personas int,
	max_personas int,
	primary key (id)
);

create table servicio (
	id int identity(1,1) not null,
	nombre varchar(100) not null,
	descripcion varchar(100),
	horar_inicio time,
	horar_fin time,
	primary key (id)
);

create table plan_servicio(
	id_servicio int not null,
	id_plan int not null,
);

create table reserva_plan(
	id_reserva int not null,
	id_plan int not null
);

create table puesto_trabajo(
	id int identity(1,1) not null,
	nombre varchar(100) not null,
	salario int,
	descripcion varchar(200),
	primary key (id)
);

create table productos(
	id int identity(1,1) not null,
	nombre varchar(50),
	coste int,
	stock int,
	primary key (id)
);


alter table alojamiento add foreign key (tipo_alojamiento) references tipo_alojamiento(id);
alter table reserva add foreign key (estado) references reserva_estado(id);  
alter table alojamiento_reserva add foreign key (id_alojamiento) references alojamiento(numero);  
alter table alojamiento_reserva add foreign key (id_reserva) references reserva(id); 
alter table cliente add foreign key (cuenta_bancaria) references cuenta_bancaria(id); 
alter table trabajador add foreign key (cuenta_bancaria) references cuenta_bancaria(id); 
alter table trabajador add foreign key (puesto) references puesto_trabajo(id); 
alter table reservas_cliente add foreign key (id_cliente) references cliente(id);  
alter table reservas_cliente add foreign key (id_reserva) references reserva(id);
alter table domicilio add foreign key (municipio) references municipio(id);
alter table cliente_domicilio add foreign key (id_cliente) references cliente(id);  
alter table cliente_domicilio add foreign key (id_domicilio) references domicilio(id);
alter table plan_servicio add foreign key (id_plan) references plan_(id);  
alter table plan_servicio add foreign key (id_servicio) references servicio(id);
alter table reserva_plan add foreign key (id_plan) references plan_(id);  
alter table reserva_plan add foreign key (id_reserva) references reserva(id);


use Empresa;
GO
create login AdminLogin with password = 'test';
create user administrador for login AdminLogin with default_schema = Empresa;
create login DirectorLogin with password = 'test';
create user director for login DirectorLogin with default_schema = Empresa;
create login Empleado1Login with password = 'test';
create user empleado1 for login Empleado1Login with default_schema = Empresa;
create login Empleado2Login with password = 'test';
create user empleado2 for login Empleado2Login with default_schema = Empresa;
create login Empleado3Login with password = 'test';
create user empleado3 for login Empleado3Login with default_schema = Empresa;
create login Empleado4Login with password = 'test';
create user empleado4 for login Empleado4Login with default_schema = Empresa;
create login Empleado5Login with password = 'test';
create user empleado5 for login Empleado5Login with default_schema = Empresa;
create login clienteLogin  with password = 'test';
create user cliente1 for login clienteLogin with default_schema = Empresa;

use Empresa;
GO
create role empleado;
create role clientes;
create role mantenimiento;
create role contabilidad;
create role marketing;
create role rrhh;
create role back_end;

-- añadir los usuarios a sus roles corespondientes

use Empresa;
GO
alter role empleado add member empleado1;
alter role empleado add member empleado2;
alter role empleado add member empleado3;
alter role empleado add member empleado4;
alter role empleado add member empleado5;
alter role clientes add member cliente1;
alter role mantenimiento add member  empleado1;
alter role contabilidad add member  empleado2;
alter role marketing add member  empleado3;
alter role rrhh add member  empleado4;
alter role back_end add member  empleado5;

-- asignar permisos

use master;
GO
alter server role sysadmin add member AdminLogin;
alter server role sysadmin add member DirectorLogin;

use Empresa;
GO
grant select, update, insert on trabajador to rrhh;
grant select, update, insert on puesto_trabajo to rrhh;
grant select on cuenta_bancaria to contabilidad;
grant select on cliente to contabilidad;
grant select, update, insert on database :: Empresa to mantenimiento;
grant select, insert on reserva to back_end;
grant select on plan_ to back_end;
grant select on reserva_plan to back_end;
grant select on plan_servicio to back_end;
grant select on servicio to back_end;
grant select on cliente to marketing;
grant select on cliente_domicilio to marketing;
grant select on domicilio to marketing;
grant select on municipio to marketing;
grant select on plan_ to marketing;
grant select on reserva to empleado;

-- crear vista para los clientes
GO

create view ReservasCliente as
select  r.*
from reserva r
join reservas_cliente rc on r.id = rc.id_reserva
where rc.id_cliente = '123456789';
GO

grant select on ReservasCliente to cliente1;

-- insertar informacion

insert into tipo_alojamiento (nombre)
values ('Bungaló');
insert into tipo_alojamiento (nombre)
values ('Parzela');
insert into tipo_alojamiento (nombre)
values ('Dormitorio Compartido');
insert into tipo_alojamiento (nombre)
values ('Area camping');

insert into alojamiento (numero, tipo_alojamiento, num_ocupantes, descripcion)
values (1, (select top 1 id from tipo_alojamiento order by RAND()), 2, 'Habitación doble con vista al mar');
insert into alojamiento (numero, tipo_alojamiento, num_ocupantes, descripcion)
values (2, (select top 1 id from tipo_alojamiento order by RAND()), 4, 'Habitación familiar');
insert into alojamiento (numero, tipo_alojamiento, num_ocupantes, descripcion)
values (3, (select top 1 id from tipo_alojamiento order by RAND()), 8, 'Habitación XXL para vacaciones en grupo');

insert into reserva_estado (nombre)
values ('Confirmada');
insert into reserva_estado (nombre)
values ('Cancelado');
insert into reserva_estado (nombre)
values ('Pendiente');

insert into reserva (fecha_entrada, fecha_salida, comentarios, estado, coste, tipo_pago, pagado, num_personas)
values ('2024-01-10', '2024-01-15', 'Vacaciones familiares', (select top 1 id from reserva_estado order by RAND()), 500, 'Tarjeta', 1, 2);
insert into reserva (fecha_entrada, fecha_salida, comentarios, estado, coste, tipo_pago, pagado, num_personas)
values ('2024-01-10', '2024-01-15', 'Persona con discapacidad de movilidad', (select top 1 id from reserva_estado order by RAND()), 500, 'Tarjeta', 1, 2);

insert into alojamiento_reserva (id_reserva, id_alojamiento)
values ((select top 1 id from reserva order by RAND()), (select top 1 numero from alojamiento order by RAND()));
insert into alojamiento_reserva (id_reserva, id_alojamiento)
values ((select top 1 id from reserva order by RAND()), (select top 1 numero from alojamiento order by RAND()));
insert into alojamiento_reserva (id_reserva, id_alojamiento)
values ((select top 1 id from reserva order by RAND()), (select top 1 numero from alojamiento order by RAND()));


insert into cuenta_bancaria (numero, cantidad_importada, cantidad_exportada)
values ('ES12345678901234567890', 1000, 500);
insert into cuenta_bancaria (numero, cantidad_importada, cantidad_exportada)
values ('ES12345678901234567891', 21, 0);
insert into cuenta_bancaria (numero, cantidad_importada, cantidad_exportada)
values ('ES12345678901234567892', 300, 90);


insert into cliente (dni, nombre, apellidos, nr_reservas, cuenta_bancaria)
values ('123456789', 'Juan', 'Pérez', 1, (select top 1 id from cuenta_bancaria order by RAND()));
insert into cliente (dni, nombre, apellidos, nr_reservas, cuenta_bancaria)
values ('123356789', 'Aina', 'Muñoz', 3, (select top 1 id from cuenta_bancaria order by RAND()));


insert into reservas_cliente (id_cliente, id_reserva)
values ((select top 1 id from cliente order by RAND()), (select top 1 id from reserva order by RAND()));
insert into reservas_cliente (id_cliente, id_reserva)
values ((select top 1 id from cliente order by RAND()), (select top 1 id from reserva order by RAND()));

insert into puesto_trabajo (nombre, salario, descripcion)
values ('Recepcionista', 2000, 'Atención al cliente');
insert into puesto_trabajo (nombre, salario, descripcion)
values ('Camarero', 2000, 'Atender al bar');
insert into puesto_trabajo (nombre, salario)
values ('Cocinero', 2000);

insert into trabajador (dni, nombre, apellidos, cuenta_bancaria, puesto)
values ('987654321', 'Ana', 'Gómez', (select top 1 id from cuenta_bancaria order by RAND()), (select top 1 id from puesto_trabajo order by RAND()));


insert into municipio (nombre, ciudad, provincia, comunidad_autonoma)
values ('Ciudad Ficticia', 'Ficticiaville', 'Ficticia', 'Fictonia');


insert into domicilio (codigo_postal, calle, numero, puerta, municipio)
values ('12345', 'Calle Falsa', 123, 'A', (select top 1 id from municipio order by RAND()));


insert into cliente_domicilio (id_cliente, id_domicilio)
values ((select top 1 id from cliente order by RAND()), (select top 1 id from domicilio order by RAND()));
insert into cliente_domicilio (id_cliente, id_domicilio)
values ((select top 1 id from cliente order by RAND()), (select top 1 id from domicilio order by RAND()));


insert into plan_ (nombre, descripcion, min_personas, max_personas)
values ('Plan Vacacional', 'Incluye alojamiento y desayuno', 2, 4);
insert into plan_ (nombre, descripcion, min_personas, max_personas)
values ('Plan Familiar', 'Descuento por el número de familiares', 4, 10);
insert into plan_ (nombre, min_personas, max_personas)
values ('Plan VIP', 3, 5);


insert into servicio (nombre, descripcion)
values ('Wi-Fi', 'Conexión a Internet');
insert into servicio (nombre, descripcion, horar_inicio, horar_fin)
values ('Room Service', 'Puedes pedir cualquier cosa a nuestros trabajadores durante el horario establecido', '08:00:00', '22:00:00');


insert into plan_servicio (id_servicio, id_plan)
values ((select top 1 id from servicio order by RAND()), (select top 1 id from plan_ order by RAND()));


insert into reserva_plan (id_reserva, id_plan)
values ((select top 1 id from reserva order by RAND()), (select top 1 id from plan_ order by RAND()));

insert into productos (nombre, coste, stock)
values ('Toallas', 10, 100);
insert into productos (nombre, coste, stock)
values ('Frutos secos', 10, 100);
insert into productos (nombre, coste, stock)
values ('Mochila camping', 10, 100);