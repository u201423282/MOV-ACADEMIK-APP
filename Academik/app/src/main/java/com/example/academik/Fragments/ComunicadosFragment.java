package com.example.academik.Fragments;

import android.os.Bundle;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import android.widget.SimpleAdapter;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;

import com.example.academik.DAO.ComunicadoDAO;
import com.example.academik.DAO.DAOException;
import com.example.academik.R;
import com.example.academik.bean.ComunicadoBean;

import java.util.ArrayList;
import java.util.HashMap;

public class ComunicadosFragment extends Fragment {

    ArrayList<ComunicadoBean> comunicados = null;

    @Nullable
    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {

        View view = inflater.inflate(R.layout.fragment_comunicados,container,false);

        listar(view);

        return view;
    }

    public void listar(View view) {
        ComunicadoDAO dao = new ComunicadoDAO(getActivity().getApplicationContext());
        try {
            comunicados = dao.listar();

            String[] from = new String[] { "Titulo", "Descripcion", "Fecha" };
            int[] to = new int[] { R.id.tvComunicadoTitulo, R.id.tvComunicadoDescripcion, R.id.tvComunicadoFecha };

            ArrayList<HashMap<String, String>> lista = new ArrayList<HashMap<String, String>>();

            for (ComunicadoBean bean:comunicados){
                HashMap<String, String> datosEvento = new HashMap<String, String>();

                datosEvento.put("Titulo", bean.getTitulo());
                datosEvento.put("Descripcion", bean.getDescripcion());
                datosEvento.put("Fecha", bean.getFecha());

                lista.add(datosEvento);
            }

            SimpleAdapter listadoAdapter = new SimpleAdapter(getActivity().getApplicationContext(), lista, R.layout.fragment_comunicados_datos, from, to);

            ListView lv = (ListView) view.findViewById(R.id.lstComunicados);
            lv.setAdapter(listadoAdapter);

        } catch (DAOException e) {
            Log.i("Listar Comunicados", "====> " + e.getMessage());
        }
    }


}
