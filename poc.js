var faker = require('faker')
var mongoose = require('mongoose')
var redis = require('redis')
var argv = require('minimist')(process.argv.slice(2))

console.log("MongoDB - Conectando")
mongoose.Promise = global.Promise
// mongocon = mongoose.connect('mongodb://192.168.99.100:32785/test')
mongocon = mongoose.connect('localhost')

console.log("Redis   - Conectando")
// redisClient = redis.createClient(32786, '192.168.99.100')
redisClient = redis.createClient()

/*
Dado el siguiente enunciado: FIUBA desea construir un sistema que permita, para un cuatrimestre dado, enumerar los cursos ofrecidos por materia y la inscripción a los cursos. Desarrolle un sistema simple que utilice como repositorio de datos exclusivamente una base de datos NoSQL.
*/

var Schema = mongoose.Schema
var ObjectId = Schema.ObjectId

var UsuarioSchema = new Schema({
  id: Number,
  nombre: String
})

var MateriaSchema = new Schema({
  id: String,
  nombre: String
})

var CursoSchema = new Schema({
  id: String,
  horarios: String
})

var CuatrimestreSchema = new Schema({
  id: Number,
  anio: Number,
  numero: Number
})

MateriaSchema.add({
  cuatrimestre: CuatrimestreSchema
})

var Usuario = mongoose.model('Usuario', UsuarioSchema)
var Materia = mongoose.model('Materia', MateriaSchema)
var Curso = mongoose.model('Curso', CursoSchema)
var Cuatrimestre = mongoose.model('Cuatrimestre', CuatrimestreSchema)

var drop = function(callback) {
  console.log("Redis   - Vaciando")
  redisClient.flushdb(function(err, reply) {
    console.log("MongoDB - Vaciando")
    Usuario.remove({}, function() {
      callback()
    })
  })
}

var initids = function(callback) {
  console.log("Redis   - Inicializando contadores de ids")
  redisClient.multi()
    .setnx("idusuario", 1)
    .setnx("idmateria", 1)
    .setnx("idcurso", 1)
    .setnx("idcuatrimestre", 1)
    .exec(callback)
}

var crearUsuario = function(callback) {
  console.log("Redis   - Creando usuario")
  redisClient.incr("idusuario", function(err, id) {
    var u = new Usuario()
    u.id = id - 1
    u.nombre = faker.name.findName()
    redisClient.set("usuario:" + (parseInt(id) - 1), JSON.stringify(u), function(err, resp) {
      console.log("MongoDB - Creando usuario")
      u.save(function(err) {
        callback(u.id)
      })
    })
  })
}

var crearCuatri = function(anio, numero, callback) {
  console.log("Redis   - Creando cuatrimestre")
  redisClient.incr("idcuatrimestre", function(err, id) {
    var c = new Cuatrimestre()
    c.id = id - 1
    c.anio = anio
    c.numero = numero
    redisClient.set("cuatrimestre:" + (parseInt(id) - 1), JSON.stringify(c), function(err, resp) {
      console.log("MongoDB - Creando cuatrimestre")
      c.save(function(err) {
        callback(c.id)
      })
    })
  })
}

var crearMateria = function(nombre, idcuatri, callback) {
  getCuatri(idcuatri, (cuatri) => {
    console.log("Redis   - Creando materia")
    redisClient.incr("idmateria", function(err, id) {
      var m = new Materia()
      m.id = id - 1
      m.nombre = nombre
      m.cuatrimestre = cuatri
      redisClient.set("materia:" + (parseInt(id) - 1), JSON.stringify(m), function(err, resp) {
        console.log("MongoDB - Creando materia")
        m.save(function(err) {
          agregarMateria(cuatri, m)
          callback(m.id)
        })
      })
    })
  })
}

var getUsuario = function(id, callback) {
  console.log("Redis   - Buscando usuario")
  redisClient.get("usuario:" + id, function(err, resp) {
    if (resp === null) {
      console.log("MongoDB - Buscando usuario")
      Usuario.findOne({
        id: id
      }, function(err, resp) {
        if (resp == null)
          resp = 404
        else {
          resp.__v = undefined
        }
        callback(resp)
      })
    } else {
      resp = JSON.parse(resp)
      callback(resp)
    }
  })
}

var getCuatri = function(id, callback) {
  console.log("Redis   - Buscando cuatrimestre")
  redisClient.get("cuatrimestre:" + id, function(err, resp) {
    if (resp === null) {
      console.log("MongoDB - Buscando cuatrimestre")
      Cuatrimestre.findOne({
        id: id
      }, function(err, resp) {
        if (resp == null)
          resp = 404
        else {
          resp.__v = undefined
        }
        callback(resp)
      })
    } else {
      resp = JSON.parse(resp)
      callback(resp)
    }
  })
}

var getMateria = function(id, callback) {
  console.log("Redis   - Buscando materia")
  redisClient.get("materia:" + id, function(err, resp) {
    if (resp === null) {
      console.log("MongoDB - Buscando materia")
      Materia.findOne({
        id: id
      }, function(err, resp) {
        if (resp == null)
          resp = 404
        else {
          resp.__v = undefined
        }
        callback(resp)
      })
    } else {
      resp = JSON.parse(resp)
      callback(resp)
    }
  })
}

var agregarMateria = (cuatri, materia, callback) => {
  if (cuatri.materias === undefined) cuatri.materias = []
  cuatri.materias.push(materia)
  console.log("Redis   - Agregando materia a cuatrimestre")
  redisClient.set("cuatrimestre:" + idcuatri, JSON.stringify(cuatri), () => {
    console.log("MongoDB - Agregando materia a cuatrimestre")
    cuatri.update(() => callback())
  })
}

var cerrarConecciones = function() {
  console.log("MongoDB - Cerrando coneccion")
  mongoose.connection.close()
  console.log("Redis   - Cerrando coneccion")
  redisClient.quit()
}

var foundArg = false
if ("d" in argv && "i" in argv) {
  drop(() => initids(cerrarConecciones))
  foundArg = true
} else if ("d" in argv) {
  drop(cerrarConecciones)
  foundArg = true
} else if ("i" in argv) {
  initids(cerrarConecciones)
  foundArg = true
} else if ("mock" in argv) {
  crearCuatri(2016, 1, () => {
    crearCuatri(2016, 2, () => {
      crearMateria("Analisis Matematico", 1, () => {
        crearUsuario(() => {
          crearUsuario(() => {
            cerrarConecciones()
          })
        })
      })
    })
  })
  foundArg = true
} else if ("ru" in argv) {
  getUsuario(argv.ru, (u) => {
    cerrarConecciones()
    console.log()
    console.log(u)
  })
  foundArg = true
}

if (!foundArg) {
  cerrarConecciones()
  console.log()
  console.log("Argumentos equivocados")
}
