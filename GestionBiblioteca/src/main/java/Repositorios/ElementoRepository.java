package Repositorios;

import Modelos.Elemento;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ElementoRepository extends JpaRepository<Elemento, Integer> {
    List<Elemento> findByTipo(String tipo);
    
    // Puedes añadir más métodos personalizados según necesites
    // Por ejemplo:
    // List<Elemento> findByAutorContaining(String autor);
    // List<Elemento> findByFechaPublicacionAfter(Date fecha);
} 