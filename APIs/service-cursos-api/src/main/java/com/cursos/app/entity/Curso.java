package com.cursos.app.entity;

import java.util.List;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;

import lombok.Data;

@Entity(name="cursos")
@Data
public class Curso {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int idcurso;
	private String identificador;
	private String nombre;
	private String estado;
	
	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(name = "curso_profesor", joinColumns = @JoinColumn(name = "idcurso"), inverseJoinColumns = @JoinColumn(name = "idprofesor"))
	private List<Profesor> profesor;
	
}
