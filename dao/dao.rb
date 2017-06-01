require 'json'

require './dao/utils.rb'
require './dao/cuatrimestre_dao.rb'
require './dao/materia_dao.rb'
require './dao/curso_dao.rb'
require './dao/alumno_dao.rb'

puts "[MongoDB] - Abriendo coneccion"
Mongoid.load_configuration(clients: {
  default: {
    database: 'arqsoft',
    hosts: 'mongodb://localhost:27017'
  }
})
