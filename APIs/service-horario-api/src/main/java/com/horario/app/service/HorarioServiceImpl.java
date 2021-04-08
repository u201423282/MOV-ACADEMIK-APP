package com.horario.app.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.horario.app.business.HorarioBusiness;
import com.horario.app.response.HorarioResponse;

@Service
public class HorarioServiceImpl implements IHorarioService {
	
	@Autowired
	private HorarioBusiness horarioBusiness; 
	
	@Override
	public List<HorarioResponse> obtenerHorarioSemanal(Integer idalumno) {
		// TODO Auto-generated method stub
		return horarioBusiness.obtenerHorarioSemanal(idalumno, 0);
	}

	@Override
	public List<HorarioResponse> obtenerHorarioPorDia(Integer idalumno, int dia) {
		// TODO Auto-generated method stub
		return horarioBusiness.obtenerHorarioPorDia(idalumno, dia);
	}

}
