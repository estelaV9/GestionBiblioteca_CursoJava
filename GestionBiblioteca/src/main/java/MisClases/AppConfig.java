<<<<<<< HEAD
package MisClases;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
=======
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package MisClases;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.ViewResolver;
>>>>>>> Unai
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ViewResolverRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

<<<<<<< HEAD
@Configuration
@EnableWebMvc
@ComponentScan(basePackages="Controladores")
public class AppConfig implements WebMvcConfigurer{
    
    @Override
    public void configureViewResolvers(ViewResolverRegistry registry) {
        InternalResourceViewResolver resolver = new InternalResourceViewResolver();
        resolver.setPrefix("/WEB-INF/vistas/");
        resolver.setSuffix(".jsp");
        registry.viewResolver(resolver);
    }
    
=======
/**
 *
 * @author Formacion
 */
@Configuration
@EnableWebMvc
@ComponentScan(basePackages = {"Controladores", "Servicios", "Repositorios", "Modelos", "MisClases"})
public class AppConfig implements WebMvcConfigurer {

    @Bean
    public ViewResolver viewResolver() {
        InternalResourceViewResolver resolver = new InternalResourceViewResolver();
        resolver.setPrefix("/WEB-INF/vistas/"); // Ruta donde están tus JSPs
        resolver.setSuffix(".jsp");
        return resolver;
    }
>>>>>>> Unai
}
