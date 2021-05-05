package com.example.academik.Fragments;

import android.app.ProgressDialog;
import android.content.Context;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ListView;
import android.widget.SimpleAdapter;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;

import com.android.volley.DefaultRetryPolicy;
import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;
import com.example.academik.R;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.HashMap;

public class NotasFragment extends Fragment {
    private ListView lv2;
    private RequestQueue mQueue2;
    ProgressDialog progressDialog;
    @Nullable
    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {

        View view = inflater.inflate(R.layout.fragment_notas,container,false);

        lv2 = (ListView) view.findViewById(R.id.lstNotasDetalle);
        cargarCalificaciones();
        return view;
    }


    private void cargarCalificaciones(){

        SharedPreferences prefs = this.getActivity().getSharedPreferences("PREFERENCIAS", Context.MODE_PRIVATE);
        String idpersona = prefs.getString("idpersona", "");

        String url = "http://20.83.224.206:9801/v1/evaluacion/obtenerCalificacionesCursos/"+idpersona;

        StringRequest stringRequest= new StringRequest(Request.Method.GET, url, new Response.Listener<String>() {
            @Override
            public void onResponse(String response) {
                try {
                    String[] from = new String[] { "Nombre","Desc1","Nota1","Desc2","Nota2","Desc3","Nota3","Desc4","Nota4","Desc5","Nota5","Desc6","Nota6","Desc7","Nota7"};

                    int[] to = new int[] {
                            R.id.tvNotaCursoNombre,
                            R.id.tvNotaDescripcion1,
                            R.id.tvNotaCalificacion1,
                            R.id.tvNotaDescripcion2,
                            R.id.tvNotaCalificacion2,
                            R.id.tvNotaDescripcion3,
                            R.id.tvNotaCalificacion3,
                            R.id.tvNotaDescripcion4,
                            R.id.tvNotaCalificacion4,
                            R.id.tvNotaDescripcion5,
                            R.id.tvNotaCalificacion5,
                            R.id.tvNotaDescripcion6,
                            R.id.tvNotaCalificacion6,
                            R.id.tvNotaDescripcion7,
                            R.id.tvNotaCalificacion7
                    };
                    JSONArray jsonArray = new JSONArray(response);

                    ArrayList<HashMap<String, String>> eventos = new ArrayList<HashMap<String, String>>();
                    for (int i=0; i<jsonArray.length(); i++){

                        JSONObject object = jsonArray.getJSONObject(i);
                        JSONArray evaluaciones = (JSONArray) object.get("evaluaciones");
                        HashMap<String, String> datosEvento = new HashMap<String, String>();
                        datosEvento.put("Nombre", object.getString("nombre"));
                       // for (int j=0; j<evaluaciones.length(); j++){
                        JSONObject objectEva = evaluaciones.getJSONObject(0);
                        datosEvento.put("Desc1", objectEva.getString("criterio"));
                        datosEvento.put("Nota1", objectEva.getString("valor"));

                        JSONObject objectEva2 = evaluaciones.getJSONObject(1);
                        datosEvento.put("Desc2", objectEva2.getString("criterio"));
                        datosEvento.put("Nota2", objectEva2.getString("valor"));

                        JSONObject objectEva3 = evaluaciones.getJSONObject(2);
                        datosEvento.put("Desc3", objectEva3.getString("criterio"));
                        datosEvento.put("Nota3", objectEva3.getString("valor"));

                        JSONObject objectEva4 = evaluaciones.getJSONObject(3);
                        datosEvento.put("Desc4", objectEva4.getString("criterio"));
                        datosEvento.put("Nota4", objectEva4.getString("valor"));

                        //}
                        eventos.add(datosEvento);
                    }

                    SimpleAdapter listadoAdapter = new SimpleAdapter(getActivity().getApplicationContext(),
                            eventos, R.layout.fragment_notas_datos, from, to);
                    progressDialog.dismiss();
                    lv2.setAdapter(listadoAdapter);
                } catch (JSONException e) {
                    Log.i("======>", e.getMessage());
                }
            }
        },
                new Response.ErrorListener() {
                    @Override
                    public void onErrorResponse(VolleyError error) {
                        Log.i("======>", error.toString());
                        progressDialog.dismiss();
                    }
                }
        );
        mQueue2= Volley.newRequestQueue(getActivity().getApplicationContext());
        mQueue2.add(stringRequest);
        stringRequest.setRetryPolicy(new DefaultRetryPolicy(30 * 1000, 1, 1.0f));
        progressDialog = new ProgressDialog(getActivity());
        progressDialog.setTitle("Calificaciones");
        progressDialog.setMessage("Cargando Calificaciones...");
        progressDialog.show(); // Display Progress Dialog
        progressDialog.setCancelable(false);
    }
}
