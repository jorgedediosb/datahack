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
