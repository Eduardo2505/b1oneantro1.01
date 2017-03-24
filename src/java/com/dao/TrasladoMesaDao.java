/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.dao;

import com.mapping.TrasladoMesa;
import java.util.List;

/**
 *
 * @author Eduardo
 */
public interface TrasladoMesaDao {
    public TrasladoMesa insertar(TrasladoMesa tras);
    
    public List getMostrar(int idDia);
}
