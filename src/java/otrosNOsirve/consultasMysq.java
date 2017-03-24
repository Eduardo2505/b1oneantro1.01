/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package otrosNOsirve;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Eduardopc
 */
public class consultasMysq {

    String mensaje = "", sSQl = "";
    ResultSet rs = null;
    PreparedStatement st = null;

    public void consultasMysq() {
    }

    public int verificar(String id) {
        conexion mysql = new conexion();
        Connection cn = mysql.Conectar();
        sSQl = "select count(vc.idVenta_Comandacol) as total from comanda c, venta_comanda vc where c.idComanda=vc.idComanda and c.estado=\"Activo\" and c.idMesa_venta=\"" + id + "\"";
        int mail = 0;
        try {
            st = cn.prepareStatement(sSQl);
            rs = st.executeQuery();
            rs.next();
            mail = rs.getInt("total");

        } catch (SQLException ex) {
            System.out.println(ex);
        } finally {
            cerrar(st);
            cerrar(rs);
            cerrar(cn);

        }

        return mail;
    }

    public int verificarAdicionales(int idVenta_Comandaco, String dCategoria) {
        conexion mysql = new conexion();
        Connection cn = mysql.Conectar();
        sSQl = "select count(a.idAdicionales) as total from adicionales a, producto p where a.idProducto=p.idProducto and a.idVenta_Comandacol=" + idVenta_Comandaco + " and p.idCategoria='" + dCategoria + "'";
        int mail = 0;
        try {
            st = cn.prepareStatement(sSQl);
            rs = st.executeQuery();
            rs.next();
            mail = rs.getInt("total");

        } catch (SQLException ex) {
            System.out.println(ex);
        } finally {
            cerrar(st);
            cerrar(rs);
            cerrar(cn);

        }

        return mail;
    }

    public int verificarAdicionalespro(int idVenta_Comandaco, String idproducto) {
        conexion mysql = new conexion();
        Connection cn = mysql.Conectar();
        sSQl = "select count(a.idAdicionales) as total from adicionales a where  a.idVenta_Comandacol=" + idVenta_Comandaco + " and a.idProducto='" + idproducto + "'";
        int mail = 0;
        try {
            st = cn.prepareStatement(sSQl);
            rs = st.executeQuery();
            rs.next();
            mail = rs.getInt("total");

        } catch (SQLException ex) {
            System.out.println(ex);
        } finally {
            cerrar(st);
            cerrar(rs);
            cerrar(cn);

        }

        return mail;
    }

    public int verificarAdicionalesproPaquete(int idVenta_Comandaco, String categoria,String sql) {
        conexion mysql = new conexion();
        Connection cn = mysql.Conectar();
        sSQl = "select  "
                + "    count(a.idAdicionales) as total "
                + "from "
                + "    adicionales a, "
                + "    producto p, "
                + "    categoria c "
                + "where "
                + "    a.idProducto = p.idProducto "
                + "        and p.idCategoria = c.idCategoria "
                + "        and a.idVenta_Comandacol = '"+ idVenta_Comandaco +"' "
                + "        and c.idCategoria = '"+categoria+"' "+sql+"";
        int mail = 0;
        try {
            st = cn.prepareStatement(sSQl);
            rs = st.executeQuery();
            rs.next();
            mail = rs.getInt("total");

        } catch (SQLException ex) {
            System.out.println(ex);
        } finally {
            cerrar(st);
            cerrar(rs);
            cerrar(cn);

        }

        return mail;
    }

    public int verificarCategria(String idCategoria,int iddia) {
        conexion mysql = new conexion();
        Connection cn = mysql.Conectar();
        
        sSQl = "SELECT  "
                + "    COUNT(vc.idVenta_Comandacol) AS total "
                + "FROM "
                + "    venta_comanda vc, "
                + "    producto p, "
                + "    comanda c,mesa_venta mv "
                + "WHERE "
                + "    c.idComanda = vc.idComanda and mv.idMesa_venta=c.idMesa_venta"
                + "        AND c.idaltadia = "+iddia+" and c.estado='Activo' and mv.estado!='Cancelado' "
                + "        AND vc.idProducto = p.idProducto "
                + "        AND p.idCategoria = '"+idCategoria+"'";
      //  System.out.println(sSQl);
        int mail = 0;
        try {
            st = cn.prepareStatement(sSQl);
            rs = st.executeQuery();
            rs.next();
            mail = rs.getInt("total");

        } catch (SQLException ex) {
            System.out.println(ex);
        } finally {
            cerrar(st);
            cerrar(rs);
            cerrar(cn);

        }

        return mail;
    }

    public int verificarProducti(String idProducto, String idComanda) {
        conexion mysql = new conexion();
        Connection cn = mysql.Conectar();
        sSQl = "select count(idVenta_Comandacol) as total from venta_comanda  where idComanda='" + idComanda + "' and idProducto='" + idProducto + "'";
        int mail = 0;
        try {
            st = cn.prepareStatement(sSQl);
            rs = st.executeQuery();
            rs.next();
            mail = rs.getInt("total");

        } catch (SQLException ex) {
            System.out.println(ex);
        } finally {
            cerrar(st);
            cerrar(rs);
            cerrar(cn);

        }

        return mail;
    }

    public float reporte(int iddia, String tipo) {
        conexion mysql = new conexion();
        Connection cn = mysql.Conectar();
        ResultSet rsa = null;
        PreparedStatement sta = null;
        if (tipo.equals("v")) {
            sSQl = "select ROUND(sum(vc.costo)) as total from venta_comanda vc,comanda c,mesa_venta mv,empleado e where e.idEmpleado=mv.idEmpleado and mv.idMesa_venta=c.idMesa_venta and c.idComanda=vc.idComanda and c.idaltadia=" + iddia + " and mv.estado!='Cancelado' and c.estado!='Cancelado' and e.idpuesto!=1  and e.idpuesto!=8 ;";
        } else {
            sSQl = "select e.Nombre,e.apellidos,e.Empleadocol,ROUND(sum(vc.costo)) as total from venta_comanda vc,comanda c,mesa_venta mv,empleado e where e.idEmpleado=mv.idEmpleado and mv.idMesa_venta=c.idMesa_venta and c.idComanda=vc.idComanda and c.idaltadia=" + iddia + " and mv.estado!='Cancelado' and c.estado!='Cancelado' and (e.idpuesto=1  or e.idpuesto=8)";
        }

        int mail = 0;
        try {
            sta = cn.prepareStatement(sSQl);
            rsa = sta.executeQuery();
            rsa.next();
            mail = rsa.getInt("total");

        } catch (SQLException ex) {
            System.out.println(ex);
        } finally {
            cerrar(sta);
            cerrar(rsa);
            cerrar(cn);

        }

        return mail;
    }

    public ResultSet ComandaVer(String idCuenta, String idComanda, Connection cn) {

        // public ResultSet ComandaVer(String idCuenta, String idComanda)
        sSQl = "SELECT CONCAT(p.nombre,'// ',p.tamano,' ml') as nombre,count(vc.idProducto) as cantidad,vc.costo as costo,c.observa,c.Autorizacion,vc.Observaciones,vc.idVenta_Comandacol as idventa,c.tipo as tipo,vc.idDescuento,p.idProducto as idProducto FROM mesa_venta mv,comanda c,venta_comanda vc,producto p where mv.idMesa_venta=c.idMesa_venta and c.idComanda=vc.idComanda and vc.idProducto=p.idProducto and c.estado='activo'  and c.idComanda like '%" + idComanda + "%' group by  vc.idProducto,vc.idDescuento,c.observa order by vc.registro DESC";

        int mail = 0;
        try {
            st = cn.prepareStatement(sSQl);
            rs = st.executeQuery();

            /*  while (rs.next()) {
            
             System.out.println(rs.getString("nombre") + " " + rs.getString("cantidad") + " " + rs.getString("costo") + " " + rs.getString("c.observa") + " " + rs.getString("vc.Observaciones") + " " + rs.getString("idventa") + "\n");

             }*/
        } catch (SQLException ex) {
            System.out.println(ex);
        } finally {
            // cerrar(st);
            //cerrar(rs);
            //cerrar(cnx);
        }
        return rs;

    }

    public ResultSet ContarAdicionales(int idVenta_Comandacol, Connection cn) {

        // public ResultSet ComandaVer(String idCuenta, String idComanda)
        sSQl = "SELECT count(a.idAdicionales) as total,p.nombre as nombre FROM  adicionales a,producto p  where a.idProducto=p.idProducto and a.idVenta_Comandacol=" + idVenta_Comandacol + " group by a.idProducto order by p.nombre DESC";
        int mail = 0;
        try {
            st = cn.prepareStatement(sSQl);
            rs = st.executeQuery();

            /*  while (rs.next()) {
            
             System.out.println(rs.getString("nombre") + " " + rs.getString("cantidad") + " " + rs.getString("costo") + " " + rs.getString("c.observa") + " " + rs.getString("vc.Observaciones") + " " + rs.getString("idventa") + "\n");

             }*/
        } catch (SQLException ex) {
            System.out.println(ex);
        } finally {
            // cerrar(st);
            //cerrar(rs);
            //cerrar(cnx);
        }
        return rs;

    }

    private void cerrar(PreparedStatement st) {
        try {
            st.close();
        } catch (SQLException ex) {
            Logger.getLogger(consultasMysq.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    private void cerrar(ResultSet rs) {
        try {
            rs.close();
        } catch (SQLException ex) {
            Logger.getLogger(consultasMysq.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    private void cerrar(Connection cnn) {
        try {
            cnn.close();
        } catch (SQLException ex) {
            Logger.getLogger(consultasMysq.class.getName()).log(Level.SEVERE, null, ex);
        }

    }
}
