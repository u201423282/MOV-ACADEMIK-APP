package com.example.academik.Fragments;

import android.Manifest;
import android.app.Activity;
import android.app.ProgressDialog;
import android.content.ContentResolver;
import android.content.ContentUris;
import android.content.ContentValues;
import android.content.Context;
import android.content.SharedPreferences;
import android.content.pm.PackageManager;
import android.database.Cursor;
import android.net.Uri;
import android.os.Bundle;
import android.provider.CalendarContract;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.CalendarView;
import android.widget.ListView;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.core.app.ActivityCompat;
import androidx.fragment.app.Fragment;
import androidx.fragment.app.FragmentManager;
import androidx.fragment.app.FragmentTransaction;

import com.android.volley.DefaultRetryPolicy;
import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;
import com.example.academik.R;
import com.example.academik.bean.CursosBean;
import com.example.academik.utilitario.SemanaEnum;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class HorarioFragment extends Fragment {

    private static final int MY_CAL_WRITE_REQ = 1;
    // Variables para cargar el fragment principal
    FragmentManager fragmentManager;
    FragmentTransaction fragmentTransaction;
    final Activity activity = getActivity();
    private RequestQueue mQueue;
    ListView lsCursos ;
    @Nullable
    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {

        View view = inflater.inflate(R.layout.fragment_horario,container,false);

        CalendarView simpleCalendarView = (CalendarView) view.findViewById(R.id.cvHorario);
        simpleCalendarView.setDate(new Date().getTime(),false,true);
        Date myDate = new Date(simpleCalendarView.getDate());
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(myDate);
        calendar.add(Calendar.DAY_OF_YEAR, 7);
        Date newDate = calendar.getTime();
        simpleCalendarView.setMaxDate(newDate.getTime());
        lsCursos = (ListView) view.findViewById(R.id.lsCursos);
        SharedPreferences prefs = this.getActivity().getSharedPreferences("PREFERENCIAS", Context.MODE_PRIVATE);
        String idpersona = prefs.getString("idpersona", "");

        simpleCalendarView.setOnDateChangeListener(new CalendarView.OnDateChangeListener() {
            @Override
        public void onSelectedDayChange(CalendarView view, int year, int month,
            int dayOfMonth) {
                try {
                String sDate1= dayOfMonth+"/"+month+"/"+year;
                Date date1 = new SimpleDateFormat("dd/MM/yyyy").parse(sDate1);
                String dayWeekText = new SimpleDateFormat("EEEE").format(date1);

                String dayOfWeek = SemanaEnum.fromValue(dayWeekText.toUpperCase()).toStringAnotherValue();

                String url = "http://20.83.224.206:8081/v1/horario/obtenerHorarioPorDia/"+idpersona+"/"+dayOfWeek;

                        StringRequest stringRequest= new StringRequest(Request.Method.GET, url, new Response.Listener<String>() {
                            @Override
                            public void onResponse(String response) {
                                try {
                                    JSONArray jsonArray = new JSONArray(response);
                                    String[] matriz = new String[jsonArray!=null && jsonArray.length()>0?jsonArray.length()*2:1];
                                    int index = 0;
                                    for (int i=0; i<jsonArray.length(); i++){
                                        JSONObject object = jsonArray.getJSONObject(i);
                                        matriz[index] = object.getString("curso").toUpperCase();
                                        index++;
                                        matriz[index] = "Profesor "+object.getString("profesor") + " De: "+object.getString("horainicio")+" A: "+object.getString("horafin") +"Hrs";

                                        index++;

                                    }

                                    if(index == 0){
                                        matriz[index] = "No tiene cursos asignados";
                                    }

                                    ArrayAdapter<String> adaptador = new ArrayAdapter<String>(getActivity().getApplicationContext(),
                                            android.R.layout.simple_list_item_1,
                                            matriz);

                                    lsCursos.setAdapter(adaptador);

                                } catch (JSONException e) {
                                    Log.i("======>", e.getMessage());
                                }
                            }
                        },
                                new Response.ErrorListener() {
                                    @Override
                                    public void onErrorResponse(VolleyError error) {
                                        Log.i("======>", error.toString());
                                    }
                                }
                        );
                        mQueue= Volley.newRequestQueue(getActivity().getApplicationContext());
                        mQueue.add(stringRequest);
                        stringRequest.setRetryPolicy(new DefaultRetryPolicy(30 * 1000, 1, 1.0f));

                } catch (ParseException e) {
                    e.printStackTrace();
                }
            }
        });
        return view;
    }

}
