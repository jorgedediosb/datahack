Curso Datahack - IBM SkillsBuild/Udemy. Incluye:

- 'Máster en SQL Server: Desde Cero a Nivel Profesional [2024]' impartido por Mariano Puglisi.
    https://www.udemy.com/course/master-sql-server/?couponCode=LEADERSALE24A
    
- 'Administración de Base de Datos Con SQL Server' impartido por Victor Hugo Cárdenas Valenzuela.
    https://www.udemy.com/course/administracion-de-base-de-datos-con-sql-server/?couponCode=LEADERSALE24A


Buenas prácticas sobre diseño, programación y seguridad

1. Definan nombres de campos cortos y que representen lo mejor posible el valor que almacena. Para nombrarlos usen el idioma que más prefieran, inglés, español.. pero respeten ese idioma durante todo el proyecto.

2. Cuando definan el nombre de un campo, por ej OrderID, asegúrense que el campo se llame igual si deben definirlo en otra tabla, eso les ahorrará muchos dolores de cabeza cuando tengan que realizar JOINS.

3. Al momento de elegir un tipo de dato para un campo, evalúen los valores que almacenará y elijan el tipo de dato adecuado. Por ejemplo, si el campo almacenará edades, no es necesario definirlo como INT, un tipo TINYINT es más que suficiente. Ahorrar en bytes mejorará la performance de la base de datos a largo plazo.

4. Para definir el nombre de un Stored Procedure es recomendable usar una nomenclatura que defina rápidamente qué tarea realiza ese proceso, por ej:
SEL_OrdenesPedido (SEL nos indica que es un proceso que devuelve datos)
INS_Pagos (INS no indica que es un proceso de grabación)

5. Normalicen las tablas; deben crear tantas tablas como requiera el modelo de base de datos. Normalizar en 3ra FN es suficiente. Si consideran que hay campos que deben colocarse en otra tabla, háganlo.

6. Aseguren su base de datos. Si tienen la posibilidad de administrar los accesos, creen usuarios, roles y permisos que garanticen la seguridad de sus datos.

No permitan que cualquier usuario pueda acceder y realizar modificaciones. Asignen los permisos adecuados a usuarios responsables o dedicados a desarrollo.

Puedes utilizar Schemas si lo consideras necesario.

7. Realiza las consultas filtrando siempre en lo posible por los campos Primary Key. Si usas JOINS, siempre coloca en la cláusula ON los campos PK. Esto hará que la consulta sea óptima.

8. Si has implementado Scheduled Jobs, asegúrate que se estén ejecutando en horarios nocturnos o cuando la base de datos esté con poca actividad, a fin de no afectar la performance al usuario.

9. Eviten el uso excesivo de Triggers. Cuando estos desencadenadores están vinculados a inserts, updates o deletes muy concurrentes, puede afectar la performance.

10. Realiza un Backup periódicamente y almacena los archivos preferentemente en un disco o dispositivo externo.