/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.dao;

import com.mapping.Descuento;
import java.util.List;

/**
 *
 * @author Eduardopc
 */
public interface DescuentoDao {

    public void insertar(Descuento descuento);

    public List getVer();
    
    public Descuento Buscarid(String idDescuento);
}
