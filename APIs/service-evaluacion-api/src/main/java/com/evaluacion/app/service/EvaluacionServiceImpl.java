package com.evaluacion.app.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.evaluacion.app.business.EvaluacionBusiness;
import com.evaluacion.app.entity.CursoEvaluacion;

@Service
public class EvaluacionServiceImpl implements IEvaluacionService {
	
	@Autowired
	private EvaluacionBusiness evaluacionBusiness; 
	
	@Override
	public List<CursoEvaluacion> obtenerCalificacionesCursos(Integer idalumno) {
		// TODO Auto-generated method Ostub
		return evaluacionBusiness.obtenerCalificacionesCursos(idalumno);
	}



}
