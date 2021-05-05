package com.example.academik.Fragments;

import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.Bundle;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.SimpleAdapter;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;
import androidx.fragment.app.FragmentManager;
import androidx.fragment.app.FragmentTransaction;

import com.amplifyframework.AmplifyException;
import com.amplifyframework.auth.cognito.AWSCognitoAuthPlugin;
import com.amplifyframework.core.Amplify;
import com.amplifyframework.storage.s3.AWSS3StoragePlugin;
import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;
import com.example.academik.MenuNavigateActivity;
import com.example.academik.R;
import com.example.academik.bean.LogueoBean;
import com.example.academik.utilitario.Util;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;

public class PerfilFragment extends Fragment {

    private RequestQueue mQueue;

    private Bitmap bitmap;

    ImageView imageView;

    @Nullable
    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {

        View view = inflater.inflate(R.layout.fragment_perfil,container,false);
        SharedPreferences prefs = this.getActivity().getSharedPreferences("PREFERENCIAS", Context.MODE_PRIVATE);
        String nombre = prefs.getString("nombre", "");
        String codigo = prefs.getString("codigo", "");
        String sede = prefs.getString("sede", "");
        String seccion = prefs.getString("seccion", "");
        String telefono = prefs.getString("telefono", "");
        String correoalumno = prefs.getString("correoalumno", "");

        EditText codigoText = (EditText) view.findViewById(R.id.etCodigoAlumno);
        EditText sedeText = (EditText) view.findViewById(R.id.etSede);
        EditText seccionText = (EditText) view.findViewById(R.id.etSeccion);
        EditText nombreText = (EditText) view.findViewById(R.id.etNombre);
        EditText telefonoText = (EditText) view.findViewById(R.id.etTelefono);
        EditText correoText = (EditText) view.findViewById(R.id.etCorreo);

        nombreText.setText(nombre);
        codigoText.setText(codigo);
        seccionText.setText(seccion);
        sedeText.setText(sede);
        telefonoText.setText(telefono);
        correoText.setText(correoalumno);

        imageView = (ImageView)view.findViewById(R.id.imageView);

        Button button = (Button) view.findViewById(R.id.btnLinkPerfil);
        button.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Fragment fragment = new PerfilEditFragment();
                FragmentManager fragmentManager = getActivity().getSupportFragmentManager();
                FragmentTransaction fragmentTransaction = fragmentManager.beginTransaction();
                fragmentTransaction.replace(R.id.container, fragment);
                fragmentTransaction.addToBackStack(null);
                fragmentTransaction.commit();
            }
        });
        try {
            Amplify.addPlugin(new AWSCognitoAuthPlugin());
            Amplify.addPlugin(new AWSS3StoragePlugin());
            Amplify.configure(this.getContext());
            Log.i("MyAmplifyApp", "Initialized Amplify");

        } catch (AmplifyException e) {
            Log.e("MyAmplifyApp", "Could not initialize Amplify", e);
        }
        dowload();

        return view;
    }

    public void dowload() {

        SharedPreferences prefs = this.getActivity().getSharedPreferences("PREFERENCIAS", Context.MODE_PRIVATE);
        String codigoAlumno = prefs.getString("codigo", "");
        final String fileName = codigoAlumno+".jfif";
        Log.i("codigo : ", fileName);
        Amplify.Storage.downloadFile(
                fileName,
                new File(this.getActivity().getApplicationContext().getFilesDir() + fileName),
                result -> {
                    Log.i("MyAmplifyApp", "Successfully downloaded: " + result.getFile().getName());
                    bitmap = BitmapFactory.decodeFile(result.getFile().getAbsolutePath());
                    imageView.setImageBitmap(bitmap);
                },
                error -> Log.e("MyAmplifyApp",  "Download Failure", error)
        );
    }


}
