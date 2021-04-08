package com.horario.app.entity;

import javax.persistence.Entity;
import javax.persistence.Id;

import lombok.Data;

@Data
@Entity(name="persona")
public class Persona {
	
	@Id
	private int idpersona;
	private String nombres;
	private String apellidoPat;
	private String apellidoMat;
	
}
