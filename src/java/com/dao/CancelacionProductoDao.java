/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.dao;

import com.mapping.Cancelacionproducto;
import java.util.List;

/**
 *
 * @author Eduardopc
 */
public interface CancelacionProductoDao {

    public void insertar(Cancelacionproducto cancelacionproducto);

    public List getver(String fecha);

    public List getver(String fechaInicial, String fechaFinal);
}
