package com.tutiempolibro.app.oauth;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.netflix.eureka.EnableEurekaClient;
import org.springframework.cloud.openfeign.EnableFeignClients;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

@EnableFeignClients
@EnableEurekaClient
@SpringBootApplication
public class ServiceOauthApplication implements CommandLineRunner{

    @Autowired
    private BCryptPasswordEncoder passwordEncoder;
    
	public static void main(String[] args) {
		SpringApplication.run(ServiceOauthApplication.class, args);
	}

	@Override
	public void run(String... args) throws Exception {
	    // TODO Auto-generated method stub
	    String clave = "123456";
	    
	    for(int i=0; i<4 ; i++) {
		String passencriptado = passwordEncoder.encode(clave);
		System.out.println(passencriptado);
	    }
	}

}
