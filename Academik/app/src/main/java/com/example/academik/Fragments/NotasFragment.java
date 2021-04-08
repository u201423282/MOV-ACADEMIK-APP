package com.example.academik.Fragments;

import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ListView;
import android.widget.SimpleAdapter;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;

import com.example.academik.R;

import java.util.ArrayList;
import java.util.HashMap;

public class NotasFragment extends Fragment {

    @Nullable
    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {

        View view = inflater.inflate(R.layout.fragment_notas,container,false);

        String[] from = new String[] { "Nombre", "Desc1", "Nota1", "Desc2", "Nota2", "Desc3", "Nota3" };
        int[] to = new int[] { R.id.tvNotaCursoNombre, R.id.tvNotaDescripcion1, R.id.tvNotaCalificacion1, R.id.tvNotaDescripcion2, R.id.tvNotaCalificacion2, R.id.tvNotaDescripcion3, R.id.tvNotaCalificacion3 };

        ArrayList<String[]> lista = new ArrayList<String[]>();

        String[] evento1 = { "Karate", "Examen Enero", "15.00", "Examen Febrero", "15.00", "Examen Marzo", "15.00" };
        String[] evento2 = { "Ingles", "Examen Enero", "15.50", "Examen Febrero", "13.00", "Examen Marzo", "18.00" };
        String[] evento3 = { "Biologia", "Examen Enero", "15.00", "Examen Febrero", "15.00", "Examen Marzo", "15.00" };

        lista.add(evento1);
        lista.add(evento2);
        lista.add(evento3);

        ArrayList<HashMap<String, String>> eventos = new ArrayList<HashMap<String, String>>();

        for (String[] evento : lista) {
            HashMap<String, String> datosEvento = new HashMap<String, String>();

            datosEvento.put("Nombre", evento[0]);
            datosEvento.put("Desc1", evento[1]);
            datosEvento.put("Nota1", evento[2]);
            datosEvento.put("Desc2", evento[3]);
            datosEvento.put("Nota2", evento[4]);
            datosEvento.put("Desc3", evento[5]);
            datosEvento.put("Nota3", evento[6]);

            eventos.add(datosEvento);
        }

        SimpleAdapter listadoAdapter = new SimpleAdapter(getActivity().getApplicationContext(), eventos, R.layout.fragment_notas_datos, from, to);

        ListView lv = (ListView) view.findViewById(R.id.lstNotasDetalle);
        lv.setAdapter(listadoAdapter);

        return view;
    }
}
