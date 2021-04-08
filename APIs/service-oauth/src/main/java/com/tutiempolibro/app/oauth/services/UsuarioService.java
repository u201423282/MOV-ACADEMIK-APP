package com.tutiempolibro.app.oauth.services;

import java.util.List;
import java.util.stream.Collectors;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.tutiempolibro.app.oauth.clients.UsuarioFeignClient;
import com.tutiempolibro.app.oauth.entity.Usuario;

import feign.FeignException;

@Service
public class UsuarioService implements UserDetailsService, IUsuarioService {

    private Logger log = LoggerFactory.getLogger(UsuarioService.class);

    @Autowired
    private UsuarioFeignClient client;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {

	try {

	    // TODO Auto-generated method stub
	    Usuario user = client.findByUsuario(username);

	    List<GrantedAuthority> authorities = user.getRoles().stream().map(role -> new SimpleGrantedAuthority(role.getDescripcion()))
		    .peek(authority -> log.info("Role :" + authority.getAuthority())).collect(Collectors.toList());
	    log.info("Usuario autenticado : " + username);

	    return new User(user.getUsuario(), user.getPassword(), user.getEstado().equals("1") ? true : false, true, true, true,
		    authorities);

	} catch (FeignException e) {
	    log.error("No existe el usuario \"+username+\" en el sistema ");
	    throw new UsernameNotFoundException("No existe el usuario " + username + " en el sistema ");
	}
    }

    @Override
    public Usuario findByUsername(String username) {
	return client.findByUsuario(username);
    }

}
