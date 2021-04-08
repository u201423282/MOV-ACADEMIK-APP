package com.horario.app.rest;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.horario.app.response.HorarioResponse;
import com.horario.app.service.IHorarioService;

@RestController
@RequestMapping(value = "/v1/horario")
public class HorarioRest {

	@Autowired
	private IHorarioService horario;

	@GetMapping(value = "/obtenerHorarioSemanal/{idalumno}", produces = { "application/json" })
	public List<HorarioResponse> obtenerHorarioSemanal(@PathVariable(value = "idalumno") Integer idalumno) {

		return horario.obtenerHorarioSemanal(idalumno);
	}

	@GetMapping(value = "/obtenerHorarioPorDia/{idalumno}/{dia}", produces = { "application/json" })
	public List<HorarioResponse> obtenerHorarioSemanal(@PathVariable(value = "idalumno") Integer idalumno,
			@PathVariable(value = "dia") Integer dia) {

		return horario.obtenerHorarioPorDia(idalumno, dia);
	}

}
