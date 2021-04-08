package com.evaluacion.app.entity;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;

import lombok.Data;

@Data
@Entity(name="det_curso_evaluacion")
@IdClass(EvaluacionIdentity.class)
public class Evaluacion {
	
	@Id
	private int idcriterio;
	@Id
	private int idcurso;
	@Id
	private int idmatricula;
	
	private Double valor;
	
	private String estado;
	
	
	@OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "idcriterio", referencedColumnName = "idcriterio", insertable = false, updatable = false)
	private Criterio criterio;
	
}
