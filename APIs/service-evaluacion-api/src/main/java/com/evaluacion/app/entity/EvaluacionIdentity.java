package com.evaluacion.app.entity;

import java.io.Serializable;

import javax.persistence.Id;

import lombok.Data;

@Data
public class EvaluacionIdentity implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	
	
	@Id
	private int idcriterio;
	@Id
	private int idcurso;
	@Id
	private int idmatricula;

}
