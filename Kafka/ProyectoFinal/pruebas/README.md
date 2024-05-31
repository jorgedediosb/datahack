https://towardsdatascience.com/how-to-do-a-sentiment-analysis-in-realtime-using-the-jupyter-notebook-kafka-and-nltk-4470aa8c3c30

How to do a sentiment analysis in real-time using the Jupyter notebook, Kafka and NLTK
A tutorial about processing streaming data from Kafka into the Jupyter notebook

We will use:
- kafka: we will use the confluent version for kafka as our streaming platform
- ksql: this is a technology from confluent that lets us create tables on top of kafka and enables us to run SQL queries in realtime.
- jupyter notebook: our environment to run the analysis
- docker compose: we will use this to create our own kafka cluster locally
- NLTK: sentiment analysis library in python using the vader algorithm

**Step 1: run docker compose**
In this first step we need to run docker compose to create our kafka cluster. This will run a bunch of docker containers that will create various elements of the cluster like zookeeper, brokers, topics, ksql.
Now very briefly, kafka is a distributed streaming platform capable of handling a large number of messages, that are organised into topics. To be able to process a topic in parallel it has to be split into partitions, and the data from these partitions are stored into separate machines called brokers. And finally, zookeeper is used to manage the resources of the brokers in the clusters. This are the elements from the vanilla version of kafka. The confluent platform adds ksql as a query engine.

Running docker-compose up (with daemon run) in the root of the project will create the cluster. You should see something like the image bellow if everything has run successfully.

The ksql service will run on port 8088 and the kafka broker will be available on port 9092. We need this information to connect to kafka from jupyter. When you are finished working on the cluster you can stop all the containers by running docker-compose down.


**Step 2: install the additional dependencies**
We are using a few python packages that maybe we have not used before, therefore we need to install them. At the root of the project, we have a requirements.txt file. To install it run the following command in the console:
$ pip install -r requirements.txt

> Si la instalación da problemas:
- Crear entorno viertual: python3 -m venv venv
- Activar entorno virtual: source venv/bin/activate
- Instalar requerimientos: pip install -r requirements.txt
    Si da problemas:
    - Instalar setuptools y wheel: pip install setuptools wheel
    - Intalar dependencias por separado:
        pip install ksql
        pip install confluent_kafka nltk

> Si da problemas crea un archivo llamado Dockerfile en tu proyecto con el siguiente contenido:
    FROM python:3.9-slim
    WORKDIR /SentimentAnalyst
    COPY requirements.txt requirements.txt
    RUN pip install --no-cache-dir -r requirements.txt
    COPY . .
    CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--allow-root"]

    - Actualiza tu archivo docker-compose.yaml para incluir el servicio de Jupyter Notebook:

**Step 3: run the kafka producer in Jupyter Notebook**
To be able to consume data in realtime we first must write some messages into kafka. We will use the confluent_kafka library in python to write a producer:

def confluent_kafka_producer():

    p = Producer({'bootstrap.servers': bootstrap_servers})
    for data in simple_messages:
        
        record_key = str(uuid.uuid4())
        record_value = json.dumps({'data': data})
        
        p.produce(topic, key=record_key, value=record_value, on_delivery=delivery_report)
        p.poll(0)

    p.flush()
    print('we\'ve sent {count} messages to {brokers}'.format(count=len(simple_messages), brokers=bootstrap_servers))

We will send some very simple JSON messages { 'data' : value } , where value is a sentence from a predefined list. For each message, we write into the queue we also need to assign a key. We will assign a random one based on the uuid to achieve a good distribution into the cluster. In the end, we also run a flush command to ensure that all the messages are sent.
Once we run the confluent_kafka_producer we should receive a log telling us that the data has been sent correctly:
we’ve sent 6 messages to 127.0.0.1:9092

Step 4: create the ksql table
Next, we need to create the ksql client that will help us to run all the commands for this interface:
client = KSQLAPI(url='http://localhost:8088', timeout=60)

We can now create a table that we will use to query the data:
client.create_table(table_name='test_data',
                   columns_type=['data varchar'],
                   topic='test',
                   value_format='JSON',
                   key='data')

Similar to our JSON message the table will have just one field called data and the type is varchar which is suitable for our string sentences.
Once we run the table creation command we can check if everything runs successfully by checking what ksql tables we have available:

client.ksql('show tables')

And we should be able to see the one we created:
[{'@type': 'tables',
  'statementText': 'show tables;',
  'tables': [{'format': 'JSON',
    'isWindowed': False,
    'name': 'TEST_DATA',
    'topic': 'test',
    'type': 'TABLE'}]}]

Step 5: get some results from kafka and apply the sentiment analysis
We can run SQL queries on kafka now. Let’s get the latest 5 messages from it:
res = client.query('select * from test_data limit 5')

To be able to work easier with this data, we parse it and store it into a dictionary:

def parse_results(res):
    res = ''.join(res)
    res = res.replace('\n', '')
    res = res.replace('}{', '},{')
    res = '[' + res + ']'
    return json.loads(res)
res_dict = parse_results(res)

And finally, we can run our sentiment analysis algorithm on these 5 sentences. As stated before we will use a pre trained vader algorithm from NLTK :
def apply_sent(res):
    sent_res = []
    for r in res:
        sid = SentimentIntensityAnalyzer()
        try:
            sent_res.append(sid.polarity_scores(r['row']['columns'][2]))
        except TypeError:
            print('limit reached')
    return sent_res
send_res = apply_sent(res_dict)

We treat theTypeError as a signal that we have reached the end of the list for our messages. We can visualise the results:
[{'compound': 0.6369, 'neg': 0.0, 'neu': 0.323, 'pos': 0.677},
 {'compound': 0.6249, 'neg': 0.0, 'neu': 0.423, 'pos': 0.577},
 {'compound': -0.5423, 'neg': 0.467, 'neu': 0.533, 'pos': 0.0},
 {'compound': 0.0, 'neg': 0.0, 'neu': 1.0, 'pos': 0.0},
 {'compound': 0.4215, 'neg': 0.0, 'neu': 0.517, 'pos': 0.483}]

Each row represents the result for one sentence, and the sentiment can be either positive, neutral or negative. This is it! We can see how in a few steps we can process and analyse realtime data in the Jupyter notebook in an environment that is easy to use for the data scientists.

_____________________________________________________
EJECUTAR ANALISIS EN TIEMPO REAL:
- Terminal 1 (productor):
    python producer_realtime.py
- Terminal 2 (consumidor):
    python consumer_realtime.py

______________________________________________________
EJECUTAR ANALISIS DESDE ARCHIVO:
- Terminal 1 (productor):
    python producer-file.py
- Terminal 2 (consumidor):
    python consumer-file.py