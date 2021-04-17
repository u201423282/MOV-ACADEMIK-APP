package com.example.academik.Fragments;

import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;
import androidx.fragment.app.FragmentManager;
import androidx.fragment.app.FragmentTransaction;

import com.android.volley.AuthFailureError;
import com.android.volley.NetworkResponse;
import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.VolleyLog;
import com.android.volley.toolbox.HttpHeaderParser;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;
import com.example.academik.R;
import com.example.academik.bean.LogueoBean;

import org.json.JSONException;
import org.json.JSONObject;

import java.io.UnsupportedEncodingException;

public class PerfilEditFragment extends Fragment {

    EditText codigoText;
    TextView actPerfilText;
    EditText seccionText;
    EditText nombreText;
    EditText telefonoText;
    EditText correoText;
    Button button;

    @Nullable
    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {

        View view = inflater.inflate(R.layout.fragment_perfil_edit,container,false);
        SharedPreferences prefs = this.getActivity().getSharedPreferences("PREFERENCIAS", Context.MODE_PRIVATE);

        button = (Button) view.findViewById(R.id.btnSave);
        button.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                AlertDialog.Builder dialogo1 = new AlertDialog.Builder(v.getContext());
                dialogo1.setTitle("Confirmación");
                dialogo1.setMessage("¿ Desea actualizar los datos ?");
                dialogo1.setCancelable(false);
                dialogo1.setPositiveButton("Confirmar", new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialogo1, int id) {
                        aceptar();
                    }
                });
                dialogo1.setNegativeButton("Cancelar", new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialogo1, int id) {
                        cancelar();
                    }
                });
                dialogo1.show();


            }
        });

        String nombre = prefs.getString("nombre", "");
        String codigo = prefs.getString("codigo", "");
        String telefono = prefs.getString("telefono", "");
        String correoalumno = prefs.getString("correoalumno", "");

        codigoText = (EditText) view.findViewById(R.id.etCodigoAlumno);
        nombreText = (EditText) view.findViewById(R.id.etNombre);
        telefonoText = (EditText) view.findViewById(R.id.etTelefono);
        correoText = (EditText) view.findViewById(R.id.etCorreo);
        actPerfilText = (TextView) view.findViewById(R.id.msgActPerfil);

        nombreText.setText(nombre);
        codigoText.setText(codigo);
        telefonoText.setText(telefono);
        correoText.setText(correoalumno);

        return view;
    }

    public void aceptar(){
        actPerfilText.setText("Actualizando...");
        SharedPreferences prefs = this.getActivity().getSharedPreferences("PREFERENCIAS", Context.MODE_PRIVATE);
        String idpersona = prefs.getString("idpersona", "");
        String telefono = telefonoText.getText().toString();
        String correoalumno = correoText.getText().toString();

        try {
            String URL = "http://20.83.224.206:9082/servicesREST/Persona/actualizarEstudiante";
            JSONObject jsonBody = new JSONObject();

            jsonBody.put("idPersona", Integer.parseInt(idpersona));
            jsonBody.put("correoPersonal", correoalumno);
            jsonBody.put("telefono", telefono);

            final String mRequestBody = jsonBody.toString();

            StringRequest stringRequest = new StringRequest(Request.Method.POST, URL, new Response.Listener<String>() {
                @Override
                public void onResponse(String response) {
                    Log.i("======>",response);

                    if(Integer.parseInt(response) == 200 ){
                        SharedPreferences.Editor editor = prefs.edit();
                        editor.putString("correoalumno", correoalumno);
                        editor.putString("telefono", telefono);
                        editor.commit();

                        Fragment fragment = new PerfilFragment();
                        FragmentManager fragmentManager = getActivity().getSupportFragmentManager();
                        FragmentTransaction fragmentTransaction = fragmentManager.beginTransaction();
                        fragmentTransaction.replace(R.id.container, fragment);
                        fragmentTransaction.addToBackStack(null);
                        fragmentTransaction.commit();

                    }

                }
            }, new Response.ErrorListener() {
                @Override
                public void onErrorResponse(VolleyError error) {

                }
            }) {
                @Override
                public String getBodyContentType() {
                    return "application/json; charset=utf-8";
                }

                @Override
                public byte[] getBody() throws AuthFailureError {
                    try {
                        return mRequestBody == null ? null : mRequestBody.getBytes("utf-8");
                    } catch (UnsupportedEncodingException uee) {
                        VolleyLog.wtf("Unsupported Encoding while trying to get the bytes of %s using %s", mRequestBody, "utf-8");
                        return null;
                    }
                }

                @Override
                protected Response<String> parseNetworkResponse(NetworkResponse response) {
                    String responseString = "";
                    if (response != null) {
                        responseString = String.valueOf(response.statusCode);
                    }
                    return Response.success(responseString, HttpHeaderParser.parseCacheHeaders(response));
                }
            };
            RequestQueue requestQueue = Volley.newRequestQueue(this.getContext());
            requestQueue.add(stringRequest);
        } catch (JSONException e) {
            e.printStackTrace();
        }

    }

    public void cancelar(){

    }
}
