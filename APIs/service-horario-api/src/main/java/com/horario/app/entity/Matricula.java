package com.horario.app.entity;

import javax.persistence.Entity;
import javax.persistence.Id;

import lombok.Data;

@Entity(name="matricula")
@Data
public class Matricula {
	
	
private int idalumno;
	
	@Id
	private int idmatricula;
	
	private int seccion;
	
	private String estado;
	
	private int idcolegio;
	
	
}
