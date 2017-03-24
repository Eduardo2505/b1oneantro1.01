/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.dao;

import java.util.List;

/**
 *
 * @author Eduardo
 */
public interface CuentaDao {

    public List getmostrar(String idComanda, String op);
    
    public List getUpdateDescuento(String idMesa);
}
