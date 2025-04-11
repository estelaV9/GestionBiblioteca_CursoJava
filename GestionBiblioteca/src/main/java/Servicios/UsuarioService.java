package Servicios;

import Modelos.Usuario;
import Repositorios.UsuarioRepository;
import jakarta.security.enterprise.AuthenticationException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class UsuarioService {

    @Autowired
    private UsuarioRepository usuarioRepository;

    private final BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();

    public String encryptPassword(String rawPassword) {
        return passwordEncoder.encode(rawPassword);
    }

    public Usuario save(Usuario usuario) {
        return usuarioRepository.save(usuario);
    }

    public boolean register(String username, String fullname, String encryptedPassword) {

        try {
            // Crear un nuevo usuario
            Usuario usuario = new Usuario(username, fullname, encryptedPassword);
            if (usuarioRepository.existsByUsername(usuario.getUsername())) {
                return false;
            }
            usuarioRepository.save(usuario);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public Usuario login(String username, String rawPassword) {
        Usuario usuarioOpt = usuarioRepository.findByUsername(username);

        if (usuarioOpt != null) {
            // Si el usuario existe, verificamos la contraseña

            // Verificar si la contraseña proporcionada coincide con la almacenada en la base de datos
            if (passwordEncoder.matches(rawPassword, usuarioOpt.getEncryptPassword())) {
                return usuarioOpt;  // Las credenciales son correctas
            }
        }
        // Si el usuario no existe en la base de datos
        return null;

    }

    public Usuario findByUsername(String username) {
        return usuarioRepository.findByUsername(username);
    }
    /*public Optional<Usuario> findByUsernameOptional(String username) {
        return usuarioRepository.findByUsernameOptional(username);
    }*/
}
