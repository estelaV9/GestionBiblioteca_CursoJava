package Servicios;

import Modelos.Audiovisual;
import Repositorios.AudiovisualRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import org.springframework.transaction.annotation.Transactional;

@Service
public class AudiovisualService {

    @Autowired
    private AudiovisualRepository audiovisualRepository;

    public List<Audiovisual> obtenerTodos() {
        return audiovisualRepository.findAll();
    }

    public Audiovisual obtenerPorId(Integer id) {
        return audiovisualRepository.findById(id).orElse(null);
    }

    public void guardar(Audiovisual audiovisual) {
        audiovisualRepository.save(audiovisual);
    }

    @Transactional
    public void eliminar(Integer id) {
        audiovisualRepository.deleteById(id); // Elimina el objeto del repositorio
    }

}
