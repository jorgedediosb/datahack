**MEMORIA INFORMATIVA**

La aplicación recoge tweets de Elon Musk y analiza el texto de cada uno según la orientación emocional y la subjetividad.

El repositorio con el proyecto esté en: https://github.com/jorgedediosb/datahack/tree/main/Kafka/ProyectoFinal/SentimentAnalyst


ANALISIS DE SENTIMIENTOS

    Cada mensaje se guarda con su texto y un valor de 'polarity' y otro de 'subjectivity'

    Polarity (Polaridad):
        La polaridad mide la orientación emocional del texto. Es un valor que varía entre -1.0 y 1.0:
        - Valores negativos (cercanos a -1.0) indican un sentimiento negativo.
        - Valores positivos (cercanos a 1.0) indican un sentimiento positivo.
        - Un valor de 0 indica un sentimiento neutral.
        
        Por ejemplo,
        - Una frase como "I love this product!" podría tener una polaridad alta (cercana a 1.0).
        - Una frase como "I hate this service." podría tener una polaridad baja (cercana a -1.0).
        - Una frase como "The product is okay." podría tener una polaridad cercana a 0.

    Subjectivity (Subjetividad):
        La subjetividad mide cuán subjetivo u objetivo es el texto. Es un valor que varía entre 0.0 y 1.0:
        - Un valor de 0.0 indica que el texto es completamente objetivo (basado en hechos).
        - Un valor de 1.0 indica que el texto es completamente subjetivo (basado en opiniones).
        
        Por ejemplo,
        - Un texto como "The capital of France is Paris." es objetiva y tendría una subjetividad baja (cercana a 0.0).
        - Un texto como "I think this movie is fantastic." es subjetiva y tendría una subjetividad alta (cercana a 1.0).


ELECCIÓN DE MONGODB:

    Ventajas:
    - Flexible y Escalable: Maneja datos semi-estructurados y permite escalar horizontalmente.
    - Alta Disponibilidad: Ofrece replicación y distribución de datos.
    - Fácil Integración: Buen soporte con varias bibliotecas y herramientas modernas.
    - Indexación y Consulta Rápida: Permite realizar consultas rápidas y eficientes.
    - Manipulación Flexible de los datos: Permite almacenar datos de texto plano, CSV, datos de Twitter y otros tipos en la misma base de datos.

    Desventajas:
    - Consistencia Eventual: Puede no ser tan fuerte como las garantías ACID completas en todas las situaciones.

    > Aunque para el análisis en tiempo real puede ser mejor Elasticsearch, he elegigo MongoDB por que creo que tiene una manipulación y almacenamiento de datos más flexible, lo que supone una mayor variedad de casos de uso.
