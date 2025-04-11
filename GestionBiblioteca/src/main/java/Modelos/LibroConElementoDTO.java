package Modelos;

public class LibroConElementoDTO {

    private Libro libro;
    private Elemento elemento;

    public LibroConElementoDTO() {
    }

    public LibroConElementoDTO(Libro libro, Elemento elemento) {
        this.libro = libro;
        this.elemento = elemento;
    }

    // Getters y Setters
    public Libro getLibro() {
        return libro;
    }

    public void setLibro(Libro libro) {
        this.libro = libro;
    }

    public Elemento getElemento() {
        return elemento;
    }

    public void setElemento(Elemento elemento) {
        this.elemento = elemento;
    }
}
