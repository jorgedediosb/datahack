--Los comandos básicos en SQL incluyen:

--1. CREATE: Utilizado para crear una nueva tabla en la base de datos:
CREATE TABLE table_name (
    column1 datatype,
    column2 datatype,
    ...
);
    -- Primary Key (Clave Primaria):
        CREATE TABLE empleados (
        id INT AUTO_INCREMENT PRIMARY KEY,
        nombre VARCHAR(100),
        departamento VARCHAR(100)
        );

    --Foreign Key (Clave Externa):
        CREATE TABLE ventas (
        id INT AUTO_INCREMENT PRIMARY KEY,
        cliente_id INT,
        total DECIMAL(10, 2),
        FOREIGN KEY (cliente_id) REFERENCES clientes(id)
        );

-- Creación de una función:
CREATE FUNCTION function_name (@name_function datatype)
RETURNS datatype
AS
BEGIN
    SET @name_function = @name_function * 5
    RETURN @name_function
END

--2. SELECT: Utilizado para recuperar datos de una o varias tablas:
SELECT column1, column2 FROM table_name;

--3. INSERT INTO: Utilizado para agregar nuevos registros a una tabla:
INSERT INTO table_name (column1, column2) VALUES (value1, value2);

--4. UPDATE: Utilizado para modificar registros existentes en una tabla:
UPDATE table_name SET column1 = value1, column2 = value2 WHERE condition;

    -- Actualizar el nombre de un cliente con un ID específico:
    UPDATE clientes
    SET nombre = 'NuevoNombre'
    WHERE id = 123;

    -- Incrementar el saldo de una cuenta bancaria en un cierto porcentaje para clientes con más de cierta edad:
    UPDATE cuentas_bancarias
    SET saldo = saldo * 1.05
    WHERE edad > 50;

    -- Cambiar el estado de un pedido a "Enviado" cuando la fecha de envío es anterior a la fecha actual:
    UPDATE pedidos
    SET estado = 'Enviado'
    WHERE fecha_envio < CURDATE();

    -- Marcar como completadas todas las tareas asignadas a un empleado específico:
    UPDATE tareas
    SET completada = 1
    WHERE empleado_id = 789;

    -- Actualizar la categoría de productos con un precio superior a cierto valor:
    UPDATE productos
    SET categoria = 'Premium'
    WHERE precio > 100;

--5. DELETE: Utilizado para eliminar registros de una tabla:
DELETE FROM table_name WHERE condition;

    -- DELETE + FOREIGN KEY (evitar que hay inconsistencia en los datos)
    DELETE FROM pedidos WHERE cliente_id IN (SELECT id FROM clientes WHERE nombre = 'Juan');

    --la sentencia DELETE eliminará todos los pedidos asociados con el cliente cuyo nombre es 'Juan' en la tabla clientes.
    --La subconsulta selecciona el id del cliente 'Juan' en la tabla clientes,
    --y luego la sentencia DELETE elimina todos los registros en la tabla pedidos que tienen ese id como valor de cliente_id.

--6. ALTER: Utilizado para modificar una tabla existente, como agregar o eliminar columnas:
ALTER TABLE table_name ADD column_name datatype; -- añade una columna
ALTER TABLE table_name ALTER COLUMN column_name datatype; -- modifica el tipo de dato de una columna
ALTER TABLE table_name DROP COLUMN column_name; -- Elimina la columna
ALTER TABLE table_name ADD FOREIGN KEY (column_name) REFERENCES table_name(column_name); -- Añade 'Clave Foranea' en una columna

--7. DROP: Utilizado para eliminar una tabla existente de la base de datos:
DROP TABLE table_name;
DROP DATABASE db_name;
ALTER TABLE table_name DROP COLUMN column_name; -- Elimina la columna

--8. TRUNCATE, elimina los registros de una tabla:
TRUNCATE TABLE table_name;
