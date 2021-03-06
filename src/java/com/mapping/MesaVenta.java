package com.mapping;
// Generated 11/04/2015 07:19:37 PM by Hibernate Tools 3.2.1.GA



import java.util.HashSet;
import java.util.Set;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * MesaVenta generated by hbm2java
 */
@Entity
@Table(name="mesa_venta"
    ,catalog="restobarpv01"
)
public class MesaVenta  implements java.io.Serializable {


     private String idMesaVenta;
     private Altadia altadia;
     private Empleado empleado;
     private Zona zona;
     private Descuento descuento;
     private Mesas mesas;
     private Integer personasAprox;
     private String estado;
     private Float totalcuenta;
     private String atorizacion;
     private String observaciones;
     private String tipo;
     private Integer posicion;
     private String horaAbierta;
     private String horaCerrada;
     private Float efectivo;
     private Float tarjeta;
     private String idMesaCapturada;
     private Set<TrasladoMesa> trasladoMesas = new HashSet<TrasladoMesa>(0);
     private Set<CancelacionMesa> cancelacionMesas = new HashSet<CancelacionMesa>(0);
     private Set<Comanda> comandas = new HashSet<Comanda>(0);

    public MesaVenta() {
    }

	
    public MesaVenta(String idMesaVenta, Altadia altadia, Empleado empleado, Zona zona, Mesas mesas) {
        this.idMesaVenta = idMesaVenta;
        this.altadia = altadia;
        this.empleado = empleado;
        this.zona = zona;
        this.mesas = mesas;
    }
    public MesaVenta(String idMesaVenta, Altadia altadia, Empleado empleado, Zona zona, Descuento descuento, Mesas mesas, Integer personasAprox, String estado, Float totalcuenta, String atorizacion, String observaciones, String tipo, Integer posicion, String horaAbierta, String horaCerrada, Float efectivo, Float tarjeta, String idMesaCapturada, Set<TrasladoMesa> trasladoMesas, Set<CancelacionMesa> cancelacionMesas, Set<Comanda> comandas) {
       this.idMesaVenta = idMesaVenta;
       this.altadia = altadia;
       this.empleado = empleado;
       this.zona = zona;
       this.descuento = descuento;
       this.mesas = mesas;
       this.personasAprox = personasAprox;
       this.estado = estado;
       this.totalcuenta = totalcuenta;
       this.atorizacion = atorizacion;
       this.observaciones = observaciones;
       this.tipo = tipo;
       this.posicion = posicion;
       this.horaAbierta = horaAbierta;
       this.horaCerrada = horaCerrada;
       this.efectivo = efectivo;
       this.tarjeta = tarjeta;
       this.idMesaCapturada = idMesaCapturada;
       this.trasladoMesas = trasladoMesas;
       this.cancelacionMesas = cancelacionMesas;
       this.comandas = comandas;
    }
   
     @Id 
    
    @Column(name="idMesa_venta", unique=true, nullable=false, length=150)
    public String getIdMesaVenta() {
        return this.idMesaVenta;
    }
    
    public void setIdMesaVenta(String idMesaVenta) {
        this.idMesaVenta = idMesaVenta;
    }
@ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="idaltadia", nullable=false)
    public Altadia getAltadia() {
        return this.altadia;
    }
    
    public void setAltadia(Altadia altadia) {
        this.altadia = altadia;
    }
@ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="idEmpleado", nullable=false)
    public Empleado getEmpleado() {
        return this.empleado;
    }
    
    public void setEmpleado(Empleado empleado) {
        this.empleado = empleado;
    }
@ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="idzona", nullable=false)
    public Zona getZona() {
        return this.zona;
    }
    
    public void setZona(Zona zona) {
        this.zona = zona;
    }
@ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="idDescuento")
    public Descuento getDescuento() {
        return this.descuento;
    }
    
    public void setDescuento(Descuento descuento) {
        this.descuento = descuento;
    }
@ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="idMesa", nullable=false)
    public Mesas getMesas() {
        return this.mesas;
    }
    
    public void setMesas(Mesas mesas) {
        this.mesas = mesas;
    }
    
    @Column(name="personasAprox")
    public Integer getPersonasAprox() {
        return this.personasAprox;
    }
    
    public void setPersonasAprox(Integer personasAprox) {
        this.personasAprox = personasAprox;
    }
    
    @Column(name="estado", length=45)
    public String getEstado() {
        return this.estado;
    }
    
    public void setEstado(String estado) {
        this.estado = estado;
    }
    
    @Column(name="totalcuenta", precision=12, scale=0)
    public Float getTotalcuenta() {
        return this.totalcuenta;
    }
    
    public void setTotalcuenta(Float totalcuenta) {
        this.totalcuenta = totalcuenta;
    }
    
    @Column(name="Atorizacion", length=450)
    public String getAtorizacion() {
        return this.atorizacion;
    }
    
    public void setAtorizacion(String atorizacion) {
        this.atorizacion = atorizacion;
    }
    
    @Column(name="Observaciones", length=450)
    public String getObservaciones() {
        return this.observaciones;
    }
    
    public void setObservaciones(String observaciones) {
        this.observaciones = observaciones;
    }
    
    @Column(name="tipo", length=45)
    public String getTipo() {
        return this.tipo;
    }
    
    public void setTipo(String tipo) {
        this.tipo = tipo;
    }
    
    @Column(name="posicion")
    public Integer getPosicion() {
        return this.posicion;
    }
    
    public void setPosicion(Integer posicion) {
        this.posicion = posicion;
    }
 
    @Column(name="HoraAbierta", length=19)
    public String getHoraAbierta() {
        return this.horaAbierta;
    }
    
    public void setHoraAbierta(String horaAbierta) {
        this.horaAbierta = horaAbierta;
    }
    
    @Column(name="HoraCerrada", length=19)
    public String getHoraCerrada() {
        return this.horaCerrada;
    }
    
    public void setHoraCerrada(String horaCerrada) {
        this.horaCerrada = horaCerrada;
    }
    
    @Column(name="efectivo", precision=12, scale=0)
    public Float getEfectivo() {
        return this.efectivo;
    }
    
    public void setEfectivo(Float efectivo) {
        this.efectivo = efectivo;
    }
    
    @Column(name="tarjeta", precision=12, scale=0)
    public Float getTarjeta() {
        return this.tarjeta;
    }
    
    public void setTarjeta(Float tarjeta) {
        this.tarjeta = tarjeta;
    }
    
    @Column(name="idMesaCapturada", length=45)
    public String getIdMesaCapturada() {
        return this.idMesaCapturada;
    }
    
    public void setIdMesaCapturada(String idMesaCapturada) {
        this.idMesaCapturada = idMesaCapturada;
    }
@OneToMany(cascade=CascadeType.ALL, fetch=FetchType.LAZY, mappedBy="mesaVenta")
    public Set<TrasladoMesa> getTrasladoMesas() {
        return this.trasladoMesas;
    }
    
    public void setTrasladoMesas(Set<TrasladoMesa> trasladoMesas) {
        this.trasladoMesas = trasladoMesas;
    }
@OneToMany(cascade=CascadeType.ALL, fetch=FetchType.LAZY, mappedBy="mesaVenta")
    public Set<CancelacionMesa> getCancelacionMesas() {
        return this.cancelacionMesas;
    }
    
    public void setCancelacionMesas(Set<CancelacionMesa> cancelacionMesas) {
        this.cancelacionMesas = cancelacionMesas;
    }
@OneToMany(cascade=CascadeType.ALL, fetch=FetchType.LAZY, mappedBy="mesaVenta")
    public Set<Comanda> getComandas() {
        return this.comandas;
    }
    
    public void setComandas(Set<Comanda> comandas) {
        this.comandas = comandas;
    }




}


