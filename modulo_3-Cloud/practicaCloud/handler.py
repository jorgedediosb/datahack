import json
import boto3
from datetime import datetime

dynamodb = boto3.resource('dynamodb', region_name='eu-west-1')
table_msg = dynamodb.Table('datahack-mensajes')

def insert_message(event, context):
    try:
        body = json.loads(event['body'])
        user = body['user']
        message = body['message']
        date = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

        response = table_msg.put_item(
            Item={
                'user': user,
                'message': message,
                'date': date
            }
        )

        return {
            'statusCode': 200,
            'body': json.dumps({'message': 'Mensaje de ' + user + ' insertado correctamente'})
        }
    except Exception as e:
        return {
            'statusCode': 500,
            'body': json.dumps({'error': str(e)})
        }

def get_messages(event, context):
    try:
        response = table_msg.scan()
        data = response['Items']
        
        while 'LastEvaluatedKey' in response:
            response = table_msg.scan(ExclusiveStartKey=response['LastEvaluatedKey'])
            data.extend(response['Items'])

        return {
            'statusCode': 200,
            'body': json.dumps(data)
        }
    except Exception as e:
        return {
            'statusCode': 500,
            'body': json.dumps({'error': str(e)})
        }


table_pro = dynamodb.Table('datahack-productos')

def insert_product(event, context):
    try:
        body = json.loads(event['body'])
        user = body['user']
        product = body['product']
        description = body['description']
        date = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

        response = table_pro.put_item(
            Item={
                'user': user,
                'product': product,
                'description': description,
                'date': date
            }
        )

        return {
            'statusCode': 200,
            'body': json.dumps({'product': 'Producto de ' + user + ' insertado correctamente'})
        }
    except Exception as e:
        return {
            'statusCode': 500,
            'body': json.dumps({'error': str(e)})
        }

def get_products(event, context):
    try:
        response = table_pro.scan()
        data = response['Items']
        
        while 'LastEvaluatedKey' in response:
            response = table_pro.scan(ExclusiveStartKey=response['LastEvaluatedKey'])
            data.extend(response['Items'])

        return {
            'statusCode': 200,
            'body': json.dumps(data)
        }
    except Exception as e:
        return {
            'statusCode': 500,
            'body': json.dumps({'error': str(e)})
        }
