package com.cursos.app.entity;

import java.util.List;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Transient;

import lombok.Data;

@Data
@Entity(name="persona")
public class Profesor {
	
	@Id
	private int idpersona;
	private String nombres;
	private String apellidoPat;
	private String apellidoMat;
	
	@Transient
	private ColegioProfesor datosLaborales;
	
	
	
}

