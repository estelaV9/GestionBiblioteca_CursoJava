package Servicios;

import Modelos.Libro;
import Repositorios.LibroRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import org.springframework.transaction.annotation.Transactional;

@Service
public class LibroService {

    @Autowired
    private LibroRepository libroRepository;

    public List<Libro> obtenerTodosLosLibros() {
        return libroRepository.findAll();
    }

    public Libro obtenerLibroPorId(Integer id) {
        return libroRepository.findById(id).orElse(null);
    }

    @Transactional
    public void guardarLibro(Libro libro) {
        libroRepository.save(libro);
    }

    @Transactional
    public void eliminarLibro(Integer id) {
        libroRepository.deleteById(id);
    }
}
