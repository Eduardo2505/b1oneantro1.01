/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package beans;

/**
 *
 * @author Eduardo
 */
public class Adicionalesbean {

    private int cantidad;
    private String producto;
    private int idadicional;
    private String medida;
    private String categoria;
    private String idVenta;

    public Adicionalesbean() {
    }

    public Adicionalesbean(String idVenta,int cantidad, String producto, int idadicional, String medida, String categoria) {
        this.cantidad = cantidad;
        this.producto = producto;
        this.idadicional = idadicional;
        this.medida = medida;
        this.categoria = categoria;
        this.idVenta=idVenta;
    }

    public String getIdVenta() {
        return idVenta;
    }

    public void setIdVenta(String idVenta) {
        this.idVenta = idVenta;
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

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }

    public String getProducto() {
        return producto;
    }

    public void setProducto(String producto) {
        this.producto = producto;
    }

    public int getIdadicional() {
        return idadicional;
    }

    public void setIdadicional(int idadicional) {
        this.idadicional = idadicional;
    }
}
