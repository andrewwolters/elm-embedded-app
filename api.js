var jsonServer = require('json-server')

var server = jsonServer.create()
server.use(jsonServer.defaults())

var router = jsonServer.router('data.json')
server.use(router)

console.log('Listening at 4000')
server.listen(4000)
