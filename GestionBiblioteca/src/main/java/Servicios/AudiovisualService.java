package Servicios;

import Modelos.Audiovisual;
import Repositorios.AudiovisualRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AudiovisualService {

    @Autowired
    private AudiovisualRepository audiovisualRepository;

    public List<Audiovisual> obtenerTodos() {
        return audiovisualRepository.findAll();
    }

    public void guardar(Audiovisual audiovisual) {
        audiovisualRepository.save(audiovisual);
    }
}