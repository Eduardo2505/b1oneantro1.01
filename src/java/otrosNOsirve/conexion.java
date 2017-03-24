/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package otrosNOsirve;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Eduardopc
 */
public class conexion {
    
    public String db = "restobarpv01";
   
    public String url = "jdbc:mysql://104.154.213.93:3306/" + db;
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
