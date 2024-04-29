import json
import boto3
from datetime import datetime

dynamodb = boto3.resource('dynamodb', region_name='eu-west-1')

def get_api_endpoint(event, context):
    try:
        api_endpoint = event['stageVariables']['API_ENDPOINT']

        return {
            'statusCode': 200,
            'headers': {
                'Access-Control-Allow-Origin': '*',
                'Access-Control-Allow-Headers': 'Content-Type',
                'Access-Control-Allow-Methods': 'OPTIONS,POST,GET'
            },
            'body': json.dumps({'apiUrl': api_endpoint})
        }
    except Exception as e:
        return {
            'statusCode': 500,
            'body': json.dumps({'error': str(e)})
        }

def insert_message(event, context):
    try:
        table_msg = dynamodb.Table('datahack-mensajes')

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
        table_msg = dynamodb.Table('datahack-mensajes')

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

def insert_product(event, context):
    try:
        table_pro = dynamodb.Table('datahack-productos')

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
        table_pro = dynamodb.Table('datahack-productos')

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
