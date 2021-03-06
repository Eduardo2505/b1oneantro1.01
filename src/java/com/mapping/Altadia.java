package com.mapping;
// Generated 11/04/2015 07:19:37 PM by Hibernate Tools 3.2.1.GA



import java.util.HashSet;
import java.util.Set;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Altadia generated by hbm2java
 */
@Entity
@Table(name="altadia"
    ,catalog="restobarpv01"
)
public class Altadia  implements java.io.Serializable {


     private Integer idaltadia;
     private String fecha;
     private String yeari;
     private String hora;
     private String estado;
     private String tipoEvento;
     private Set<MesaVenta> mesaVentas = new HashSet<MesaVenta>(0);
     private Set<Pagoscorte> pagoscortes = new HashSet<Pagoscorte>(0);
     private Set<Comanda> comandas = new HashSet<Comanda>(0);

    public Altadia() {
    }

	
    public Altadia(String tipoEvento) {
        this.tipoEvento = tipoEvento;
    }
    public Altadia(String fecha, String yeari, String hora, String estado, String tipoEvento, Set<MesaVenta> mesaVentas, Set<Pagoscorte> pagoscortes, Set<Comanda> comandas) {
       this.fecha = fecha;
       this.yeari = yeari;
       this.hora = hora;
       this.estado = estado;
       this.tipoEvento = tipoEvento;
       this.mesaVentas = mesaVentas;
       this.pagoscortes = pagoscortes;
       this.comandas = comandas;
    }
   
     @Id @GeneratedValue(strategy=IDENTITY)
    
    @Column(name="idaltadia", unique=true, nullable=false)
    public Integer getIdaltadia() {
        return this.idaltadia;
    }
    
    public void setIdaltadia(Integer idaltadia) {
        this.idaltadia = idaltadia;
    }
    
    @Column(name="fecha", length=10)
    public String getFecha() {
        return this.fecha;
    }
    
    public void setFecha(String fecha) {
        this.fecha = fecha;
    }

    @Column(name="yeari", length=0)
    public String getYeari() {
        return this.yeari;
    }
    
    public void setYeari(String yeari) {
        this.yeari = yeari;
    }
   
    @Column(name="hora", length=19)
    public String getHora() {
        return this.hora;
    }
    
    public void setHora(String hora) {
        this.hora = hora;
    }
    
    @Column(name="estado", length=45)
    public String getEstado() {
        return this.estado;
    }
    
    public void setEstado(String estado) {
        this.estado = estado;
    }
    
    @Column(name="tipoEvento", nullable=false, length=45)
    public String getTipoEvento() {
        return this.tipoEvento;
    }
    
    public void setTipoEvento(String tipoEvento) {
        this.tipoEvento = tipoEvento;
    }
@OneToMany(cascade=CascadeType.ALL, fetch=FetchType.LAZY, mappedBy="altadia")
    public Set<MesaVenta> getMesaVentas() {
        return this.mesaVentas;
    }
    
    public void setMesaVentas(Set<MesaVenta> mesaVentas) {
        this.mesaVentas = mesaVentas;
    }
@OneToMany(cascade=CascadeType.ALL, fetch=FetchType.LAZY, mappedBy="altadia")
    public Set<Pagoscorte> getPagoscortes() {
        return this.pagoscortes;
    }
    
    public void setPagoscortes(Set<Pagoscorte> pagoscortes) {
        this.pagoscortes = pagoscortes;
    }
@OneToMany(cascade=CascadeType.ALL, fetch=FetchType.LAZY, mappedBy="altadia")
    public Set<Comanda> getComandas() {
        return this.comandas;
    }
    
    public void setComandas(Set<Comanda> comandas) {
        this.comandas = comandas;
    }




}


