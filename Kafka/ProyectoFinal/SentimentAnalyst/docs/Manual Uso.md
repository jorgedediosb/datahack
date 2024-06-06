**MANUAL DE USO**

INFORMACIÓN TOPICS:

    - Topics creados:
        $ docker-compose exec broker kafka-topics --list --bootstrap-server localhost:9092

    - Información de un topic:
        $ docker-compose exec broker kafka-topics --bootstrap-server localhost:9092 --describe --topic input-topic
        $ docker-compose exec broker kafka-topics --bootstrap-server localhost:9092 --describe --topic results-topic
    
    - Mensajes recibidos en el topic 'input-topic':
        $ docker-compose exec broker kafka-console-consumer --bootstrap-server localhost:9092 --topic input-topic --from-beginning
    
    - Mensajes recibidos en el topic 'results-topic':
        $ docker-compose exec broker kafka-console-consumer --bootstrap-server localhost:9092 --topic results-topic --from-beginning

MONGODB
    - Acceso:
        $ docker exec -it mongodb bash
        $ mongo --username admin --password admin --authenticationDatabase admin
        $ use sentiment_analysis

    - Imprimir datos:
        $ db.results.find().pretty()
        > Ejemplo:
            {
                "_id" : ObjectId("665e15647b85a49dbd07504d"),
                "text" : "@DaveLeeBBC @verge Coal is dying due to nat gas fracking. It's basically dead.",
                "polarity" : -0.1625,
                "subjectivity" : 0.3875
            }
        $ exit

EJECICIÓN QUERIES:

    - Con KSQL:
        Aceder a KSQLDB:
            $ docker-compose exec ksqldb-cli ksql http://ksqldb-server:8088
            
        - Imprimir todos los mensajes del topic 'input-topic':
            $ CREATE STREAM input_topic_data (message VARCHAR) 
            WITH (KAFKA_TOPIC='input-topic', VALUE_FORMAT='DELIMITED');
            $ SELECT * FROM input_topic_data;
    
    - Con Python:
        - Media de sentimiento:
            $ docker-compose exec sentiment-analysis python3 /app/queries/query_average_sentiment.py
            Salida:
                Average Polarity: 0.14234062933555217
                Average Subjectivity: 0.34904894054548186
            
        - Mensajes negativos:
            $ docker-compose exec sentiment-analysis python3 /app/queries/negative_messages.py
            Salida:
                Text: 'Got called randomly by Kanye West today and received a download of his thoughts, ranging from shoes to Moses. He was polite, but opaque.', Polarity: -0.5


INTERFAZ CONTROL CENTER:
    - Acceso a la interfaz 'Control Center': http://127.0.0.1:9021