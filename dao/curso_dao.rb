module CursoDAO
  def self.create(cu)
    puts "[MongoDB] - Insertando curso"
    cuh = cu.attributes.clone
    Curso.collection.insert_one(cuh)
    MateriaDAO.add_curso(cuh['materia']['_id'], cuh)
  end

  def self.all
    puts "[MongoDB] - Buscando cursos"
    Curso.all.each do |o|
      o.materia['_id'] = o.materia['_id'].to_s
      o.alumnos.each do |a|
        a['_id'] = a['_id'].to_s
      end
      puts to_j(o.as_json)
    end
  end

  def self.get(id)
    puts "[MongoDB] - Buscando curso"
    Curso.find(id)
  end

  def self.add_alumno(cid, ah)
    puts "[MongoDB] - Agregando alumno a curso"
    ah.delete 'cursos'
    get(cid).push(alumnos: ah)
  end
end
