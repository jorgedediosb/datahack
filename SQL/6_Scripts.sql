/*
Un script en SQL es un archivo que contiene una serie de instrucciones SQL que se ejecutan secuencialmente.
Estos scripts se utilizan para automatizar tareas repetitivas, gestionar bases de datos,
realizar operaciones complejas, y para la implementación y mantenimiento de bases de datos.

Un script SQL puede incluir comandos como CREATE, INSERT, UPDATE, DELETE, así como la definición de procedimientos almacenados,
funciones, triggers y otros objetos de la base de datos.
*/

-- EJEMPLO:

-- Crear una nueva base de datos
CREATE DATABASE MiBaseDeDatos;
GO

-- Usar la base de datos creada
USE MiBaseDeDatos;
GO

-- Crear una tabla llamada 'clientes'
CREATE TABLE clientes (
    cliente_id INT PRIMARY KEY,
    nombre NVARCHAR(100),
    correo NVARCHAR(100)
);
GO

-- Insertar datos en la tabla 'clientes'
INSERT INTO clientes (cliente_id, nombre, correo) VALUES (1, 'Juan Pérez', 'juan.perez@example.com');
INSERT INTO clientes (cliente_id, nombre, correo) VALUES (2, 'Ana Gómez', 'ana.gomez@example.com');
GO

-- Realizar una consulta para seleccionar todos los registros de la tabla 'clientes'
SELECT * FROM clientes;
GO

