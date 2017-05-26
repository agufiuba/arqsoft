require 'mongoid'
require './mongo_dao.rb'

class Cuatrimestre
  include Mongoid::Document
  store_in collection: "cuatrimestres"
  field :numero, type: Integer
  field :anio, type: Integer
  field :materias, type: Array, default: []
end

class Materia
  include Mongoid::Document
  store_in collection: "materias"
  field :nombre, type: String
  field :cuatrimestre, type: Hash
  field :cursos, type: Array, default: []
end

class Curso
  include Mongoid::Document
  store_in collection: "cursos"
  field :nombre_docente, type: String
  field :materia, type: Hash
  field :alumnos, type: Array, default: []
end

class Alumno
  include Mongoid::Document
  store_in collection: "alumnos"
  field :nombre, type: String
  field :curso, type: Array, default: []
end

MongoDAO.drop

c1 = Cuatrimestre.new
c1.anio = 2017
c1.numero = 1
MongoDAO.create_cuatrimestre c1

m1 = Materia.new
m1.nombre = "AM2"
m1.cuatrimestre = c1.attributes
ch = c1.attributes.clone
ch.delete 'materias'
m1.cuatrimestre = ch
MongoDAO.create_materia m1

cu1 = Curso.new
cu1.nombre_docente = 'Prelat'
mh1 = m1.attributes
mh1.delete 'cuatrimestre'
mh1.delete 'cursos'
cu1.materia = mh1
MongoDAO.create_curso cu1

a1 = Alumno.new
a1.nombre = 'Agustin Gaillard'
cuh1 = cu1.attributes
cuh1.delete 'alumnos'
cuh1.delete 'materia'
a1.curso = cuh1
MongoDAO.create_alumno a1

MongoDAO.get_cuatrimestres
MongoDAO.get_materias
MongoDAO.get_cursos
MongoDAO.get_alumnos
