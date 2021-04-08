package com.horario.app.business;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.horario.app.entity.Horario;
import com.horario.app.entity.Matricula;
import com.horario.app.enums.SemanaEnum;
import com.horario.app.repository.MatriculaRepository;
import com.horario.app.repository.ProgramacionRepository;
import com.horario.app.response.HorarioResponse;

@Service
public class HorarioBusiness {

	@Autowired
	private MatriculaRepository matriculaRepo;

	@Autowired
	private ProgramacionRepository progRepo;

	public List<HorarioResponse> obtenerHorarioSemanal(Integer idalumno, int dia) {

		List<Matricula> lmatricula = matriculaRepo.findByIdalumnoAndEstado(idalumno, "1");
		List<HorarioResponse> lhorario = new ArrayList<HorarioResponse>();
		if (lmatricula != null && lmatricula.size() > 0) {

			List<Horario> lprog = progRepo.findByIdseccion(lmatricula.get(0).getSeccion());

			lprog.forEach(h -> {
				HorarioResponse response = new HorarioResponse();
				response.setDia(h.getDia());
				response.setHorainicio(h.getHorainicio());
				response.setHorafin(h.getHorafin());
				response.setCurso(h.getCurso().getNombre());

				response.setProfesor(
						h.getProfesor() != null ? h.getProfesor().getNombres() + " " + h.getProfesor().getApellidoPat()
								: "NO ASIGNADO");

				lhorario.add(response);
			});
		}

		return lhorario;
	}

	public List<HorarioResponse> obtenerHorarioPorDia(Integer idalumno, int dia) {

		List<Matricula> lmatricula = matriculaRepo.findByIdalumnoAndEstado(idalumno, "1");
		List<HorarioResponse> lhorario = new ArrayList<HorarioResponse>();
		if (lmatricula != null && lmatricula.size() > 0) {

			List<Horario> lprog = progRepo.findByIdseccion(lmatricula.get(0).getSeccion());

			lprog.forEach(h -> {
			
				if (SemanaEnum.fromAnotherValue(dia + "").equals(SemanaEnum.fromValue(h.getDia()))) {

					HorarioResponse response = new HorarioResponse();
					response.setDia(h.getDia());
					response.setHorainicio(h.getHorainicio());
					response.setHorafin(h.getHorafin());
					response.setCurso(h.getCurso().getNombre());

					response.setProfesor(h.getProfesor() != null
							? h.getProfesor().getNombres() + " " + h.getProfesor().getApellidoPat()
							: "NO ASIGNADO");

					lhorario.add(response);

				}

			});
		}

		return lhorario;
	}

}
