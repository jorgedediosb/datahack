--1. TOP: Se usa en SQL Server para limitar el número de filas devueltas por una consulta:
SELECT TOP 5 * FROM productos;

--2. ORDER BY: Se utiliza para ordenar los resultados de una consulta según una o más columnas:
SELECT * FROM empleados ORDER BY salario DESC;

--3. TOP + ORDER BY: Se puede combinar TOP con ORDER BY para obtener las primeras filas de una consulta ordenada:
SELECT TOP 10 * FROM clientes ORDER BY fecha_registro DESC;

--4. DISTINCT: Se usa para eliminar filas duplicadas de los resultados de una consulta:
SELECT DISTINCT departamento FROM empleados;

--5. GROUP BY: Se utiliza para agrupar filas que tienen los mismos valores en una o más columnas y se usa con funciones de agregación como COUNT, SUM, AVG, etc:
SELECT departamento, COUNT(*) as total_empleados FROM empleados GROUP BY departamento;

--6. WHERE: Se usa para filtrar filas basadas en una condición específica:
SELECT * FROM productos WHERE precio > 100;
