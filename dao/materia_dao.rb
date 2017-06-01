module MateriaDAO
  def self.create(m)
    puts "[MongoDB] - Insertando materia"
    mh = m.attributes.clone
    Materia.collection.insert_one(mh)
    CuatrimestreDAO.add_materia(mh['cuatrimestre']['_id'], mh)
  end

  def self.all
    puts "[MongoDB] - Buscando materias"
    Materia.all.each do |o|
      o.cuatrimestre['_id'] = o.cuatrimestre['_id'].to_s
      o.cursos.each do |cu|
        cu['_id'] = cu['_id'].to_s
      end
      puts to_j(o.as_json)
    end
  end

  def self.get(id)
    puts "[MongoDB] - Buscando materia"
    Materia.find(id)
  end

  def self.add_curso(mid, cuh)
    puts "[MongoDB] - Agregando curso a materia"
    cuh.delete 'materia'
    cuh.delete 'alumnos'
    get(mid).push(cursos: cuh)
  end
end
