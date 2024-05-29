import json
from confluent_kafka import Consumer, KafkaException
from transformers import pipeline

# Configuración de Kafka
bootstrap_servers = '127.0.0.1:9092'
group_id = 'tweet_analysis_group'
topic = 'realtime-tweets'

# Configurar el modelo de análisis de sentimientos
sentiment_analysis = pipeline('sentiment-analysis', model="cardiffnlp/twitter-roberta-base-sentiment")

def process_message(msg):
    tweet = json.loads(msg.value())
    tweet_text = tweet['data']
    sentiment = sentiment_analysis(tweet_text)[0]
    print(f'Tweet: {tweet_text}\nSentiment: {sentiment}\n')

if __name__ == "__main__":
    consumer = Consumer({
        'bootstrap.servers': bootstrap_servers,
        'group.id': group_id,
        'auto.offset.reset': 'earliest'
    })
    consumer.subscribe([topic])

    try:
        while True:
            msg = consumer.poll(timeout=1.0)
            if msg is None:
                continue
            if msg.error():
                if msg.error().code() == KafkaError._PARTITION_EOF:
                    continue
                else:
                    raise KafkaException(msg.error())
            process_message(msg)
    except KeyboardInterrupt:
        pass
    finally:
        consumer.close()
