/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package beans;

/**
 *
 * @author Eduardo
 */
public class ComandaCancelada {

    private String idComanda;
    private String NomEmpleado;
    private String Apellido;
    private String DescripcionCancelacion;
    private String Registro;
    private String AutorizacionCancelacion;

    public ComandaCancelada() {
    }

    public ComandaCancelada(String idComanda, String NomEmpleado, String Apellido, String DescripcionCancelacion, String Registro, String AutorizacionCancelacion) {
        this.idComanda = idComanda;
        this.NomEmpleado = NomEmpleado;
        this.Apellido = Apellido;
        this.DescripcionCancelacion = DescripcionCancelacion;
        this.Registro = Registro;
        this.AutorizacionCancelacion = AutorizacionCancelacion;
    }

    public String getIdComanda() {
        return idComanda;
    }

    public void setIdComanda(String idComanda) {
        this.idComanda = idComanda;
    }

    public String getNomEmpleado() {
        return NomEmpleado;
    }

    public void setNomEmpleado(String NomEmpleado) {
        this.NomEmpleado = NomEmpleado;
    }

    public String getApellido() {
        return Apellido;
    }

    public void setApellido(String Apellido) {
        this.Apellido = Apellido;
    }

    public String getDescripcionCancelacion() {
        return DescripcionCancelacion;
    }

    public void setDescripcionCancelacion(String DescripcionCancelacion) {
        this.DescripcionCancelacion = DescripcionCancelacion;
    }

    public String getRegistro() {
        return Registro;
    }

    public void setRegistro(String Registro) {
        this.Registro = Registro;
    }

    public String getAutorizacionCancelacion() {
        return AutorizacionCancelacion;
    }

    public void setAutorizacionCancelacion(String AutorizacionCancelacion) {
        this.AutorizacionCancelacion = AutorizacionCancelacion;
    }
}