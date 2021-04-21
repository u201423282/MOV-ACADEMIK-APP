package com.example.academik;

import androidx.appcompat.app.AppCompatActivity;

import android.app.ActionBar;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.util.Base64;
import android.util.Log;
import android.view.View;
import android.widget.EditText;
import android.widget.TextView;

import com.android.volley.AuthFailureError;
import com.android.volley.DefaultRetryPolicy;
import com.android.volley.NetworkResponse;
import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.ServerError;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.HttpHeaderParser;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;
import com.example.academik.bean.LogueoBean;
import com.example.academik.utilitario.Util;

import org.json.JSONException;
import org.json.JSONObject;

import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Map;

public class LoginActivity extends AppCompatActivity {
    private Context context;
    String idPersona = "";
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        getSupportActionBar().show();
        context = this;
        setContentView(R.layout.activity_login);

    }

    public void f_login(View v) {

        final TextView msgLogueo = findViewById(R.id.msgLogueo);
        msgLogueo.setText("Validando...");
        final EditText txtUsuario = findViewById(R.id.etUsuario);
        final EditText txtPassword = findViewById(R.id.etPassword);
        String url = "http://20.83.224.206:9101/oauth/token";

        StringRequest stringRequest = new StringRequest(Request.Method.POST, url,
                new Response.Listener<String>() {
                    @Override
                    public void onResponse(String response) {
                        try {
                            JSONObject objeto = new JSONObject(response);
                            Log.i("======>", objeto.getString("idpersona"));
                             if(objeto.getString("idpersona") != null){
                                 idPersona = objeto.getString("idpersona");
                                 msgLogueo.setText("Autenticacion exitosa.");
                                 SharedPreferences prefs = getSharedPreferences("PREFERENCIAS", Context.MODE_PRIVATE);
                                 String urlPerfil = "http://20.83.224.206:9082/servicesREST/Persona/obtenerEstudiante/"+idPersona;
                                 msgLogueo.setText("Obteniendo Información...");
                                 StringRequest stringRequest= new StringRequest(Request.Method.GET, urlPerfil, new Response.Listener<String>() {
                                     @Override
                                     public void onResponse(String response) {
                                         try {

                                             JSONObject objeto = new JSONObject(response);
                                             LogueoBean infoSesion = new LogueoBean();
                                             infoSesion.setNombre(objeto.getString("nombres")+ " " + objeto.getString("apePaterno") + " " + objeto.getString("apeMaterno"));
                                             infoSesion.setCodigoAlumno(objeto.getString("identificador"));
                                             infoSesion.setSede(objeto.getString("descripcionUbicacion"));
                                             infoSesion.setSeccion(objeto.getString("seccion"));
                                             infoSesion.setTelefono(objeto.getString("telefono"));
                                             infoSesion.setCorreoAlumno(objeto.getString("correoPersonal"));
                                             infoSesion.setIdPersona(idPersona);
                                             Util.guardarInformacionAlumno(prefs, infoSesion);
                                             Intent i = new Intent(context, MenuNavigateActivity.class);
                                             i.putExtra("TOKEN", idPersona);
                                             startActivity(i);
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

                                 RequestQueue requestQueue = Volley.newRequestQueue(context);
                                 requestQueue.add(stringRequest);
                            }else{
                                msgLogueo.setText(objeto.getString("invalid_grant")!=null?objeto.getString("error_description"):"Error en el logueo");
                            }
                        } catch (JSONException e) {
                            msgLogueo.setText(e.getMessage());
                            Log.i("======>", e.getMessage());
                        }
                    }
                },
                new Response.ErrorListener() {
                    @Override
                    public void onErrorResponse(VolleyError error) {
                        // As of f605da3 the following should work
                        NetworkResponse response = error.networkResponse;
                        if (error instanceof ServerError && response != null) {
                            try {
                                String res = new String(response.data,
                                        HttpHeaderParser.parseCharset(response.headers, "utf-8"));
                                // Now you can use any deserializer to make sense of data
                                JSONObject obj = new JSONObject(res);
                                if(obj.getString("error") != null){
                                    msgLogueo.setText(obj.getString("error_description"));
                                }
                            } catch (UnsupportedEncodingException e1) {
                                // Couldn't properly decode data to string
                                e1.printStackTrace();
                            } catch (JSONException e2) {
                                // returned data is not JSONObject?
                                e2.printStackTrace();
                            }
                        }
                    }
                }
        ) {
            @Override
            protected Map<String, String> getParams() {
                Map<String, String> params = new HashMap();
                params.put("username", txtUsuario.getText().toString());
                params.put("password", txtPassword.getText().toString());
                params.put("grant_type", "password");
                return params;

            }
            ;

            public Map getHeaders() throws AuthFailureError {
                HashMap<String, String> params = new HashMap<String, String>();
                String creds = String.format("%s:%s", "appacademik", "12345");
                String auth = "Basic " + Base64.encodeToString(creds.getBytes(), Base64.DEFAULT);
                params.put("Authorization", auth);
                return params;
            }
            ;

        };

        RequestQueue requestQueue = Volley.newRequestQueue(context);
        requestQueue.add(stringRequest);
        stringRequest.setRetryPolicy(new DefaultRetryPolicy(30 * 1000, 1, 1.0f));
    }

}