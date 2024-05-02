**EJERICIO 2**

Para dimensionar el clúster Hadoop y determinar el número de máquinas necesarias, primero necesitamos calcular el almacenamiento total requerido para todos los eventos de películas provenientes de distintas fuentes durante un año.

Primero, calcularemos el tamaño total de datos generados por todas las fuentes por día:

Fuente 1:
10.000 eventos/día × 15 KB/evento = 150.000 KB/día

Fuente 2: 
120.000 eventos/día × 300 Bytes/evento = 36.000.000 Bytes/día
(convertido a KB: 36.000.000 Bytes/día ÷ 1.024 = 35.156,25 KB/día)

Sumando ambos, obtenemos el total de KB por día de ambas fuentes:
150.000 KB/día + 35.156,25 KB/día = 185.156,25 KB/día

Para calcular el almacenamiento total requerido para un año, multiplicaremos este valor por 365 (días en un año):
185.156,25 KB/día × 365 días/año = 67.582.031,25 KB/año

Ahora, necesitamos convertir esto a terabytes (TB) para compararlo con la capacidad de las máquinas.
Como: 1 TB = 1024 × 1024 × 1024 KB, tenemos:
67.582.031,25 KB/año ÷ (1024 × 1024 × 1024) KB/TB ≈ 67,58 TB/año

Dado que cada máquina puede tener hasta 22 discos de 2 terabytes cada uno, la capacidad total de almacenamiento por máquina es de:
22 discos × 2 TB/disco = 44 TB/máquina

Para calcular el número de máquinas necesarias, dividimos el almacenamiento total requerido para un año por la capacidad de almacenamiento por máquina:
63.17 TB/año ÷ 44 TB/máquina ≈ 1.44 máquinas

Dado que no podemos tener una fracción de una máquina, necesitaríamos al menos 2 máquinas para cumplir con los requisitos de almacenamiento.


En cuanto a la justificación de por qué se necesita esta capacidad para un clúster Hadoop, es importante tener un almacenamiento adecuado para manejar grandes volúmenes de datos generados por múltiples fuentes. Un clúster Hadoop distribuye estos datos entre múltiples nodos (máquinas) para procesamiento y almacenamiento redundante, lo que garantiza la tolerancia a fallos y el rendimiento escalable. Además, Hadoop utiliza el modelo de programación MapReduce, que permite procesar grandes conjuntos de datos de manera paralela, lo que requiere una infraestructura de almacenamiento adecuada para manejar eficientemente estos datos.


**EJERICIO 3**
Para integrar estas herramientas con el ecosistema Hadoop, podemos considerar varias opciones según los requisitos específicos de cada caso de uso:

1. Herramienta de BI (p.ej.: Microstrategy):
    - Posibles herramientas de Hadoop: Hive, Impala, Apache Drill
    - Ventajas e inconvenientes:
        - Hive: Es una herramienta de almacenamiento y consulta de datos basada en SQL que permite ejecutar consultas SQL sobre datos almacenados en Hadoop. Es fácil de usar y ampliamente compatible con herramientas de BI. Sin embargo, puede ser más lento en comparación con Impala o Drill para consultas interactivas.

        - Impala: Proporciona un acceso rápido a datos almacenados en Hadoop utilizando un motor de consulta MPP (procesamiento en paralelo masivo). Es altamente eficiente para consultas interactivas y tiene una baja latencia. Sin embargo, puede consumir mucha RAM, especialmente para consultas complejas o de gran escala.
        
        - Apache Drill: Es una herramienta de consulta SQL interactiva y distribuida que permite consultar datos de varios sistemas de almacenamiento sin necesidad de moverlos. Es altamente escalable y ofrece una latencia muy baja para consultas ad hoc. Sin embargo, puede requerir una configuración más compleja en comparación con Hive o Impala.

2. Web de consultas sobre pedidos realizados:
    - Posibles herramientas de Hadoop: Apache Phoenix, HBase
    - Ventajas e inconvenientes:
        - Apache Phoenix: Es una capa SQL sobre HBase que permite ejecutar consultas SQL sobre datos en tiempo real. Proporciona una alta velocidad de consulta y es compatible con herramientas de BI. Sin embargo, puede tener una curva de aprendizaje más pronunciada y requiere un diseño adecuado de tablas en HBase.
        
        - HBase: Es una base de datos NoSQL distribuida y escalable que puede manejar grandes volúmenes de datos y proporcionar acceso aleatorio a ellos. Es ideal para aplicaciones que requieren acceso rápido a datos en tiempo real. Sin embargo, puede requerir una administración más compleja y no es compatible directamente con SQL.

3. Generación de informes SQL usando R que se ejecutan mensualmente:
    - Posibles herramientas de Hadoop: Apache Hive, Apache Spark SQL
    - Ventajas e inconvenientes:
        - Apache Hive: Como se mencionó anteriormente, Hive es una herramienta de almacenamiento y consulta de datos basada en SQL que puede ser utilizada para ejecutar consultas SQL sobre datos en Hadoop. Es compatible con R a través de diversas interfaces y proporciona un acceso fácil a datos estructurados. Sin embargo, puede ser más lento en comparación con Spark SQL para ciertas operaciones.
        
        - Apache Spark SQL: Es un módulo de Apache Spark que permite ejecutar consultas SQL sobre datos distribuidos en Hadoop de manera eficiente. Es altamente escalable y puede procesar grandes volúmenes de datos rápidamente. Además, es compatible con R a través de bibliotecas como Sparklyr. Sin embargo, puede requerir más recursos computacionales en comparación con Hive para operaciones complejas.

4. Recopilación de información de redes sociales:
    - Posibles herramientas de Hadoop: Apache Flume, Apache Kafka
    - Ventajas e inconvenientes:
        - Apache Flume: Es una herramienta de ingestión de datos distribuida y confiable que permite recopilar datos de diversas fuentes y cargarlos en Hadoop. Es fácil de configurar y puede integrarse con fuentes de datos externas como redes sociales. Sin embargo, puede ser menos escalable que Kafka para ciertos escenarios de alta velocidad de ingestión.

        - Apache Kafka: Es una plataforma de streaming distribuida que puede manejar grandes volúmenes de datos en tiempo real. Es altamente escalable y puede garantizar la tolerancia a fallos y la entrega de mensajes. Es ideal para escenarios donde se requiere una ingestión de datos de alta velocidad y una transmisión en tiempo real, como la recopilación de información de redes sociales. Sin embargo, puede requerir una configuración más compleja y un mayor esfuerzo de administración en comparación con Flume.