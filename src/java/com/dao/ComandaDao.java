/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.dao;

import com.mapping.Comanda;
import com.mapping.MesaVenta;
import java.util.List;

/**
 *
 * @author Eduardopc
 */
public interface ComandaDao {

    public void insertar(Comanda comanda);

    public Comanda bucarPorId(String id);

    public List getBuscar(String idMesa);

    public void actulizar(String idComanda, String estado);

    public void actulizarIdMesaventa(String idComanda, MesaVenta mesaventa);

    public int contar(int id, String mesaVenta, String estado);

    public int contar(int id);

    public int contarComanda(String idComanda);

    public List getMesas(String inicio, String fi, int iddia);

    public void actulizaridDia(String idComanda, int iddia);

    public void actulizarImp(String idComanda, String impresion);

 
}
