Instalar serverless en la carpeta del proyecto:
$ npm install serverless

Configurar AWS CLI con credenciales de AWS:
$ aws configure +  introducir Access Key y Secret Key del usuario AWS

Desplegar la app:
$ sls deploy o serverless deploy --verbose (para más info)

Para volver a desplegar:
$ serverless remove (para asegurarse que no haya conflictos con los logs del anterior despliegue)
$ sls deploy

Información sobre el despliegue:
$ sls info

Cargar archivos web en el bucket:
$ aws s3 cp web/ s3://datahack-cloud/ --recursive

Finalizado el despliegue indicará los endpoints y las funciones:
endpoints (el ID varía según el usuario):
  POST - https://3qceox1tef.execute-api.eu-west-1.amazonaws.com/dev/insert-message
  GET - https://3qceox1tef.execute-api.eu-west-1.amazonaws.com/dev/get-messages
  POST - https://3qceox1tef.execute-api.eu-west-1.amazonaws.com/dev/insert-product
  GET - https://3qceox1tef.execute-api.eu-west-1.amazonaws.com/dev/get-products
functions:
  insertMessage: datahack-cloud-dev-insertMessage
  getMessages: datahack-cloud-dev-getMessages
  insertProduct: datahack-cloud-dev-insertProduct
  getProduct: datahack-cloud-dev-getProduct

Enviar mensajes:
$ curl -X POST -H "Content-Type: application/json" -d '{"user":"Elena", "message":"Hola mundo!"}' https://3qceox1tef.execute-api.eu-west-1.amazonaws.com/dev/insert-message
Leer mensajes:
$ curl https://3qceox1tef.execute-api.eu-west-1.amazonaws.com/dev/get-messages

Enviar productos:
curl -X POST -H "Content-Type: application/json" -d '{"user":"Jorge", "product":"Iphone", "description": "Iphone muy guapo"}' https://3qceox1tef.execute-api.eu-west-1.amazonaws.com/dev/insert-product
Leer productos:
$ curl https://3qceox1tef.execute-api.eu-west-1.amazonaws.com/dev/get-products

Acceder a la web:
curl https://datahack-cloud.s3.amazonaws.com/index.html
curl https://datahack-cloud.s3-eu-west-1.amazonaws.com/index.html


NOTAS

Acceder a la web:
instalar plugin???
serverless plugin install -n serverless-plugin-existing-s3

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

