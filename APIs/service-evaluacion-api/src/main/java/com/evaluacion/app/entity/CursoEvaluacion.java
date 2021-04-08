package com.evaluacion.app.entity;

import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Transient;

import com.evaluacion.app.response.EvaluacionResponse;

import lombok.Data;

@Data
@Entity(name="cursos")
public class CursoEvaluacion {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int idcurso;
	private String identificador;
	private String nombre;
	
	@Transient
	private List<EvaluacionResponse> evaluaciones;
	
}
