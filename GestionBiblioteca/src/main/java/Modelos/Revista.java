package Modelos;

import jakarta.persistence.*;

@Entity
@Table(name = "revista")
public class Revista {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "revista_id")
    private Integer revistaId;

    @Column(name = "elemento_id")
    private Integer elementoId;

    @Column(name = "num_publicacion", nullable = false)
    private Integer numPublicacion;

    public Revista() {
    }

    public Revista(Integer elementoId, Integer numPublicacion) {
        this.elementoId = elementoId;
        this.numPublicacion = numPublicacion;
    }

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

    public Integer getNumPublicacion() {
        return numPublicacion;
    }

    public void setNumPublicacion(Integer numPublicacion) {
        this.numPublicacion = numPublicacion;
    }

    
}