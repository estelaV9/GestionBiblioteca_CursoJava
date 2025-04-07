package Controladores;

import Modelos.Libro;
import Servicios.LibroService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/libros")
public class LibroController {

    @Autowired
    private LibroService libroService;

    @GetMapping("/")
    public String listarLibros(Model model) {
        model.addAttribute("libros", libroService.obtenerTodosLosLibros());
        model.addAttribute("libroForm", new Libro());
        return "lista_libros";
    }

    @GetMapping("/editar/{id}")
    public String mostrarFormularioEdicion(@PathVariable("id") Integer id, Model model) {
        Libro libro = libroService.obtenerLibroPorId(id);
        model.addAttribute("libroForm", libro);
        model.addAttribute("libros", libroService.obtenerTodosLosLibros());
        return "lista_libros";
    }

    @PostMapping("/guardar")
    public String guardarLibro(@ModelAttribute("libroForm") Libro libro,
            BindingResult result,
            Model model,
            RedirectAttributes redirectAttributes) {

        // Validaciones manuales
        if (libro.getGenero() == null || libro.getGenero().trim().isEmpty()) {
            result.rejectValue("genero", "error.genero", "El género es obligatorio");
        }
        if (libro.getNumPaginas() == null || libro.getNumPaginas() <= 0) {
            result.rejectValue("numPaginas", "error.paginas", "Número de páginas inválido");
        }

        if (result.hasErrors()) {
            model.addAttribute("libros", libroService.obtenerTodosLosLibros());
            return "lista_libros";
        }

        libroService.guardarLibro(libro);
        redirectAttributes.addFlashAttribute("success",
                libro.getLibroId() == null ? "Libro creado exitosamente" : "Libro actualizado exitosamente");
        return "redirect:/libros/";
    }

    @GetMapping("/eliminar/{id}")
    public String eliminarLibro(@PathVariable("id") Integer id, RedirectAttributes redirectAttributes) {
        libroService.eliminarLibro(id);
        redirectAttributes.addFlashAttribute("success", "Libro eliminado exitosamente");
        return "redirect:/libros/";
    }
}
