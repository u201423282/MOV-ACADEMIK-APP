package com.cursos.app.rest;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.cursos.app.entity.Curso;
import com.cursos.app.service.ICursoService;

@RestController
@RequestMapping(value = "/v1/curso")
public class CursoRest {
	
	
	@Autowired
	ICursoService cursoService;
	
	@GetMapping(value = "/obtenerCursos/{idalumno}", produces = { "application/json" })
	List<Curso> obtenerCursosVigentes(@PathVariable (value ="idalumno") Integer idalumno) {
		return cursoService.obtenerCursosVigentes(idalumno);
	}
	
}
