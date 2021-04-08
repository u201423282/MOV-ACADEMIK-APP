package com.horario.app.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.horario.app.entity.Horario;

public interface ProgramacionRepository extends JpaRepository<Horario, Integer>{
	
	public List<Horario> findByIdseccion(Integer idseccion);
}
