package com.tutiempolibro.app.oauth.clients;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.tutiempolibro.app.oauth.entity.Usuario;

@FeignClient(name="service-user")
public interface UsuarioFeignClient {
    
    @GetMapping("/usuarios/search/obtenerUsuario")
    public Usuario findByUsuario(@RequestParam String usuario);
}
