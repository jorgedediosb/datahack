# producer_file.py
from kafka import KafkaProducer
import json
import uuid

def read_file(file_path):
    with open(file_path, 'r') as file:
        lines = file.readlines()
    return lines

def confluent_kafka_producer(file_path, bootstrap_servers, topic):
    producer = KafkaProducer(
        bootstrap_servers=bootstrap_servers,
        value_serializer=lambda v: json.dumps(v).encode('utf-8')
    )

    messages = read_file(file_path)
    for message in messages:
        record_key = str(uuid.uuid4())
        record_value = {'data': message.strip()}
        producer.send(topic, key=record_key.encode('utf-8'), value=record_value)
    producer.flush()
    print(f'Sent {len(messages)} messages to {bootstrap_servers}')

if __name__ == '__main__':
    file_path = 'path_to_your_file.txt'  # Update this with your file path
    bootstrap_servers = '127.0.0.1:9092'
    topic = 'file-text'
    confluent_kafka_producer(file_path, bootstrap_servers, topic)
