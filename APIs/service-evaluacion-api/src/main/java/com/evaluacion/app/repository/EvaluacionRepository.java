package com.evaluacion.app.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.evaluacion.app.entity.Evaluacion;

public interface EvaluacionRepository  extends JpaRepository<Evaluacion, Integer>{

	public List<Evaluacion> findByIdcurso(Integer idCurso);
	
}
