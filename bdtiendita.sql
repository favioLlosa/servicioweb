-- cerrar todas las conexiones a la base de datos
use master
go
IF EXISTS(SELECT * from sys.databases WHERE name='bdtiendita')  
BEGIN 
alter database bdtiendita set single_user 
with rollback immediate
END 
go

-- buscamos si existe la base de datos
IF EXISTS(SELECT * from sys.databases WHERE name='bdtiendita')  
BEGIN 
	-- seleccionamos el master 
	use master
	--eliminamos la base de datos 
    drop DATABASE bdtiendita
END 
go

-- creando la base de datos
create database bdtiendita
go
--seleccionamos la base de datos
use bdtiendita
go
--creamos la tabla
-- continente
create table categoria(
codcat integer primary key identity(1,1),
nomcat varchar(60) not null,
estcat bit not null
)
go

-- insertando datos
-- categoria
insert into categoria values('bebidas',1)
insert into categoria values('golosinas',1)
insert into categoria values('abarrotes',1)
insert into categoria values('licor',0)
go

select * from categoria
go
