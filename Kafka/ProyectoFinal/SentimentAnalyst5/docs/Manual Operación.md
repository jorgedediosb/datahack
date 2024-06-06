**MANUAL DE OPERACIÓN**

REQUERIMIENTOS:
- docker / docker desktop

EJECUTAR LA APLICACION
    Iniciar servicios:
        $ docker-compose up -d
    Verificar si todos los servicios están funcionando correctamente:
        $ docker-compose ps
    Reiniciar algún servicio si fuese necesario (alguna vez se han detenido en broker, creo que por sobrecalientamiento del ordenador):
        $ docker-compose restart nombre_del_servicio
    Ejecutar app Sentiment Analysis:
        > Esperar unos segundos hasta que todos los servicios estén corriendo correctamente
        $ docker-compose exec sentiment-analysis bash -c "python3 read_CSV.py & python3 consumer.py"
        > Imprime todos los mensajes del archivo dataset.csv mostrando el texto, la polaridad y la Subjetividad. Ejemplo:
            Text: 'Please ignore prior tweets, as that was someone pretending to be me :)  This is actually me.', Polarity: 0.16666666666666666, Subjectivity: 0.3666666666666667

