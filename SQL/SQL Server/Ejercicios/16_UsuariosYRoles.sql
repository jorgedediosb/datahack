/*
En SQL Server, la creación de usuarios y roles es fundamental para la gestión de la seguridad
y el control de acceso a la base de datos. A continuación, se explica cómo crear usuarios y roles,
asignar permisos y gestionar estos elementos mediante scripts SQL.
*/

-- Crear un Usuario de Base de Datos Asociado a un Inicio de Sesión (Login)
-- 1. Crear un Inicio de Sesión (Login) en el Servidor SQL:

-- Crear un inicio de sesión con autenticación de SQL Server
CREATE LOGIN miLogin WITH PASSWORD = 'TuContraseñaSegura';

-- Crear un inicio de sesión con autenticación de Windows
CREATE LOGIN [DOMINIO\NombreUsuario] FROM WINDOWS;

-- 2. Crear un Usuario de Base de Datos Asociado al Inicio de Sesión:
USE NombreDeTuBaseDeDatos;
GO
CREATE USER miUsuario FOR LOGIN miLogin;


--Crear un Rol de Base de Datos:
USE NombreDeTuBaseDeDatos;
GO
CREATE ROLE miRol;

--Asignar Permisos a un Rol:
    USE NombreDeTuBaseDeDatos;
    GO

    -- Otorgar permisos de selección (SELECT) en una tabla específica
    GRANT SELECT ON NombreDeLaTabla TO miRol;

    -- Otorgar permisos de inserción (INSERT) en una tabla específica
    GRANT INSERT ON NombreDeLaTabla TO miRol;

    -- Otorgar permisos de actualización (UPDATE) en una tabla específica
    GRANT UPDATE ON NombreDeLaTabla TO miRol;

    -- Otorgar permisos de eliminación (DELETE) en una tabla específica
    GRANT DELETE ON NombreDeLaTabla TO miRol;

    -- Otorgar permisos de ejecución (EXECUTE) en procedimientos almacenados específicos
    GRANT EXECUTE ON NombreDelProcedimiento TO miRol;


--Ejemplo Completo
    -- Crear un inicio de sesión
    CREATE LOGIN miLogin WITH PASSWORD = 'TuContraseñaSegura';
    GO

    -- Crear una base de datos para el ejemplo
    CREATE DATABASE MiBaseDeDatosEjemplo;
    GO

    -- Usar la base de datos recién creada
    USE MiBaseDeDatosEjemplo;
    GO

    -- Crear un usuario en la base de datos para el inicio de sesión
    CREATE USER miUsuario FOR LOGIN miLogin;
    GO

    -- Crear un rol en la base de datos
    CREATE ROLE miRol;
    GO

    -- Asignar el usuario al rol
    EXEC sp_addrolemember 'miRol', 'miUsuario';
    GO

    -- Crear una tabla de ejemplo
    CREATE TABLE MiTablaEjemplo (
        Id INT PRIMARY KEY,
        Nombre NVARCHAR(50)
    );
    GO

    -- Otorgar permisos de SELECT e INSERT en la tabla al rol
    GRANT SELECT, INSERT ON MiTablaEjemplo TO miRol;
    GO

