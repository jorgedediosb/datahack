from pymongo import MongoClient

# Configuración
mongo_uri = "mongodb://admin:admin@mongodb:27017"
database_name = "sentiment_analysis"
collection_name = "results"

# Conectar a MongoDB
client = MongoClient(mongo_uri)
db = client[database_name]
collection = db[collection_name]

# Consulta de agregación
pipeline = [
    {
        "$group": {
            "_id": None,
            "average_polarity": {"$avg": "$polarity"},
            "average_subjectivity": {"$avg": "$subjectivity"}
        }
    }
]

# Ejecutar la consulta
result = list(collection.aggregate(pipeline))

# Mostrar el resultado
if result:
    avg_polarity = result[0].get("average_polarity", "N/A")
    avg_subjectivity = result[0].get("average_subjectivity", "N/A")
    print(f"Average Polarity: {avg_polarity}")
    print(f"Average Subjectivity: {avg_subjectivity}")
else:
    print("No data found.")
