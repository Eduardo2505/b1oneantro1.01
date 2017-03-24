/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.dao.impl;

import beans.Adicionalesbean;
import beans.CortesiaBean;
import com.dao.CortesiaBeanDao;
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
public class CortesiaBeanDaoImpl implements CortesiaBeanDao {

    @Override
    public List getVer(int iddia) {
        List<CortesiaBean> pg = new ArrayList<CortesiaBean>();
        conexion mysql = new conexion();
        Connection cn = mysql.Conectar();
        ResultSet rs = null;
        PreparedStatement st = null;
        try {
            String sSQl = "SELECT  "
                    + "    CONCAT(p.nombre, '// ', p.tamano), "
                    + "    COUNT(vc.idVenta_Comandacol), "
                    + "    vc.costo, "
                    + "    c.Autorizacion, "
                    + "    c.observa, "
                    + "    COUNT(vc.idVenta_Comandacol) * vc.costo AS venta, "
                    + "    c.idMesa_venta AS cuenta,p.medida "
                    + "FROM "
                    + "    empleado e, "
                    + "    producto p, "
                    + "    venta_comanda vc, "
                    + "    comanda c, "
                    + "    mesa_venta mv "
                    + "WHERE "
                    + "    mv.idMesa_venta = c.idMesa_venta "
                    + "        AND p.idProducto = vc.idProducto "
                    + "        AND c.idComanda = vc.idComanda "
                    + "        AND c.idaltadia = "+iddia+" "
                    + "		AND c.estado ='Activo' "
                    + "        AND mv.estado!='Cancelado' "
                    + "        AND mv.idEmpleado = e.idEmpleado and c.tipo='cortesia' "
                    + "GROUP BY vc.idProducto , c.observa";

            st = cn.prepareStatement(sSQl);
            rs = st.executeQuery();

            while (rs.next()) {
                CortesiaBean ne = new CortesiaBean();

                ne.setProducto(rs.getString(1));
                ne.setCantidad(rs.getInt(2));
                ne.setPreciUnitario(rs.getFloat(3));
                ne.setAutorizacion(rs.getString(4));
                ne.setObservacion(rs.getString(5));
                ne.setPreciTotal(rs.getFloat(6));
                ne.setMedida(rs.getString(7));
                //ne.setProducto(rs.getString(1))


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
