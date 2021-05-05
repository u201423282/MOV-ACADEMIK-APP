package com.example.academik.utilitario;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import androidx.recyclerview.widget.RecyclerView;

import com.example.academik.R;
import com.example.academik.bean.CursosBean;

import java.util.ArrayList;
import java.util.List;

public class CursosAdapter extends RecyclerView.Adapter<CursosAdapter.MyViewHolder> {

    private List<CursosBean> cursosList;

    LayoutInflater inflater;
    ArrayList<CursosBean> model;

    public CursosAdapter(List<CursosBean> cursosList) {
        this.cursosList = cursosList;
    }

    public class MyViewHolder extends RecyclerView.ViewHolder {

        public TextView descripcion, profesorNombre, profesorCorreo;

        public MyViewHolder(View view) {
            super(view);
            descripcion = (TextView) view.findViewById(R.id.tvCurso);
            profesorNombre = (TextView) view.findViewById(R.id.tvProfesorNombre);
            profesorCorreo = (TextView) view.findViewById(R.id.tvProfesorCorreo);
        }
    }

    @Override
    public MyViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View itemView = LayoutInflater.from(parent.getContext())
                .inflate(R.layout.fragment_cursos_datos, parent, false);

        return new MyViewHolder(itemView);
    }

    @Override
    public void onBindViewHolder(MyViewHolder holder, int position) {
        CursosBean cursos = cursosList.get(position);
        holder.descripcion.setText(cursos.getDescripcion());
        holder.profesorNombre.setText(cursos.getProfesorNombre());
        holder.profesorCorreo.setText(cursos.getProfesorCorreo());
    }

    @Override
    public int getItemCount() {
        return cursosList.size();
    }
}
