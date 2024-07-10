/*
Una transacción en SQL es una secuencia de operaciones que se ejecutan como una unidad de trabajo única.
Las transacciones aseguran que todas las operaciones dentro de la transacción se completen correctamente
antes de que se confirmen los cambios en la base de datos. Si alguna de las operaciones falla,
toda la transacción puede revertirse (rollback), dejando la base de datos en un estado consistente.

Las transacciones en bases de datos siguen el modelo ACID, que garantiza que se mantengan ciertas propiedades:
    - Atomicidad (Atomicity): Todas las operaciones dentro de una transacción se consideran como una unidad indivisible.
    O todas se completan correctamente, o ninguna se completa.
    - Consistencia (Consistency): Las transacciones llevan a la base de datos de un estado consistente a otro estado consistente.
    - Aislamiento (Isolation): Las transacciones se ejecutan de manera independiente y transparente, asegurando que los cambios
    realizados en una transacción no sean visibles para otras transacciones hasta que se confirmen.
    - Durabilidad (Durability): Una vez que una transacción se confirma, los cambios se almacenan permanentemente en la base de datos,
    incluso si ocurre una falla del sistema.

Comandos Básicos para Manejar Transacciones
   - BEGIN TRANSACTION: Inicia una nueva transacción.
   - COMMIT: Confirma todos los cambios realizados durante la transacción.
   - ROLLBACK: Revierte todos los cambios realizados durante la transacción.

*/

-- Ejemplo 1: Transacción Básica para asegurar que dos operaciones de inserción se realicen de manera atómica.
BEGIN TRANSACTION;

-- Intentar insertar un registro en la tabla de clientes
INSERT INTO clientes (cliente_id, nombre, correo) VALUES (1, 'Juan Pérez', 'juan.perez@example.com');

-- Intentar insertar un registro en la tabla de pedidos
INSERT INTO pedidos (pedido_id, cliente_id, fecha) VALUES (101, 1, '2024-05-20');

-- Confirmar la transacción
COMMIT;

/*
Si ambas operaciones de inserción tienen éxito, los cambios se confirman en la base de datos.
Si alguna de las operaciones falla, se puede usar ROLLBACK para revertir los cambios.
*/


-- Ejemplo 2: Uso de ROLLBACK en Caso de Error. Si ocurre un error durante una de las operaciones, se revierte toda la transacción.
BEGIN TRANSACTION;

BEGIN TRY
    -- Intentar insertar un registro en la tabla de clientes
    INSERT INTO clientes (cliente_id, nombre, correo) VALUES (2, 'Ana Gómez', 'ana.gomez@example.com');
    
    -- Intentar insertar un registro en la tabla de pedidos
    INSERT INTO pedidos (pedido_id, cliente_id, fecha) VALUES (102, 2, '2024-05-21');
    
    -- Confirmar la transacción
    COMMIT;
END TRY
BEGIN CATCH
    -- Si ocurre un error, revertir la transacción
    ROLLBACK;

    -- Mostrar el error
    SELECT ERROR_MESSAGE() AS ErrorMensaje;
END CATCH;

/*
Si alguna de las instrucciones de inserción falla, se ejecutará la sección CATCH
y se revertirán todos los cambios realizados durante la transacción.
*/

-- Ejemplo 3: Transacciones con Actualización de Múltiples Tablas.
BEGIN TRANSACTION;

BEGIN TRY
    -- Actualizar el saldo de un cliente
    UPDATE clientes SET saldo = saldo - 100 WHERE cliente_id = 3;

    -- Registrar la transacción en el historial de transacciones
    INSERT INTO historial_transacciones (cliente_id, monto, fecha) VALUES (3, -100, GETDATE());

    -- Confirmar la transacción
    COMMIT;
END TRY
BEGIN CATCH
    -- Si ocurre un error, revertir la transacción
    ROLLBACK;

    -- Mostrar el error
    SELECT ERROR_MESSAGE() AS ErrorMensaje;
END CATCH;

/*
 si alguna de las operaciones falla, se revertirán todas las actualizaciones,
 asegurando que los datos se mantengan consistentes.
*/