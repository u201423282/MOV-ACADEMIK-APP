package com.example.academik.bean;

public class LogueoBean {

    private String idPersona;
    private String nombre;
    private String codigoAlumno;
    private String sede;
    private String seccion;
    private String telefono;
    private String correoAlumno;

    public void setCorreoAlumno(String correoAlumno) {
        this.correoAlumno = correoAlumno;
    }

    public String getCorreoAlumno() {
        return correoAlumno;
    }

    public String getIdPersona() {
        return idPersona;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public void setIdPersona(String idPersona) {
        this.idPersona = idPersona;
    }

    public String getSeccion() {
        return seccion;
    }

    public void setSeccion(String seccion) {
        this.seccion = seccion;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getSede() {
        return sede;
    }

    public void setSede(String sede) {
        this.sede = sede;
    }

    public String getCodigoAlumno() {
        return codigoAlumno;
    }

    public void setCodigoAlumno(String codigoAlumno) {
        this.codigoAlumno = codigoAlumno;
    }


}
