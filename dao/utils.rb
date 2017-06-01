module DAOUtils
  def self.drop
    puts "[MongoDB] - Dropeando todo"
    Mongoid.purge!
  end
end

def to_j(o)
  aux = o.clone
  aux['_id'] = aux['_id'].to_s
  JSON.pretty_generate(aux)
end
