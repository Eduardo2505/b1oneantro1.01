/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package beans;

/**
 *
 * @author Eduardo
 */
public class Comandaventabean {

    private String producto;
    private int cantidad;
    private Float costo;
    private String observaciones;
    private String autorizacion;
    private String descuento;
    private String idProducto;
    private int idventa;
    private Float totalcosto;
    private String tipo;
    private String medida;
    private String categoria;

    public Comandaventabean() {
    }

    public Comandaventabean(String categoria, String medida, String tipo, String producto, int cantidad, Float costo, String observaciones, String autorizacion, String descuento, String idProducto, int idventa, Float totalcosto) {
        this.producto = producto;
        this.cantidad = cantidad;
        this.costo = costo;
        this.observaciones = observaciones;
        this.autorizacion = autorizacion;
        this.descuento = descuento;
        this.idProducto = idProducto;
        this.idventa = idventa;
        this.totalcosto = totalcosto;
        this.tipo = tipo;
        this.medida = medida;
        this.categoria = categoria;
    }

    public String getCategoria() {
        return categoria;
    }

    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }

    public String getMedida() {
        return medida;
    }

    public void setMedida(String medida) {
        this.medida = medida;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public Float getTotalcosto() {
        return totalcosto;
    }

    public void setTotalcosto(Float totalcosto) {
        this.totalcosto = totalcosto;
    }

    public int getIdventa() {
        return idventa;
    }

    public void setIdventa(int idventa) {
        this.idventa = idventa;
    }

    public String getProducto() {
        return producto;
    }

    public void setProducto(String producto) {
        this.producto = producto;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }

    public Float getCosto() {
        return costo;
    }

    public void setCosto(Float costo) {
        this.costo = costo;
    }

    public String getObservaciones() {
        return observaciones;
    }

    public void setObservaciones(String observaciones) {
        this.observaciones = observaciones;
    }

    public String getAutorizacion() {
        return autorizacion;
    }

    public void setAutorizacion(String autorizacion) {
        this.autorizacion = autorizacion;
    }

    public String getDescuento() {
        return descuento;
    }

    public void setDescuento(String descuento) {
        this.descuento = descuento;
    }

    public String getIdProducto() {
        return idProducto;
    }

    public void setIdProducto(String idProducto) {
        this.idProducto = idProducto;
    }
}
