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
public interface AdicionalesComprobarDao {
    
    public String limite(String query,int lim,int idventa);
    
    public int limiteclases(String clase,int idventa);
    
    public List getAdicionales(int idventa);
    
   public List getAdicionalesReporte(int idDia);
    
}
