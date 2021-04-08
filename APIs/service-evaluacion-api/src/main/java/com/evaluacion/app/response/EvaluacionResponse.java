package com.evaluacion.app.response;

import javax.persistence.Id;

import lombok.Data;

@Data
public class EvaluacionResponse {
		
	private Double valor;
	
	private String criterio;
	
	private Double peso;
		
	private String estado;
	
}
