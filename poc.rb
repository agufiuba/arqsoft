require 'mongoid'

class Cuatrimestre
  include Mongoid::Document
  store_in collection: "cuatrimestres"
  field :numero, type: Integer
  field :anio, type: Integer
end

class Materia
  include Mongoid::Document
  store_in collection: "materias"
  field :nombre, type: String
end

class Curso
  include Mongoid::Document
  store_in collection: "cursos"
  # horarios
  # docente
end

class Usuario
  include Mongoid::Document
  store_in collection: "usuarios"
end
