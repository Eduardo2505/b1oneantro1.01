/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package beans;

/**
 *
 * @author Eduardo
 */
public class ReporteBarraBean {

    private String producto;
    private String medida;
    private int cantida;
    private float costo;
    private String descuento;
     private float total;

    public ReporteBarraBean() {
    }

    public ReporteBarraBean(String producto, String medida, int cantida, float costo, String descuento, float total) {
        this.producto = producto;
        this.medida = medida;
        this.cantida = cantida;
        this.costo = costo;
        this.descuento = descuento;
        this.total = total;
    }

    public float getTotal() {
        return total;
    }

    public void setTotal(float total) {
        this.total = total;
    }

   

    public String getDescuento() {
        return descuento;
    }

    public void setDescuento(String descuento) {
        this.descuento = descuento;
    }

    public float getCosto() {
        return costo;
    }

    public void setCosto(float costo) {
        this.costo = costo;
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

    public int getCantida() {
        return cantida;
    }

    public void setCantida(int cantida) {
        this.cantida = cantida;
    }
}
