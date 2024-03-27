instalar SAM:
    brew tap aws/tap
    brew install aws-sam-cli

Ejecuta el siguiente comando para iniciar la API local y simular tu función Lambda y tu tabla DynamoDB:
    sam local start-api
    (Docker debe estar instalado y corriendo)