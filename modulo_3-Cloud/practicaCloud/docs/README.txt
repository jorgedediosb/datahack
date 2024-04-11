INSTRUCCIONES PARA DESPLEGAR APP ANUNCIOS Y MENSAJERÍA EN AWS

  Instalar serverless en la carpeta donde se aloje el proyecto:
      npm install serverless

  Configurar AWS CLI con credenciales de AWS:
      aws configure
      > introducir Access Key y Secret Key del usuario AWS

  Desplegar la app:
      sls deploy o sls deploy --verbose (para más info)

  Eliminar despliegue:
      sls remove

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
    
    Información sobre el despliegue:
        sls info

FUNCIONES
  Enviar mensajes:
      curl -X POST -H "Content-Type: application/json" -d '{"user":"Profesor", "message":"Yo soy tu profe!"}' https://15a6pfpykk.execute-api.eu-west-1.amazonaws.com/dev/insert-message
    Leer mensajes:
      curl https://15a6pfpykk.execute-api.eu-west-1.amazonaws.com/dev/get-messages

  Enviar productos:
    $ curl -X POST -H "Content-Type: application/json" -d '{"user":"Jorge", "product":"Iphone", "description": "Iphone muy guapo"}' https://15a6pfpykk.execute-api.eu-west-1.amazonaws.com/dev/insert-product
    Leer productos:
      curl https://15a6pfpykk.execute-api.eu-west-1.amazonaws.com/dev/get-products

ACCESO INTERFAZ WEB:
  Cargar archivos directorio 'web' en el bucket (no he logrado que funcione la opción "package/include: - web/**" en el yaml para cargarlos automáticamente):
    aws s3 cp web/ s3://datahack-cloud/ --recursive
    curl https://datahack-cloud.s3-eu-west-1.amazonaws.com/index.html o (visitar enlace en navegador)

  > La interfaz web sólo  tiene las funciones de enviar mensajes y leer mensajes (fue la prueba inicial).
  > NO HE LOGRADO QUE FUNCIONEN LAS FUNCIONES EN LA INTERFAZ WEB (en consola SI funcionan)
  > Pude 'cargar' manualmente en proyecto en AWS con los mismos servicios y  el funcionamiento es perfecto.
  > Enlace interfaz cargada en AWS manualmente: https://d1671x27qva124.cloudfront.net

CONTENIDO EXTRAS
  - Incluyo diagama de arquitectura en AWS.
  - Incluyo carpeta 'web-prueba-anuncios' con interfaz web de publicación de anuncios y mensajería que funciona en local.
    NO LOGRÉ EL CORRECTO FUNCIONAMIENTO DE ESTA INTERFAZ AL DESPLEGAR, en local sí funciona.
    Creo que  necesita una relación entre tablas anuncios/mensajes que no logré desplegar correctamente.

EXPLICACIÓN DE SERVICIOS ELEGIDOS
He querido crear un servicio web lo más real posible usando los servicios aprendidos y más típicos para este proyecto:
  - Cloudfront para el acceso desde cualquier sitio.
  - IAM para los roles de acceso.
  - S3 para el alojamiento web.
  - API Gateway para las peticiones a las funciones.
  - Lambda para cada una de las funciones.
  - DynamoDB para alojar las tablas de mensajes y anuncios por separado.

Un proyecto real tendría como mínimo, a parte de los servicio usados:
  Amazon Cognito para la autenticación de usuarios y el control de acceso.
  Amazon Simple Notification Service (SNS) para notificaciones en tiempo real.
  AWS Amplify: Para crear y hospedar la interfaz web estática (S3 para las imágenes).