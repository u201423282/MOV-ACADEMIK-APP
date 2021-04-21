package com.example.academik.utilitario;

import android.content.SharedPreferences;

import com.example.academik.bean.LogueoBean;

public class Util {

    public static void guardarSesion(SharedPreferences prefs, String idPersona){
        SharedPreferences.Editor editor = prefs.edit();
        editor.putString("idpersona", idPersona);
        editor.commit();
    }

    public static void guardarInformacionAlumno(SharedPreferences prefs, LogueoBean info){
        SharedPreferences.Editor editor = prefs.edit();
        editor.putString("nombre", info.getNombre());
        editor.putString("codigo", info.getCodigoAlumno());
        editor.putString("sede",info.getSede());
        editor.putString("seccion",info.getSeccion());
        editor.putString("telefono",info.getTelefono());
        editor.putString("correoalumno", info.getCorreoAlumno());
        editor.putString("idpersona", info.getIdPersona());
        editor.commit();
    }

}
