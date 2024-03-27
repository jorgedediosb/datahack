import json
import boto3

def lambda_handler(event, context):
    # Obtener los datos del evento (en este caso, se esperan datos del formulario)
    data = json.loads(event['body'])
    
    # Extraer los campos del anuncio del cuerpo de la solicitud
    titulo = data['titulo']
    imagen = data['imagen']
    texto = data['texto']
    categoria = data['categoria']
    precio = data['precio']
    
    # Aquí podrías validar los datos recibidos antes de guardarlos en la base de datos
    
    # Guardar los datos del anuncio en una base de datos (por ejemplo, DynamoDB)
    dynamodb = boto3.resource('dynamodb')
    table = dynamodb.Table('anuncios')
    
    response = table.put_item(
        Item={
            'titulo': titulo,
            'imagen': imagen,
            'descripcion': texto,
            'categoria': categoria,
            'precio': precio
        }
    )
    
    # Devolver una respuesta al cliente
    if response['ResponseMetadata']['HTTPStatusCode'] == 200:
        return {
            'statusCode': 200,
            'body': json.dumps('Anuncio creado exitosamente')
        }
    else:
        return {
            'statusCode': 500,
            'body': json.dumps('Error al crear el anuncio')
        }
