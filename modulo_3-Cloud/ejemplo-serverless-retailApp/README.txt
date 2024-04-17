url: https://www.serverless.com/blog/how-create-dynamic-website-with-serverless-components

Instalar AWS CLI:

Configurar AWS CLI con credenciales de AWS:
aws configure
> introducir Access Key y Secret Key del usuario AWS

Instalar serverless en la carpeta donde se aloje el proyecto:
npm install serverless

Install Serverless Components with the following command:
npm i serverless-components -g
sudo npm i serverless-components -g

Desplegar la app:
components deploy
sls deploy o sls deploy --verbose (para más info)

Eliminar despliegue:
sls remove