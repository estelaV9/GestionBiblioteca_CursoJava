/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controladores;

import Modelos.Empleado;
import Modelos.Libro;
import Modelos.Prestamo;
import Modelos.Socio;
import Servicios.EmpleadoService;
import Servicios.SocioService;
import java.io.File;
import java.io.IOException;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 *
 * @author Formacion
 */
@Controller
@RequestMapping("/admin")
public class EmpleadoController {

    @Autowired
    private EmpleadoService empleadoService;

    @Autowired
    private SocioService socioService;

    // Mostrar formulario para alta
    @GetMapping("/usuarios/nuevo")
    public String mostrarFormularioUsuario(Model model) {
        model.addAttribute("socio", new Socio());
        model.addAttribute("empleado", new Empleado());
        return "formulario_usuario";
    }

    @PostMapping("/usuarios/guardar/socio")
    public String guardarSocio(@ModelAttribute Socio socio, Model model) {
        try {
            // Guardar el nuevo socio
            empleadoService.guardarSocio(socio);
            return "redirect:/admin/usuarios/lista";
        } catch (DataIntegrityViolationException e) {
            // Capturar error y mostrar mensaje adecuado
            model.addAttribute("error", "Hubo un problema al guardar el socio. Verifique las relaciones de datos.");
            return "formulario_socio"; // El nombre de tu formulario
        }
    }

    // Guardar empleado
    @PostMapping("/usuarios/guardar/empleado")
    public String guardarEmpleado(@ModelAttribute Empleado empleado) {
        empleadoService.guardarEmpleado(empleado);
        return "redirect:/admin/usuarios/lista";
    }

    // Listar todos
    @GetMapping("/usuarios/lista")
    public String listarUsuarios(Model model) {
        List<Socio> socios = empleadoService.listarSocios();
        List<Empleado> empleados = empleadoService.listarEmpleados();
        model.addAttribute("socios", socios);
        model.addAttribute("empleados", empleados);
        return "lista_usuarios";
    }

    // Baja
    @PostMapping("/usuarios/eliminar/{id}")
    public String eliminarUsuario(@PathVariable Integer id) {
        empleadoService.eliminarUsuario(id);
        return "redirect:/admin/usuarios/lista";
    }

// Mostrar formulario para nuevo préstamo
    @GetMapping("/prestamos/nuevo")
    public String mostrarFormularioPrestamo(Model model) {
        model.addAttribute("prestamo", new Prestamo());

        List<Socio> socios = empleadoService.listarSocios();
        List<Libro> libros = empleadoService.listarLibrosDisponibles();

        model.addAttribute("socios", socios);
        model.addAttribute("libros", libros);

        return "formulario_prestamo";
    }

// Guardar nuevo préstamo
    @PostMapping("/prestamos/guardar")
    public String guardarPrestamo(@ModelAttribute Prestamo prestamo) {
        empleadoService.asignarPrestamo(prestamo);
        return "redirect:/admin/prestamos/lista";
    }

// Listar préstamos
    @GetMapping("/prestamos/lista")
    public String listarPrestamos(Model model) {
        model.addAttribute("prestamos", empleadoService.listarPrestamos());
        return "lista_prestamos";
    }

// Marcar devolución
    @PostMapping("/prestamos/devolver/{id}")
    public String devolverPrestamo(@PathVariable Integer id) {
        Prestamo prestamo = empleadoService.obtenerPrestamoPorId(id);
        empleadoService.recibirDevolucion(prestamo);
        return "redirect:/admin/prestamos/lista";
    }

// Generar multa
    @GetMapping("/prestamos/multa/{id}")
    public String generarMulta(@PathVariable Integer id, Model model) {
        Prestamo prestamo = empleadoService.obtenerPrestamoPorId(id);
        try {
            File multa = empleadoService.generarMulta(prestamo);
            if (multa != null) {
                model.addAttribute("mensaje", "Multa generada: " + multa.getAbsolutePath());
            } else {
                model.addAttribute("mensaje", "No hay multa, la devolución fue a tiempo.");
            }
        } catch (IOException e) {
            model.addAttribute("mensaje", "Error al generar la multa.");
        }
        return "multa_generada";
    }
}