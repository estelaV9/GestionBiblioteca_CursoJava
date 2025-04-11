package Modelos;

public class RevistaDTO {

    private Integer revistaId;
    private Integer elementoId;
    private Integer numero;
    private String titulo;
    private String autor;
    private String fechaPublicacion;
    private Integer numEjemplaresDisponibles;

    // Constructores, getters y setters
    public RevistaDTO() {
    }

    public RevistaDTO(Integer revistaId, Integer elementoId, Integer numero, String titulo, String autor, String fechaPublicacion, Integer numEjemplaresDisponibles) {
        this.revistaId = revistaId;
        this.elementoId = elementoId;
        this.numero = numero;
        this.titulo = titulo;
        this.autor = autor;
        this.fechaPublicacion = fechaPublicacion;
        this.numEjemplaresDisponibles = numEjemplaresDisponibles;
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

    public Integer getNumero() {
        return numero;
    }

    public void setNumero(Integer numero) {
        this.numero = numero;
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public String getAutor() {
        return autor;
    }

    public void setAutor(String autor) {
        this.autor = autor;
    }

    public String getFechaPublicacion() {
        return fechaPublicacion;
    }

    public void setFechaPublicacion(String fechaPublicacion) {
        this.fechaPublicacion = fechaPublicacion;
    }

    public Integer getNumEjemplaresDisponibles() {
        return numEjemplaresDisponibles;
    }

    public void setNumEjemplaresDisponibles(Integer numEjemplaresDisponibles) {
        this.numEjemplaresDisponibles = numEjemplaresDisponibles;
    }

}
