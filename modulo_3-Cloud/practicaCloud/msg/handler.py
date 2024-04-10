import json
import boto3
from datetime import datetime

dynamodb = boto3.resource('dynamodb', region_name='eu-west-1')
table = dynamodb.Table('datahack-msg-deploy')

def insert_message(event, context):
    try:
        body = json.loads(event['body'])
        user = body['user']
        message = body['message']
        date = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

        response = table.put_item(
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
        response = table.scan()
        data = response['Items']
        
        while 'LastEvaluatedKey' in response:
            response = table.scan(ExclusiveStartKey=response['LastEvaluatedKey'])
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
