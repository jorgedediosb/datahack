'use strict';

const { v4 } = require('uuid');
const AWS = require('aws-sdk');


const dynamoDb = new AWS.DynamoDB.DocumentClient();

module.exports.AddAnuncio = async (event, context, callback) => {
    // Conectar a la Base de datos a través del ClientId
    // y el Client Secret ya configurado:
    try{

    // Recoger los datos provenientes del body de la petición
    const { user, title, text } = JSON.parse(event.body);
    const tableName = 'Anuncios';
    const createAt = new Date();
    const id = v4();
    const comment = "";

    // Crear el objeto para guardar
    const newAnuncio = {
        id,
        user,
        title,
        text,
        createAt: new Date(Date.now()).toISOString()
    };
    // put permite guardar un dato
    // ( no es como el PUT en REST )
      await dynamoDb.put({
        TableName: tableName,
        Item: newAnuncio
    }).promise()

    return {
      statusCode: 200,
      headers: {
          'Access-Control-Allow-Origin': '*',
          "Content-Type": "application/json"
      },
      body: JSON.stringify(newAnuncio)
    }
  } catch (error) {
    console.error(`Error al procesar la solicitud: ${error}`);
    console.log(`Cuerpo de la solicitud: ${event.body}`);
    return {
        statusCode: 500,
        body: JSON.stringify({ error: 'Ha ocurrido un error al procesar la solicitud' ,
        texto: event.body})
    };
  }
};

module.exports.GetAnuncios = async (event, context, callback) => {

  try {
    const dynamodb = new AWS.DynamoDB.DocumentClient();
    const tableName = 'Anuncios';
    // scan es como hacer un fetch de toda la tabla
    const result = await dynamodb.scan({
        TableName: tableName
    }).promise();

    return {
      statusCode: 200,
      headers: {
          'Access-Control-Allow-Origin': '*',
          "Content-Type": "application/json"
      },
      body: JSON.stringify(result.Items)
  };
} catch(error) {
    console.log(error);
}
}



module.exports.GetAnuncioId = async (event, context, callback) => {

  try {
    const dynamodb = new AWS.DynamoDB.DocumentClient();
    const tableName = 'Anuncios';
    const { id } = event.pathParameters;
    const result = await dynamodb.get({
        TableName: tableName,
        Key: {
          id
        }
    }).promise();

    if (!result.Item) {
      return {
        statusCode: 404,
        headers: {
          'Access-Control-Allow-Origin': '*',
          "Content-Type": "application/json"
        },
        body: JSON.stringify({ message: `No se encontró un anuncio con el id ${id}` })
      }
    }

    return {
      statusCode: 200,
      headers: {
        'Access-Control-Allow-Origin': '*',
        "Content-Type": "application/json"
      },
      body: JSON.stringify(result.Item)
    };
  } catch(error) {
    console.log(error);
  }
}

module.exports.DeleteOld = async (event) => {
  try {
    const dynamodb = new AWS.DynamoDB.DocumentClient();
    const tableName = 'Anuncios';
    const oneHourAgo =  new Date(Date.now() - (60 * 60 * 1000)).toISOString();
    console.log(oneHourAgo)
    const params = {
      TableName: tableName,
      FilterExpression: '#createAt < :oneHourAgo',
      ExpressionAttributeNames: {
        '#createAt': 'createAt'
      },
      ExpressionAttributeValues: {
        ':oneHourAgo': oneHourAgo
      }
    };
    const data = await dynamodb.scan(params).promise();
    console.log(params)
    const items = data.Items;
    console.log(items)
    const batchWriteParams = {
      RequestItems: {
        [tableName]: items.map(item => ({
          DeleteRequest: {
            Key: {
                id: item.id
            }
          }
        }))
      }
    };
    await dynamodb.batchWrite(batchWriteParams).promise();
    console.log(`Deleted ${items.length} items`);
  } catch (error) {
    console.error(error);
  }
};

//module.exports.AddComent = async (event, context, callback) => {
//
//  const tableName = 'Anuncios';
//  const dynamodb = new AWS.DynamoDB.DocumentClient();
//
//  // Extraer el id desde los parámetros del path:
//  const id = event.pathParameters.id;
//  // Extraer valores recibidos a través del evento:
//  const comentario = JSON.parse(event.body);
//  console.log(id);
//  console.log(comentario);
//
//  const params = {
//    TableName: tableName,
//    Key: {
//      id: id
//    },
//    UpdateExpression: 'SET #comentarios = list_append(if_not_exists(#comentarios, :empty_list), :comentario)',
//    ExpressionAttributeNames: {
//      '#comentarios': 'comentarios'
//    },
//    ExpressionAttributeValues: {
//      ':comentario': [comentario],
//      ':empty_list': []
//    }
//  };
//
//  dynamodb.update(params, function(err, data) {
//    if (err) {
//      console.log(err);
//      callback(err);
//    } else {
//      console.log(data);
//      callback(null, data);
//    }
//  });
//};

module.exports.AddComent = async (event, context, callback) => {

  try {
    const tableName = 'Anuncios';
    const dynamodb = new AWS.DynamoDB.DocumentClient();

    // Extraer el id desde los parámetros del path:
    const id = event.pathParameters.id;
    // Extraer valores recibidos a través del evento:
    const comentario = JSON.parse(event.body);
    console.log(id);
    console.log(comentario);

    const params = {
      TableName: tableName,
      Key: {
        id: id
      },
      UpdateExpression: 'SET #comentarios = list_append(if_not_exists(#comentarios, :empty_list), :comentario)',
      ExpressionAttributeNames: {
        '#comentarios': 'comentarios'
      },
      ExpressionAttributeValues: {
        ':comentario': [comentario],
        ':empty_list': []
      }
    };

    const data = await dynamodb.update(params).promise();

    console.log(data);
    callback(null, {
      statusCode: 200,
      headers: {
        'Access-Control-Allow-Origin': '*',
        "Content-Type": "application/json"
      },
      body: JSON.stringify(data)
    });

  } catch (err) {
    console.log(err);
    callback(err);
  }
};