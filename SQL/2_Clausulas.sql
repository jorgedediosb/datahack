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

--7. JOIN: combina filas de dos o más tablas:
    -- INNER JOIN: Combina filas de dos tablas donde existe una coincidencia en ambas.
    SELECT clientes.cliente_id, clientes.nombre, pedidos.pedido_id, pedidos.fecha
    FROM clientes
    INNER JOIN pedidos ON clientes.cliente_id = pedidos.cliente_id;

    -- LEFT JOIN. Devuelve todas las filas de la tabla izquierda y las filas coincidentes de la tabla derecha.
    SELECT clientes.cliente_id, clientes.nombre, pedidos.pedido_id, pedidos.fecha
    FROM clientes
    LEFT JOIN pedidos ON clientes.cliente_id = pedidos.cliente_id;

    -- RIGHT JOIN. Devuelve todas las filas de la tabla derecha y las filas coincidentes de la tabla izquierda.
    SELECT clientes.cliente_id, clientes.nombre, pedidos.pedido_id, pedidos.fecha
    FROM clientes
    RIGHT JOIN pedidos ON clientes.cliente_id = pedidos.cliente_id;

    -- FULL JOIN. Devuelve todas las filas cuando hay una coincidencia en una de las tablas.
    SELECT clientes.cliente_id, clientes.nombre, pedidos.pedido_id, pedidos.fecha
    FROM clientes
    FULL JOIN pedidos ON clientes.cliente_id = pedidos.cliente_id;

    -- CROSS JOIN. Devuelve el producto cartesiano de las dos tablas.
    SELECT clientes.cliente_id, clientes.nombre, pedidos.pedido_id, pedidos.fecha
    FROM clientes
    CROSS JOIN pedidos;

--8. UNION. 
/*
se utiliza para combinar los resultados de dos o más consultas SELECT en un solo conjunto de resultados.
La cláusula UNION selecciona solo filas distintas de ambas consultas.
Si deseas incluir todas las filas, incluidas las duplicadas, puedes utilizar UNION ALL
*/

SELECT cliente_id, nombre FROM clientes_2023
UNION
SELECT cliente_id, nombre FROM clientes_2024;

