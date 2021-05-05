package com.example.academik.DAO;

import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.util.Log;

import com.example.academik.bean.ComunicadoBean;

import java.util.ArrayList;

public class ComunicadoDAO {
    private DbHelper _dbHelper;

    public ComunicadoDAO(Context c) {
        _dbHelper = new DbHelper(c);
    }

    public void insertar(String titulo, String fecha, String descripcion) throws DAOException {
        Log.i("ComunicadoDAO", "insertar()");
        SQLiteDatabase db = _dbHelper.getWritableDatabase();
        try {
            String[] args = new String[]{titulo, fecha, descripcion};
            db.execSQL("INSERT INTO comunicado(titulo, fecha, descripcion) VALUES(?,?,?)", args);
            Log.i("ComunicadoDAO", "Se insertó");
        } catch (Exception e) {
            throw new DAOException("ComunicadoDAO: Error al insertar: " + e.getMessage());
        } finally {
            if (db != null) {
                db.close();
            }
        }
    }

    public ArrayList<ComunicadoBean> listar() throws DAOException {
        Log.i("ComunicadoDAO", "buscar()");
        SQLiteDatabase db = _dbHelper.getReadableDatabase();
        ArrayList<ComunicadoBean> lista = new ArrayList<ComunicadoBean>();
        try {
            Cursor c = db.rawQuery("select id, titulo, fecha, descripcion from comunicado order by id desc", null);

            if (c.getCount() > 0) {
                c.moveToFirst();
                do {
                    int id = c.getInt(c.getColumnIndex("id"));
                    String titulo = c.getString(c.getColumnIndex("titulo"));
                    String fecha = c.getString(c.getColumnIndex("fecha"));
                    String descripcion = c.getString(c.getColumnIndex("descripcion"));

                    ComunicadoBean comunicado = new ComunicadoBean();
                    comunicado.setId(id);
                    comunicado.setTitulo(titulo);
                    comunicado.setFecha(fecha);
                    comunicado.setDescripcion(descripcion);

                    lista.add(comunicado);
                } while (c.moveToNext());
            }
            c.close();
        } catch (Exception e) {
            throw new DAOException("ComunicadoDAO: Error al obtener: " + e.getMessage());
        } finally {
            if (db != null) {
                db.close();
            }
        }
        return lista;
    }


}
