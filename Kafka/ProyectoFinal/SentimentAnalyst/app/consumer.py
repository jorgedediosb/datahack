
from confluent_kafka import Consumer, KafkaException
from textblob import TextBlob
from pymongo import MongoClient
import os

kafka_broker = os.getenv('KAFKA_BROKER', 'broker:29092')
kafka_topic = os.getenv('KAFKA_TOPIC', 'input-topic')
kafka_group_id = os.getenv('KAFKA_GROUP_ID', 'sentiment_group')
mongo_uri = os.getenv('MONGO_URI', 'mongodb://admin:admin@mongo:27017/')

consumer = Consumer({
    'bootstrap.servers': kafka_broker,
    'group.id': kafka_group_id,
    'auto.offset.reset': 'earliest'
})

consumer.subscribe([kafka_topic])

mongo_client = MongoClient(mongo_uri)
db = mongo_client.sentiment_analysis
collection = db.results

def save_result(text, polarity, subjectivity):
    collection.insert_one({
        'text': text,
        'polarity': polarity,
        'subjectivity': subjectivity
    })

def analyze_sentiment(text):
    blob = TextBlob(text)
    return blob.sentiment.polarity, blob.sentiment.subjectivity

def consume_messages():
    try:
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
            polarity, subjectivity = analyze_sentiment(text)
            save_result(text, polarity, subjectivity)
            print(f"Text: {text}, Polarity: {polarity}, Subjectivity: {subjectivity}")

    except KeyboardInterrupt:
        pass
    finally:
        consumer.close()

if __name__ == '__main__':
    consume_messages()
'''
from confluent_kafka import Consumer, KafkaException
import os
from textblob import TextBlob
from pymongo import MongoClient

kafka_broker = os.getenv('KAFKA_BROKER', 'broker:29092')
kafka_topic = os.getenv('KAFKA_TOPIC', 'input-topic')
kafka_group_id = os.getenv('KAFKA_GROUP_ID', 'sentiment_group')
mongo_uri = os.getenv('MONGO_URI', 'mongodb://admin:admin@mongo:27017/')

# Configurar el consumidor de Kafka
consumer = Consumer({
    'bootstrap.servers': kafka_broker,
    'group.id': kafka_group_id,
    'auto.offset.reset': 'earliest'
})

# Conectar a MongoDB
client = MongoClient(mongo_uri)
db = client.sentiment_analysis
collection = db.sentiments

def analyze_sentiment(text):
    blob = TextBlob(text)
    return blob.sentiment.polarity, blob.sentiment.subjectivity

def consume_loop(consumer, topics):
    try:
        consumer.subscribe(topics)
        while True:
            msg = consumer.poll(timeout=1.0)
            if msg is None:
                continue
            if msg.error():
                if msg.error().code() == KafkaError._PARTITION_EOF:
                    continue
                else:
                    raise KafkaException(msg.error())
            text = msg.value().decode('utf-8')
            polarity, subjectivity = analyze_sentiment(text)
            sentiment_data = {
                'text': text,
                'polarity': polarity,
                'subjectivity': subjectivity
            }
            print(f"Polarity: {polarity}, Subjectivity: {subjectivity}")
            collection.insert_one(sentiment_data)
    finally:
        consumer.close()

if __name__ == '__main__':
    consume_loop(consumer, [kafka_topic])

'''