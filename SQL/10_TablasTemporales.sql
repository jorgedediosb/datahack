/*
Las tablas temporales en SQL son tablas especiales que se almacenan en la base de datos temporal del servidor
y se eliminan automáticamente al finalizar la sesión del usuario o la conexión que las creó.
Se utilizan para almacenar datos temporales que solo se necesitan durante la duración de una sesión
o transacción.

Tipos de Tablas Temporales
Hay dos tipos principales de tablas temporales en SQL:

Tablas Temporales Locales:
- Se crean con un solo signo de número (#) antes del nombre de la tabla.
- Son visibles solo para la sesión que las creó.
- Se eliminan automáticamente cuando la sesión se cierra.
*/

CREATE TABLE #TablaTemporalLocal (
    id INT,
    nombre NVARCHAR(100)
);

/*
Tablas Temporales Globales:
- Se crean con dos signos de número (##) antes del nombre de la tabla.
- Son visibles para todas las sesiones y conexiones.
- Se eliminan cuando todas las sesiones que las están usando se cierran.
*/
CREATE TABLE ##TablaTemporalGlobal (
    id INT,
    nombre NVARCHAR(100)
);

/*
Ventajas de Usar Tablas Temporales
- Facilitar la Manipulación de Datos: Permiten almacenar datos intermedios durante el procesamiento de consultas complejas.
- Mejorar el Rendimiento: Reducen la carga en la base de datos principal al realizar operaciones de gran volumen de datos en una tabla temporal.
- Aislamiento de Datos: Permiten mantener los datos temporales aislados de las tablas permanentes, evitando así conflictos y contaminaciones.
*/

--Ejemplo 1: Crear y Usar una Tabla Temporal Local
-- Crear una tabla temporal local
CREATE TABLE #EmpleadosTemporales (
    empleado_id INT,
    nombre NVARCHAR(100),
    salario DECIMAL(10, 2)
);

-- Insertar datos en la tabla temporal
INSERT INTO #EmpleadosTemporales (empleado_id, nombre, salario)
VALUES (1, 'Juan Pérez', 50000.00),
       (2, 'Ana Gómez', 55000.00);

-- Seleccionar datos de la tabla temporal
SELECT * FROM #EmpleadosTemporales;

-- La tabla se elimina automáticamente al finalizar la sesión


--Ejemplo 2: Usar una Tabla Temporal Local en un Procedimiento Almacenado
CREATE PROCEDURE ObtenerSalariosAltos
AS
BEGIN
    -- Crear una tabla temporal local
    CREATE TABLE #SalariosAltos (
        empleado_id INT,
        nombre NVARCHAR(100),
        salario DECIMAL(10, 2)
    );

    -- Insertar datos en la tabla temporal
    INSERT INTO #SalariosAltos (empleado_id, nombre, salario)
    SELECT empleado_id, nombre, salario
    FROM empleados
    WHERE salario > 60000;

    -- Seleccionar datos de la tabla temporal
    SELECT * FROM #SalariosAltos;

    -- La tabla se elimina automáticamente al finalizar el procedimiento
END;
GO

-- Ejecutar el procedimiento almacenado
EXEC ObtenerSalariosAltos;


--Ejemplo 3: Crear y Usar una Tabla Temporal Global
-- Crear una tabla temporal global
CREATE TABLE ##ProductosTemporales (
    producto_id INT,
    nombre NVARCHAR(100),
    precio DECIMAL(10, 2)
);

-- Insertar datos en la tabla temporal
INSERT INTO ##ProductosTemporales (producto_id, nombre, precio)
VALUES (1, 'Producto A', 10.00),
       (2, 'Producto B', 15.00);

-- Seleccionar datos de la tabla temporal desde otra sesión
SELECT * FROM ##ProductosTemporales;

-- La tabla se elimina automáticamente cuando todas las sesiones que la están usando se cierran


/*
Consideraciones al Usar Tablas Temporales
- Duración y Visibilidad: Las tablas temporales locales solo son visibles en la sesión que las creó y se eliminan cuando la sesión termina. Las tablas temporales globales son visibles para todas las sesiones y se eliminan cuando todas las sesiones que las usan terminan.
- Espacio en Disco: Las tablas temporales se crean en la base de datos temporal (tempdb), por lo que un uso excesivo puede afectar el rendimiento del sistema.
- Índices y Restricciones: Puedes crear índices y restricciones en tablas temporales igual que en tablas permanentes, pero estos índices y restricciones también son temporales.
*/

