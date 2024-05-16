/*
En SQL, las estructuras de control son un conjunto de características que te permiten controlar
el flujo de ejecución de las sentencias SQL.
Aunque SQL es principalmente un lenguaje declarativo diseñado para definir y manipular datos,
algunas implementaciones, como SQL Server, PostgreSQL y Oracle, incluyen características
que te permiten realizar ciertas operaciones de control de flujo similares a las que
encontrarías en lenguajes de programación procedimentales.
*/

--1. IF-ELSE: Permite realizar una acción condicional basada en una condición.
DECLARE @edad INT;
SET @edad = 25;

IF @edad >= 18
BEGIN -- Si se cumple la condición se ejecuta:
    PRINT 'Eres mayor de edad';
END
ELSE -- Si no se cumple la condición del IF:
BEGIN
    PRINT 'Eres menor de edad';
END;

--2. EXISTS. Verificar si una subconsulta devuelve algún resultado.
    -- Devuelve un valor booleano, TRUE si la subconsulta devuelve uno o más registros,
    --y FALSE si la subconsulta no devuelve ningún registro.

DECLARE @cliente_id INT;
SET @cliente_id = 123;

IF EXISTS (SELECT 1 FROM pedidos WHERE cliente_id = @cliente_id)
BEGIN
    PRINT 'Este cliente tiene pedidos.';
END
ELSE
BEGIN
    PRINT 'Este cliente no tiene pedidos.';
END;


--3. CASE: Proporciona una forma de realizar múltiples acciones condicionales en una sola expresión.
DECLARE @dia_semana INT;
SET @dia_semana = 3;

SELECT 
    CASE @dia_semana
        WHEN 1 THEN 'Lunes'
        WHEN 2 THEN 'Martes'
        WHEN 3 THEN 'Miércoles'
        WHEN 4 THEN 'Jueves'
        WHEN 5 THEN 'Viernes'
        ELSE 'Fin de semana'
    END AS NombreDia;

--4. Bucles (WHILE): Permiten repetir un bloque de código hasta que se cumpla una condición.
DECLARE @contador INT;
SET @contador = 1;

WHILE @contador <= 5
BEGIN
    PRINT 'Contador: ' + CAST(@contador AS VARCHAR(10));
    SET @contador = @contador + 1;
END;

--5. TRY / CATCH. Manejo de errores.
BEGIN TRY
    -- Intentar realizar alguna operación aquí
    SELECT 1 / 0; -- Esta operación generará un error de división por cero
END TRY
BEGIN CATCH
    -- Manejar el error aquí
    PRINT 'Se produjo un error: ' + ERROR_MESSAGE();
END CATCH;

--6. RETURN se utiliza para finalizar la ejecución de un procedimiento almacenado y devolver un valor opcional al código que lo llamó.
CREATE PROCEDURE ObtenerNombre
AS
BEGIN
    DECLARE @nombre VARCHAR(100);
    SET @nombre = 'Juan';
    
    -- Devolver el nombre
    RETURN @nombre;
END;

--7. BREAK se utiliza en un bucle para salir de él prematuramente cuando se cumple una condición específica.
DECLARE @contador INT;
SET @contador = 1;

WHILE @contador <= 10
BEGIN
    IF @contador = 5
    BEGIN
        -- Salir del bucle cuando el contador es igual a 5
        BREAK;
    END
    
    PRINT 'Contador: ' + CAST(@contador AS VARCHAR(10));
    SET @contador = @contador + 1;
END;

