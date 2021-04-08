package com.cursos.app.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.cursos.app.entity.ColegioProfesor;

public interface ColegioProfesorRepo extends JpaRepository<ColegioProfesor, Integer>{

	public List<ColegioProfesor> findByIdprofesorAndIdcolegio(Integer idProfesor, Integer idColegio);
	
}
