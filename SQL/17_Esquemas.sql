/*
Un esquema en SQL Server es un contenedor lógico que agrupa objetos de la base de datos,
como tablas, vistas, procedimientos almacenados, etc. Los esquemas ayudan a organizar estos objetos
y a gestionar los permisos de manera más eficiente. Cada base de datos en SQL Server tiene un esquema
predeterminado llamado dbo (database owner).

Ventajas de Usar Esquemas
- Organización: Ayudan a agrupar objetos relacionados.
- Seguridad: Permiten asignar permisos a grupos de objetos.
- Nombres: Facilitan la gestión de nombres de objetos, evitando conflictos.
- Desarrollo y Mantenimiento: Simplifican la separación de objetos de diferentes módulos o proyectos.
*/

--Crear un Esquema:
    -- Crear un esquema llamado 'ventas'
    CREATE SCHEMA ventas;

    --Crear un Usuario Asociado a un Esquema:
        --cualquier objeto que el usuario cree por defecto pertenecerá a ese esquema, a menos que se especifique otro esquema.
        -- Crear un usuario y asignarle un esquema predeterminado
        USE NombreDeTuBaseDeDatos;
        GO

        CREATE USER usuarioVentas FOR LOGIN miLogin
        WITH DEFAULT_SCHEMA = ventas;

    --Asignar Permisos en el Esquema:
        -- Otorgar permisos de SELECT e INSERT en el esquema 'ventas' al usuario
        GRANT SELECT, INSERT ON SCHEMA::ventas TO usuarioVentas;


--Ejemplo Detallado de Todo el Proceso:
    -- Crear un esquema llamado 'ventas'
    CREATE SCHEMA ventas;
    GO

    -- Crear un inicio de sesión
    CREATE LOGIN miLoginVentas WITH PASSWORD = 'ContraseñaSegura';
    GO

    -- Usar la base de datos donde se creará el usuario
    USE NombreDeTuBaseDeDatos;
    GO

    -- Crear un usuario asociado al inicio de sesión y asignarle el esquema predeterminado 'ventas'
    CREATE USER usuarioVentas FOR LOGIN miLoginVentas
    WITH DEFAULT_SCHEMA = ventas;
    GO

    -- Crear una tabla en el esquema 'ventas'
    CREATE TABLE ventas.Productos (
        Id INT PRIMARY KEY,
        Nombre NVARCHAR(100),
        Precio DECIMAL(10, 2)
    );
    GO

    -- Otorgar permisos de SELECT, INSERT, UPDATE y DELETE en el esquema 'ventas' al usuario 'usuarioVentas'
    GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA::ventas TO usuarioVentas;
    GO
