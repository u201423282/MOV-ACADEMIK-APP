package com.example.academik.bean;

public class CursosBean {

    private String descripcion;
    private String profesorNombre;
    private String profesorCorreo;

    public CursosBean(String descripcion,String profesorNombre,String profesorCorreo){
        this.descripcion = descripcion;
        this.profesorNombre = profesorNombre;
        this.profesorCorreo = profesorCorreo;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public String getProfesorNombre() {
        return profesorNombre;
    }

    public void setProfesorNombre(String profesorNombre) {
        this.profesorNombre = profesorNombre;
    }

    public String getProfesorCorreo() {
        return profesorCorreo;
    }

    public void setProfesorCorreo(String profesorCorreo) {
        this.profesorCorreo = profesorCorreo;
    }

}
