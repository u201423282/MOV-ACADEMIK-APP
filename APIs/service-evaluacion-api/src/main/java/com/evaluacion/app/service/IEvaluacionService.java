package com.evaluacion.app.service;

import java.util.List;

import com.evaluacion.app.entity.CursoEvaluacion;

public interface IEvaluacionService {
	
	public List<CursoEvaluacion> obtenerCalificacionesCursos (Integer idalumno);
	
}
