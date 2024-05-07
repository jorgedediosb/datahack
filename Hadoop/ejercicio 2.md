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
2.000 eventos/día × 1.500 KB/evento = 3.000.000 KB/día

Sumando las dos fuentes, obtenemos el total KB/día:
150.000 KB/día + (35.156,25 KB/día + 15.000.000 + 136.000.000 + 3.000.000) = 154.035.156,25 KB/día

Para calcular el almacenamiento para un año:
154.035.156,25 KB/día × 365 días = 56.222.832.031,25 KB/año

Convertimos a terabytes (TB) para compararlo con la capacidad de las máquinas
1 TB = 1024 × 1024 × 1024 KB = 1.073.741.824 KB tenemos:
56.222.832.031,25 KB/año ÷ (1024 × 1024 × 1024) KB/TB = 52,36 TB/año

Cada máquina puede tener hasta 22 discos de 2 terabytes cada uno, la capacidad total de almacenamiento por máquina es:
22 discos × 2 TB/disco = 44 TB/máquina

Nº de máquinas necesarias:
52,36 TB/año ÷ 44 TB/máquina ≈ 1,19 máquinas

Necesitaríamos **2 máquinas** para cumplir con los requisitos de almacenamiento.


**Justificación para la necesidad de esta capacidad para un clúster Hadoop:**

Es importante tener un almacenamiento adecuado para manejar grandes volúmenes de datos generados por múltiples fuentes. Un clúster Hadoop distribuye estos datos entre múltiples nodos (máquinas) para realizar un procesamiento y almacenamiento redundante, lo que garantiza la tolerancia a fallos y el rendimiento escalable.

Hadoop utiliza el modelo MapReduce y HDFS, que permiten procesar grandes conjuntos de datos de forma paralela, lo que requiere una infraestructura de almacenamiento adecuada para manejar eficientemente estos datos.

El ecosistema Hadoop incluye herramientas como Hive o Sqoop, herramientas necesarias si se trabaja con Terabytes de datos.
