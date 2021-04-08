package com.evaluacion.app.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.evaluacion.app.entity.Matricula;

public interface MatriculaRepository extends JpaRepository<Matricula, Integer> {

	public List<Matricula> findByIdalumnoAndEstado(Integer idalumno, String estado);
}
