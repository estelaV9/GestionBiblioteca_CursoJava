package Servicios;

import Modelos.Revista;
import Repositorios.RevistaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RevistaService {

    @Autowired
    private RevistaRepository revistaRepository;

    public List<Revista> obtenerTodos() {
        return revistaRepository.findAll();
    }

    public void guardar(Revista revista) {
        revistaRepository.save(revista);
    }
}
