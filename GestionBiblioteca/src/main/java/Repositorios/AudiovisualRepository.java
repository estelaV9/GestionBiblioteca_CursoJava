package Repositorios;

import Modelos.Audiovisual;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface AudiovisualRepository extends JpaRepository<Audiovisual, Integer> {
}