
package MisClases;

import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;

/**
 *
 * @author Formacion
 */
public class MyWebApplicationInitializer extends AbstractAnnotationConfigDispatcherServletInitializer {

    @Override
    protected Class<?>[] getRootConfigClasses() {
        return new Class<?>[]{JpaConfig.class};

    }

    @Override
    protected Class<?>[] getServletConfigClasses() {

        return new Class<?>[]{AppConfig.class};

    }

    @Override
    protected String[] getServletMappings() {

        return new String[]{"/"};

    }

}
