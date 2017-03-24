/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.dao.impl;

import beans.Comandaventabean;
import com.dao.CuentaDao;
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
public class CuentaDaoImpl implements CuentaDao {

    @Override
    public List getmostrar(String idcuenta, String op) {
        List<Comandaventabean> pg = new ArrayList<Comandaventabean>();
        conexion mysql = new conexion();
        Connection cn = mysql.Conectar();
        ResultSet rs = null;
        PreparedStatement st = null;
        String sSQl = "";
        try {
            if (op.equals("adicional")) {
                sSQl = "SELECT  "
                        + "    CONCAT(p.nombre, ' ', p.tamano) AS nombre, "
                        + "    COUNT(vc.idProducto) AS cantidad, "
                        + "    vc.costo AS costo, "
                        + "    c.observa, "
                        + "    c.Autorizacion, "
                        + "    vc.idVenta_Comandacol AS idventa, "
                        + "    c.tipo AS tipo, "
                        + "    vc.idDescuento, "
                        + "    p.idProducto AS idProducto,sum(vc.costo) suman,p.medida "
                        + "FROM "
                        + "    mesa_venta mv, "
                        + "    comanda c, "
                        + "    venta_comanda vc, "
                        + "    producto p "
                        + "WHERE "
                        + "    mv.idMesa_venta = c.idMesa_venta "
                        + "        AND c.idComanda = vc.idComanda "
                        + "        AND vc.idProducto = p.idProducto "
                        + "        AND c.estado = 'activo' "
                        + "        AND mv.idMesa_venta = '" + idcuenta + "' "
                        + "        AND p.opcion = 'adicional' "
                        + "        AND c.idComanda LIKE '%%' "
                        + "GROUP BY vc.idProducto , vc.idDescuento , c.observa,vc.idVenta_Comandacol "
                        + "ORDER BY vc.registro DESC";
            } else {
                sSQl = "SELECT  "
                        + "    CONCAT(p.nombre, ' ', p.tamano) AS nombre, "
                        + "    COUNT(vc.idProducto) AS cantidad, "
                        + "    vc.costo AS costo, "
                        + "    c.observa, "
                        + "    c.Autorizacion, "
                        + "    vc.idVenta_Comandacol AS idventa, "
                        + "    c.tipo AS tipo, "
                        + "    vc.idDescuento, "
                        + "    p.idProducto AS idProducto,sum(vc.costo) suman,p.medida "
                        + "FROM "
                        + "    mesa_venta mv, "
                        + "    comanda c, "
                        + "    venta_comanda vc, "
                        + "    producto p "
                        + "WHERE "
                        + "    mv.idMesa_venta = c.idMesa_venta "
                        + "        AND c.idComanda = vc.idComanda "
                        + "        AND vc.idProducto = p.idProducto "
                        + "        AND c.estado = 'activo' "
                        + "        AND mv.idMesa_venta = '" + idcuenta + "' "
                        + "        AND p.opcion != 'adicional' "
                        + "        AND c.idComanda LIKE '%%' "
                        + "GROUP BY vc.idProducto , vc.idDescuento , c.observa,vc.idVenta_Comandacol "
                        + "ORDER BY vc.registro DESC";

            }
            System.out.println(sSQl);
            st = cn.prepareStatement(sSQl);
            rs = st.executeQuery();

            while (rs.next()) {
                Comandaventabean ne = new Comandaventabean();

                ne.setProducto(rs.getString(1));
                ne.setCantidad(rs.getInt(2));
                ne.setCosto(rs.getFloat(3));
                ne.setObservaciones(rs.getString(4));
                ne.setAutorizacion(rs.getString(5));
                ne.setIdventa(rs.getInt(6));
                ne.setTipo(rs.getString(7));
                ne.setDescuento(rs.getString(8));
                ne.setIdProducto(rs.getString(9));
                ne.setTotalcosto(rs.getFloat(10));
                ne.setMedida(rs.getString(11));

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
    public List getUpdateDescuento(String idMesa) {
        List<Comandaventabean> pg = new ArrayList<Comandaventabean>();
        conexion mysql = new conexion();
        Connection cn = mysql.Conectar();
        ResultSet rs = null;
        PreparedStatement st = null;
        String sSQl = "";
        try {

            sSQl = "SELECT  "
                    + "    vc.idVenta_Comandacol, p.precio "
                    + "FROM "
                    + "    venta_comanda vc, "
                    + "    comanda c, "
                    + "    producto p "
                    + "WHERE "
                    + "    p.idProducto = vc.idProducto "
                    + "        AND vc.idComanda = c.idComanda "
                    + "        AND c.idMesa_venta = '" + idMesa + "'";

            //System.out.println(sSQl);
            st = cn.prepareStatement(sSQl);
            rs = st.executeQuery();

            while (rs.next()) {
                Comandaventabean ne = new Comandaventabean();

                ne.setIdventa(rs.getInt(1));
                ne.setCosto(rs.getFloat(2));


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
