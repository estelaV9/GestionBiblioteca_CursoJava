package Controladores;

import Modelos.Elemento;
import Modelos.Libro;
import Modelos.LibroConElementoDTO;
import Servicios.ElementoService;
import Servicios.LibroService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import java.util.Date;
import org.springframework.format.annotation.DateTimeFormat;

@Controller
@RequestMapping("/empleado/libros")
public class LibroController {

    @Autowired
    private LibroService libroService;

    @Autowired
    private ElementoService elementoService;

    @GetMapping("/")
    public String listarLibros(Model model) {
        model.addAttribute("librosConElementos", libroService.obtenerTodosLosLibrosConElementos());
        model.addAttribute("elementos", elementoService.obtenerTodosLosElementos()); // Añade esta línea
        model.addAttribute("libroForm", new Libro());
        return "lista_libros";
    }

    @GetMapping("/editar/{id}")
    public String mostrarFormularioEdicion(@PathVariable("id") Integer id, Model model) {
        Libro libro = libroService.obtenerLibroPorId(id);
        if (libro != null) {
            model.addAttribute("libroForm", libro);  // Asegura que se envía como "libroForm"
            return "lista_libros";
        }
        return "redirect:/empleado/libros/";
    }

    @PostMapping("/guardar")
    public String guardarLibro(
            @RequestParam(required = false) Integer libroId,
            @RequestParam String genero,
            @RequestParam Integer numPaginas,
            @RequestParam String editorial,
            // Campos del elemento (solo para creación)
            @RequestParam(required = false) String titulo,
            @RequestParam(required = false) String autor,
            @RequestParam(required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") Date fechaPublicacion,
            @RequestParam(required = false) Integer numEjemDispo,
            RedirectAttributes redirectAttributes) {

        try {
            if (libroId == null) { // Nuevo libro
                // Validar campos del elemento
                if (titulo == null || autor == null || fechaPublicacion == null || numEjemDispo == null) {
                    redirectAttributes.addFlashAttribute("error", "Todos los campos del elemento son requeridos");
                    return "redirect:/empleado/libros/";
                }

                // Crear nuevo elemento
                Elemento elemento = new Elemento();
                elemento.setTitulo(titulo);
                elemento.setAutor(autor);
                elemento.setFechaPublicacion(fechaPublicacion);
                elemento.setNumEjemDispo(numEjemDispo);
                elemento.setTipo("libro");

                Elemento elementoGuardado = elementoService.guardarElemento(elemento);

                // Crear libro
                Libro libro = new Libro();
                libro.setElementoId(elementoGuardado.getElementoId());
                libro.setGenero(genero);
                libro.setNumPaginas(numPaginas);
                libro.setEditorial(editorial);

                libroService.guardarLibro(libro);

                redirectAttributes.addFlashAttribute("success", "Libro creado exitosamente");
            } else { // Edición
                Libro libroExistente = libroService.obtenerLibroPorId(libroId);
                if (libroExistente != null) {
                    libroExistente.setGenero(genero);
                    libroExistente.setNumPaginas(numPaginas);
                    libroExistente.setEditorial(editorial);
                    libroService.guardarLibro(libroExistente);
                    redirectAttributes.addFlashAttribute("success", "Libro actualizado exitosamente");
                }
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error: " + e.getMessage());
            e.printStackTrace(); // Esto ayudará a ver el error en los logs
        }
        return "redirect:/empleado/libros/";
    }

    @GetMapping("/eliminar/{id}")
    public String eliminarLibro(@PathVariable("id") Integer id, RedirectAttributes redirectAttributes) {
        Libro libro = libroService.obtenerLibroPorId(id);
        if (libro != null) {
            try {
                // Primero eliminamos el libro
                libroService.eliminarLibro(id);

                // Luego eliminamos el elemento asociado si existe
                if (libro.getElementoId() != null) {
                    elementoService.eliminarElemento(libro.getElementoId());
                }

                redirectAttributes.addFlashAttribute("success", "Libro eliminado exitosamente"
                        + (libro.getElementoId() != null ? " junto con su elemento asociado" : ""));
            } catch (Exception e) {
                redirectAttributes.addFlashAttribute("error", "Error al eliminar: " + e.getMessage());
            }
        } else {
            redirectAttributes.addFlashAttribute("error", "No se encontró el libro a eliminar");
        }
        return "redirect:/empleado/libros/";
    }

}
