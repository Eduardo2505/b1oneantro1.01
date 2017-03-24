package com.mapping;
// Generated 11/04/2015 07:19:37 PM by Hibernate Tools 3.2.1.GA


import java.util.HashSet;
import java.util.Set;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

/**
 * Descuento generated by hbm2java
 */
@Entity
@Table(name="descuento"
    ,catalog="restobarpv01"
)
public class Descuento  implements java.io.Serializable {


     private String idDescuento;
     private Double porcentaje;
     private String observaciones;
     private Set<MesaVenta> mesaVentas = new HashSet<MesaVenta>(0);
     private Set<VentaComanda> ventaComandas = new HashSet<VentaComanda>(0);

    public Descuento() {
    }

	
    public Descuento(String idDescuento) {
        this.idDescuento = idDescuento;
    }
    public Descuento(String idDescuento, Double porcentaje, String observaciones, Set<MesaVenta> mesaVentas, Set<VentaComanda> ventaComandas) {
       this.idDescuento = idDescuento;
       this.porcentaje = porcentaje;
       this.observaciones = observaciones;
       this.mesaVentas = mesaVentas;
       this.ventaComandas = ventaComandas;
    }
   
     @Id 
    
    @Column(name="idDescuento", unique=true, nullable=false, length=45)
    public String getIdDescuento() {
        return this.idDescuento;
    }
    
    public void setIdDescuento(String idDescuento) {
        this.idDescuento = idDescuento;
    }
    
    @Column(name="porcentaje", precision=22, scale=0)
    public Double getPorcentaje() {
        return this.porcentaje;
    }
    
    public void setPorcentaje(Double porcentaje) {
        this.porcentaje = porcentaje;
    }
    
    @Column(name="Observaciones", length=456)
    public String getObservaciones() {
        return this.observaciones;
    }
    
    public void setObservaciones(String observaciones) {
        this.observaciones = observaciones;
    }
@OneToMany(cascade=CascadeType.ALL, fetch=FetchType.LAZY, mappedBy="descuento")
    public Set<MesaVenta> getMesaVentas() {
        return this.mesaVentas;
    }
    
    public void setMesaVentas(Set<MesaVenta> mesaVentas) {
        this.mesaVentas = mesaVentas;
    }
@OneToMany(cascade=CascadeType.ALL, fetch=FetchType.LAZY, mappedBy="descuento")
    public Set<VentaComanda> getVentaComandas() {
        return this.ventaComandas;
    }
    
    public void setVentaComandas(Set<VentaComanda> ventaComandas) {
        this.ventaComandas = ventaComandas;
    }




}


