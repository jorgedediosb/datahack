instalar SAM:
    brew tap aws/tap
    brew install aws-sam-cli

Ejecuta el siguiente comando para iniciar la API local y simular tu función Lambda y tu tabla DynamoDB:
    sam local start-api
    (Docker debe estar instalado y corriendo)

PROBAR app simple-chat:
- instalar node
Cambiar permisos del directorio descargado:
- sudo chown -R nombre_usuario ~/.npm
Instalar serverless:
npm install serverless
Instalar DynamoDB en local (opción de descargar como imagen Docker) y ejecutar con:
java -Djava.library.path=./DynamoDBLocal_lib -jar DynamoDBLocal.jar -sharedDb

Añadir configuración local en archivo handler.py:
dynamodb = boto3.resource('dynamodb', endpoint_url='http://localhost:8000')