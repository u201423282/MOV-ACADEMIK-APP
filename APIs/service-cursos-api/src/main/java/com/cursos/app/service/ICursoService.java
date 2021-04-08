package com.cursos.app.service;

import java.util.List;

import com.cursos.app.entity.Curso;

public interface ICursoService {
	
	public List<Curso> obtenerCursosVigentes(Integer idalumno);
	
}
