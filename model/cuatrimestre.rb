class Cuatrimestre
  include Mongoid::Document
  store_in collection: "cuatrimestres"
  field :numero, type: Integer
  field :anio, type: Integer
  field :materias, type: Array, default: []
end
