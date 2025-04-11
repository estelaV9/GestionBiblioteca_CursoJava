package Modelos;

import jakarta.persistence.*;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;

@Entity
@Table(name = "revista")
public class Revista {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "revista_id")
    private Integer revistaId;

    @Column(name = "elemento_id")
    private Integer elementoId;

    @NotNull(message = "El número de páginas es obligatorio")
    @Min(value = 1, message = "Debe tener al menos 1 página")
    @Column(name = "num_publicacion", nullable = false)
    private Integer numero;

    // Constructores
    public Revista() {
    }

    public Revista(Integer elementoId, Integer numero) {
        this.elementoId = elementoId;
        this.numero = numero;
    }

    // Getters y Setters
    public Integer getRevistaId() {
        return revistaId;
    }

    public void setRevistaId(Integer revistaId) {
        this.revistaId = revistaId;
    }

    public Integer getElementoId() {
        return elementoId;
    }

    public void setElementoId(Integer elementoId) {
        this.elementoId = elementoId;
    }

    public Integer getNumero() {
        return numero;
    }

    public void setNumero(Integer numero) {
        this.numero = numero;
    }
}
