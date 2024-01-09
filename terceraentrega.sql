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
	nombre int not null,
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
	numero char(20) not null,
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
create user cliente for login clienteLogin with default_schema = Empresa;

use Empresa;
GO
create role administracio;
use Empresa;
GO
create role empleado;
use Empresa;
GO
create role clientes;
use Empresa;
GO
create role mantenimiento;
use Empresa;
GO
create role contabilidad;
use Empresa;
GO
create role marketing;
use Empresa;
GO
create role rrhh;
use Empresa;
GO
create role soporte;
use Empresa;
GO
create role direccion;


alter role administracio add member administrador;
alter role empleado add member empleado1;
alter role empleado add member empleado2;
alter role empleado add member empleado3;
alter role empleado add member empleado4;
alter role empleado add member empleado5;
alter role clientes add member cliente;
alter role mantenimiento add member  empleado1;
alter role contabilidad add member  empleado2;
alter role marketing add member  empleado3;
alter role rrhh add member  empleado4;
alter role soporte add member  empleado5;
alter role direccion add member  director;

