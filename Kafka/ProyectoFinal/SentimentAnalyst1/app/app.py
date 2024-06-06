import os
from confluent_kafka import Consumer, KafkaError
from textblob import TextBlob

KAFKA_BROKER = os.getenv('KAFKA_BROKER')
KAFKA_TOPIC = os.getenv('KAFKA_TOPIC')
KAFKA_GROUP_ID = os.getenv('KAFKA_GROUP_ID')

def analyze_sentiment(text):
    analysis = TextBlob(text)
    return analysis.sentiment.polarity, analysis.sentiment.subjectivity

def consume_messages():
    consumer = Consumer({
        'bootstrap.servers': KAFKA_BROKER,
        'group.id': KAFKA_GROUP_ID,
        'auto.offset.reset': 'earliest'
    })
    consumer.subscribe([KAFKA_TOPIC])

    while True:
        msg = consumer.poll(1.0)
        if msg is None:
            continue
        if msg.error():
            if msg.error().code() == KafkaError._PARTITION_EOF:
                continue
            else:
                print(msg.error())
                break

        text = msg.value().decode('utf-8')
        polarity, subjectivity = analyze_sentiment(text)
        print(f"Text: {text}, Polarity: {polarity}, Subjectivity: {subjectivity}")

    consumer.close()

if __name__ == "__main__":
    consume_messages()
