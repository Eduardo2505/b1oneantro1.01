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
public interface ReportesDao {

    public List getBarra(int iddia, String categoria);

    public List getBarraCosto(int iddia, String categoria);
}
