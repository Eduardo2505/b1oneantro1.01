/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.dao;

import com.mapping.Altadia;
import java.util.List;

/**
 *
 * @author Eduardopc
 */
public interface AltadiaDao {

    public List getDias();

    public Altadia bucar();

    public Altadia bucar(int id);

    public void insertar(Altadia altadia);

    public void actulizar(int id, String estado);
}
