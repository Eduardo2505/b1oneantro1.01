/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.adicionales.xml;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import jdom.jdom;
import otrosNOsirve.conexion;

/**
 *
 * @author Eduardo
 */
public class Crearadicionales {

    public static void main(String[] args) {

        conexion mysql = new conexion();
        Connection cn = mysql.Conectar();
        String sSQl;
        String resp = "";

         sSQl = "SELECT * FROM producto where importacion=\"itacate\" and tipoEvento=\"Nocturno\"";
       // sSQl = "SELECT * FROM producto where idCategoria ='2X1' and opcion='adicional'";

        try {

            Statement st = cn.createStatement();
            ResultSet rset;
            rset = st.executeQuery(sSQl);

            while (rset.next()) {



                //eliminar(rset.getInt(1));
                System.out.println(rset.getString(1));
               copiar("C:\\Users\\Eduardopc\\Desktop\\itacate.xml","C:\\Users\\Eduardopc\\Desktop\\xml\\"+rset.getString(1)+".xml");
               // jdom dao = new jdom();
               // dao.editar("C:\\Users\\Eduardo\\Desktop\\064258193.xml", rset.getString(1), rset.getString(2), "botella");



            }


            st.close();
            rset.close();
            cn.close();

        } catch (SQLException ex) {
            System.out.println(ex);
        }


    }

    static void copiar(String sourceFile, String destinationFile) {


        try {
            File inFile = new File(sourceFile);
            File outFile = new File(destinationFile);

            FileInputStream in = new FileInputStream(inFile);
            FileOutputStream out = new FileOutputStream(outFile);

            int c;
            while ((c = in.read()) != -1) {
                out.write(c);
            }

            in.close();
            out.close();
        } catch (IOException e) {
            System.err.println("Hubo un error de entrada/salida!!!");
        }

    }
}
