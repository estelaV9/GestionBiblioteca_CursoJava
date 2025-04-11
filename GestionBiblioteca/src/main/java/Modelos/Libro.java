package Modelos;

import jakarta.persistence.*;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

@Entity
@Table(name = "libro")
public class Libro {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "libro_id")
    private Integer libroId;

    @Column(name = "elemento_id")
    private Integer elementoId;

    @NotNull(message = "El género no puede estar vacío")
    @Size(min = 2, max = 100, message = "El género debe tener entre 2 y 100 caracteres")
    @Column(name = "genero", nullable = false, length = 100)
    private String genero;

    @NotNull(message = "El número de páginas es obligatorio")
    @Min(value = 1, message = "Debe tener al menos 1 página")
    @Column(name = "num_page", nullable = false)
    private Integer numPaginas;

    @Column(name = "editorial", nullable = false, length = 100)
    private String editorial;
 
    // Constructores
    public Libro() {
    }

    public Libro(Integer elementoId, String genero, Integer numPaginas, String editorial) {
        this.elementoId = elementoId;
        this.genero = genero;
        this.numPaginas = numPaginas;
        this.editorial = editorial;
    }

    // Getters y Setters
    public Integer getLibroId() {
        return libroId;
    }

    public void setLibroId(Integer libroId) {
        this.libroId = libroId;
    }

    public Integer getElementoId() {
        return elementoId;
    }

    public void setElementoId(Integer elementoId) {
        this.elementoId = elementoId;
    }

    public String getGenero() {
        return genero;
    }

    public void setGenero(String genero) {
        this.genero = genero;
    }

    public Integer getNumPaginas() {
        return numPaginas;
    }

    public void setNumPaginas(Integer numPaginas) {
        this.numPaginas = numPaginas;
    }

    public String getEditorial() {
        return editorial;
    }

    public void setEditorial(String editorial) {
        this.editorial = editorial;
    }

}
