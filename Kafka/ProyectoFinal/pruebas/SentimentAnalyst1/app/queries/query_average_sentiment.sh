#!/bin/bash

# Configuración
MONGO_URI="mongodb://admin:admin@localhost:27017"
DATABASE="sentiment_analysis"
COLLECTION="results"

# Consulta de agregación en formato JSON
AGGREGATE_QUERY='[
  {
    "$group": {
      "_id": null,
      "average_polarity": { "$avg": "$polarity" },
      "average_subjectivity": { "$avg": "$subjectivity" }
    }
  }
]'

# Ejecutar la consulta
mongo "$MONGO_URI/$DATABASE" --quiet --eval "db.$COLLECTION.aggregate($AGGREGATE_QUERY).forEach(printjson);"
