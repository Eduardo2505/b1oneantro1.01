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
public interface ComandaVentaBeans {

    public List getBuscar(String idComanda, String op);

    public List getMostrarCancelacion(String idComanda, String op);

    public List getMostrarCancelacionDatos(int iddia);
}
