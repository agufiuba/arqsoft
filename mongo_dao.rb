module MongoDAO
  # puts "[MongoDB] - Abriendo coneccion"
  # Mongoid.load_configuration(clients: {
  #   default: {
  #     database: 'arqsoft',
  #     hosts: 'mongodb://localhost:27017'
  #   }
  # })

  # def self.drop
  #   Mongoid.purge!
  # end

  # def self.create_cuatrimestre(c)
  #   puts "[MongoDB] - Insertando cuatrimestre"
  #   Cuatrimestre.collection.insert_one(c.attributes)
  # end
  #
  # def self.get_cuatrimestres
  #   puts "[MongoDB] - Buscando cuatrimestres"
  #   Cuatrimestre.all.each do |o|
  #     o.materias.each do |m|
  #       m['_id'] = m['_id'].to_s
  #     end
  #     puts to_j((o.as_json))
  #   end
  # end
  #
  # def self.get_cuatrimestre(id)
  #   puts "[MongoDB] - Buscando cuatrimestre"
  #   Cuatrimestre.find(id)
  # end

  # def self.add_materia_cuatrimestre(cid, mh)
  #   puts "[MongoDB] - Agregando materia a cuatrimestre"
  #   mh.delete 'cuatrimestre'
  #   mh.delete 'cursos'
  #   get_cuatrimestre(cid).push(materias: mh)
  # end

  # def self.create_materia(m)
  #   puts "[MongoDB] - Insertando materia"
  #   mh = m.attributes.clone
  #   Materia.collection.insert_one(mh)
  #   add_materia_cuatrimestre(mh['cuatrimestre']['_id'], mh)
  # end
  #
  # def self.get_materias
  #   puts "[MongoDB] - Buscando materias"
  #   Materia.all.each do |o|
  #     o.cuatrimestre['_id'] = o.cuatrimestre['_id'].to_s
  #     o.cursos.each do |cu|
  #       cu['_id'] = cu['_id'].to_s
  #     end
  #     puts to_j(o.as_json)
  #   end
  # end
  #
  # def self.get_materia(id)
  #   puts "[MongoDB] - Buscando materia"
  #   Materia.find(id)
  # end
  #
  # def self.add_curso_materia(mid, cuh)
  #   puts "[MongoDB] - Agregando curso a materia"
  #   cuh.delete 'materia'
  #   cuh.delete 'alumnos'
  #   get_materia(mid).push(cursos: cuh)
  # end

  # def self.create_curso(cu)
  #   puts "[MongoDB] - Insertando curso"
  #   cuh = cu.attributes.clone
  #   Curso.collection.insert_one(cuh)
  #   add_curso_materia(cuh['materia']['_id'], cuh)
  # end
  #
  # def self.get_cursos
  #   puts "[MongoDB] - Buscando cursos"
  #   Curso.all.each do |o|
  #     o.materia['_id'] = o.materia['_id'].to_s
  #     o.alumnos.each do |a|
  #       a['_id'] = a['_id'].to_s
  #     end
  #     puts to_j(o.as_json)
  #   end
  # end
  #
  # def self.get_curso(id)
  #   puts "[MongoDB] - Buscando curso"
  #   Curso.find(id)
  # end

  # def self.create_alumno(a)
  #   puts "[MongoDB] - Insertando alumno"
  #   ah = a.clone.attributes
  #   Alumno.collection.insert_one(ah)
  #   add_alumno_curso(ah['curso']['_id'], ah)
  # end
  #
  # def self.get_alumnos
  #   puts "[MongoDB] - Buscando alumnos"
  #   Alumno.all.each do |o|
  #     o.curso['_id'] = o.curso['_id'].to_s
  #     puts to_j(o.as_json)
  #   end
  # end

  # def self.add_alumno_curso(cid, ah)
  #   puts "[MongoDB] - Agregando alumno a curso"
  #   ah.delete 'curso'
  #   get_curso(cid).push(alumnos: ah)
  # end

  # def self.to_j(o)
  #   aux = o.clone
  #   aux['_id'] = aux['_id'].to_s
  #   JSON.pretty_generate(aux)
  # end
end
