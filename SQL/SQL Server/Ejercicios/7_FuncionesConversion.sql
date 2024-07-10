/*
Las funciones de conversión en SQL se utilizan para convertir datos de un tipo a otro.
Estas funciones son esenciales cuando necesitas asegurarte de que los datos se manipulen y se comparen correctamente.
*/

-- CAST. Convierte una expresión de un tipo de datos a otro tipo de datos:
CAST(expresión AS tipo_de_datos)

    -- Convertir un número a cadena
    SELECT CAST(12345 AS VARCHAR(10)) AS NumeroComoCadena;

    -- Convertir una cadena a número
    SELECT CAST('12345' AS INT) AS CadenaComoNumero;

    -- Convertir una cadena a fecha
    SELECT CAST('2024-05-20' AS DATE) AS CadenaComoFecha;


-- CONVERT. Proporciona una funcionalidad similar a CAST, pero con un poco más de control sobre el formato de la conversión. 
-- Es específica de SQL Server
CONVERT(tipo_de_datos, expresión [, estilo])

    -- Convertir un número a cadena
    SELECT CONVERT(VARCHAR(10), 12345) AS NumeroComoCadena;

    -- Convertir una cadena a número
    SELECT CONVERT(INT, '12345') AS CadenaComoNumero;

    -- Convertir una cadena a fecha con estilo específico
    SELECT CONVERT(DATE, '20/05/2024', 103) AS CadenaComoFecha; -- 103 es el estilo para dd/mm/yyyy


-- TRY_CAST. Es similar a CAST, pero devuelve NULL si la conversión falla en lugar de producir un error.
-- Es específica de SQL Server.
TRY_CAST(expresión AS tipo_de_datos)

    -- Intentar convertir una cadena a número (fallará y devolverá NULL)
    SELECT TRY_CAST('abc' AS INT) AS CadenaInvalidaComoNumero;

    -- Intentar convertir una cadena válida a número
    SELECT TRY_CAST('12345' AS INT) AS CadenaValidaComoNumero;


-- TRY_CONVERT. Es similar a CONVERT, pero devuelve NULL si la conversión falla en lugar de producir un error.
-- Es específica de SQL Server.
TRY_CONVERT(tipo_de_datos, expresión [, estilo])

    -- Intentar convertir una cadena a número (fallará y devolverá NULL)
    SELECT TRY_CONVERT(INT, 'abc') AS CadenaInvalidaComoNumero;

    -- Intentar convertir una cadena válida a número
    SELECT TRY_CONVERT(INT, '12345') AS CadenaValidaComoNumero;


-- TO_CHAR, TO_DATE, TO_NUMBER: Se utilizan para convertir entre cadenas, fechas y números.
-- Específicas de Oracle.
TO_CHAR(expresión, 'formato')
TO_DATE(cadena, 'formato')
TO_NUMBER(cadena, 'formato')

    -- Convertir una fecha a cadena
    SELECT TO_CHAR(SYSDATE, 'DD-MON-YYYY') AS FechaComoCadena FROM DUAL;

    -- Convertir una cadena a fecha
    SELECT TO_DATE('20-MAY-2024', 'DD-MON-YYYY') AS CadenaComoFecha FROM DUAL;

    -- Convertir una cadena a número
    SELECT TO_NUMBER('12345') AS CadenaComoNumero FROM DUAL;


--Funciones de Manipulación de Cadenas--

-- LEFT. Devuelve la parte izquierda de una cadena con un número específico de caracteres.
SELECT LEFT('Hola Mundo', 4) AS ParteIzquierda; -- Resultado: 'Hola'

-- RIGHT. Devuelve la parte derecha de una cadena con un número específico de caracteres.
SELECT RIGHT('Hola Mundo', 5) AS ParteDerecha; -- Resultado: 'Mundo'

-- LEN. Devuelve la longitud de una cadena.
SELECT LEN('Hola Mundo') AS Longitud; -- Resultado: 10

-- LOWER. Convierte todos los caracteres de una cadena a minúsculas.
SELECT LOWER('Hola Mundo') AS Minusculas; -- Resultado: 'hola mundo'

-- UPPER. Convierte todos los caracteres de una cadena a mayúsculas.
SELECT UPPER('Hola Mundo') AS Mayusculas; -- Resultado: 'HOLA MUNDO'

-- REPLACE. Reemplaza todas las ocurrencias de una subcadena dentro de una cadena con otra subcadena.
SELECT REPLACE('Hola Mundo', 'Mundo', 'SQL') AS Reemplazo; -- Resultado: 'Hola SQL'

-- REPLICATE. Repite una cadena un número especificado de veces.
SELECT REPLICATE('Hola', 3) AS Repetido; -- Resultado: 'HolaHolaHola'

-- LTRIM. Elimina los espacios en blanco iniciales de una cadena.
SELECT LTRIM('   Hola Mundo') AS SinEspaciosIniciales; -- Resultado: 'Hola Mundo'

-- RTRIM. Elimina los espacios en blanco finales de una cadena.
SELECT RTRIM('Hola Mundo   ') AS SinEspaciosFinales; -- Resultado: 'Hola Mundo'

-- CONCAT. Concatena dos o más cadenas.
SELECT CONCAT('Hola', ' ', 'Mundo') AS Concatenado; -- Resultado: 'Hola Mundo'


--Funciones de Fecha y Hora--

-- DATEADD. Agraga intervalos a las fechas
SELECT DATEADD(day, 2, GETDATE()) -- Añade 2 días al registro que se llame (si son horas se indica 'hour')

-- DATEDIFF. Devuelve la diferencia entre dos fechas en el intervalo especificado.
    -- Diferencia en días entre dos fechas
    SELECT DATEDIFF(day, '2024-01-01', '2024-05-20') AS DiferenciaDias; -- Resultado: 140

    -- Diferencia en meses entre dos fechas
    SELECT DATEDIFF(month, '2024-01-01', '2024-05-20') AS DiferenciaMeses; -- Resultado: 4

-- DATEPART. Devuelve una parte específica de una fecha (año, mes, día, hora, minuto, etc.).
    -- Obtener el año de una fecha
    SELECT DATEPART(year, '2024-05-20') AS Anio; -- Resultado: 2024

    -- Obtener el mes de una fecha
    SELECT DATEPART(month, '2024-05-20') AS Mes; -- Resultado: 5

    -- Obtener el día de una fecha
    SELECT DATEPART(day, '2024-05-20') AS Dia; -- Resultado: 20

    -- Obtener el día de la semana de una fecha (1=domingo, 2=lunes, etc.)
    SELECT DATEPART(weekday, '2024-05-20') AS DiaSemana; -- Resultado: 2 (lunes)

-- GETDATE y GETUTCDATE. Devuelve la fecha (o fecha y hora) cuando se creó el registro.

-- ISDATE. Evalua si una fecha tiene el formato correcto. Devuelve 0 como 'false' y 1 como 'true'


-- Ejemplo Completo --
DECLARE @cadena NVARCHAR(100) = '  ¡Bienvenido a SQL!   ';
DECLARE @fecha1 DATE = '2024-01-01';
DECLARE @fecha2 DATE = '2024-05-20';

SELECT
    LEFT(@cadena, 10) AS ParteIzquierda,
    RIGHT(@cadena, 5) AS ParteDerecha,
    LEN(@cadena) AS Longitud,
    LOWER(@cadena) AS Minusculas,
    UPPER(@cadena) AS Mayusculas,
    REPLACE(@cadena, 'SQL', 'T-SQL') AS Reemplazo,
    REPLICATE('Hola ', 3) AS Repetido,
    LTRIM(@cadena) AS SinEspaciosIniciales,
    RTRIM(@cadena) AS SinEspaciosFinales,
    CONCAT('¡', 'Hola', ' ', 'Mundo!') AS Concatenado,
    DATEDIFF(day, @fecha1, @fecha2) AS DiferenciaDias,
    DATEPART(year, @fecha2) AS Anio,
    DATEPART(month, @fecha2) AS Mes,
    DATEPART(day, @fecha2) AS Dia,
    DATEPART(weekday, @fecha2) AS DiaSemana;

-- Se declara una cadena y dos fechas, y luego se aplican varias funciones para mostrar cómo se pueden manipular cadenas y fechas en SQL.