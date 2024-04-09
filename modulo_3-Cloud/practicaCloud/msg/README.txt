Instalar serverless en la carpeta del proyecto:
$ npm install serverless

Comprobar errores con paquete de despliegue:
$ serverless package

Configurar AWS CLI con credenciales de AWS:
$ aws configure (e introducir Access Key y Secret Key del usuario AWS)

Desplegar la app:
$ serverless deploy o sls deploy

Finalizado el despliegue indicará los endpoints y las funciones:
endpoints:
  POST - https://bqbhbrsh19.execute-api.eu-west-1.amazonaws.com/dev/insert-message
  GET - https://bqbhbrsh19.execute-api.eu-west-1.amazonaws.com/dev/get-messages
functions:
  insertMessage: datahack-cloud-dev-insertMessage (40 kB)
  getMessages: datahack-cloud-dev-getMessages (40 kB)

Insertar mensajes:
curl -X POST -H "Content-Type: application/json" -d '{"user": "nombre_de_usuario", "message": "contenido_del_mensaje"}' https://bqbhbrsh19.execute-api.eu-west-1.amazonaws.com/dev/insert-message
Leer mensajes:
curl -X GET https://bqbhbrsh19.execute-api.eu-west-1.amazonaws.com/dev/get-messages


Serverless debe dar enlace endpoint de la API (usar plugin S3 Sync de serverless):
$ npm install serverless-s3-sync --save-dev

en archivo serverless.yaml indicar:
plugins:
  - serverless-s3-sync

custom:
  s3Sync:
    - bucketName: my-static-bucket
      localDir: path/to/your/local/directory


otra opción es:
Para acceder a tu sitio web, primero debes asegurarte de que los archivos estáticos
(HTML, CSS, JavaScript) estén alojados en un bucket de Amazon S3 y que el bucket tenga
configurada la opción de hosting de sitios web estáticos. Luego, puedes acceder al
sitio web a través de la URL proporcionada por el bucket de S3.

Aquí están los pasos para hacerlo:

Sube los archivos estáticos (index.html, styles.css, scripts.js) al bucket de S3 utilizando
un script o herramienta de línea de comandos como aws-cli.
Una vez que el alojamiento del sitio web esté habilitado y los archivos estén cargados en el bucket,
el bucket de S3 proporcionará una URL pública para acceder al sitio web.
Visita la URL proporcionada por el bucket de S3 en tu navegador web para acceder al sitio web
y probar su funcionamiento

