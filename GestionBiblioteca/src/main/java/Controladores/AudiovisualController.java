package Controladores;

import Modelos.Audiovisual;
import Servicios.AudiovisualService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/empleado/audiovisuales")
public class AudiovisualController {

    @Autowired
    private AudiovisualService audiovisualService;

    @GetMapping("/")
    public String listarAudiovisuales(Model model) {
        model.addAttribute("audiovisuales", audiovisualService.obtenerTodos());
        return "lista_audiovisuales";  // Nombre de la vista JSP
    }

    @PostMapping("/guardar")
    public String guardarAudiovisual(@RequestParam Integer elementoId, @RequestParam Audiovisual.Formato formato) {
        Audiovisual audiovisual = new Audiovisual(elementoId, formato);
        audiovisualService.guardar(audiovisual);
        return "redirect:/empleado/audiovisuales/";
    }

    @PostMapping("/editar")
    public String actualizarAudiovisual(@RequestParam Integer audiovisualId, @RequestParam Integer elementoId, @RequestParam Audiovisual.Formato formato) {
        Audiovisual audiovisual = new Audiovisual(elementoId, formato);
        audiovisual.setAudiovisualId(audiovisualId);
        audiovisualService.guardar(audiovisual);
        return "redirect:/empleado/audiovisuales/";
    }

    @GetMapping("/eliminar/{id}")
    public String eliminarAudiovisual(@PathVariable Integer id) {
        audiovisualService.eliminar(id);
        return "redirect:/empleado/audiovisuales/"; // Regresa a la lista de audiovisuales
    }

}
