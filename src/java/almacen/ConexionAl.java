/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package almacen;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import otrosNOsirve.conexion;

/**
 *
 * @author Eduardopc
 */
public class ConexionAl {
    public String db = "dfiestad_almacen";
   
    public String url = "jdbc:mysql://localhost/" + db;
    public String user = "root";
    public String pass = "seiter";

    public void conexion() {
    }

    public Connection Conectar() {
        Connection link = null;
        try {
            //Cargamos el Drivers Mysql

            Class.forName("org.gjt.mm.mysql.Driver");
            link = DriverManager.getConnection(url, user, pass);


        } catch (ClassNotFoundException ex) {
            Logger.getLogger(conexion.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException e) {
        }
        return link;
    }
}
