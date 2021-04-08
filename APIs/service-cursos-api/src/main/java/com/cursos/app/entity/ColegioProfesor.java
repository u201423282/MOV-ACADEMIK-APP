package com.cursos.app.entity;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

import lombok.Data;


@Entity(name="colegio_profesor")
@Data
public class ColegioProfesor {
	
	@Id
	private Integer idprofesor;
	private String identificador;
	private String correolaboral;
	private Integer idcolegio;
	
	
}
