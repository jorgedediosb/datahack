from pymongo import MongoClient

# Configuración
mongo_uri = "mongodb://admin:admin@mongodb:27017"
database_name = "sentiment_analysis"
collection_name = "results"

# Conectar a MongoDB
client = MongoClient(mongo_uri)
db = client[database_name]
collection = db[collection_name]

# Consulta de los mensajes con polaridad negativa
negative_messages = collection.find({"polarity": {"$lt": 0}})

# Mostrar los mensajes con polaridad negativa
print("Negative Messages:")
for message in negative_messages:
    print(f"Text: {message['text']}, Polarity: {message['polarity']}")
