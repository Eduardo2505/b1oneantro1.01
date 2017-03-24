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
public interface ProductoBeanDao {

    public List getFiltro(String tipoEvento, String producto,String idCategoria);
    public List getFiltro();
}
