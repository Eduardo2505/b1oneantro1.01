package com.mapping;
// Generated 11/04/2015 07:19:37 PM by Hibernate Tools 3.2.1.GA



import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Transladoproducto generated by hbm2java
 */
@Entity
@Table(name="transladoproducto"
    ,catalog="restobarpv01"
)
public class Transladoproducto  implements java.io.Serializable {


     private int idTransladoProducto;
     private VentaComanda ventaComanda;
     private String descripcion;
     private String registro;
     private String autorizacion;

    public Transladoproducto() {
    }

	
    public Transladoproducto(int idTransladoProducto, VentaComanda ventaComanda) {
        this.idTransladoProducto = idTransladoProducto;
        this.ventaComanda = ventaComanda;
    }
    public Transladoproducto(int idTransladoProducto, VentaComanda ventaComanda, String descripcion, String registro, String autorizacion) {
       this.idTransladoProducto = idTransladoProducto;
       this.ventaComanda = ventaComanda;
       this.descripcion = descripcion;
       this.registro = registro;
       this.autorizacion = autorizacion;
    }
   
     @Id 
    
    @Column(name="idTransladoProducto", unique=true, nullable=false)
    public int getIdTransladoProducto() {
        return this.idTransladoProducto;
    }
    
    public void setIdTransladoProducto(int idTransladoProducto) {
        this.idTransladoProducto = idTransladoProducto;
    }
@ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="idVenta_Comandacol", nullable=false)
    public VentaComanda getVentaComanda() {
        return this.ventaComanda;
    }
    
    public void setVentaComanda(VentaComanda ventaComanda) {
        this.ventaComanda = ventaComanda;
    }
    
    @Column(name="Descripcion", length=450)
    public String getDescripcion() {
        return this.descripcion;
    }
    
    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }
    
    @Column(name="Registro", length=19)
    public String getRegistro() {
        return this.registro;
    }
    
    public void setRegistro(String registro) {
        this.registro = registro;
    }
    
    @Column(name="Autorizacion", length=450)
    public String getAutorizacion() {
        return this.autorizacion;
    }
    
    public void setAutorizacion(String autorizacion) {
        this.autorizacion = autorizacion;
    }




}

