/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.dao;

import com.mapping.CancelacionMesa;
import java.util.List;

/**
 *
 * @author Eduardo
 */
public interface CancelacionmesaDao {

    public CancelacionMesa insertar(CancelacionMesa cancelacionmesa);
    
    public List getMostrar(int idDia);
    public CancelacionMesa getBuscar(String idMesa);
}
