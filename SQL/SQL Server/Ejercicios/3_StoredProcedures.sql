/*
Los "stored procedures" (procedimientos almacenados) en SQL son un conjunto de instrucciones SQL
que se almacenan en el sistema de gestión de bases de datos
y se pueden ejecutar de manera repetida mediante una llamada desde una aplicación
o directamente desde el gestor de base de datos.

Los procedimientos almacenados permiten encapsular lógica empresarial compleja en la base de datos,
lo que puede mejorar el rendimiento, la seguridad y la mantenibilidad de una aplicación.
*/

-- 1. Crear un procedimiento almacenado simple que devuelva todos los empleados de una tabla:
CREATE PROCEDURE ObtenerEmpleados
AS
BEGIN
    SELECT * FROM empleados;
END;

-- 2. Crear un procedimiento almacenado que acepte un parámetro y devuelva empleados con un salario superior a ese valor:
CREATE PROCEDURE ObtenerEmpleadosPorSalario
    @salario_min DECIMAL
AS
BEGIN
    SELECT * FROM empleados WHERE salario > @salario_min;
END;

-- 3. Crear un procedimiento almacenado que inserte un nuevo empleado en la tabla de empleados:
CREATE PROCEDURE InsertarEmpleado
    @nombre VARCHAR(100),
    @salario DECIMAL
AS
BEGIN
    INSERT INTO empleados (nombre, salario) VALUES (@nombre, @salario);
END;

-- 4. Crear un procedimiento almacenado que actualice el salario de un empleado en función de su ID:
CREATE PROCEDURE ActualizarSalarioEmpleado
    @id INT,
    @nuevo_salario DECIMAL
AS
BEGIN
    UPDATE empleados SET salario = @nuevo_salario WHERE id = @id;
END;

-- 5. Crear un procedimiento almacenado que elimine un empleado en función de su ID:
CREATE PROCEDURE EliminarEmpleado
    @id INT
AS
BEGIN
    DELETE FROM empleados WHERE id = @id;
END;


/*
ANSI_NULLS es una opción de configuración que especifica si se deben seguir
las reglas ANSI SQL para el manejo de valores nulos (NULL)
durante la comparación y la ordenación. Cuando ANSI_NULLS está habilitado,
las comparaciones con NULL se tratan de acuerdo con el estándar ANSI SQL,
lo que significa que NULL no es igual a nada, ni siquiera a otro NULL.

Por ejemplo, con ANSI_NULLS habilitado, la expresión NULL = NULL devolverá FALSE.

En SQL Server, ANSI_NULLS está habilitado de forma predeterminada para nuevas bases de datos,
pero es importante tener en cuenta su estado al escribir consultas y procedimientos almacenados
para garantizar el comportamiento deseado.
*/

CREATE PROCEDURE ObtenerEmpleadosSinApellido
AS
BEGIN
    SET ANSI_NULLS ON; -- Habilitar ANSI_NULLS para este procedimiento
    SELECT * FROM empleados WHERE apellido IS NULL;
END;


/*
ISNULL es una función en SQL que se utiliza para manejar valores nulos.
Toma dos argumentos: el valor que se va a evaluar y el valor que se devolverá si el valor evaluado es nulo.
Si el valor evaluado no es nulo, se devuelve el propio valor evaluado.

Por ejemplo, en la expresión ISNULL(columna, valor_predeterminado), si columna es nula,
la función devolverá valor_predeterminado; de lo contrario, devolverá el valor de columna.

ISNULL es útil para proporcionar valores predeterminados cuando se encuentran valores nulos en las consultas SQL,
como en el ejemplo anterior donde se utiliza para proporcionar un valor predeterminado de 0 si el salario de un empleado es nulo.
*/

CREATE PROCEDURE ActualizarSalarioConIncremento
    @incremento DECIMAL
AS
BEGIN
    UPDATE empleados SET salario = ISNULL(salario, 0) + @incremento;
END;


/*
sp_help es un procedimiento almacenado del sistema en SQL Server que proporciona información detallada
sobre los objetos de la base de datos, como tablas, vistas, índices y procedimientos almacenados.
Es una herramienta muy útil para obtener rápidamente una descripción completa de la estructura
y propiedades de un objeto en la base de datos.
*/
-- USOS:
-- 1. Obtener información sobre una tabla:
EXEC sp_help 'nombre_de_la_tabla';

-- 2. Obtener información sobre otros objetos:
EXEC sp_help 'mi_stored_procedure';

-- 3. Obtener información general de la base de datos:
EXEC sp_help;

-- Ejemplo de Uso en un Procedimiento Almacenado:
CREATE PROCEDURE ObtenerInfoTabla
    @nombreTabla NVARCHAR(128)
AS
BEGIN
    -- Ejecutar sp_help para obtener información sobre la tabla
    EXEC sp_help @nombreTabla;
END;


-- sp_helptext te muestra el código fuente de estos objetos:
EXEC sp_helptext 'nombre_del_procedimiento';
EXEC sp_helptext 'mi_procedimiento_almacenado';
EXEC sp_helptext 'mi_funcion';
EXEC sp_helptext 'mi_vista';
EXEC sp_helptext 'mi_trigger';


