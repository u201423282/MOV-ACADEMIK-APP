package com.tutiempolibro.app.oauth.services;

import com.tutiempolibro.app.oauth.entity.Usuario;

public interface IUsuarioService {
    public Usuario findByUsername(String username);
}
