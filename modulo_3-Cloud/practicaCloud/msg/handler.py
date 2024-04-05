import json
import boto3
from datetime import datetime

dynamodb = boto3.resource('dynamodb', region_name='eu-west-1')
table = dynamodb.Table('datahack-msg')

def lambda_handler(event, context):
    table = dynamodb.Table('datahack-msg')
    user = event['user']
    message = event['message']
    date = event['date']
    
    response = table.put_item(
        Item={
            'user': user,
            'msg': message,
            'date': date
        }
    )

    return {
        'statusCode': 200,
        'body': json.dumps('Mensaje de ' + user)
    }

def lambda_handler(event, context):
    table = dynamodb.Table('datahack-msg')
    response = table.scan()
    data = response['Items']
    
    while 'LastEvaluatedKey' in response:
        response = table.scan(ExclusiveStartKey=response['LastEvaluatedKey'])
        data.extend(response['Items'])
    return data