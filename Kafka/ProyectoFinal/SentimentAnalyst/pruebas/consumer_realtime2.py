from confluent_kafka import Consumer, KafkaError
from nltk.sentiment.vader import SentimentIntensityAnalyzer
import nltk

# Descargar el lexicon de VADER
nltk.download('vader_lexicon')

# Configuración del consumidor
conf = {
    'bootstrap.servers': "localhost:9092",
    'group.id': "group1",
    'auto.offset.reset': 'earliest'
}

# Crear consumidor
consumer = Consumer(**conf)
consumer.subscribe(['test_topic'])

# Inicializar el analizador de sentimientos
sid = SentimentIntensityAnalyzer()

# Consumir mensajes y realizar análisis de sentimientos
try:
    while True:
        msg = consumer.poll(timeout=1.0)
        if msg is None:
            continue
        if msg.error():
            if msg.error().code() == KafkaError._PARTITION_EOF:
                continue
            else:
                print(msg.error())
                break
        text = msg.value().decode('utf-8')
        sentiment = sid.polarity_scores(text)
        print(f"Received message: {text}")
        print(f"Sentiment Analysis: {sentiment}")
finally:
    # Cerrar consumidor
    consumer.close()
