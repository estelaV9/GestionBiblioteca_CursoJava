package Servicios;

import Modelos.Elemento;
import Modelos.Revista;
import Modelos.RevistaDTO;
import Repositorios.ElementoRepository;
import Repositorios.RevistaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class RevistaService {

    @Autowired
    private RevistaRepository revistaRepository;

    @Autowired
    private ElementoRepository elementoRepository;

    // Nuevo: guardar desde DTO
    @Transactional
    public void guardarRevistaDesdeDTO(RevistaDTO dto) {
        System.out.println("Intentando guardar revista desde DTO: " + dto.getRevistaId()
                + ", elemento_id: " + dto.getElementoId()
                + ", num_publicacion: " + dto.getNumero());

        if (dto.getNumero() == null) {
            throw new IllegalArgumentException("El número de publicación no puede ser nulo");
        }

        Revista revista;
        if (dto.getRevistaId() != null) {
            revista = revistaRepository.findById(dto.getRevistaId()).orElse(new Revista());
        } else {
            revista = new Revista();
        }

        revista.setRevistaId(dto.getRevistaId());
        revista.setElementoId(dto.getElementoId());
        revista.setNumero(dto.getNumero());

        revistaRepository.save(revista);
    }

    public List<Revista> obtenerTodasLasRevistas() {
        return revistaRepository.findAll();
    }

    public Revista obtenerRevistaPorId(Integer id) {
        return revistaRepository.findById(id).orElse(null);
    }

    // Nuevo: obtener un RevistaDTO por ID
    public RevistaDTO obtenerRevistaDTOPorId(Integer id) {
        Optional<Revista> optional = revistaRepository.findById(id);
        if (optional.isPresent()) {
            Revista revista = optional.get();
            Elemento elemento = elementoRepository.findById(revista.getElementoId()).orElse(null);
            return new RevistaDTO(
                    revista.getRevistaId(),
                    revista.getElementoId(),
                    revista.getNumero(),
                    elemento != null ? elemento.getTitulo() : "",
                    elemento != null ? elemento.getAutor() : "",
                    elemento != null ? elemento.getFechaPublicacion().toString() : "",
                    elemento != null ? elemento.getNumEjemDispo() : 0
            );
        }
        return null;
    }

    @Transactional
    public void eliminarRevista(Integer id) {
        revistaRepository.deleteById(id);
    }

    public List<RevistaDTO> obtenerTodasLasRevistasConElemento() {
        List<Revista> revistas = revistaRepository.findAll();
        return revistas.stream().map(revista -> {
            Elemento elemento = elementoRepository.findById(revista.getElementoId()).orElse(null);
            return new RevistaDTO(
                    revista.getRevistaId(),
                    revista.getElementoId(),
                    revista.getNumero(),
                    elemento != null ? elemento.getTitulo() : "",
                    elemento != null ? elemento.getAutor() : "",
                    elemento != null ? elemento.getFechaPublicacion().toString() : "",
                    elemento != null ? elemento.getNumEjemDispo() : 0
            );
        }).collect(Collectors.toList());
    }

    // Nuevo: útil para mostrar en formularios desplegables
    public List<Elemento> obtenerTodosLosElementos() {
        return elementoRepository.findAll();
    }

    @Transactional
    public void eliminarRevistaConElemento(Integer id) {
        // Primero eliminamos la revista
        Revista revista = revistaRepository.findById(id).orElse(null);
        if (revista != null) {
            Integer elementoId = revista.getElementoId();
            // Eliminamos la revista
            revistaRepository.delete(revista);
            System.out.println("Revista eliminada con ID: " + id);

            // Luego eliminamos el elemento asociado
            Elemento elemento = elementoRepository.findById(elementoId).orElse(null);
            if (elemento != null) {
                elementoRepository.delete(elemento);
                System.out.println("Elemento eliminado con ID: " + elementoId);
            }
        }
    }

}
