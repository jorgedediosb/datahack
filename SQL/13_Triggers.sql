/*
Un trigger en SQL es un tipo especial de procedimiento almacenado que se ejecuta automáticamente en respuesta a ciertos eventos en una tabla o vista, como INSERT, UPDATE o DELETE. Los triggers se utilizan para imponer reglas de negocio, validar datos, mantener la integridad referencial y realizar tareas automáticas.

Tipos de Triggers
AFTER Triggers: Se ejecutan después de que se ha realizado una operación de INSERT, UPDATE o DELETE.
INSTEAD OF Triggers: Se ejecutan en lugar de la operación INSERT, UPDATE o DELETE que los activó.
*/

/*
Creación de Triggers
Ejemplo de Trigger AFTER INSERT

Este ejemplo crea un trigger que se ejecuta después de que se inserte un nuevo registro en la tabla empleados
y registra la inserción en una tabla de auditoría.
*/
-- Crear la tabla de auditoría
CREATE TABLE AuditoriaEmpleados (
    auditoria_id INT IDENTITY(1,1) PRIMARY KEY,
    empleado_id INT,
    accion NVARCHAR(50),
    fecha DATETIME DEFAULT GETDATE()
);

-- Crear el trigger AFTER INSERT
CREATE TRIGGER trg_AfterInsert_Empleados
ON empleados
AFTER INSERT
AS
BEGIN
    INSERT INTO AuditoriaEmpleados (empleado_id, accion)
    SELECT empleado_id, 'INSERT' FROM inserted; --'inserted' son las filas que han sido insertadas o actualizadas en la tabla que desencadenó el trigger.
END;

/*
Ejemplo de Trigger AFTER UPDATE

Este ejemplo crea un trigger que se ejecuta después de que se actualice un registro en la tabla empleados
y registra la actualización en la tabla de auditoría.
*/
-- Crear el trigger AFTER UPDATE
CREATE TRIGGER trg_AfterUpdate_Empleados
ON empleados
AFTER UPDATE
AS
BEGIN
    INSERT INTO AuditoriaEmpleados (empleado_id, accion)
    SELECT empleado_id, 'UPDATE' FROM inserted;
END;

/*
Ejemplo de Trigger AFTER DELETE

Este ejemplo crea un trigger que se ejecuta después de que se elimine un registro de la tabla empleados
y registra la eliminación en la tabla de auditoría.
*/
-- Crear el trigger AFTER DELETE
CREATE TRIGGER trg_AfterDelete_Empleados
ON empleados
AFTER DELETE
AS
BEGIN
    INSERT INTO AuditoriaEmpleados (empleado_id, accion)
    SELECT empleado_id, 'DELETE' FROM deleted;
END;


/*
Uso de Triggers
Los triggers se pueden usar para diversas tareas, como:
- Validación de Datos: Asegurar que los datos cumplen con ciertas reglas antes de ser insertados o actualizados.
- Mantenimiento de la Integridad Referencial: Automatizar la actualización o eliminación de registros relacionados en otras tablas.
- Auditoría: Registrar cambios en los datos para realizar un seguimiento de las operaciones realizadas en la base de datos.
- Notificación: Enviar alertas o realizar acciones automáticas en respuesta a cambios en los datos.

Consideraciones
- Rendimiento: Los triggers pueden afectar el rendimiento de la base de datos si se utilizan excesivamente o si contienen lógica compleja.
- Depuración: Depurar triggers puede ser complicado debido a su naturaleza automática.
- Recursividad: Los triggers pueden llamar a otros triggers, lo que puede causar recursividad y complicaciones si no se manejan adecuadamente.

Resumen
Los triggers son herramientas poderosas en SQL que permiten automatizar tareas y mantener la integridad de los datos de manera eficiente.
Su uso adecuado puede mejorar la consistencia y seguridad de una base de datos, aunque es importante tener en cuenta su impacto potencial en el rendimiento y la complejidad del sistema.







*/