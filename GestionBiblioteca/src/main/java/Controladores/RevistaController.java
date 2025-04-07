package Controladores;

import Modelos.Revista;
import Servicios.RevistaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/revistas")
public class RevistaController {

    @Autowired
    private RevistaService revistaService;

    @GetMapping("/")
    public String listarRevistas(Model model) {
        model.addAttribute("revistas", revistaService.obtenerTodos());
        return "lista_revistas";
    }

    @PostMapping("/guardar")
    public String guardarRevista(
            @RequestParam Integer elementoId,
            @RequestParam Integer numPublicacion) {
        
        Revista revista = new Revista(elementoId, numPublicacion);
        revistaService.guardar(revista);
        
        return "redirect:/revistas/";
    }
}