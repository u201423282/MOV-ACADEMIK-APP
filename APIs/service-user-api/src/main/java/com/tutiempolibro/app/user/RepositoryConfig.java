package com.tutiempolibro.app.user;

import org.springframework.context.annotation.Configuration;
import org.springframework.data.rest.core.config.RepositoryRestConfiguration;
import org.springframework.data.rest.webmvc.config.RepositoryRestConfigurer;

import com.tutiempolibro.app.user.models.entity.Rol;
import com.tutiempolibro.app.user.models.entity.User;

@Configuration
public class RepositoryConfig implements RepositoryRestConfigurer {

    @Override
    public void configureRepositoryRestConfiguration(RepositoryRestConfiguration config) {
	config.exposeIdsFor(User.class, Rol.class);
    }
    
    
}
