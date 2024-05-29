import os
from confluent_kafka import Producer

KAFKA_BROKER = os.getenv('KAFKA_BROKER')
KAFKA_TOPIC = os.getenv('KAFKA_TOPIC')

def delivery_report(err, msg):
    if err is not None:
        print('Message delivery failed: {}'.format(err))
    else:
        print('Message delivered to {} [{}]'.format(msg.topic(), msg.partition()))

p = Producer({'bootstrap.servers': KAFKA_BROKER})

with open('data.txt', 'r') as file:
    for line in file:
        p.produce(KAFKA_TOPIC, line.strip(), callback=delivery_report)
        p.poll(0)

p.flush()
