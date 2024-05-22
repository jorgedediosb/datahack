--Creando un Login de SQL
----Login me da acceso al servidor
Use master
go
Create login SystemUser with password='P@ssw0rd'
go

--Creando un user para el login informatica en la BD Northwind
--Además lo agrego al esquema informatica
Use Northwind
go
Create user SystemUser for login SystemUser 
with default_schema =Informatica
go
--Agregando el esquema informatica
Create schema Informatica authorization SystemUser
go
--Dar permisos de manera individual
Grant create table to SystemUser
Grant select to SystemUser
--Denegar permiso
Deny create table to SystemUser
Deny select to SystemUser
--Revocar un permiso
Revoke create table to SystemUser
Revoke select to SystemUser
----Para el login yo tengo roles de servidor
Exec sp_addsrvrolemember 'SystemUser ', 'Sysadmin' 
go
Exec sp_dropsrvrolemember 'SystemUser ', 'Sysadmin' 
go

--Para agregar al user a un rol de base de datos
Exec sp_addrolemember 'db_datareader' , 'SystemUser'
Exec sp_addrolemember 'db_datawriter' , 'SystemUser'
go

--Habilitar al Invitado
GRANT CONNECT TO guest
--Deshabilitar al invitado
Revoke CONNECT TO guest

--Ejecutar una instruccion en nombre de SysteUser sin salir del usuario actual
execute as user='SystemUser'
Create table Test
(Codigo int not null primary key,
nombre varchar(150)
)
revert