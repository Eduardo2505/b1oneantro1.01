/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.dao.impl;

import beans.Adicionalesbean;
import com.dao.AdicionalesComprobarDao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import otrosNOsirve.conexion;

/**
 *
 * @author Eduardo
 */
public class AdicionalesComprobarDaoImpl implements AdicionalesComprobarDao {
    
    @Override
    public String limite(String query, int lim, int idventa) {
        conexion mysql = new conexion();
        Connection cn = mysql.Conectar();
        String sSQl;
        String resp = "";
        
        sSQl = "SELECT  "
                + "    COUNT(*) "
                + "FROM "
                + "    adicionales "
                + "WHERE "
                + "    idVenta_Comandacol = " + idventa + " "
                + "        AND idProducto " + query + "";
        
        try {
            System.out.println(sSQl);
            Statement st = cn.createStatement();
            ResultSet rset;
            rset = st.executeQuery(sSQl);
            
            rset.next();
            int resul = rset.getInt(1);
            int limc = lim - 1;
            if (resul <= limc) {
                resp = "agregar";
            } else {
                resp = "bloqueado";
            }
            st.close();
            rset.close();
            cn.close();
            
        } catch (SQLException ex) {
            System.out.println(ex);
        }
        System.out.println(resp.trim());
        return resp.trim();
    }
    
    @Override
    public int limiteclases(String clase, int idventa) {
        conexion mysql = new conexion();
        Connection cn = mysql.Conectar();
        String sSQl;
        int resp = 0;
        sSQl = "SELECT  "
                + "    count(*) "
                + "FROM "
                + "    adicionales "
                + "WHERE "
                + "    idVenta_Comandacol = " + idventa + " "
                + "        AND descripcion " + clase + " ";
        try {
            System.out.println(sSQl);
            Statement st = cn.createStatement();
            ResultSet rset = null;
            rset = st.executeQuery(sSQl);
            rset.next();
            resp = rset.getInt(1);
            st.close();
            rset.close();
            cn.close();
            
        } catch (SQLException ex) {
            System.out.println(ex);
        }
        
        return resp;
    }
    
    @Override
    public List getAdicionales(int idventa) {
        List<Adicionalesbean> pg = new ArrayList<Adicionalesbean>();
        conexion mysql = new conexion();
        Connection cn = mysql.Conectar();
        ResultSet rs = null;
        PreparedStatement st = null;
        try {
            String sSQl = "SELECT  "
                    + "    COUNT(a.idAdicionales) AS cantidad, CONCAT(p.nombre, ' ', p.tamano) AS nombre,a.idAdicionales id,p.medida "
                    + "FROM "
                    + "    producto p, "
                    + "    adicionales a "
                    + "WHERE "
                    + "    p.idProducto = a.idProducto "
                    + "        AND a.idVenta_Comandacol = " + idventa + " "
                    + "GROUP BY a.idProducto";
            
            st = cn.prepareStatement(sSQl);
            rs = st.executeQuery();
            
            while (rs.next()) {
                Adicionalesbean ne = new Adicionalesbean();
                
                
                ne.setCantidad(rs.getInt(1));
                ne.setProducto(rs.getString(2));
                ne.setIdadicional(rs.getInt(3));
                ne.setMedida(rs.getString(4));
                
                
                pg.add(ne); //agregas ese objeto a la lista

            }
            st.close();
            rs.close();
            cn.close();
            
        } catch (Exception e) {
            return null;
        }
        return pg;
    }
    
    @Override
    public List getAdicionalesReporte(int idDia) {
        List<Adicionalesbean> pg = new ArrayList<Adicionalesbean>();
        conexion mysql = new conexion();
        Connection cn = mysql.Conectar();
        ResultSet rs = null;
        PreparedStatement st = null;
        try {
            String sSQl = "SELECT  "
                    + "    CONCAT(p.nombre, '// ', p.tamano), COUNT(a.idAdicionales),p.idCategoria,p.medida ,c.idComanda "
                    + "FROM "
                    + "    empleado em, "
                    + "    mesa_venta mv, "
                    + "    comanda c, "
                    + "    venta_comanda vc, "
                    + "    adicionales a, "
                    + "    producto p "
                    + "WHERE "
                    + "    em.idEmpleado = mv.idEmpleado "
                    + "        AND mv.idMesa_venta = c.idMesa_venta "
                    + "        AND p.idProducto = a.idProducto "
                    + "        AND c.idComanda = vc.idComanda "
                    + "        AND vc.idVenta_Comandacol = a.idVenta_Comandacol "
                    + "        AND c.estado = 'Activo' "
                    + "        AND mv.estado != 'Cancelado' "
                    + "        AND c.idaltadia = " + idDia + " "
                    + "        AND mv.idaltadia = " + idDia + " "
                    + "GROUP BY a.idProducto order by p.idCategoria";
            System.out.println(sSQl);
            st = cn.prepareStatement(sSQl);
            rs = st.executeQuery();
            
            while (rs.next()) {
                Adicionalesbean ne = new Adicionalesbean();
                
                
                
                ne.setProducto(rs.getString(1));
                ne.setCantidad(rs.getInt(2));
                ne.setCategoria(rs.getString(3));
                ne.setMedida(rs.getString(4));
                ne.setIdVenta(rs.getString(5));
                
                
                pg.add(ne); //agregas ese objeto a la lista

            }
            st.close();
            rs.close();
            cn.close();
            
        } catch (Exception e) {
            return null;
        }
        return pg;
    }
}
