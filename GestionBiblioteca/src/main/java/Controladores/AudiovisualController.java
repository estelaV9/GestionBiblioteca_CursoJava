package Controladores;

import Modelos.Audiovisual;
import Servicios.AudiovisualService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/audiovisuales")
public class AudiovisualController {

    @Autowired
    private AudiovisualService audiovisualService;

    @GetMapping("/")
    public String listarAudiovisuales(Model model) {
        model.addAttribute("audiovisuales", audiovisualService.obtenerTodos());
        return "lista_audiovisuales";
    }

    @PostMapping("/guardar")
    public String guardarAudiovisual(
            @RequestParam Integer elementoId,
            @RequestParam Audiovisual.Formato formato) {
        
        Audiovisual audiovisual = new Audiovisual(elementoId, formato);
        audiovisualService.guardar(audiovisual);
        
        return "redirect:/audiovisuales/";
    }
}