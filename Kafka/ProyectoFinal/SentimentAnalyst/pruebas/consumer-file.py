# consumer_file.py
from kafka import KafkaConsumer
import json
from nltk.sentiment.vader import SentimentIntensityAnalyzer
import nltk

nltk.download('vader_lexicon')

def confluent_kafka_consumer(bootstrap_servers, group_id, topic):
    consumer = KafkaConsumer(
        topic,
        bootstrap_servers=bootstrap_servers,
        auto_offset_reset='earliest',
        enable_auto_commit=True,
        group_id=group_id,
        value_deserializer=lambda x: json.loads(x.decode('utf-8'))
    )

    sid = SentimentIntensityAnalyzer()

    for message in consumer:
        record_value = message.value
        data = record_value['data']
        sentiment = sid.polarity_scores(data)
        print(f'Message: {data}')
        print(f'Sentiment: {sentiment}')

if __name__ == '__main__':
    bootstrap_servers = '127.0.0.1:9092'
    group_id = 'file-text-group'
    topic = 'file-text'
    confluent_kafka_consumer(bootstrap_servers, group_id, topic)
