from confluent_kafka import Producer
import json
import sys
import time

# Configuración del productor
conf = {'bootstrap.servers': "localhost:9092"}

# Crear productor
producer = Producer(**conf)

def delivery_report(err, msg):
    """Callback de entrega de mensajes."""
    if err is not None:
        print(f"Message delivery failed: {err}")
    else:
        print(f"Message delivered to {msg.topic()} [{msg.partition()}]")

def read_file_and_produce(file_path, topic):
    """Leer archivo y producir mensajes a Kafka."""
    with open(file_path, 'r') as file:
        for line in file:
            producer.produce(topic, key=str(time.time()), value=line.strip(), callback=delivery_report)
            producer.poll(0)

    producer.flush()

if __name__ == "__main__":
    file_path = 'path/to/your/file.txt'  # Cambia esto por la ruta de tu archivo
    topic = 'test_topic'
    read_file_and_produce(file_path, topic)
