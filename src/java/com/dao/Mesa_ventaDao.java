/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.dao;

import com.mapping.Empleado;
import com.mapping.MesaVenta;
import java.util.List;

/**
 *
 * @author Eduardopc
 */
public interface Mesa_ventaDao {

    public List getMesaVenta(String estado, String idEmpleado, int idDia);
// cancelaciones

    public List getMesaVenta(String estado, int idDia);

    public void insertar(MesaVenta mesaventa);

    public MesaVenta bucarPorId(String id);

    public void actualiza(String idMesaventa, float total);

    public void actualiza(String idMesaventa, float efectivo, float tarjeta);

    public void cerrar(String idMesaventa, String estado, String hora, String autorizacion);

    public void cerrardescuento(String idMesaventa, String estado, String hora, String autorizacion);

    public void AbrirCuenta(String idMesaventa, String estado, String observacion);

    public List BuscarMesaVenta(String estado, String idEmpleado, int idDia, String idMesa);

    public void trasladar(String idMesaventa, Empleado empleado);

    public int contar();

    public int MesaAbiertas(String idEmpledo);

    public float Sumtotal(int idDiao);

    public float Sumtotal(int idDiao, String idEmpleado);

    public List getCuentasAbiertas(String estado, int idDia, String idMesaventa);

    public List getCorte(int idDia);

    public void actualizaDia(String idMesaventa, int iddia);

    public void actualizaDescuento(String idMesaventa, String Autorizacion, String Obs, String iddecuento);
    //public int contarProducto(Producto);

    //Actualizar//
    public List Mostrarmesa(int idDia);
}
