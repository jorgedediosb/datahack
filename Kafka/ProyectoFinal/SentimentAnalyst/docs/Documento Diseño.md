**DOCUMENTO DE DISEÑO**

COMPONENTES:

KAFKA:
    - Zookeeper: Proporciona la funcionalidad de coordinación distribuida necesaria para Kafka. Zookeeper administra y coordina los brokers de Kafka para garantizar que la operación del clúster sea coordinada y confiable.

    - Broker: Es el componente que administra el almacenamiento y la transmisión de los mensajes. Crea el topic 'input-topic' que recibe los mensajes del Productor. Una vez recibidos, el consumidor los analiza y envía el resultado al topic 'results-topic'

    - Schema-registry: Permite almacenar y recuperar esquemas de Avro que se utilizan para la serialización y deserialización de mensajes.

    - Connect: Poroporciona la conexión entre Kafka y el resto de componentes. Gestiona el conector que envía los datos del topic 'results-topic' a MongoDB.

    - Connector-registration: ejecuta de forma automática el conector 'mongo-sink-results.json' (en la carpeta 'connectors') para enviar los datos del topic 'results-topic' a Mongo. Se ejecuta gracias al plugin de Mongo (en la carpeta 'plugins'). Es un servicio que depende de 'Connect' pero tenerlo separado ofrece  mayor flexibilidad y simplicidad. Una vez se despliega el docker-compose, este servicio 'expira' ya que está esperando a que se ejecute la app para recibir los datos y enviarlos a Mongo. El connector tarda unos segundos en estar activo una vez se ejecuta la aplicación.

    - Control-center: Es una interfaz gráfica para administrar y monitorear el clúster de Kafka. Proporciona métricas, monitoreo de consumidores, información sobre topics y conectores, etc. Tarda en arrancar.

    - Ksqldb-server: Ejecuta un servidor ksqlDB, que es una base de datos de flujo de eventos. Permite realizar las consultas SQL en tiempo real.

    - Ksqldb-cli: Es la interfaz de línea de comandos (CLI) para interactuar con ksqlDB. 

    - Mongodb: Almacena los mensajes analizados por el Consumidor y enviados por el Conector. Está configurado con un nombre de usuario (admin) y contraseña (admin) para acceder a la base de datos donde se guardan (sentiment_analysis).

APP
    - Sentiment-analysis: Es la propia aplicación de análisis de sentimiento. Está construida a partir del directorio ./app que incluye (en orden de ejecución):

        - requirements.txt: requerimientos para la ejecución de los scripts (en la imagen de la app que se construye con el dockerfile)
        - dataset.csv: Dataset con Tweets (de Elon Musk).
        - read_CSV.py: Script que transforma los Tweets del dataset cogiendo sólo el texto y mandánsolo como líneas individuales a data.txt 
        - data.txt: Recibe los textos de los tweets en líneas individuales.
        - producer.py: Es el productor.  Script que recoge los datos de data.txt y los envía al topic 'input-topic'
        - consumer.py: Es el consumidor. Script que recoge los datos del topic 'input-topic', los analiza y los manda al topic 'results-topic'
        - Queries: Scripts que ejecutan las consultas en MongoDB sentimiento medio y mensajes negativos.


