/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package otrosNOsirve;

import com.dao.impl.AltadiaDaoImpl;
import com.mapping.Altadia;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Eduardo
 */
public class Consultas {

    String mensaje = "", sSQl = "";
    ResultSet rs = null;
    PreparedStatement st = null;
    conexion mysql = new conexion();
    Connection cn = mysql.Conectar();

    public Consultas() {
    }

    public float cantidad(int idDia, String tipo) {
        float total = 0;
        try {
            if (tipo.equals("v")) {
                sSQl = "select sum(mv.totalcuenta) as total from empleado e,mesa_venta mv  where  mv.idEmpleado=e.idEmpleado and mv.idaltadia=" + idDia + " and e.idpuesto!=1  and e.idpuesto!=8 and mv.estado!='Cancelado'";
            } else {

                sSQl = " select sum(mv.totalcuenta) as total from empleado e,mesa_venta mv where  mv.idEmpleado=e.idEmpleado and mv.idaltadia=" + idDia + " and (e.idpuesto=1  or e.idpuesto=8) and mv.estado!='Cancelado'";
            }
            st = cn.prepareStatement(sSQl);
            rs = st.executeQuery();
            rs.next();
            total = rs.getFloat("total");
        } catch (SQLException ex) {
            System.out.println(ex);
        } finally {
            cerrar(st);
            cerrar(rs);
            cerrar(cn);

        }
        return total;

    }

    

    private void cerrar(PreparedStatement st) {
        try {
            st.close();
        } catch (SQLException ex) {
            Logger.getLogger(Consultas.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    private void cerrar(ResultSet rs) {
        try {
            rs.close();
        } catch (SQLException ex) {
            Logger.getLogger(Consultas.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    private void cerrar(Connection cnn) {
        try {
            cnn.close();
        } catch (SQLException ex) {
            Logger.getLogger(Consultas.class.getName()).log(Level.SEVERE, null, ex);
        }



    }

    public static void main(String[] args) {
        consultasMysq con = new consultasMysq();
        AltadiaDaoImpl daoDi = new AltadiaDaoImpl();
        Altadia dia = new Altadia();
        dia = daoDi.bucar();
        int idDia = dia.getIdaltadia();
        float total = con.reporte(idDia, "v");
        float totalc = con.reporte(idDia, "c");
        System.out.println(total);
        System.out.println(totalc);
    }
}
