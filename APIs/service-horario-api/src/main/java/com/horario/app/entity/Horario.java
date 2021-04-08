package com.horario.app.entity;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;


import lombok.Data;

@Entity(name="programacion_seccion_curso")
@Data
public class Horario {
	@Id
	private int idprogseccur;
	private int idseccion;
	private int idcurso;
	private String dia;
	private String horainicio;
	private String horafin;
	private Integer idprofesor;
	
	@OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "idcurso", referencedColumnName = "idcurso", insertable = false, updatable = false)
	private Curso curso;
	
	@OneToOne(optional = true, cascade = CascadeType.ALL)
    @JoinColumn(name = "idprofesor", nullable = true, referencedColumnName = "idpersona", insertable = false, updatable = false)
	private Persona profesor;
	
	
}
