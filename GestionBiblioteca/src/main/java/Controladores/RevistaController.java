package Controladores;

import Modelos.RevistaDTO;
import Servicios.RevistaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/empleado/revistas")
public class RevistaController {

    @Autowired
    private RevistaService revistaService;

    @GetMapping("/")
    public String listarRevistas(Model model) {
        List<RevistaDTO> revistas = revistaService.obtenerTodasLasRevistasConElemento();
        model.addAttribute("revistas", revistas);
        model.addAttribute("revistaForm", new RevistaDTO());
        model.addAttribute("elementos", revistaService.obtenerTodosLosElementos()); // Asegúrate de tener este método
        return "lista_revistas";
    }

    @GetMapping("/editar/{id}")
    public String editar(@PathVariable("id") Integer id, Model model) {
        RevistaDTO revistaDTO = revistaService.obtenerRevistaDTOPorId(id);  // Cambié de Revista a RevistaDTO
        model.addAttribute("revistaForm", revistaDTO);  // Pasa el DTO a la vista
        model.addAttribute("revistas", revistaService.obtenerTodasLasRevistas());
        return "lista_revistas";
    }

    @PostMapping("/guardar")
    public String guardarRevista(@ModelAttribute("revistaForm") RevistaDTO revistaDTO, 
                                  BindingResult result,
                                  Model model,
                                  RedirectAttributes redirectAttributes) {

        System.out.println("Datos recibidos en el controlador - ID: " + revistaDTO.getRevistaId()
                + ", elemento_id: " + revistaDTO.getElementoId()
                + ", num_publicacion: " + revistaDTO.getNumero());

        revistaService.guardarRevistaDesdeDTO(revistaDTO);  // Guardamos desde el DTO
        redirectAttributes.addFlashAttribute("success", "Revista guardada exitosamente");
        return "redirect:/empleado/revistas/";
    }

    @GetMapping("/eliminar/{id}")
    public String eliminar(@PathVariable("id") Integer id, RedirectAttributes redirectAttributes) {
        revistaService.eliminarRevistaConElemento(id);  // Llamada al nuevo método de eliminación
        redirectAttributes.addFlashAttribute("success", "Revista eliminada exitosamente");
        return "redirect:/empleado/revistas/";
    }
}
