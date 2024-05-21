/*
Una vista en SQL es una consulta predefinida almacenada en la base de datos que permite a los usuarios ver y, en algunos casos, modificar datos de una o más tablas de manera simplificada. Las vistas no almacenan datos por sí mismas; en su lugar, almacenan una definición de consulta que se ejecuta cada vez que se accede a la vista. Esto proporciona una capa de abstracción y seguridad, permitiendo a los usuarios interactuar con los datos sin acceder directamente a las tablas subyacentes.

Características de las Vistas:
- Abstracción de Datos: Permiten a los usuarios trabajar con un subconjunto de datos de una manera más simplificada y específica.
- Seguridad: Pueden restringir el acceso a datos sensibles, mostrando solo las columnas y filas necesarias para los usuarios.
- Simplicidad: Simplifican consultas complejas al encapsularlas en una vista, facilitando su uso.
- Reutilización: Pueden ser reutilizadas en múltiples consultas, mejorando la consistencia y reduciendo la duplicación de código.

Consideraciones al Usar Vistas:
- Rendimiento: Las vistas no almacenan datos; ejecutan la consulta subyacente cada vez que se accede a ellas. Para consultas muy complejas o grandes conjuntos de datos, esto puede impactar el rendimiento.
- Actualizaciones: No todas las vistas son actualizables. Una vista es actualizable si permite realizar INSERT, UPDATE y DELETE en las tablas subyacentes a través de la vista. Esto depende de la estructura de la consulta de la vista.
- Dependencias: Si se modifican las tablas subyacentes (por ejemplo, cambiando nombres de columnas o eliminando columnas), las vistas que dependen de esas tablas pueden romperse y necesitar ser actualizadas.
- Seguridad: Las vistas pueden restringir el acceso a ciertas columnas o filas, proporcionando una capa adicional de seguridad.
*/

-- Ejemplo 1: Creación de una Vista Simple:
-- Crear la tabla de empleados
CREATE TABLE empleados (
    empleado_id INT PRIMARY KEY,
    nombre NVARCHAR(100),
    puesto NVARCHAR(100),
    salario DECIMAL(10, 2),
    activo BIT
);

-- Insertar algunos datos
INSERT INTO empleados (empleado_id, nombre, puesto, salario, activo)
VALUES (1, 'Juan Pérez', 'Desarrollador', 50000.00, 1),
       (2, 'Ana Gómez', 'Analista', 55000.00, 0),
       (3, 'Carlos López', 'Gerente', 60000.00, 1);

-- Crear una vista que muestre solo los empleados activos
CREATE VIEW EmpleadosActivos AS
SELECT empleado_id, nombre, puesto, salario
FROM empleados
WHERE activo = 1;

-- Seleccionar datos de la vista
SELECT * FROM EmpleadosActivos;


-- Ejemplo 2: Vista con Joins:
-- Crear la tabla de departamentos
CREATE TABLE departamentos (
    departamento_id INT PRIMARY KEY,
    nombre NVARCHAR(100)
);

-- Insertar algunos datos en la tabla de departamentos
INSERT INTO departamentos (departamento_id, nombre)
VALUES (1, 'Desarrollo'),
       (2, 'Recursos Humanos');

-- Actualizar la tabla de empleados para incluir el ID del departamento
ALTER TABLE empleados ADD departamento_id INT;

-- Actualizar los datos de empleados para incluir los IDs de departamento
UPDATE empleados SET departamento_id = 1 WHERE empleado_id IN (1, 3);
UPDATE empleados SET departamento_id = 2 WHERE empleado_id = 2;

-- Crear una vista que una las tablas empleados y departamentos
CREATE VIEW EmpleadosConDepartamento AS
SELECT e.empleado_id, e.nombre, e.puesto, d.nombre AS departamento
FROM empleados e
JOIN departamentos d ON e.departamento_id = d.departamento_id;

-- Seleccionar datos de la vista
SELECT * FROM EmpleadosConDepartamento;


-- Modificar una Vista:
-- Modificar la vista EmpleadosActivos para incluir solo el nombre y el salario
ALTER VIEW EmpleadosActivos AS
SELECT nombre, salario
FROM empleados
WHERE activo = 1;


-- Eliminar una Vista:
DROP VIEW EmpleadosActivos;


/*
Resumen
Las vistas en SQL son herramientas poderosas que permiten a los usuarios trabajar con datos de manera más simplificada y segura.
Proporcionan una capa de abstracción que puede facilitar el manejo de datos complejos
y mejorar la seguridad al restringir el acceso a datos sensibles. Con una comprensión adecuada de su uso y limitaciones,
las vistas pueden ser una parte integral de una estrategia eficaz de gestión de bases de datos.
*/


