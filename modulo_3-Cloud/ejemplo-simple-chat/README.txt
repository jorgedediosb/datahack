Código original:
https://github.com/sergiokhayyat/simple-chat

Para ejecutar la aplicación de chat sin necesidad de ejecutar DynamoDB localmente, se debe seguir estos pasos:

Configurar los servicios en la nube de AWS:
- Asegúrate de tener una cuenta activa en AWS.
- Configura los servicios necesarios en la nube de AWS, como Lambda y DynamoDB.
- Crea una tabla en DynamoDB para almacenar los mensajes del chat.

Actualiza el archivo serverless.yaml:
- Asegúrate de que la configuración de provider incluya la información correcta, como el nombre de la región de AWS y el perfil de AWS.
- Verifica que las funciones get_messages y send_message estén definidas correctamente y asociadas con los eventos HTTP.

Despliega la aplicación en AWS:
- Utiliza el comando sls deploy para desplegar tu aplicación en AWS.
- Esto creará y configurará los recursos necesarios en AWS, como funciones Lambda y la tabla de DynamoDB.

Obtiene las URL de las API de API Gateway:
- Después de desplegar, serverless te proporcionará las URL de las API de API Gateway que exponen tus funciones Lambda al mundo exterior.
- Estas URL se pueden encontrar en la salida del comando sls deploy.

Actualiza la interfaz de usuario:
- En el archivo HTML de tu interfaz de usuario, actualiza las llamadas a la API para usar las nuevas URL de la API de API Gateway.
- Asegúrate de que las solicitudes HTTP enviadas desde tu interfaz de usuario estén dirigidas a las nuevas URL de la API.

Prueba la aplicación:
- Abre el archivo HTML de tu interfaz de usuario en un navegador web.
- Envía mensajes a través de la interfaz de usuario y verifica que se procesen correctamente por la aplicación de chat desplegada en AWS.
- Verifica que los mensajes se almacenen correctamente en la tabla de DynamoDB y que puedan ser recuperados mediante la función get_messages.

Al seguir estos pasos, podrás ejecutar tu aplicación de chat en AWS de manera similar a la otra aplicación que utilizas, pero sin la necesidad de ejecutar DynamoDB localmente.