/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package beans;

/**
 *
 * @author Eduardo
 */
public class CortesiaBean {

    private String producto;
    private String medida;
    private int cantidad;
    private Float preciUnitario;
    private Float preciTotal;
    private String Autorizacion;
    private String Observacion;

    public CortesiaBean() {
    }

    public CortesiaBean(String producto, String medida, int cantidad, Float preciUnitario, Float preciTotal, String Autorizacion, String Observacion) {
        this.producto = producto;
        this.medida = medida;
        this.cantidad = cantidad;
        this.preciUnitario = preciUnitario;
        this.preciTotal = preciTotal;
        this.Autorizacion = Autorizacion;
        this.Observacion = Observacion;
    }

    public String getProducto() {
        return producto;
    }

    public void setProducto(String producto) {
        this.producto = producto;
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

    public Float getPreciUnitario() {
        return preciUnitario;
    }

    public void setPreciUnitario(Float preciUnitario) {
        this.preciUnitario = preciUnitario;
    }

    public Float getPreciTotal() {
        return preciTotal;
    }

    public void setPreciTotal(Float preciTotal) {
        this.preciTotal = preciTotal;
    }

    public String getAutorizacion() {
        return Autorizacion;
    }

    public void setAutorizacion(String Autorizacion) {
        this.Autorizacion = Autorizacion;
    }

    public String getObservacion() {
        return Observacion;
    }

    public void setObservacion(String Observacion) {
        this.Observacion = Observacion;
    }
    
}
