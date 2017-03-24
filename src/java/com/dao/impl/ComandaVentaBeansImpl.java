/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.dao.impl;

import beans.ComandaCancelada;
import beans.Comandaventabean;
import com.dao.ComandaVentaBeans;
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
public class ComandaVentaBeansImpl implements ComandaVentaBeans {

    @Override
    public List getBuscar(String idComanda, String op) {
        List<Comandaventabean> pg = new ArrayList<Comandaventabean>();
        conexion mysql = new conexion();
        Connection cn = mysql.Conectar();
        ResultSet rs = null;
        PreparedStatement st = null;
        String sSQl = "";
        try {
            if (op.equals("adicional")) {
                sSQl = "SELECT  "
                        + "    CONCAT(p.nombre,' ', p.tamano) AS nombre, "
                        + "    COUNT(vc.idProducto) AS cantidad, "
                        + "    vc.costo AS costo, "
                        + "    c.observa, "
                        + "    c.Autorizacion, "
                        + "    vc.idVenta_Comandacol AS idventa, "
                        + "    vc.idDescuento, "
                        + "    p.idProducto AS idProducto,sum(vc.costo) suman,p.medida,p.idCategoria,p.tipo "
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
                        + "        AND c.idComanda LIKE '%" + idComanda + "%' and p.opcion='adicional' "
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
                        + "    vc.idDescuento, "
                        + "    p.idProducto AS idProducto,sum(vc.costo) suman,p.medida,p.idCategoria,p.tipo "
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
                        + "        AND c.idComanda LIKE '%" + idComanda + "%' and p.opcion!='adicional' "
                        + "GROUP BY vc.idProducto , vc.idDescuento , c.observa, vc.idVenta_Comandacol "
                        + "ORDER BY vc.registro DESC";

            }
            // System.out.println(sSQl);
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
                ne.setDescuento(rs.getString(7));
                ne.setIdProducto(rs.getString(8));
                ne.setTotalcosto(rs.getFloat(9));
                ne.setMedida(rs.getString(10));
                ne.setCategoria(rs.getString(11));
                ne.setTipo(rs.getString(12));

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
    public List getMostrarCancelacion(String idComanda, String op) {
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
                        + "        AND c.estado = 'Cancelado' "
                        + "        AND c.idComanda LIKE '%" + idComanda + "%' and p.opcion='adicional' "
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
                        + "        AND c.estado = 'Cancelado' "
                        + "        AND c.idComanda LIKE '%" + idComanda + "%' and p.opcion!='adicional' "
                        + "GROUP BY vc.idProducto , vc.idDescuento , c.observa, vc.idVenta_Comandacol "
                        + "ORDER BY vc.registro DESC";

            }
            // System.out.println(sSQl);
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
                ne.setDescuento(rs.getString(7));
                ne.setIdProducto(rs.getString(8));
                ne.setTotalcosto(rs.getFloat(9));
                ne.setMedida(rs.getString(10));

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
    public List getMostrarCancelacionDatos(int idDia) {
        List<ComandaCancelada> pg = new ArrayList<ComandaCancelada>();
        conexion mysql = new conexion();
        Connection cn = mysql.Conectar();
        ResultSet rs = null;
        PreparedStatement st = null;
        String sSQl = "";
        try {

            sSQl = "SELECT  "
                    + "    c.idComanda, "
                    + "    em.Nombre, "
                    + "    em.apellidos, "
                    + "    cc.descripcion, "
                    + "    cc.Registro, "
                    + "    cc.Autorizacion "
                    + "FROM "
                    + "    mesa_venta mv, "
                    + "    comanda c, "
                    + "    venta_comanda vc, "
                    + "    empleado em, "
                    + "    cancelacion_comanda cc "
                    + "WHERE "
                    + "    mv.idMesa_venta = c.idMesa_venta "
                    + "        AND em.idEmpleado = mv.idEmpleado "
                    + "        AND cc.idComanda = c.idComanda "
                    + "        AND c.idComanda = vc.idComanda    "
                    + "        AND c.estado = 'Cancelado' "
                    + "        AND c.idaltadia = "+idDia+" "
                    + "GROUP BY c.idComanda "
                    + "ORDER BY vc.registro DESC";

            //System.out.println(sSQl);
            st = cn.prepareStatement(sSQl);
            rs = st.executeQuery();

            while (rs.next()) {
                ComandaCancelada ne = new ComandaCancelada();

              
                ne.setIdComanda(rs.getString(1));
                ne.setNomEmpleado(rs.getString(2));
                ne.setApellido(rs.getString(3));
                ne.setDescripcionCancelacion(rs.getString(4));
                ne.setRegistro(rs.getString(5));
                ne.setAutorizacionCancelacion(rs.getString(6));

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
