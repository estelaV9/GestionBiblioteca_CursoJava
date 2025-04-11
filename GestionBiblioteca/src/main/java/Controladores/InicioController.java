/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controladores;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author Formacion
 */
@Controller
public class InicioController {

    @GetMapping("/empleado/")
    public ModelAndView inicio() {
        ModelAndView mav = new ModelAndView("inicio");

        //a este return le añade el prefijo y el sufijo de appconfig, sin o seria /WEB-INF/vistas/inicio.jsp
        return mav;
    }
}
