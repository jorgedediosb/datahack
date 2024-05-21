
/*
En SQL, las funciones se utilizan para encapsular y reutilizar lógica en consultas y operaciones.
Las funciones en SQL se pueden clasificar en dos tipos principales:
funciones escalares y funciones tipo tabla. 
*/

--FUNCIONES ESCALARES
--devuelven un solo valor (escalar) basado en los parámetros de entrada.
--Este valor puede ser de cualquier tipo de datos, como entero, cadena, fecha, etc.

-- Ejemplo:
-- Crear una función escalar que convierte una cadena a mayúsculas
CREATE FUNCTION dbo.Uppercase(@input NVARCHAR(100))
RETURNS NVARCHAR(100)
AS
BEGIN
    RETURN UPPER(@input);
END;
GO
-- Usar la función escalar en una consulta
SELECT dbo.Uppercase('hola mundo') AS Resultado; -- Resultado: 'HOLA MUNDO'


-- Ejemplo Proyecto Hospital:
--select dbo.nombrefun (256)
select dbo.concatenar('Lopez','Roberto')
select dbo.obtenerPais (9)

select * from paciente

CREATE FUNCTION nombrefun (@var int)
RETURNS int
AS
BEGIN
	set @var = @var * 5
	return @var
END

CREATE FUNCTION concatenar (
				@apellido varchar(50),
				@nombre varchar(50)
				)
RETURNS varchar(100)
AS
BEGIN
	declare @resultado varchar(100)
	set @resultado = @apellido + ', ' + @nombre
	return @resultado	
END

CREATE FUNCTION obtenerPais(
				@idpaciente paciente
				)
RETURNS varchar(50)
AS
BEGIN
	declare @pais varchar(50)
	SET @pais = (SELECT PA.pais From paciente P
					INNER JOIN Pais PA
					ON PA.idPais = P.idPais
					WHERE idPaciente=@idpaciente)
	
	RETURN @pais
END

--FUNCIONES DE TIPO TABLA
-- devuelven un conjunto de filas (una tabla).
-- Este conjunto de resultados puede ser tratado como una tabla normal en las consultas SQL.

/*
Funciones Tipo Tabla con Valores en Línea (Inline Table-Valued Functions)
Estas funciones contienen una sola declaración RETURN que devuelve una tabla.
*/
--Ejemplo:
-- Crear una función tipo tabla en línea que devuelve clientes activos
CREATE FUNCTION dbo.ClientesActivos()
RETURNS TABLE
AS
RETURN
(
    SELECT cliente_id, nombre
    FROM clientes
    WHERE activo = 1
);
GO
-- Usar la función tipo tabla en una consulta
SELECT * FROM dbo.ClientesActivos();

/*
Funciones Tipo Tabla con Valores Múltiples (Multi-Statement Table-Valued Functions)
Estas funciones pueden contener múltiples instrucciones T-SQL y deben definir explícitamente una tabla para devolver.
*/
--Ejemplo:
-- Crear una función tipo tabla con valores múltiples que devuelve pedidos de un cliente
CREATE FUNCTION dbo.PedidosPorCliente(@cliente_id INT)
RETURNS @Pedidos TABLE
(
    pedido_id INT,
    fecha DATE
)
AS
BEGIN
    -- Insertar datos en la tabla de resultados
    INSERT INTO @Pedidos (pedido_id, fecha)
    SELECT pedido_id, fecha
    FROM pedidos
    WHERE cliente_id = @cliente_id;

    RETURN;
END;
GO
-- Usar la función tipo tabla en una consulta
SELECT * FROM dbo.PedidosPorCliente(1);


-- Ejemplo Proyecto Hospital:
select * from dbo.listaPaises()

CREATE FUNCTION listaPaises()
RETURNS @paises TABLE(idpais char(3), pais varchar(50))
AS
BEGIN
	
	INSERT INTO @paises values('ESP','Espa�a')
	INSERT INTO @paises values('MEX','Mexico')
	INSERT INTO @paises values('CHI','Chile')
	INSERT INTO @paises values('PER','Per�')
	INSERT INTO @paises values('ARG','Argentina')

	RETURN
END




