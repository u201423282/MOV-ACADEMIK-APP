package com.example.academik.Fragments;

import android.os.Bundle;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.ListView;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;
import androidx.fragment.app.FragmentManager;
import androidx.fragment.app.FragmentTransaction;

import com.example.academik.R;

public class HorarioFragment extends Fragment {

    // Variables para cargar el fragment principal
    FragmentManager fragmentManager;
    FragmentTransaction fragmentTransaction;

    @Nullable
    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {

        View view = inflater.inflate(R.layout.fragment_horario,container,false);

        ListView lstDias = (ListView) view.findViewById(R.id.lstDias);

        int i = 0;
        String[] matriz = new String[5];
        matriz[i++] = "Lunes";
        matriz[i++] = "Martes";
        matriz[i++] = "Miercoles";
        matriz[i++] = "Jueves";
        matriz[i++] = "Viernes";

        ArrayAdapter<String> adaptador = new ArrayAdapter<String>(getActivity().getApplicationContext(),
                android.R.layout.simple_list_item_1,
                matriz);
        lstDias.setAdapter(adaptador);

        lstDias.setOnItemClickListener(new AdapterView.OnItemClickListener()
        {
            @Override
            public void onItemClick(AdapterView<?> adapter, View v,
                                    int position, long arg3)
            {
                String value = (String)adapter.getItemAtPosition(position);
                Log.i("=====>", "Dentro de click: " + value);

                // Crear fragmento de tu clase
                Fragment fragment = new CursosFragment();
                // Obtener el administrador de fragmentos a través de la actividad
                FragmentManager fragmentManager = getActivity().getSupportFragmentManager();
                // Definir una transacción
                FragmentTransaction fragmentTransaction = fragmentManager.beginTransaction();
                // Remplazar el contenido principal por el fragmento
                fragmentTransaction.replace(R.id.container, fragment);
                fragmentTransaction.addToBackStack(null);
                // Cambiar
                fragmentTransaction.commit();

            }
        });

        return view;
    }
}
