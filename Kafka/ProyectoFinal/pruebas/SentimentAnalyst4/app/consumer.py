from confluent_kafka import Consumer, KafkaException, Producer
from textblob import TextBlob
import os
import json

kafka_broker = os.getenv('KAFKA_BROKER', 'broker:29092')
kafka_topic = os.getenv('KAFKA_TOPIC', 'input-topic')
kafka_group_id = os.getenv('KAFKA_GROUP_ID', 'sentiment_group')
results_topic = os.getenv('RESULTS_TOPIC', 'results-topic')

consumer = Consumer({
    'bootstrap.servers': kafka_broker,
    'group.id': kafka_group_id,
    'auto.offset.reset': 'earliest'  # Cambiar a 'latest' para ignorar los mensajes iniciales
})

producer = Producer({
    'bootstrap.servers': kafka_broker
})

consumer.subscribe([kafka_topic])

def analyze_sentiment(text):
    blob = TextBlob(text)
    return blob.sentiment.polarity, blob.sentiment.subjectivity

def produce_result(text, polarity, subjectivity):
    result = {
        'text': text,
        'polarity': polarity,
        'subjectivity': subjectivity
    }
    producer.produce(results_topic, json.dumps(result).encode('utf-8'))

def consume_messages():
    try:
        initial_messages = set()  # Conjunto para almacenar los mensajes iniciales recibidos
        while True:
            msg = consumer.poll(1.0)
            if msg is None:
                continue
            if msg.error():
                if msg.error().code() == KafkaException._PARTITION_EOF:
                    continue
                else:
                    print(msg.error())
                    break

            text = msg.value().decode('utf-8')
            if text not in initial_messages:  # Verificar si el mensaje es nuevo
                polarity, subjectivity = analyze_sentiment(text)
                produce_result(text, polarity, subjectivity)
                print(f"Text: {text}, Polarity: {polarity}, Subjectivity: {subjectivity}")
                initial_messages.add(text)  # Agregar el mensaje al conjunto de mensajes iniciales

    except KeyboardInterrupt:
        pass
    finally:
        consumer.close()
        producer.flush()

if __name__ == '__main__':
    consume_messages()
