package Repositorios;

import Modelos.Libro;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface LibroRepository extends JpaRepository<Libro, Integer> {
    // Aquí no es necesario escribir el INSERT manualmente, Spring Data JPA lo hace con el método save()
}