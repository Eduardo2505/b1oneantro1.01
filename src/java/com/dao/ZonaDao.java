/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.dao;

import com.mapping.Zona;
import java.util.List;

/**
 *
 * @author Eduardopc
 */
public interface ZonaDao {

    public List getZona();

    public void insertar(Zona zona);
}
