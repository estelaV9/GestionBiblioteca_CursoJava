/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Servicios;

/**
 *
 * @author Formacion
 */
import Modelos.Socio;
import Modelos.Usuario;
import Repositorios.SocioRepository;
import Repositorios.UsuarioRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SocioService {

    @Autowired
    private SocioRepository socioRepository;

    @Autowired
    private UsuarioRepository usuarioRepository;

    public boolean registerSocio(Socio socio) {
        try {
            System.out.println("Guardando socio: " + socio);
            // Guardar el socio en la base de datos
            socioRepository.save(socio);
            return true;  // Socio registrado con éxito
        } catch (Exception e) {
            e.printStackTrace();
            return false;  // Error al registrar el socio
        }
    }
}
