from confluent_kafka import Producer
import os

kafka_broker = os.getenv('KAFKA_BROKER', 'broker:29092')
kafka_topic = os.getenv('KAFKA_TOPIC', 'input-topic')

p = Producer({'bootstrap.servers': kafka_broker})

def delivery_report(err, msg):
    if err is not None:
        print('Message delivery failed: {}'.format(err))
    else:
        print('Message delivered to {} [{}]'.format(msg.topic(), msg.partition()))

with open('data.txt', 'r') as file:
    for line in file:
        p.produce(kafka_topic, line.strip(), callback=delivery_report)
        p.poll(1)

p.flush()
