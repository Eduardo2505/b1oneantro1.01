/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.dao;

import com.mapping.Producto;
import java.util.List;

/**
 *
 * @author Eduardopc
 */
public interface ProductoDao {

    public List getFiltro(String nombre, String tipo, String tipoEvento, String producto);

    public List getFiltro(String tipo, String tipoEvento, String producto);

    public void insertar(Producto producto);

    public void actulizar(String idPro, String tipo, String evento);

    public List getOtro();

    public List getVEr();
    
    public List getAdicionales();

    public List getBuscar(String nombre, String tipoEvento);

    public Producto getBuscar(String id);

    public List getFiltro(String categori, String evento);

    public int contar();

    public void actualizar(Producto producto);
    
    public List getVErSucategorias();
    
    public List getProPromo(String tipo);
    
    public void actulizarPromo(String idPro, String act);
}
