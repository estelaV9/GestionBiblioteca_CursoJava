// Modelo Audiovisual.java
package Modelos;

import jakarta.persistence.*;

@Entity
@Table(name = "audiovisual")
public class Audiovisual {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "audiovisual_id")
    private Integer audiovisualId;

    @Column(name = "elemento_id")
    private Integer elementoId;

    @Enumerated(EnumType.STRING)
    @Column(name = "formato", nullable = false)
    private Formato formato;

    public enum Formato {
        CD, DVD, BLURAY
    }

    public Audiovisual() {
    }

    public Audiovisual(Integer elementoId, Formato formato) {
        this.elementoId = elementoId;
        this.formato = formato;
    }

    public Integer getAudiovisualId() {
        return audiovisualId;
    }

    public void setAudiovisualId(Integer audiovisualId) {
        this.audiovisualId = audiovisualId;
    }

    public Integer getElementoId() {
        return elementoId;
    }

    public void setElementoId(Integer elementoId) {
        this.elementoId = elementoId;
    }

    public Formato getFormato() {
        return formato;
    }

    public void setFormato(Formato formato) {
        this.formato = formato;
    }

    
}