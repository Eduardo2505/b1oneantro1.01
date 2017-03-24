/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package almacen;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Eduardopc
 */
public class ExistenciasController {

    ConexionAl mysql = new ConexionAl();
    Connection cn = mysql.Conectar();
    ResultSet rs = null;
    PreparedStatement st = null;
    String sSQl = "";

    public ExistenciasController() {
    }

    public int checar(String idProducto) {
        int total=0;
        sSQl = "select ((entradas-salidas)+devoluciones) from Existencias where idProductos ='"+idProducto+"' ";
   
        try {
            st = cn.prepareStatement(sSQl);
            rs = st.executeQuery();
            rs.next();
            total = rs.getInt(1);

        } catch (SQLException ex) {
            System.out.println(ex);
        } finally {
            cerrar(st);
            cerrar(rs);
            cerrar(cn);

        }
        
        
        return total;
        
    }
    public static void main(String[] args) {
        ExistenciasController dao=new ExistenciasController();
        int ver=dao.checar("150");
        System.out.println(ver);
    }

    private void cerrar(PreparedStatement ps) {
        try {
            ps.close();
        } catch (SQLException ex) {
        }

    }

    private void cerrar(ResultSet rs) {
        try {
            rs.close();
        } catch (SQLException ex) {
        }

    }

    private void cerrar(Connection cnn) {
        try {
            cnn.close();
        } catch (SQLException ex) {
        }

    }
}
