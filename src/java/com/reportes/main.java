/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.reportes;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import otrosNOsirve.conexion;

/**
 *
 * @author Eduardo
 */
public class main {
    public static void main(String[] args) {
        try {
            conexion mysql = new conexion();
            Connection cn = mysql.Conectar();
            ResultSet rsc = null;
            PreparedStatement stc = null;
            String sSQl = "select *from mesas";

                stc = cn.prepareStatement(sSQl);
                rsc = stc.executeQuery();
                while (rsc.next()) {
                    System.out.println(rsc.getString(1));
                
                }
        } catch (SQLException ex) {
            Logger.getLogger(main.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
