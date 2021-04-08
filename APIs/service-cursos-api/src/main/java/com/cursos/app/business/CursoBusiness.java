package com.cursos.app.business;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cursos.app.entity.ColegioProfesor;
import com.cursos.app.entity.Curso;
import com.cursos.app.entity.Matricula;
import com.cursos.app.repository.ColegioProfesorRepo;
import com.cursos.app.repository.MatriculaRepository;

@Service
public class CursoBusiness {

	@Autowired
	private MatriculaRepository matricula;
	
	@Autowired
	private ColegioProfesorRepo colegioProfesorRepo;

	public List<Curso> obtenerCursosVigentes(Integer idalumno) {
		List<Matricula> lmatricula = matricula.findByIdalumnoAndEstado(idalumno, "1");

		List<Curso> cursosEncontrados = new ArrayList<Curso>();

		if (lmatricula != null && lmatricula.size() > 0) {

			cursosEncontrados = lmatricula.get(0).getCursos();
			Set<Curso> hashSet = new HashSet<Curso>(cursosEncontrados);
			cursosEncontrados.clear();
			cursosEncontrados.addAll(hashSet);

			
			  cursosEncontrados.forEach(c -> {
				  c.getProfesor().forEach(p -> {
					  					  
					  List<ColegioProfesor> lcolpro = colegioProfesorRepo.findByIdprofesorAndIdcolegio(p.getIdpersona(), lmatricula.get(0).getIdcolegio());
					  p.setDatosLaborales(lcolpro!=null && lcolpro.size() > 0 ?lcolpro.get(0):new ColegioProfesor());
					  
				  });
				
			  
			  });
			 

			return cursosEncontrados;
		}
		return cursosEncontrados;
	}

}
