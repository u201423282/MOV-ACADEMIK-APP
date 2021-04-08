package com.tutiempolibro.app.oauth.entity;

import java.io.Serializable;
import java.util.List;

import lombok.Data;

@Data
public class Usuario implements Serializable {

    /**
     * 
     */
    private static final long serialVersionUID = 1L;

    private Integer idusuario;

    private String usuario;

    private String password;

    private Integer idpersona;

    private String estado;

    private List<Rol> roles;

}
