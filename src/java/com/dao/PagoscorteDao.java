/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.dao;

import com.mapping.Pagoscorte;
import java.util.List;

/**
 *
 * @author Eduardo
 */
public interface PagoscorteDao {

    public Pagoscorte insertar(Pagoscorte pagoscorte);

    public void actualizar(int id, float efectivo, float tarjetas);

    public void actualizar(int id, float total);

    public void eliminar(int id);

    public Pagoscorte buscar(String idEmpleado, int iddida);

    public Pagoscorte buscar(int idpagocorte);

    public List getFiltro(String idEmpleado);
    
 
}
