from confluent_kafka import Producer, KafkaError
import os
import time

kafka_broker = os.getenv('KAFKA_BROKER', 'broker:29092')
kafka_topic = os.getenv('KAFKA_TOPIC', 'input-topic')

p = Producer({'bootstrap.servers': kafka_broker})

def delivery_report(err, msg):
    if err is not None:
        print('Message delivery failed: {}'.format(err))
    else:
        print('Message delivered to {} [{}]'.format(msg.topic(), msg.partition()))

def produce_from_file():
    with open('data.txt', 'r') as file:
        lines = file.readlines()
        for line in lines:
            p.produce(kafka_topic, line.strip(), callback=delivery_report)
            p.poll(0)
            time.sleep(0.1)  # Añadir un pequeño retraso para evitar saturar el productor

def wait_for_new_lines():
    with open('data.txt', 'r') as file:
        # Ir a la última posición del archivo
        file.seek(0, 2)
        while True:
            # Leer nuevas líneas
            line = file.readline()
            if not line:
                # Si no hay nuevas líneas, esperar un poco antes de revisar nuevamente
                time.sleep(0.1)
                continue
            # Enviar la nueva línea al consumidor
            p.produce(kafka_topic, line.strip(), callback=delivery_report)
            p.poll(0)

if __name__ == '__main__':
    produce_from_file()
    wait_for_new_lines()
