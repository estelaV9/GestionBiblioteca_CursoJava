package Servicios;

import Modelos.Elemento;
import Repositorios.ElementoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
public class ElementoService {

    @Autowired
    private ElementoRepository elementoRepository;

    @Transactional
    public Elemento guardarElemento(Elemento elemento) {
        // Validación básica
        if (elemento.getTitulo() == null || elemento.getTitulo().trim().isEmpty()) {
            throw new IllegalArgumentException("El título no puede estar vacío");
        }
        if (elemento.getAutor() == null || elemento.getAutor().trim().isEmpty()) {
            throw new IllegalArgumentException("El autor no puede estar vacío");
        }
        if (elemento.getNumEjemDispo() == null || elemento.getNumEjemDispo() < 0) {
            throw new IllegalArgumentException("El número de ejemplares debe ser positivo");
        }

        return elementoRepository.save(elemento);
    }

    public Elemento obtenerElementoPorId(Integer id) {
        Optional<Elemento> elemento = elementoRepository.findById(id);
        return elemento.orElse(null);
    }

    @Transactional
    public void eliminarElemento(Integer id) {
        elementoRepository.deleteById(id);
    }

    public List<Elemento> obtenerTodosLosElementos() {
        return elementoRepository.findAll();
    }

    public List<Elemento> obtenerElementosPorTipo(String tipo) {
        return elementoRepository.findByTipo(tipo);
    }

    @Transactional
    public Elemento actualizarElemento(Elemento elemento) {
        if (!elementoRepository.existsById(elemento.getElementoId())) {
            throw new IllegalArgumentException("El elemento con ID " + elemento.getElementoId() + " no existe");
        }
        return elementoRepository.save(elemento);
    }
}