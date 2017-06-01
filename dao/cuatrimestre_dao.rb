module CuatrimestreDAO
  def self.create(c)
    puts "[MongoDB] - Insertando cuatrimestre"
    Cuatrimestre.collection.insert_one(c.attributes)
  end

  def self.all
    puts "[MongoDB] - Buscando cuatrimestres"
    Cuatrimestre.all.each do |o|
      o.materias.each do |m|
        m['_id'] = m['_id'].to_s
      end
      puts to_j((o.as_json))
    end
  end

  def self.get(id)
    puts "[MongoDB] - Buscando cuatrimestre"
    Cuatrimestre.find(id)
  end

  def self.add_materia(cid, mh)
    puts "[MongoDB] - Agregando materia a cuatrimestre"
    mh.delete 'cuatrimestre'
    mh.delete 'cursos'
    get(cid).push(materias: mh)
  end
end
