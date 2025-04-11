package Controladores;

import Modelos.Empleado;
import Modelos.Socio;
import Modelos.Usuario;
import Servicios.EmpleadoService;
import Servicios.SocioService;
import Servicios.UsuarioService;
import java.util.Date;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class AuthController {

    @Autowired
    private UsuarioService usuarioService;
    @Autowired
    private SocioService socioService;

    @Autowired
    private EmpleadoService empleadoService;

    @GetMapping("/login")
    public String login() {
        return "login";
    }

    @PostMapping("/loginRegister")
    public String doLogin(@RequestParam String username,
            @RequestParam("password") String password,
            Model model) {
        Usuario usuario = usuarioService.login(username, password);
        if (usuario != null) {
            return "redirect:/empleado/";
        } else {
            model.addAttribute("error", "Credenciales inválidas");
            return "login";
        }
    }

    @GetMapping("/signup")
    public String registerForm() {
        return "signup";
    }
// Registrar usuario y socio o empleado

    @PostMapping("/register")
    public String registerUser(@RequestParam String username,
            @RequestParam String fullname,
            @RequestParam String password,
            @RequestParam String type,
            @RequestParam(required = false) String dni,
            @RequestParam(required = false) String employeeNumber,
            @RequestParam(required = false) String adminLevel,
            @RequestParam String dob,
            Model model) {
        try {
            // Encriptar la contraseña
            BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
            String encryptedPassword = passwordEncoder.encode(password);

            // Registrar al usuario
           /* boolean isUserCreated = usuarioService.register(username, fullname, encryptedPassword);
            if (!isUserCreated) {
                model.addAttribute("error", "Error al crear el usuario");
                return "signup";
            }*/

            // Registrar como socio o empleado dependiendo del tipo
            if (type.equals("socio")) {
                Date birthDate = java.sql.Date.valueOf(dob);
            Date inscripcionDate = new Date(); // Fecha actual
            
            Socio socio = new Socio(username, fullname, encryptedPassword, 
                                  dni, birthDate, inscripcionDate);
            socioService.registerSocio(socio);
            
    
            } else if (type.equals("empleado")) {
                // Verificar que los parámetros de empleado estén presentes y se puedan convertir correctamente
                if (employeeNumber != null && adminLevel != null) {
                    Integer numEmpl = Integer.valueOf(employeeNumber); // Convertir el número de empleado
                    Empleado.AdminLevel level = Empleado.AdminLevel.valueOf(adminLevel); // Convertir el nivel de administrador
                    Empleado empleado = new Empleado(username, fullname, encryptedPassword, numEmpl, level);
                    // Registrar el empleado
                    empleadoService.registerEmpleado(empleado);
                } else {
                    model.addAttribute("error", "Faltan datos para registrar el empleado");
                    return "signup";
                }
            }

            return "redirect:/empleado/";  // Redirigir a la página de inicio
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "Error al registrar el usuario");
            return "signup";  // Volver al formulario de registro en caso de error
        }
    }

}
