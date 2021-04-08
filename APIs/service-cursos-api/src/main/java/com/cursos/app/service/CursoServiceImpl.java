package com.cursos.app.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cursos.app.business.CursoBusiness;
import com.cursos.app.entity.Curso;

@Service
public class CursoServiceImpl implements ICursoService {
	
	@Autowired
	private CursoBusiness cursoNegocio;
	
	public List<Curso> obtenerCursosVigentes(Integer idalumno) {

		return cursoNegocio.obtenerCursosVigentes(idalumno);
	}
}
