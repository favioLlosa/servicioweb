-- seleccionamos la BD
use bdtiendita
go 
-- procedimiento genero
-- Mostrar
IF EXISTS(SELECT * FROM sys.procedures WHERE NAME='SP_MostrarCategoria') 
DROP PROCEDURE SP_MostrarCategoria;  
go
CREATE PROC	SP_MostrarCategoria
as
begin
select * from categoria where estcat = 1;
end
go
exec SP_MostrarCategoria

-- Mostrar Todo
IF EXISTS(SELECT * FROM sys.procedures WHERE NAME='SP_MostrarCategoriaTodo') 
DROP PROCEDURE SP_MostrarCategoriaTodo;  
go
CREATE PROC	SP_MostrarCategoriaTodo
as
begin
select * from categoria;
end
go
exec SP_MostrarCategoriaTodo

-- Registrar
IF EXISTS(SELECT * FROM sys.procedures WHERE NAME='SP_RegistrarCategoria') 
DROP PROCEDURE SP_RegistrarCategoria;  
go
CREATE PROC	SP_RegistrarCategoria
@nombre varchar(60),
@estado bit
as
begin
begin tran SP_RegistrarCategoria
begin try
insert into categoria values(@nombre,@estado)
commit tran SP_RegistrarCategoria
end try
begin catch
	rollback tran SP_RegistrarCategoria
end catch
end
go

-- actualizar
IF EXISTS(SELECT * FROM sys.procedures WHERE NAME='SP_ActualizarCategoria') 
DROP PROCEDURE SP_ActualizarCategoria;  
go
CREATE PROC	SP_ActualizarCategoria
@codigo int,
@nombre varchar(60),
@estado bit
as
begin
begin tran SP_ActualizarCategoria
begin try
update categoria set  nomcat=@nombre, estcat=@estado where codcat=@codigo
commit tran SP_ActualizarCategoria
end try
begin catch
	rollback tran SP_ActualizarCategoria
end catch
end
go

-- eliminar
IF EXISTS(SELECT * FROM sys.procedures WHERE NAME='SP_EliminarCategoria') 
DROP PROCEDURE SP_EliminarCategoria;  
go
CREATE PROC	SP_EliminarCategoria
@codigo int
as
begin
begin tran SP_EliminarCategoria
begin try
update categoria set estcat=0 where codcat=@codigo
commit tran SP_EliminarCategoria
end try
begin catch
	rollback tran SP_EliminarCategoria
end catch
end
go

