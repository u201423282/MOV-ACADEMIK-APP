package com.evaluacion.app.rest;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.evaluacion.app.entity.CursoEvaluacion;
import com.evaluacion.app.service.IEvaluacionService;

@RestController
@RequestMapping(value = "/v1/evaluacion")
public class EvaluacionRest {
	
	@Autowired
	private IEvaluacionService evaluacion;
	
	@GetMapping(value = "/obtenerCalificacionesCursos/{idalumno}", produces = { "application/json" })
	public List<CursoEvaluacion> obtenerCalificacionesCursos (@PathVariable (value ="idalumno") Integer idalumno){
		return evaluacion.obtenerCalificacionesCursos(idalumno);
	}
	
	
}
