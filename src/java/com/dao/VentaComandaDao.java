/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.dao;

import com.mapping.VentaComanda;
import java.util.List;

/**
 *
 * @author Eduardopc
 */
public interface VentaComandaDao {

    public int insertar(VentaComanda ventaComanda);

    public void eliminar(int id);

    public VentaComanda BuscarComanda(int idcomanda);

    public void actualiza(int id, String Observaciones);

    public void actualizaEstado(int id, String estado);

    public int contar();

    public List getVerDistribucion(String idProducto, String idComanda);

    public List getVerDistribucion(String idComanda);

    public List getVer(String idComanda);

    public int contar(String idProducto, String  idComanda);

    public float total(int idDia, String idMesa_venta);

    public void actualizaDes(int id, String idDes, String Obs, float costo);

    public int verificarComanda(String idComanda);
}
