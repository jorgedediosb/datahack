Crear topic manualmente si no se crea al lanzar el docker-compose.yaml:
$ docker-compose exec broker kafka-topics --bootstrap-server localhost:9092 --create --topic input-topic --partitions 1 --replication-factor 1

Reiniciar servicio:
$ docker-compose restart sentiment-analysis

Ver los topics del broker:
$ docker-compose exec broker kafka-topics --bootstrap-server localhost:9092 --list

verificar si el servicio está funcionando correctamente:
$ docker-compose exec sentiment-analysis ps aux


Iniciar servicios:
$ docker-compose up -d

Enviar los datos al tópico de Kafka, accede al contenedor del servicio de análisis de sentimiento y ejecuta el productor:
$ docker-compose exec sentiment-analysis bash
$ python producer.py

Leer datos en el consumidor (en otra terminal):
$ docker-compose exec sentiment-analysis bash
$ python consumer.py

Acceder al contenedor mongo:
$ docker ps (para ver el ID del contenedor)
$ docker exec -it ID_Contenedor /bin/bash
ó
$ docker exec -it mongo bash
$ mongo --username admin --password admin --authenticationDatabase admin
$ use sentiment_analysis
$ db.results.find().pretty()

Reiniciar:
$ docker-compose down && docker-compose up -d

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