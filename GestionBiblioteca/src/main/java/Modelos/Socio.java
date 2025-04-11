package Modelos;

import jakarta.persistence.*;
import java.util.Date;

@Entity
@Table(name = "socio")
@PrimaryKeyJoinColumn(name = "user_id") // Hereda el ID de Usuario
public class Socio extends Usuario {
    @Column(name = "dni", nullable = false)
    private String dni;

    @Column(name = "fecha_nacimiento", nullable = false)
    private Date fechaNacimiento;

    @Column(name = "fecha_inscripcion", nullable = false)
    private Date fechaInscripcion;

    // Constructor
    public Socio(String username, String fullname, String encryptPassword, 
                String dni, Date fechaNacimiento, Date fechaInscripcion) {
        super(username, fullname, encryptPassword);
        this.dni = dni;
        this.fechaNacimiento = fechaNacimiento;
        this.fechaInscripcion = fechaInscripcion;
    }

    public Socio() {
    }
    
    
    // Getters y setters
    

    public String getDni() {
        return dni;
    }

    public void setDni(String dni) {
        this.dni = dni;
    }

    public Date getFechaNacimiento() {
        return fechaNacimiento;
    }

    public void setFechaNacimiento(Date fechaNacimiento) {
        this.fechaNacimiento = fechaNacimiento;
    }

    public Date getFechaInscripcion() {
        return fechaInscripcion;
    }

    public void setFechaInscripcion(Date fechaInscripcion) {
        this.fechaInscripcion = fechaInscripcion;
    }
}
