package com.tutiempolibro.app.zuul.oauth;

import java.util.Arrays;

import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.Ordered;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.oauth2.config.annotation.web.configuration.EnableResourceServer;
import org.springframework.security.oauth2.config.annotation.web.configuration.ResourceServerConfigurerAdapter;
import org.springframework.security.oauth2.config.annotation.web.configurers.ResourceServerSecurityConfigurer;
import org.springframework.security.oauth2.provider.token.store.JwtAccessTokenConverter;
import org.springframework.security.oauth2.provider.token.store.JwtTokenStore;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;
import org.springframework.web.filter.CorsFilter;

@Configuration
@EnableResourceServer
public class ResourceServerConfig extends ResourceServerConfigurerAdapter {

    @Override
    public void configure(ResourceServerSecurityConfigurer resources) throws Exception {
	// TODO Auto-generated method stub
	resources.tokenStore(tokenStore());
    }

    @Override
    public void configure(HttpSecurity http) throws Exception {
	// TODO Auto-generated method stub
	http.authorizeRequests().antMatchers("/api/segurity/oauth/**").permitAll()
		.antMatchers(HttpMethod.GET, "/api/book/**").permitAll()
		.antMatchers("/api/customer/management/**").permitAll()
		.antMatchers(HttpMethod.GET, "/api/shoppingcart/**", "/api/rentsales/**", "/api/usuarios/**").hasAnyRole("ADMIN", "USER")
		.antMatchers(HttpMethod.POST, "/api/usuarios/**","/api/books/management/**").hasRole("ADMIN")
		.antMatchers(HttpMethod.GET, "/api/books/management/**").hasAnyRole("ADMIN", "USER")
		.antMatchers(HttpMethod.PUT, "/api/usuarios/**").hasRole("ADMIN")
		.antMatchers(HttpMethod.DELETE, "/api/usuarios/**").hasRole("ADMIN")
		.antMatchers(HttpMethod.POST, "/api/shoppingcart/**", "/api/rentsales/**").hasRole("USER")
		.anyRequest().authenticated().and().cors().configurationSource(corsConfigurationSource());

    }

    @Bean
    public CorsConfigurationSource corsConfigurationSource() {
	CorsConfiguration corsConfig = new CorsConfiguration();
	corsConfig.setAllowedOrigins(Arrays.asList("*"));
	corsConfig.setAllowedMethods(Arrays.asList("POST", "GET", "PUT", "DELETE", "OPTIONS"));
	corsConfig.setAllowCredentials(true);
	corsConfig.setAllowedHeaders(Arrays.asList("Authorization", "Content-Type"));

	UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
	source.registerCorsConfiguration("/**", corsConfig);
	return source;
    }

    @Bean
    public FilterRegistrationBean<CorsFilter> corsFilter() {
	FilterRegistrationBean<CorsFilter> bean = new FilterRegistrationBean<CorsFilter>(new CorsFilter(corsConfigurationSource()));
	bean.setOrder(Ordered.HIGHEST_PRECEDENCE);
	return bean;
    }

    @Bean
    public JwtTokenStore tokenStore() {
	return new JwtTokenStore(accessTokenConverter());
    }

    @Bean
    public JwtAccessTokenConverter accessTokenConverter() {
	JwtAccessTokenConverter tokenConverter = new JwtAccessTokenConverter();
	tokenConverter.setSigningKey("mriosalvar");
	return tokenConverter;
    }

}
