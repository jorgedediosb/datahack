PRÁCTICA HADOOP

## EJERCICIO 2

Para dimensionar el clúster Hadoop y determinar el número de máquinas necesarias, primero necesitamos calcular el almacenamiento total requerido para todos los eventos de películas provenientes de distintas fuentes durante un año.

Primero, calcularemos el tamaño total de datos generados por todas las fuentes por día:

Fuente 1:
10.000 eventos/día × 15 KB/evento = 150.000 KB/día

Fuente 2: 
120.000 eventos/día × 300 Bytes/evento = 36.000.000 Bytes/día (en KB = 35.156,25 KB/día)
150.000 eventos/día × 100 KB/evento = 15.000.000 KB/día
170.000 eventos/día × 800 KB/evento = 136.000.000 KB/día
200.000 eventos/día × 1.500 KB/evento = 300.000.000 KB/día --> **ES CORRECTO? EL ENUNCIADO INDICA 2000 EVENTOS/DÍA**

Sumando las dos fuentes, obtenemos el total KB/día:
150.000 KB/día + (35.156,25 KB/día + 15.000.000 + 136.000.000 + 300.000.000) = 451.035.156,25 KB/día

Para calcular el almacenamiento para un año:
451.035.156,25 KB/día × 365 días = 164.627.832.031,25 KB/año

Convertimos a terabytes (TB) para compararlo con la capacidad de las máquinas
1 TB = 1024 × 1024 × 1024 KB = 1.073.741.824 KB tenemos:
164.627.832.031,25 KB/año ÷ (1024 × 1024 × 1024) KB/TB = 153,32 TB/año

Cada máquina puede tener hasta 22 discos de 2 terabytes cada uno, la capacidad total de almacenamiento por máquina es:
22 discos × 2 TB/disco = 44 TB/máquina

Nº de máquinas necesarias:
153,32 TB/año ÷ 44 TB/máquina ≈ 3,48 máquinas

Necesitaríamos **4 máquinas** para cumplir con los requisitos de almacenamiento.


Justificación para la necesidad de esta capacidad para un clúster Hadoop:

Es importante tener un almacenamiento adecuado para manejar grandes volúmenes de datos generados por múltiples fuentes. Un clúster Hadoop distribuye estos datos entre múltiples nodos (máquinas) para realizar un procesamiento y almacenamiento redundante, lo que garantiza la tolerancia a fallos y el rendimiento escalable. Además, Hadoop utiliza el modelo de programación MapReduce, que permite procesar grandes conjuntos de datos de manera paralela, lo que requiere una infraestructura de almacenamiento adecuada para manejar eficientemente estos datos.

Indicar que el ecosistema Hadoop incluye herramientas como Hive o Sqoop que facilitan el procesamiento de grandes cantidades de datos, algo necesario si se trabaja con Terabytes de datos.


## EJERCICIO 3

- Herramientas del ecosistema Hadoop según los requisitos de cada caso de uso:

1. Herramienta de BI - Microstrategy:
    - Posibles herramientas de Hadoop: Hive, Impala, Drill
    - Ventajas e inconvenientes:
        - Hive: Es una herramienta de almacenamiento y consulta de datos basada en SQL que permite ejecutar consultas SQL sobre datos almacenados en Hadoop. Es fácil de usar y ampliamente compatible con herramientas de BI. Sin embargo, puede ser más lento en comparación con Impala o Drill para consultas interactivas.

        - Impala: Proporciona un acceso rápido a datos almacenados en Hadoop utilizando un motor de consulta MPP (procesamiento en paralelo masivo). Es altamente eficiente para consultas interactivas y tiene una baja latencia. Sin embargo, puede consumir mucha RAM, especialmente para consultas complejas o de gran escala.
        
        - Apache Drill: Es una herramienta de consulta SQL interactiva y distribuida que permite consultar datos de varios sistemas de almacenamiento sin necesidad de moverlos. Es altamente escalable y ofrece una latencia muy baja para consultas ad hoc. Sin embargo, puede requerir una configuración más compleja en comparación con Hive o Impala.

2. Web de consultas sobre pedidos realizados:
    - Posibles herramientas de Hadoop: Phoenix, HBase
    - Ventajas e inconvenientes:
        - Phoenix: Es una capa SQL sobre HBase que permite ejecutar consultas SQL sobre datos en tiempo real. Proporciona una alta velocidad de consulta y es compatible con herramientas de BI. Sin embargo, puede tener una curva de aprendizaje más pronunciada y requiere un diseño adecuado de tablas en HBase.
        
        - HBase: Es una base de datos NoSQL distribuida y escalable que puede manejar grandes volúmenes de datos y proporcionar acceso aleatorio a ellos. Es ideal para aplicaciones que requieren acceso rápido a datos en tiempo real. Sin embargo, puede requerir una administración más compleja y no es compatible directamente con SQL.

3. Generación de informes SQL usando R que se ejecutan mensualmente:
    - Posibles herramientas de Hadoop: Hive, Spark SQL
    - Ventajas e inconvenientes:
        - Hive: Como se mencionó anteriormente, Hive es una herramienta de almacenamiento y consulta de datos basada en SQL que puede ser utilizada para ejecutar consultas SQL sobre datos en Hadoop. Es compatible con R a través de diversas interfaces y proporciona un acceso fácil a datos estructurados. Sin embargo, puede ser más lento en comparación con Spark SQL para ciertas operaciones.
        
        - Spark SQL: Es un módulo de Apache Spark que permite ejecutar consultas SQL sobre datos distribuidos en Hadoop de manera eficiente. Es altamente escalable y puede procesar grandes volúmenes de datos rápidamente. Además, es compatible con R a través de bibliotecas como Sparklyr. Sin embargo, puede requerir más recursos computacionales en comparación con Hive para operaciones complejas.

4. Recopilación de información de redes sociales:
    - Posibles herramientas de Hadoop: Flume, Kafka, Spark
    - Ventajas e inconvenientes:
        - Flume: Es una herramienta de ingestión de datos distribuida y confiable que permite recopilar datos de diversas fuentes y cargarlos en Hadoop. Es fácil de configurar y puede integrarse con fuentes de datos externas como redes sociales. Sin embargo, puede ser menos escalable que Kafka para ciertos escenarios de alta velocidad de ingestión.

        - Kafka: Es una plataforma de streaming distribuida que puede manejar grandes volúmenes de datos en tiempo real. Es altamente escalable y puede garantizar la tolerancia a fallos y la entrega de mensajes. Es ideal para escenarios donde se requiere una ingestión de datos de alta velocidad y una transmisión en tiempo real, como la recopilación de información de redes sociales. Sin embargo, puede requerir una configuración más compleja y un mayor esfuerzo de administración en comparación con Flume.

        - Spark es un framework de procesamiento de datos en memoria que proporciona capacidades de análisis distribuido. Permite realizar operaciones complejas de procesamiento de datos de manera eficiente y escalable, aprovechando la memoria RAM para acelerar el procesamiento. Los inconvenientes son que requiere una infraestructura robusta y configuración compleja para gestionar la ingesta de datos en tiempo real y garantizar un procesamiento eficiente. Tiene un curva pronunciada de aprendizaje.
