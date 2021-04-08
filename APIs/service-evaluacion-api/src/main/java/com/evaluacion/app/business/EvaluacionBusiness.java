package com.evaluacion.app.business;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.evaluacion.app.entity.CursoEvaluacion;
import com.evaluacion.app.entity.Evaluacion;
import com.evaluacion.app.entity.Matricula;
import com.evaluacion.app.repository.EvaluacionRepository;
import com.evaluacion.app.repository.MatriculaRepository;
import com.evaluacion.app.response.EvaluacionResponse;

@Service
public class EvaluacionBusiness {

	@Autowired
	private MatriculaRepository matriculaRepo;

	@Autowired
	private EvaluacionRepository evaluacionRepo;

	public List<CursoEvaluacion> obtenerCalificacionesCursos(Integer idalumno) {
		List<Matricula> lmatricula = matriculaRepo.findByIdalumnoAndEstado(idalumno, "1");

		List<CursoEvaluacion> cursosEncontrados = new ArrayList<CursoEvaluacion>();

		if (lmatricula != null && lmatricula.size() > 0) {

			cursosEncontrados = lmatricula.get(0).getCursos();
			Set<CursoEvaluacion> hashSet = new HashSet<CursoEvaluacion>(cursosEncontrados);
			cursosEncontrados.clear();
			cursosEncontrados.addAll(hashSet);

			cursosEncontrados.forEach(c -> {

				List<Evaluacion> evaluaciones = evaluacionRepo.findByIdcurso(c.getIdcurso());
				List<EvaluacionResponse> evaluacionesList =  new ArrayList<EvaluacionResponse>();
				if (evaluaciones != null && evaluaciones.size() > 0) {
						
					evaluaciones.forEach(e -> {
						
						EvaluacionResponse evaluacionResponse = new EvaluacionResponse();
						evaluacionResponse.setCriterio(e.getCriterio().getDescripcion());
						evaluacionResponse.setPeso(e.getCriterio().getPeso());
						evaluacionResponse.setValor(e.getValor());
						evaluacionResponse.setEstado(e.getEstado());
						evaluacionesList.add(evaluacionResponse);
						

					});

				}
				
				c.setEvaluaciones(evaluacionesList);

			});

			return cursosEncontrados;

		}

		return cursosEncontrados;

	}

}
