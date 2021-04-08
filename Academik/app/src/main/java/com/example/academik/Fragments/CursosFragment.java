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

public class CursosFragment extends Fragment {

    @Nullable
    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {

        View view = inflater.inflate(R.layout.fragment_cursos,container,false);


        String[] from = new String[] { "Time", "Name", "Desc" };
        int[] to = new int[] { R.id.tvCurso, R.id.tvProfesorNombre, R.id.tvProfesorCorreo };

        ArrayList<String[]> lista = new ArrayList<String[]>();

        String[] evento1 = { "Karate", "Prof. Zlatan Ibra", "zibra@fifa.pe", "1" };
        String[] evento2 = { "Ingles", "Prof. Carlos Tevez", "ctevez@fifa.pe", "2" };
        String[] evento3 = { "Biologia", "Prof. Cristiano Ronaldo", "cr7@fifa.pe", "3" };

        lista.add(evento1);
        lista.add(evento2);
        lista.add(evento3);

        ArrayList<HashMap<String, String>> eventos = new ArrayList<HashMap<String, String>>();

        for (String[] evento : lista) {
            HashMap<String, String> datosEvento = new HashMap<String, String>();

            datosEvento.put("Time", evento[0]);
            datosEvento.put("Name", evento[1]);
            datosEvento.put("Desc", evento[2]);
            datosEvento.put("id", evento[3]);

            eventos.add(datosEvento);
        }

        SimpleAdapter listadoAdapter = new SimpleAdapter(getActivity().getApplicationContext(), eventos, R.layout.fragment_cursos_datos, from, to);

        ListView lv = (ListView) view.findViewById(R.id.lstDiaDetalle);
        lv.setAdapter(listadoAdapter);

        return view;
    }
}
