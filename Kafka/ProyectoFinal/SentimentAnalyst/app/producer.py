
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
'''
import time
from watchdog.observers import Observer
from watchdog.events import FileSystemEventHandler
from confluent_kafka import Producer
import os

kafka_broker = os.getenv('KAFKA_BROKER', 'broker:29092')
kafka_topic = os.getenv('KAFKA_TOPIC', 'input-topic')
data_file = 'data.txt'
progress_file = 'progress.txt'

# Configurar el productor de Kafka
producer = Producer({'bootstrap.servers': kafka_broker})

def acked(err, msg):
    if err is not None:
        print(f"Failed to deliver message: {err}")
    else:
        print(f"Message produced: {msg.value().decode('utf-8')}")

def read_progress():
    if not os.path.exists(progress_file):
        return 0
    with open(progress_file, 'r') as f:
        try:
            return int(f.readline().strip())
        except ValueError:
            return 0

def write_progress(lines_processed):
    with open(progress_file, 'w') as f:
        f.write(str(lines_processed))

class FileChangeHandler(FileSystemEventHandler):
    def __init__(self):
        super().__init__()
        self.lines_processed = read_progress()
        self.process_new_lines(initial=True)

    def on_modified(self, event):
        if event.src_path == os.path.abspath(data_file):
            self.process_new_lines()

    def process_new_lines(self, initial=False):
        with open(data_file, 'r') as f:
            lines = f.readlines()
            new_lines = lines[self.lines_processed:]
            for line in new_lines:
                producer.produce(kafka_topic, line.strip(), callback=acked)
                producer.flush()
                self.lines_processed += 1
            write_progress(self.lines_processed)

if __name__ == '__main__':
    event_handler = FileChangeHandler()
    observer = Observer()
    observer.schedule(event_handler, path='.', recursive=False)
    observer.start()
    try:
        while True:
            time.sleep(1)
    except KeyboardInterrupt:
        observer.stop()
    observer.join()

'''

