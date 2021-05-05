package com.example.academik.Fragments;

import android.app.Activity;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.SharedPreferences;
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
import androidx.recyclerview.widget.DefaultItemAnimator;
import androidx.recyclerview.widget.DividerItemDecoration;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import com.android.volley.DefaultRetryPolicy;
import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;
import com.example.academik.R;
import com.example.academik.bean.CursosBean;
import com.example.academik.utilitario.CursosAdapter;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class CursosFragment extends Fragment {
    private ListView lv;
    private RequestQueue mQueue;
    ProgressDialog progressDialog;
    final Activity activity = getActivity();

    private List<CursosBean> cursosList = new ArrayList<>();
    private RecyclerView recyclerView;
    private CursosAdapter  mAdapter;

    @Nullable
    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {

        View view = inflater.inflate(R.layout.fragment_cursos,container,false);

        recyclerView = (RecyclerView) view.findViewById(R.id.rvCursos);

        mAdapter = new CursosAdapter(cursosList);
        RecyclerView.LayoutManager mLayoutManager = new LinearLayoutManager(getContext());
        recyclerView.setLayoutManager(mLayoutManager);
        recyclerView.setItemAnimator(new DefaultItemAnimator());
        recyclerView.addItemDecoration(new DividerItemDecoration(getActivity(), LinearLayoutManager.VERTICAL));
        recyclerView.setAdapter(mAdapter);

        cargarCursos();

        return view;
    }


    private void cargarCursos(){

        SharedPreferences prefs = this.getActivity().getSharedPreferences("PREFERENCIAS", Context.MODE_PRIVATE);
        String idpersona = prefs.getString("idpersona", "");
        String url = "http://20.83.224.206:9800/v1/curso/obtenerCursos/"+idpersona;

        StringRequest stringRequest= new StringRequest(Request.Method.GET, url, new Response.Listener<String>() {
            @Override
            public void onResponse(String response) {
                try {
                    JSONArray jsonArray = new JSONArray(response);

                    //String[] from = new String[] { "Time", "Name", "Desc" };
                    //int[] to = new int[] { R.id.tvCurso, R.id.tvProfesorNombre, R.id.tvProfesorCorreo };
                    progressDialog.incrementProgressBy(60);
                    //ArrayList<HashMap<String, String>> eventos = new ArrayList<HashMap<String, String>>();
                    for (int i=0; i<jsonArray.length(); i++){
                        JSONObject object = jsonArray.getJSONObject(i);
                        JSONArray profesor = (JSONArray) object.get("profesor");
                        JSONObject datoLab = (JSONObject)profesor.getJSONObject(0).get("datosLaborales");

                        CursosBean curso = new CursosBean(
                                object.getString("nombre")
                                , profesor.getJSONObject(0).getString("nombres") +" "+ profesor.getJSONObject(0).getString("apellidoPat")
                                , datoLab.getString("correolaboral"));
                        cursosList.add(curso);

                        //HashMap<String, String> datosEvento = new HashMap<String, String>();
                        //datosEvento.put("Time", object.getString("nombre"));
                        //datosEvento.put("Name", profesor.getJSONObject(0).getString("nombres") +" "+ profesor.getJSONObject(0).getString("apellidoPat"));
                        //datosEvento.put("Desc", datoLab.getString("correolaboral"));
                        //datosEvento.put("id", object.getString("idcurso"));

                        //eventos.add(datosEvento);
                    }

                    mAdapter.notifyDataSetChanged();

                    //SimpleAdapter adaptador = new SimpleAdapter(getActivity().getApplicationContext(), eventos, R.layout.fragment_cursos_datos, from, to);
                    //lv.setAdapter(adaptador);

                    progressDialog.dismiss();
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
        mQueue= Volley.newRequestQueue(getActivity().getApplicationContext());
        mQueue.add(stringRequest);
        stringRequest.setRetryPolicy(new DefaultRetryPolicy(30 * 1000, 1, 1.0f));

        progressDialog = new ProgressDialog(getActivity());
        progressDialog.setTitle("Cursos");
        progressDialog.setMessage("Cargando Datos...");
        progressDialog.show(); // Display Progress Dialog
        progressDialog.setCancelable(false);
    }

}
