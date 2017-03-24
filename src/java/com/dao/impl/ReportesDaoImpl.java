/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.dao.impl;

import beans.ReporteBarraBean;
import com.dao.ReportesDao;
import com.mapping.Producto;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import otrosNOsirve.conexion;

/**
 *
 * @author Eduardo
 */
public class ReportesDaoImpl implements ReportesDao {

    @Override
    public List getBarra(int iddia, String categoria) {
        List<ReporteBarraBean> pg = new ArrayList<ReporteBarraBean>();
        conexion mysql = new conexion();
        Connection cn = mysql.Conectar();
        ResultSet rs = null;
        PreparedStatement st = null;
        try {
            String sSQl = "SELECT  "
                    + "    CONCAT(p.nombre, '// ', p.tamano), COUNT(vc.idVenta_Comandacol),p.medida "
                    + "FROM "
                    + "    empleado em, "
                    + "    producto p, "
                    + "    venta_comanda vc, "
                    + "    comanda c, "
                    + "    mesa_venta mv "
                    + "WHERE "
                    + "    vc.idComanda = c.idComanda "
                    + "        AND p.idProducto = vc.idProducto "
                    + "        AND c.idaltadia = " + iddia + " "
                    + "        AND c.estado = 'Activo' "
                    + "        AND em.idEmpleado = mv.idEmpleado "
                    + "        AND mv.idMesa_venta = c.idMesa_venta "
                    + "        AND mv.estado != 'Cancelado' "
                    + "        AND p.idCategoria = '" + categoria + "' "
                    + "GROUP BY vc.idProducto";
            System.out.println(sSQl);
            st = cn.prepareStatement(sSQl);
            rs = st.executeQuery();
            //System.out.println(sSQl);
            while (rs.next()) {
                ReporteBarraBean ne = new ReporteBarraBean();

                ne.setProducto(rs.getString(1));
                ne.setCantida(rs.getInt(2));
                ne.setMedida(rs.getString(3));



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
    public List getBarraCosto(int iddia, String categoria) {
        List<ReporteBarraBean> pg = new ArrayList<ReporteBarraBean>();
        conexion mysql = new conexion();
        Connection cn = mysql.Conectar();
        ResultSet rs = null;
        PreparedStatement st = null;
        try {
            String sSQl = "SELECT  "
                    + "    CONCAT(p.nombre, '// ', p.tamano), "
                    + "    COUNT(vc.idVenta_Comandacol), "
                    + "    p.medida, "
                    + "    vc.costo, "
                    + "    (COUNT(vc.idVenta_Comandacol) * vc.costo) "
                    + "FROM "
                    + "    empleado em, "
                    + "    producto p, "
                    + "    venta_comanda vc, "
                    + "    comanda c, "
                    + "    mesa_venta mv "
                    + "WHERE "
                    + "    vc.idComanda = c.idComanda "
                    + "        AND p.idProducto = vc.idProducto "
                    + "        AND c.idaltadia = " + iddia + " "
                    + "        AND c.estado = 'Activo' "
                    + "        AND em.idEmpleado = mv.idEmpleado "
                    + "        AND mv.idMesa_venta = c.idMesa_venta "
                    + "        AND mv.estado != 'Cancelado' AND p.idCategoria = '" + categoria + "' "
                    + "GROUP BY vc.idProducto , vc.costo";
             System.out.println(sSQl);
            st = cn.prepareStatement(sSQl);
            rs = st.executeQuery();
            //System.out.println(sSQl);
            while (rs.next()) {
                ReporteBarraBean ne = new ReporteBarraBean();

                ne.setProducto(rs.getString(1));
                ne.setCantida(rs.getInt(2));
                ne.setMedida(rs.getString(3));
                ne.setCosto(rs.getFloat(4));
                ne.setTotal(rs.getFloat(5));




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
