
--Las tablas tipo numero, cambiarlas de integer a longint/bigint ya que
--no cabe un numero real

create database Ejersicio3;
\c ejersicio3

--------------------------------Creacion de tablas ---------------------------------

create table Hoteles(
 cod_est  SERIAL,
 nombre   varchar(45) not null,
 apellido varchar(40) not null,
 ciudad   varchar(45) not null,
 id_usuario integer not null,
 --Tipo de usuario
 --1= premiun
 --2= constante
 --3= esporadico
 Telefono integer,
 FK_est  integer not null
 );



create table Estancias(
 id_codigEstanci SERIAL,
 Pension varchar(45) null,
 fechaEnt Date not null,
 Hotel_codig integer not null,
 FK_codigEstaci integer not null
 );

create table Viaje_Contratados(
 id_codig SERIAL,
 turista_codig integer not null,
 sucursal integer not null,
 Vuelo_Cod integer NOT NULL,
 FK_codig integer not null
 );

create table Vuelos(
  numV      SERIAL,
  fechaV    DATE    null,
  Horav     int    null,
  Destin    varchar(45) null,
  plaza     integer
  );

 create table Vuelo_Turista(
  id_vuelo SERIAL,
  clase integer not null,
  Precio integer not null,
  N_vuel integer not null,
  viajeCont integer not null

  );

 create table Turista(
  rut_coord SERIAL,
  nombre varchar(45) not null,
  apellido varchar(45) not null,
  Direccion varchar (80) null,
  telefono varchar(10) null
  );


  create table sucursales(
   CodSucursal SERIAL,
   DireccionSucursal varchar(45) null,
   telefonoSucursal varchar(10) null
   );

--------------------------------Creacion de llaves primarias---------------------------------
 alter table Vuelos add constraint ps_Vuelos primary key(numV);
 alter table Hoteles add constraint PS_Hoteles primary key(cod_est);
 alter table Vuelo_Turista add constraint PS_Vuelo_Turista primary key(id_vuelo);
 alter table Viaje_Contratados add constraint ps_Viaje_Contratados primary key(id_codig);
 alter table Estancias add constraint ps_Estancias primary key(id_codigEstanci);
 alter table Turista add constraint ps_secretarios primary key(rut_coord);
 alter table sucursales add constraint ps_Sucursal primary key(CodSucursal);
--------------------------------Creacion de llaves Foraneas---------------------------------
 alter table Estancias add constraint FKH foreign key (FK_codigEstaci)references Hoteles(cod_est);
 alter table Viaje_Contratados add constraint FKVC foreign key (FK_codig)references Estancias(id_codigEstanci);
 alter table Viaje_Contratados add constraint FKVCS foreign key (sucursal)references sucursales(CodSucursal);
 alter table Viaje_Contratados add constraint FKVCT foreign key (turista_codig)references Turista(rut_coord);
 alter table Viaje_Contratados add constraint FKVV foreign key (Vuelo_Cod)references Vuelo_Turista(id_vuelo);
 alter table Vuelo_Turista add constraint FKVVT foreign key (N_vuel)references Vuelos(numV);

-------------------------------------------Registrar Datos Hotel-------------------------------------
insert into Hoteles(id_usuario,nombre,apellido,ciudad,telefono,FK_est)
values (1,'juan','ramirez','cartagena',514,7);
insert into Hoteles(id_usuario,nombre,apellido,ciudad,telefono,FK_est)
values (1,'jesusP','rivera','cartagena',5144,6);
insert into Hoteles(id_usuario,nombre,apellido,ciudad,telefono,FK_est)
values (1,'Julian','castro','cartagena',5134,5);
insert into Hoteles(id_usuario,nombre,apellido,ciudad,telefono,FK_est)
values (1,'liseth','paternina','cartagena',30147,1);
insert into Hoteles(id_usuario,nombre,apellido,ciudad,telefono,FK_est)
values (2,'yiseth','buenavides','cartagena',301479,1);
insert into Hoteles(id_usuario,nombre,apellido,ciudad,telefono,FK_est)
values (2,'maria','antonieta','bogota',3014795,5);
insert into Hoteles(id_usuario,nombre,apellido,ciudad,telefono,FK_est)
values (2,'Samanthas','Primera','cundinamarca',30147951,5);
insert into Hoteles(id_usuario,nombre,apellido,ciudad,telefono,FK_est)
values (3,'Natalia','loli','panama',301479516,5);
insert into Hoteles(id_usuario,nombre,apellido,ciudad,telefono,FK_est)
values (1,'cuchupla','mama','valle',301479167,5);
-------------------------------------------Registrar Datos Vuelos-------------------------------------

insert into Vuelos(Destin) values('Bogota');
insert into Vuelos(Destin) values('panama');
insert into Vuelos(Destin) values('armenia');
------------------------------------------Registrar Datos Vuelos_turista-------------------------------------

insert into Vuelo_turista(clase,precio,N_vuel,viajeCont)
values (1,250000,1,1);
insert into Vuelo_turista(clase,precio,N_vuel,viajeCont)
values (1,250000,1,2);
insert into Vuelo_turista(clase,precio,N_vuel,viajeCont)
values (2,10000,1,2);

----------------------VISTAS---------------------
Create view Premiun AS
  select id_usuario,nombre,apellido
  FROM Hoteles
  WHERE id_usuario=1;

Create view cartagena AS
  select ciudad,nombre,apellido
  FROM Hoteles
  WHERE ciudad='cartagena';

Create view Extrangeros AS
  select ciudad,nombre,apellido
  FROM Hoteles
  WHERE ciudad!='cartagena';
  ------------------------Subconsulta--------------------------------------------
  select nombre as Cartageneros from hoteles where ciudad = 'cartagena' ;

--------------------------------Ver Vista-----------------
select * FROM  Hoteles;
SELECT * FROM  Premiun;
SELECT * FROM  cartagena;
SELECT * FROM  Extrangeros;

-------------------------------Mostrar tablas con valores nulos---------------------------
select * from hoteles where apellido is null;
select * from hoteles where apellido is null and ciudad is null;
---------------Eliminar una vista---------------------------
DROP VIEW if EXISTS Premiun;
------------------------------TRASACCIONES SQL-------------------------
------------------------------Crear los indices-------------------------
Create INDEX Gastos_turistas on Vuelo_turista(viajeCont);
------------------------------inicio de la TRASACCION------------------
BEGIN;
insert into Vuelo_turista(clase,Precio,N_vuel,viajeCont) values (3,15000,2,7);
select * from Vuelo_turista;
----Cancelar la TRANSACCION----
ROLLBACK;
----Ejecutar cambios------
commit;


----------------------------------Join---------------------------------
select * from Cartagena A join hoteles B on A.nombre = B.nombre;
select * from Cartagena A LEFT  JOIN hoteles B on A.nombre = B.nombre;
select * from Cartagena A FULL OUTER Join  hoteles B on A.nombre = B.nombre;
