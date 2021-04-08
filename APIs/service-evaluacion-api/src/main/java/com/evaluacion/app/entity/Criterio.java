package com.evaluacion.app.entity;

import javax.persistence.Entity;
import javax.persistence.Id;

import lombok.Data;

@Data
@Entity(name="criterio_evaluacion")
public class Criterio {
	
	@Id
	private int idcriterio;
	
	private String descripcion;
	
	private Double peso;
	
	private String estado;
	
	
}
