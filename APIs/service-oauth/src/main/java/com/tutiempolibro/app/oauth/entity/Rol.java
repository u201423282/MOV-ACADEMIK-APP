package com.tutiempolibro.app.oauth.entity;

import java.io.Serializable;

import lombok.Data;

@Data
public class Rol implements Serializable {

    /**
     * 
     */
    private static final long serialVersionUID = 1L;
    
  
    private Integer idperfil;
    
    private String descripcion;
    
    private String estado;
    
    

}