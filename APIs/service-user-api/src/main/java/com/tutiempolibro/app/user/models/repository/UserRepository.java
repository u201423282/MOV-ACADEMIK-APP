package com.tutiempolibro.app.user.models.repository;

import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;
import org.springframework.data.rest.core.annotation.RestResource;

import com.tutiempolibro.app.user.models.entity.User;

@RepositoryRestResource(path="usuarios")
public interface UserRepository extends PagingAndSortingRepository<User, Integer>{
    
    @RestResource(path="obtenerUsuario")
    public User findByUsuario(@Param("usuario") String usuario);
    
}
