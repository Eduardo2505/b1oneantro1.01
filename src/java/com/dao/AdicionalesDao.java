/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.dao;

import com.mapping.Adicionales;
import java.util.List;

/**
 *
 * @author Eduardopc
 */
public interface AdicionalesDao {

    public void insertar(Adicionales adicionales);

    public void eliminar(int id);

    public int contar(String idProducto, int id);

    public List getMostrar(int idventa);

    public Adicionales bucar(int idVenta_Comandacol);
}
