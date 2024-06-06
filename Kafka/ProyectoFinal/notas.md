PROBLEMAS:
- KAFKA_CREATE_TOPICS: 'input-topic:3:3' No crea topics con 3 particiones y un factor de replicación 3.
- Los mensajes que recibe el topic input-topic vienen repetidos por 3.
- ¿Puedo hacer la agregación de datos con ksqldb?
- Configuraciones manuales? Cargar sólo mensajes nuevos?
- Hacer tests?

Reiniciar después de hacer cambios:
$ docker-compose up -d --build
$ docker-compose up -d --build sentiment-analysis (nombre del servicio que se ha hecho cambios)
$ docker-compose down && docker-compose up -d

Crear topic manualmente si no se crea al lanzar el docker-compose.yaml:
$ docker-compose exec broker kafka-topics --bootstrap-server localhost:9092 --create --topic input-topic --partitions 1 --replication-factor 1

___________________________________________________________
REQUERIMIENTOS:
- docker / docker desktop

EJECUTAR LA APLICACION
    Iniciar servicios:
        $ docker-compose up -d
    Verificar si todos los servicios están funcionando correctamente:
        $ docker-compose ps
    Reiniciar algún servicio si fuese necesario (alguna vez se han detenido en broker, creo que por sobrecalientamiento del ordenador):
        $ docker-compose restart nombre_del_servicio
    Ejecutar app Sentiment Analysis:
        > Esperar unos segundos hasta que todos los servicios estén corriendo correctamente
        $ docker-compose exec sentiment-analysis bash -c "python3 read_CSV.py & python3 consumer.py"
        > Imprime todos los mensajes del archivo dataset.csv mostrando el texto, la polaridad y la Subjetividad. Ejemplo:
            Text: 'Please ignore prior tweets, as that was someone pretending to be me :)  This is actually me.', Polarity: 0.16666666666666666, Subjectivity: 0.3666666666666667

INFORMACIÓN TOPICS:
    Ver los topics que se han creado:
        $ docker-compose exec broker kafka-topics --list --bootstrap-server localhost:9092
    Información de un topic:
        $ docker-compose exec broker kafka-topics --bootstrap-server localhost:9092 --describe --topic input-topic
        $ docker-compose exec broker kafka-topics --bootstrap-server localhost:9092 --describe --topic results-topic
    Mensajes recibidos en el topic 'input-topic':
        $ docker-compose exec broker kafka-console-consumer --bootstrap-server localhost:9092 --topic input-topic --from-beginning
    Mensajes recibidos en el topic 'results-topic':
        $ docker-compose exec broker kafka-console-consumer --bootstrap-server localhost:9092 --topic results-topic --from-beginning

MONGO
    Acceder a la base de datos:
        $ docker exec -it mongodb bash
        $ mongo --username admin --password admin --authenticationDatabase admin
        $ use sentiment_analysis
        $ db.results.find().pretty()
        > Ejemplo:
            {
                "_id" : ObjectId("665e15647b85a49dbd07504d"),
                "text" : "@DaveLeeBBC @verge Coal is dying due to nat gas fracking. It's basically dead.",
                "polarity" : -0.1625,
                "subjectivity" : 0.3875
            }
        $ exit

Ejecución Queries:
    - Con KSQL:
        Aceder a KSQLDB:
            $ docker-compose exec ksqldb-cli ksql http://ksqldb-server:8088
        - Imprimir todos los mensajes del topic 'input-topic':
            $ CREATE STREAM input_topic_data (message VARCHAR) 
            WITH (KAFKA_TOPIC='input-topic', VALUE_FORMAT='DELIMITED');
            $ SELECT * FROM input_topic_data;

    - Con Python:
        Media de sentimiento:
            $ docker-compose exec sentiment-analysis python3 /app/queries/query_average_sentiment.py
        Mensajes negativos:
            $ docker-compose exec sentiment-analysis python3 /app/queries/negative_messages.py

INTERFAZ CONTROL CENTER:
    Acceso a la interfaz 'Control Center': http://127.0.0.1:9021
    
___________________________________________________
Polarity (Polaridad)
La polaridad mide la orientación emocional del texto. Es un valor que varía entre -1.0 y 1.0:
Valores negativos (cercanos a -1.0) indican un sentimiento negativo.
Valores positivos (cercanos a 1.0) indican un sentimiento positivo.
Un valor de 0 indica un sentimiento neutral.
Por ejemplo, en el contexto de análisis de sentimientos:
Una frase como "I love this product!" podría tener una polaridad alta (cercana a 1.0).
Una frase como "I hate this service." podría tener una polaridad baja (cercana a -1.0).
Una frase como "The product is okay." podría tener una polaridad cercana a 0.

Subjectivity (Subjetividad)
La subjetividad mide cuán subjetivo u objetivo es el texto. Es un valor que varía entre 0.0 y 1.0:
Un valor de 0.0 indica que el texto es completamente objetivo (basado en hechos).
Un valor de 1.0 indica que el texto es completamente subjetivo (basado en opiniones).
Por ejemplo:
Una frase como "The capital of France is Paris." es objetiva y tendría una subjetividad baja (cercana a 0.0).
Una frase como "I think this movie is fantastic." es subjetiva y tendría una subjetividad alta (cercana a 1.0).
_____________________________________________________
Uso de MongoDB como mecanismo de consumo de la información. Fases:
1. Producción de mensajes: Los mensajes (textos) se producen y se envían a un 'topic' de Kafka mediante un productor.
2. Consumo de mensajes: Los mensajes del 'topic' de Kafka se consumen mediante un consumidor.
3. Procesamiento de mensajes: Los mensajes consumidos se analizan para determinar su polaridad y subjetividad utilizando la librería TextBlob.
4. Almacenamiento de resultados: Los resultados del análisis (textos junto con sus puntuaciones de polaridad y subjetividad) se almacenan en una base de datos MongoDB permitiendo su posterior acceso, consulta y análisis.

Elección de MongoDB:
Ventajas:
- Flexible y Escalable: Maneja datos semi-estructurados y permite escalar horizontalmente.
- Alta Disponibilidad: Ofrece replicación y distribución de datos.
- Fácil Integración: Buen soporte con varias bibliotecas y herramientas modernas.
- Indexación y Consulta Rápida: Permite realizar consultas rápidas y eficientes.
- Manipulación Flexible de los datos: Permite almacenar datos de texto plano, CSV, datos de Twitter y otros tipos en la misma base de datos.
Desventajas:
- Consistencia Eventual: Puede no ser tan fuerte como las garantías ACID completas en todas las situaciones.

2ª opción: Elasticsearch
Ventajas:
- Búsqueda y Análisis en Tiempo Real: Diseñado para búsqueda y análisis rápidos.
- Escalabilidad: Altamente escalable y distribuido.
- Flexible: Maneja datos semi-estructurados.
Desventajas:
- No ACID Completo: No ofrece garantías ACID completas.
- Curva de Aprendizaje: Puede requerir tiempo para aprender a optimizar consultas y configuraciones.

> Aunque para el análisis en tiempo real puede ser mejor Elasticsearch, he elegigo MongoDB por que creo que tiene una manipulación y almacenamiento de datos más flexible, lo que supone una mayor variedad de casos de uso.
______________________________________________________
Servicios incluidos en docker-compose.yaml:
- zookeeper: Este servicio proporciona la funcionalidad de coordinación distribuida necesaria para Kafka. Zookeeper administra y coordina los brokers de Kafka para garantizar que la operación del clúster sea coordinada y confiable.
- broker: Este servicio es el broker de Kafka en sí mismo. Es el componente central de Kafka que administra el almacenamiento y la transmisión de los mensajes. Este broker está configurado para permitir conexiones en los puertos 9092 y 9101.
- schema-registry: El registro de esquemas es una herramienta clave cuando trabajas con datos estructurados en Kafka. Permite almacenar y recuperar esquemas de Avro que se utilizan para la serialización y deserialización de mensajes.
- connect: Este servicio proporciona una forma de conectar Kafka con otros sistemas, como bases de datos, sistemas de almacenamiento en la nube, sistemas de procesamiento de datos, etc. Esencialmente, Kafka Connect facilita la integración de Kafka con el ecosistema de datos existente.
- control-center: El Control Center de Confluent es una interfaz gráfica de usuario para administrar y monitorear clústeres de Kafka. Proporciona métricas detalladas, alertas, monitoreo de consumidores, etc.
- ksqldb-server: Este servicio ejecuta un servidor de ksqlDB, que es una base de datos de flujo de eventos que se ejecuta en la parte superior de Kafka. Permite realizar consultas SQL en tiempo real sobre flujos de datos de Kafka.
- ksqldb-cli: Es la interfaz de línea de comandos (CLI) para interactuar con ksqlDB. 
- mongodb: Este servicio está utilizando la imagen oficial de MongoDB. Proporciona una instancia de MongoDB que se puede utilizar para almacenar datos de manera persistente. Está configurado con un nombre de usuario y contraseña para acceder a la base de datos.
- sentiment-analysis: Este servicio es la propia aplicación, que está construida a partir del contexto del directorio ./app. Depende de los servicios de Kafka y MongoDB para su funcionamiento.
_____________________________________________________
Razones por las que podría ser beneficioso que el broker de Kafka cree más topics:

- Separación de responsabilidades: Puedes tener diferentes temas para diferentes tipos de datos o para diferentes partes de tu aplicación. Por ejemplo, puedes tener un tema para los tweets recopilados, otro para los datos procesados y otro para los resultados del análisis de sentimientos. Esto ayuda a mantener una separación clara de las responsabilidades y facilita la administración y el mantenimiento del sistema.

- Escalabilidad: Al tener más temas, puedes distribuir la carga de trabajo de manera más eficiente entre los diferentes consumidores. Si tienes diferentes partes de tu aplicación que requieren diferentes niveles de procesamiento o paralelismo, puedes ajustar la configuración de particiones y consumidores para cada tema según sea necesario.

- Durabilidad y retención de datos: Puedes configurar la retención de datos y las políticas de compactación de registros para cada tema según tus requisitos específicos. Esto te permite controlar cuánto tiempo se retienen los datos en cada tema y cómo se gestionan los datos obsoletos.

- Administración y monitorización: Al tener más temas, puedes obtener una mejor visibilidad sobre el flujo de datos en tu sistema. Puedes monitorear el rendimiento de cada tema individualmente y ajustar la configuración según sea necesario para optimizar el rendimiento y la fiabilidad.