class Materia
  include Mongoid::Document
  store_in collection: "materias"
  field :nombre, type: String
  field :cuatrimestre, type: Hash
  field :cursos, type: Array, default: []
end
