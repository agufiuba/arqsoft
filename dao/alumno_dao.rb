module AlumnoDAO
  def self.create(a)
    puts "[MongoDB] - Insertando alumno"
    ah = a.attributes.clone
    Alumno.collection.insert_one(ah)
  end

  def self.add_curso(a, cuh)
    cuh.delete 'materia'
    cuh.delete 'alumnos'
    geta = get(a.id)
    geta.push(cursos: cuh)
    ah = a.attributes.clone
    geta['cursos'].each do |c|
      CursoDAO.add_alumno(c['_id'], ah)
    end
  end

  def self.get(id)
    puts "[MongoDB] - Buscando alumno"
    Alumno.find(id)
  end

  def self.all
    puts "[MongoDB] - Buscando alumnos"
    Alumno.all.each do |o|
      o.cursos.each do |cu|
        cu['_id'] = cu['_id'].to_s
      end
      puts to_j(o.as_json)
    end
  end
end
