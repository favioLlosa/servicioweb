use bdtiendita
go

create table producto(
codpro int primary key identity(1,1),
nompro varchar(60)not null,
despro varchar(500)not null,
prepro money not null,
canpro decimal not null,
estpro bit not null,
codcat  int,
foreign key(codcat)references categoria(codcat)
)
go

insert into producto values(
'Coca Cola 3Lt','Botella no retornable de plastico de 3 litro',11,20,1,1
)
insert into producto values('Sublime de 120gr','Chocolate Subline de 120gr con mani',2.5,40,1,2)
insert into producto values('Arroz Costeno','Arroz Costeno premiun',5.3,18,1,3)
insert into producto values('Aceite Primor','Aceite Primor Premiun',7.5,30,2,3)
insert into producto values('Piqueo Snax','Piqueo Snax',7.5,30,2,3)
go

select*from producto

CREATE PROC	SP_MostrarProducto
as
begin
select * from producto where estpro = 1;
end
go
exec SP_MostrarProducto


CREATE PROC	SP_MostrarProductoTodo
as
begin
select * from producto;
end
go
exec SP_MostrarProductoTodo

CREATE PROC	SP_RegistrarProducto
@nombre varchar(60),
@descripcion varchar(500),
@precio money,
@cantidad decimal,
@estado bit,
@codcat int
as
begin
begin tran SP_RegistrarProducto
begin try
insert into producto values(@nombre,@descripcion,@precio,@cantidad,@estado,@codcat)
commit tran SP_RegistrarProducto
end try
begin catch
	rollback tran SP_RegistrarProducto
end catch
end
go
 
EXEC SP_RegistrarProducto

--REGISTRO
EXEC SP_RegistrarProducto 
    @nombre = 'Mantequilla',
    @descripcion = 'Rica y deliciosa',
    @precio = 10.99,
    @cantidad = 100,
    @estado = 1, 
    @codcat = 1; 

CREATE PROC	SP_ActualizarProdcuto
@codigo int,
@nombre varchar(60),
@descripcion varchar(500),
@precio money,
@cantidad decimal,
@estado bit,
@codcat int
as
begin
begin tran SP_ActualizarProducto
begin try
update producto set  nompro=@nombre, despro=@descripcion, prepro=@precio,
canpro=@cantidad,estpro=@estado,codcat=@codcat where codpro=@codigo
commit tran SP_ActualizarProducto
end try
begin catch
	rollback tran SP_ActualizarProducto
end catch
end
go

-- UPDATE
DECLARE @codigoProducto int = 4; 
DECLARE @NewNombre varchar(60) = 'Mantequilla de calidad';
DECLARE @NewDescripcion varchar(500) = 'La mejor mantequilla del mercado';
DECLARE @NewPrecio decimal = 12.99;
DECLARE @NewCantidad decimal = 150;
DECLARE @NewEstado bit = 1; 
DECLARE @NewCodCat int = 2; 

EXEC SP_ActualizarProdcuto 
    @codigo = @codigoProducto,
    @nombre = @NewNombre,
    @descripcion = @NewDescripcion,
    @precio = @NewPrecio,
    @cantidad = @NewCantidad,
    @estado = @NewEstado,
    @codcat = @NewCodCat;

CREATE PROC	SP_EliminarProducto
@codigo int
as
begin
begin tran SP_EliminarProducto
begin try
update Producto set estpro=0 where codpro=@codigo
commit tran SP_EliminarProducto
end try
begin catch
	rollback tran SP_EliminarProducto
end catch
end
go

--ELIMINAR UN PRODUCTO
DECLARE @codigoProducto int = 4; 

EXEC SP_EliminarProducto
    @codigo = @codigoProducto;