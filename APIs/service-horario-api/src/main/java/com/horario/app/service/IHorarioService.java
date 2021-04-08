package com.horario.app.service;

import java.util.List;

import com.horario.app.response.HorarioResponse;

public interface IHorarioService {

	public List<HorarioResponse> obtenerHorarioSemanal(Integer idalumno);
	
	public List<HorarioResponse> obtenerHorarioPorDia(Integer idalumno, int dia);
}
