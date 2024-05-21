/*
Tablas en Memoria
Descripción: Las tablas en memoria, también conocidas como tablas optimizadas para memoria o tablas con almacenamiento en memoria, son tablas cuyos datos se almacenan en la memoria RAM en lugar de en el disco. Están diseñadas para operaciones de alto rendimiento y baja latencia.

Características:
- Almacenamiento en RAM: Los datos se mantienen en la memoria principal del servidor.
- Velocidad: Proporcionan un acceso y manipulación de datos extremadamente rápidos debido a la alta velocidad de la memoria RAM.
- Persistencia: Pueden configurarse para ser duraderas (persistentes) o no duraderas (volátiles). Las tablas duraderas guardan los datos en el disco para recuperación en caso de fallo, mientras que las volátiles no lo hacen.
- Optimización para Concurrencia: Utilizan técnicas avanzadas de control de concurrencia, como versiones múltiples de registros (MVCC) y control de concurrencia optimista.
- Limitaciones: Su capacidad está limitada por la cantidad de memoria RAM disponible en el servidor. No todas las características de las tablas en disco están disponibles para tablas en memoria, dependiendo del sistema de gestión de bases de datos (DBMS).
*/

--Ejemplo:
-- Crear un esquema de optimización para memoria
CREATE SCHEMA OptimizedMemory;

-- Crear una tabla en memoria
CREATE TABLE OptimizedMemory.MemTable (
    id INT PRIMARY KEY NONCLUSTERED,
    nombre NVARCHAR(100)
) WITH (MEMORY_OPTIMIZED = ON, DURABILITY = SCHEMA_AND_DATA); -- Durabilidad configurada para mantener el esquema y los datos


/*
Tablas Físicas (En Disco)
Descripción: Las tablas físicas son las tablas tradicionales que almacenan datos en el disco duro del servidor. Este es el tipo de tabla más común en los sistemas de bases de datos.

Características:
- Almacenamiento en Disco: Los datos se almacenan en medios de almacenamiento persistentes como discos duros o unidades de estado sólido (SSD).
- Persistencia: Todos los datos son persistentes y se recuperan después de un reinicio del sistema o fallo del servidor.
- Escalabilidad: Pueden manejar grandes volúmenes de datos, limitados principalmente por el espacio de almacenamiento disponible en el servidor.
- Rendimiento: Generalmente más lentas que las tablas en memoria debido a la latencia de E/S del disco, aunque el uso de SSD puede mejorar significativamente el rendimiento.
- Características Completas: Soportan todas las características avanzadas de un DBMS, como índices complejos, triggers, constraints y transacciones completas.
*/

-- Ejemplo:
-- Crear una tabla física (en disco)
CREATE TABLE DiskTable (
    id INT PRIMARY KEY,
    nombre NVARCHAR(100)
);

/*
Diferencias Clave
1. Almacenamiento:
- Tablas en Memoria: Los datos se almacenan en la memoria RAM.
- Tablas Físicas: Los datos se almacenan en disco.

2. Velocidad:
- Tablas en Memoria: Acceso y manipulación de datos extremadamente rápidos.
- Tablas Físicas: Acceso y manipulación de datos más lentos debido a la latencia del disco, aunque los SSD mejoran el rendimiento.

3. Persistencia:
- Tablas en Memoria: Pueden ser duraderas (persistentes) o volátiles (no persistentes).
- Tablas Físicas: Siempre persistentes.

4. Uso de Recursos:
- Tablas en Memoria: Utilizan memoria RAM, lo que las limita en tamaño por la cantidad de memoria disponible.
- Tablas Físicas: Utilizan espacio en disco, permitiendo almacenamiento de grandes volúmenes de datos.

5. Concurrencia:
- Tablas en Memoria: Utilizan técnicas avanzadas como MVCC y control de concurrencia optimista.
- Tablas Físicas: Utilizan métodos tradicionales de bloqueo de registros y páginas.

6. Casos de Uso:
- Tablas en Memoria: Adecuadas para aplicaciones que requieren alta velocidad y bajas latencias, como sistemas de trading financiero, análisis en tiempo real, y aplicaciones que necesitan acceso rápido a datos.
- Tablas Físicas: Adecuadas para almacenamiento de grandes volúmenes de datos, aplicaciones que requieren persistencia total, y donde el rendimiento no es el único factor crítico.
*/