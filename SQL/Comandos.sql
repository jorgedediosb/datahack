--Los comandos básicos en SQL incluyen:

--1. SELECT: Utilizado para recuperar datos de una o varias tablas:
SELECT column1, column2 FROM table_name;

--2. INSERT INTO: Utilizado para agregar nuevos registros a una tabla:
INSERT INTO table_name (column1, column2) VALUES (value1, value2);

--3. UPDATE: Utilizado para modificar registros existentes en una tabla:
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

--4. DELETE: Utilizado para eliminar registros de una tabla:
DELETE FROM table_name WHERE condition;

--5. CREATE TABLE: Utilizado para crear una nueva tabla en la base de datos:
CREATE TABLE table_name (
    column1 datatype,
    column2 datatype,
    ...
);

--6. ALTER TABLE: Utilizado para modificar una tabla existente, como agregar o eliminar columnas:
ALTER TABLE table_name ADD column_name datatype;

--7. DROP TABLE: Utilizado para eliminar una tabla existente de la base de datos:
DROP TABLE table_name;
