/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controladores;

/**
 *
 * @author Formacion
 */
import Servicios.SocioService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Date;

@Controller
public class SocioController {

    @Autowired
    private SocioService socioService;

    @GetMapping("/register-socio")
    public String showRegisterForm() {
        return "register-socio";  // La vista del formulario de registro
    }

    @PostMapping("/register-socio")
    public String registerSocio(@RequestParam String username, @RequestParam String fullname,
            @RequestParam String password, @RequestParam String dni,
            @RequestParam String fechaNacimiento, Model model) {

        // Convertir la fecha de nacimiento de String a Date
        Date fechaNacimientoDate = java.sql.Date.valueOf(fechaNacimiento);  

        // Encriptar la contraseña
        BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        String encryptedPassword = passwordEncoder.encode(password);
        return "";

    }
}
