class Alumno
  include Mongoid::Document
  store_in collection: "alumnos"
  field :nombre, type: String
  field :cursos, type: Array, default: []
end
