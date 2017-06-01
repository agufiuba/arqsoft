require 'mongoid'

require './model/alumno.rb'
require './model/cuatrimestre.rb'
require './model/materia.rb'
require './model/curso.rb'

require './dao/dao.rb'

DAOUtils.drop

c1 = Cuatrimestre.new
c1.anio = 2017
c1.numero = 1
CuatrimestreDAO.create c1

m1 = Materia.new
m1.nombre = "AM2"
m1.cuatrimestre = c1.attributes
ch = c1.attributes.clone
ch.delete 'materias'
m1.cuatrimestre = ch
MateriaDAO.create m1

cu1 = Curso.new
cu1.nombre_docente = 'Prelat'
mh1 = m1.attributes
mh1.delete 'cuatrimestre'
mh1.delete 'cursos'
cu1.materia = mh1
CursoDAO.create cu1

a1 = Alumno.new
a1.nombre = 'Agustin Gaillard'
cuh1 = cu1.attributes
cuh1.delete 'alumnos'
cuh1.delete 'materia'
AlumnoDAO.create a1
AlumnoDAO.add_curso a1, cuh1

CuatrimestreDAO.all
MateriaDAO.all
CursoDAO.all
AlumnoDAO.all

Mongoid::Clients.disconnect
