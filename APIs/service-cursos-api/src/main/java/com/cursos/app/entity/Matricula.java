package com.cursos.app.entity;

import java.io.Serializable;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;

import lombok.Data;

@Entity(name="matricula")
@Data
public class Matricula implements Serializable{/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private int idalumno;
	
	@Id
	private int seccion;
	
	private String estado;
	
	private int idcolegio;
	
	@ManyToMany(fetch = FetchType.EAGER)
	@JoinTable(name = "programacion_seccion_curso", joinColumns = @JoinColumn(name = "idseccion"), inverseJoinColumns = @JoinColumn(name = "idcurso"))
	private List<Curso> cursos;

}
