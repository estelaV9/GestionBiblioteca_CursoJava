package Servicios;

import Modelos.*;
import Repositorios.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.*;
import java.time.temporal.ChronoUnit;
import java.util.Date;
import java.util.List;

@Service
public class EmpleadoService {

    @Autowired
    private EmpleadoRepository empleadoRepository;

    @Autowired
    private LibroRepository libroRepo;

    @Autowired
    private PrestamoRepository prestamoRepo;

    @Autowired
    private SocioRepository socioRepo;

    // Guardar socio
    public void guardarSocio(Socio socio) {
        socioRepo.save(socio);
    }

// Guardar empleado
    public void guardarEmpleado(Empleado empleado) {
        empleadoRepository.save(empleado);
    }

// Listar todos los socios
    public List<Socio> listarSocios() {
        return socioRepo.findAll();
    }

// Listar todos los empleados
    public List<Empleado> listarEmpleados() {
        return empleadoRepository.findAll();
    }

// Eliminar usuario (puede ser socio o empleado)
    public void eliminarUsuario(Integer id) {
        if (socioRepo.existsById(id)) {
            socioRepo.deleteById(id);
        } else if (empleadoRepository.existsById(id)) {
            empleadoRepository.deleteById(id);
        } else {
            throw new IllegalArgumentException("Usuario no encontrado con ID: " + id);
        }
    }

    // GESTIÓN COLECCIÓN
    public Libro agregarLibro(Libro libro) {
        return libroRepo.save(libro);
    }

    public Libro editarLibro(Libro libro) {
        return libroRepo.save(libro);
    }

    public void eliminarLibro(Integer id) {
        libroRepo.deleteById(id);
    }

    // GESTIÓN PRÉSTAMOS
    public Prestamo asignarPrestamo(Prestamo prestamo) {
        return prestamoRepo.save(prestamo);
    }

    public void recibirDevolucion(Prestamo prestamo) {
        Elemento elemento = prestamo.getElemento();
        prestamo.setFechaDevolucion(new Date());
        prestamoRepo.save(prestamo);
    }

    public File generarMulta(Prestamo prestamo) throws IOException {
        if (prestamo.getFechaDevolucion() == null || prestamo.getFechaPrestamo() == null) {
            return null;
        }

        long diasRetraso = ChronoUnit.DAYS.between(
                prestamo.getFechaPrestamo().toInstant(),
                prestamo.getFechaDevolucion().toInstant()
        );

        if (diasRetraso > 0) {
            double multa = diasRetraso * 0.10;
            prestamo.setMulta(multa);
            prestamoRepo.save(prestamo);

            File file = new File("multa_" + prestamo.getId() + ".txt");
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(file))) {
                writer.write("ID Préstamo: " + prestamo.getId());
                writer.newLine();
                writer.write("Días de retraso: " + diasRetraso);
                writer.newLine();
                writer.write("Multa: €" + multa);
            }
            return file;
        }
        return null;
    }

    // GESTIÓN USUARIOS
    public void darAltaSocio(Socio socio, Empleado empleado) {
        if (empleado.getAdminLevel() == Empleado.AdminLevel.alto) {
            socioRepo.save(socio);
        } else {
            throw new SecurityException("Solo administradores de nivel alto pueden dar de alta socios.");
        }
    }

    public void darBajaSocio(Integer id, Empleado empleado) {
        if (empleado.getAdminLevel() == Empleado.AdminLevel.alto) {
            socioRepo.deleteById(id);
        } else {
            throw new SecurityException("Solo administradores de nivel alto pueden dar de baja socios.");
        }
    }

    public Empleado findByEmplNum(int emplNum) {
        return empleadoRepository.findByEmplNum(emplNum);
    }

    public void registerEmpleado(Empleado empleado) {
        try {
            empleadoRepository.save(empleado);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<Libro> listarLibrosDisponibles() {
        return libroRepo.findAll();
    }

    public List<Prestamo> listarPrestamos() {
        return prestamoRepo.findAll();
    }

    public Prestamo obtenerPrestamoPorId(Integer id) {
        return prestamoRepo.findById(id).orElse(null);
    }
}
