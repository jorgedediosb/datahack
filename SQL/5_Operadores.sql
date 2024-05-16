-- OPERADORES ARITMÉTRICOS
/*
+ (Suma): Se utiliza para sumar valores.
- (Resta): Se utiliza para restar valores.
* (Multiplicación): Se utiliza para multiplicar valores.
/ (División): Se utiliza para dividir valores.
% (Módulo O Resto): Devuelve el resto de la división entera.
*/

SELECT 10 + 5 AS Suma; -- Resultado: 15
SELECT 10 - 5 AS Resta; -- Resultado: 5
SELECT 10 * 5 AS Multiplicacion; -- Resultado: 50
SELECT 10 / 5 AS Division; -- Resultado: 2
SELECT 10 % 3 AS Modulo; -- Resultado: 1 (resto de la división de 10 entre 3)

DECLARE @num1 decimal(9,2)=20;
DECLARE @num2 decimal(9,2)=30;
DECLARE @result decimal(9,2);
SET @result = @num1 - @num2;
PRINT @result;


-- OPERADORES DE COMPARACIÓN
/*
= (Igual a): Comprueba si dos valores son iguales.
<> o != (No igual a): Comprueba si dos valores no son iguales.
> (Mayor que): Comprueba si el valor de la izquierda es mayor que el de la derecha.
< (Menor que): Comprueba si el valor de la izquierda es menor que el de la derecha.
>= (Mayor o igual que): Comprueba si el valor de la izquierda es mayor o igual que el de la derecha.
<= (Menor o igual que): Comprueba si el valor de la izquierda es menor o igual que el de la derecha.
*/

SELECT * FROM empleados WHERE salario > 50000; -- Selecciona empleados con un salario mayor que 50000
SELECT * FROM productos WHERE precio <= 10; -- Selecciona productos con un precio igual o menor que 10
SELECT * FROM clientes WHERE edad <> 25; -- Selecciona clientes cuya edad no es igual a 25

DECLARE @num1 decimal(9,2)=20;
DECLARE @num2 decimal(9,2)=30;
IF @num1 > @num2
    print 'SI'

