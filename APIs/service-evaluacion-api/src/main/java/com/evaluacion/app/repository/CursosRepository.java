package com.evaluacion.app.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.evaluacion.app.entity.CursoEvaluacion;

public interface CursosRepository extends JpaRepository<CursoEvaluacion, Integer>{
	
}
