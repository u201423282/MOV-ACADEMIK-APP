package com.horario.app.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.horario.app.entity.Matricula;

public interface MatriculaRepository extends JpaRepository<Matricula, Integer>{
	
	public List<Matricula> findByIdalumnoAndEstado(Integer idAlumno, String estado);
	
}
