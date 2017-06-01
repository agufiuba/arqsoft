class Curso
  include Mongoid::Document
  store_in collection: "cursos"
  field :nombre_docente, type: String
  field :materia, type: Hash
  field :alumnos, type: Array, default: []
end
