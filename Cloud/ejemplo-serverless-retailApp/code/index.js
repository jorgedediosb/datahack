const AWS = require('aws-sdk')

const dynamo = new AWS.DynamoDB.DocumentClient({ region: 'us-east-1' })

const tableName = process.env.productTableName

function create(evt, ctx, cb) {
  const item = JSON.parse(evt.body)
  dynamo.put(
    {
      Item: item,
      TableName: tableName
    },
    (err, resp) => {
      if (err) {
        cb(err)
      } else {
        cb(null, {
          statusCode: 201,
          headers: {
            'Content-Type': 'application/json',
            'Access-Control-Allow-Origin': '*'
          },
          body: JSON.stringify(resp)
        })
      }
    }
  )
}

function get(evt, ctx, cb) {
  const vId = parseInt(evt.pathParameters.id, 10)
  dynamo.get(
    {
      Key: {
        id: vId
      },
      TableName: tableName
    },
    (err, data) => {
      if (err) {
        cb(err)
      } else {
        const product = data.Item
        cb(null, {
          statusCode: 200,
          headers: {
            'Content-Type': 'application/json',
            'Access-Control-Allow-Origin': '*'
          },
          body: JSON.stringify(product)
        })
      }
    }
  )
}

function list(evt, ctx, cb) {
  dynamo.scan(
    {
      TableName: tableName
    },
    (err, data) => {
      if (err) {
        cb(err)
      } else {
        const products = data.Items
        cb(null, {
          statusCode: 200,
          headers: {
            'Content-Type': 'application/json',
            'Access-Control-Allow-Origin': '*'
          },
          body: JSON.stringify(products)
        })
      }
    }
  )
}

module.exports = { create, get, list }


const { readFile } = require('fs')

module.exports = {
  async deploy(inputs, context) {
    const productsDb = await context.children.productsDb
    const products = await new Promise((resolve, reject) =>
      readFile('data/products.json', (err, data) => {
        if (err) {
          reject(err)
        } else {
          resolve(JSON.parse(data))
        }
      })
    )

    if (products.length > 0) {
      const tablename = `products-${context.serviceId}`
      context.log(`Seeding ${products.length} items into table ${tablename}.`)

      const insertItem = (triesLeft, wait) => (product) =>
        productsDb.fns
          .insert(productsDb.inputs, {
            log: context.log,
            state: productsDb.state,
            options: {
              tablename,
              itemdata: product
            }
          })
          .catch(async (error) => {
            if (triesLeft > 0) {
              return new Promise((resolve, reject) => {
                setTimeout(() => {
                  const doInsert = insertItem(triesLeft - 1, wait)(product)
                  doInsert.then(resolve, reject)
                }, wait)
              })
            }

            throw error
          })

      const insertions = products.map(JSON.stringify).map(insertItem(30, 8000))
      await Promise.all(insertions)
    }
  }
}