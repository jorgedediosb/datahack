**MANUAL DE OPERACIÓN**

REQUERIMIENTOS:
- docker / docker desktop


EJECUCIÓN DE LA APP

    Desplegar servicios:
        $ docker-compose up -d (desde carpeta 'SentimentAnalyst')

    Verificar que todos los servicios están funcionando correctamente:
        $ docker-compose ps

    Reiniciar algún servicio (si fuese necesario):
        $ docker-compose restart nombre_del_servicio
    
    Ejecutar app:
        $ docker-compose exec sentiment-analysis bash -c "python3 read_CSV.py & python3 consumer.py"

        > Imprime todos los mensajes del archivo dataset.csv mostrando el texto, su polaridad y su subjetividad.
        > Salida de uno de los mensajes:
            Text: 'Please ignore prior tweets, as that was someone pretending to be me :)  This is actually me.', Polarity: 0.16666666666666666, Subjectivity: 0.3666666666666667

