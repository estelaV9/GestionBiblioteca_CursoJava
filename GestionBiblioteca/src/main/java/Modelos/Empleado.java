package Modelos;

import Modelos.Usuario;
import jakarta.persistence.*;
import java.util.Objects;

@Entity
@Table(name = "empleado")
@PrimaryKeyJoinColumn(name = "empleado_id")
public class Empleado extends Usuario {

    @Column(name = "empl_num", nullable = false, unique = true)
    private Integer emplNum;

    @Enumerated(EnumType.STRING)
    @Column(name = "admin_level", nullable = false)
    private AdminLevel adminLevel;

    public enum AdminLevel {
        alto, bajo
    }

    public Empleado() {
    }

    public Empleado(String username, String fullname, String encryptPassword, 
                   Integer emplNum, AdminLevel adminLevel) {
        super(username, fullname, encryptPassword);
        this.emplNum = emplNum;
        this.adminLevel = adminLevel;
    }

    // Getters y setters
    public Integer getEmplNum() {
        return emplNum;
    }

    public void setEmplNum(Integer emplNum) {
        this.emplNum = emplNum;
    }

    public AdminLevel getAdminLevel() {
        return adminLevel;
    }

    public void setAdminLevel(AdminLevel adminLevel) {
        this.adminLevel = adminLevel;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        if (!super.equals(o)) return false;
        Empleado empleado = (Empleado) o;
        return Objects.equals(emplNum, empleado.emplNum);
    }

    @Override
    public int hashCode() {
        return Objects.hash(super.hashCode(), emplNum);
    }

    @Override
    public String toString() {
        return "Empleado{" +
                "id=" + getUserId() +
                ", username='" + getUsername() + '\'' +
                ", fullname='" + getFullname() + '\'' +
                ", emplNum=" + emplNum +
                ", adminLevel=" + adminLevel +
                '}';
    }
}