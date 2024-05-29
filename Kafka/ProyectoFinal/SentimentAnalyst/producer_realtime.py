import sys
import json
import uuid
from confluent_kafka import Producer

# Configuración de Kafka
bootstrap_servers = '127.0.0.1:9092'
topic = 'realtime-tweets'

def delivery_report(err, msg):
    if err is not None:
        print('Message delivery failed: {}'.format(err))
    else:
        print('Message delivered to {}'.format(msg.topic()))

def confluent_kafka_producer():
    p = Producer({'bootstrap.servers': bootstrap_servers})
    
    print("Enter messages (type 'exit' to quit):")
    while True:
        message = input('>> ')
        if message.lower() == 'exit':
            break

        record_key = str(uuid.uuid4())
        record_value = json.dumps({'data': message})
        
        p.produce(topic, key=record_key, value=record_value, on_delivery=delivery_report)
        p.poll(0)

    p.flush()
    print('Producer has been stopped.')

if __name__ == "__main__":
    confluent_kafka_producer()
