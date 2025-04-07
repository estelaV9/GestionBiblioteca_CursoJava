<<<<<<< HEAD
=======
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
>>>>>>> Unai
package MisClases;

import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;

<<<<<<< HEAD
public class MyWebApplicationInitializer
        extends AbstractAnnotationConfigDispatcherServletInitializer {

    @Override 
    protected Class <?>[] getRootConfigClasses(){
        return null;
=======
/**
 *
 * @author Formacion
 */
public class MyWebApplicationInitializer extends AbstractAnnotationConfigDispatcherServletInitializer {

    @Override
    protected Class<?>[] getRootConfigClasses() {
        return new Class<?>[]{JpaConfig.class};
>>>>>>> Unai
    }

    @Override
    protected Class<?>[] getServletConfigClasses() {
<<<<<<< HEAD
        return new Class<?>[] {AppConfig.class};
=======
        return new Class<?>[]{AppConfig.class};
>>>>>>> Unai
    }

    @Override
    protected String[] getServletMappings() {
<<<<<<< HEAD
        return new String[] {"/"};
=======
        return new String[]{"/"};
>>>>>>> Unai
    }

}
