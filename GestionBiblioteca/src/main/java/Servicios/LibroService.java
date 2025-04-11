package Servicios;

import Modelos.Elemento;
import Modelos.Libro;
import Modelos.LibroConElementoDTO;
import Servicios.ElementoService;
import Repositorios.ElementoRepository;
import Repositorios.LibroRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import org.springframework.transaction.annotation.Transactional;

@Service
public class LibroService {

    @Autowired
    private LibroRepository libroRepository;

    @Autowired
    private ElementoRepository elementoRepository;

    public List<LibroConElementoDTO> obtenerTodosLosLibrosConElementos() {
        List<Libro> libros = libroRepository.findAll();
        return libros.stream()
                .map(libro -> {
                    Elemento elemento = null;
                    if (libro.getElementoId() != null) {
                        elemento = elementoRepository.findById(libro.getElementoId()).orElse(null);
                    }
                    return new LibroConElementoDTO(libro, elemento);
                })
                .collect(Collectors.toList());
    }

    @Transactional
    public void guardarLibro(Libro libro) {
        // Validación adicional por si acaso
        if (libro.getNumPaginas() == null) {
            libro.setNumPaginas(0); // Valor por defecto
        }
        libroRepository.save(libro);
    }

    public List<Libro> obtenerTodosLosLibros() {
        return libroRepository.findAll();
    }

    public Libro obtenerLibroPorId(Integer id) {
        return libroRepository.findById(id).orElse(null);
    }

    @Transactional
    public void eliminarLibro(Integer id) {
        libroRepository.deleteById(id);
    }

}
