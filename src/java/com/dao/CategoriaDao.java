/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.dao;

import com.mapping.Categoria;
import java.util.List;

/**
 *
 * @author Eduardopc
 */
public interface CategoriaDao {

    public List getFiltro();

    public List getFiltro(String sql);

    public void insertar(Categoria categoria);

    public void actulizar(Categoria categoria);

    public void actulizar(String id, String estado);
    
    public int buscar(String id);
}
