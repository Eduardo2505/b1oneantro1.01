/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package jdom;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import org.jdom.JDOMException;		// |/ JDOM
import org.jdom.input.SAXBuilder;	// |
import java.util.logging.Level;
import java.util.logging.Logger;
import java.net.URL;
import java.net.URLConnection;
import org.jdom.Document;
import org.jdom.Element;

/**
 *
 * @author Eduardo
 */
public class Reportexml {

    public Reportexml() {
    }

    public int buscarenXml(String valor, String direccion) {
        int res = 0;
        try {

            SAXBuilder builder = new SAXBuilder();
         //   File xmlFile = new File(direccion);
            File xmlFile = new File("C:\\Users\\Eduardo\\Desktop\\064258193.xml");
            Document document = (Document) builder.build(xmlFile);
            Element rootNode = document.getRootElement();
            List list = rootNode.getChildren("altadia");

            String nombreTabla = rootNode.getAttributeValue("id");



            for (int i = 0; i < list.size(); i++) {

                Element node = (Element) list.get(i);

                //  System.out.println("Aforo : " + node.getChildText("aforo"));
                //  System.out.println("Cantidad : " + node.getChildText("dinero"));
                res = Integer.parseInt(node.getChildText(valor));


            }

        } catch (IOException io) {
            System.out.println(io.getMessage());
        } catch (JDOMException ex) {
            Logger.getLogger(Reportexml.class.getName()).log(Level.SEVERE, null, ex);
        }
        return res;
    }

    public void descargar(String direccion) {
        try {
            // Url con la foto
            URL url = new URL(
                    "http://dfiestadf.com/CoverBy/Reporte.xml");

            // establecemos conexion
            URLConnection urlCon = url.openConnection();

            // Sacamos por pantalla el tipo de fichero
            System.out.println(urlCon.getContentType());

            // Se obtiene el inputStream de la foto web y se abre el fichero
            // local.
            InputStream is = urlCon.getInputStream();
            String path = new java.io.File(".").getAbsolutePath();
            // String curDir = System.getProperty("user.dir");
            //String rutaRelativaApp= System.getProperty("user.dir") + System.getProperty("file.separator");

            //FileOutputStream fos = new FileOutputStream(path + "/Reporte.xml");
            //System.out.println(rutaRelativaApp);
            //      FileOutputStream fos = new FileOutputStream("C:\\Users\\Eduardo\\Desktop\\Reporte.xml");
            FileOutputStream fos = new FileOutputStream(direccion);

            // Lectura de la foto de la web y escritura en fichero local
            byte[] array = new byte[1000]; // buffer temporal de lectura.
            int leido = is.read(array);
            while (leido > 0) {
                fos.write(array, 0, leido);
                leido = is.read(array);
            }

            // cierre de conexion y fichero.
            is.close();
            fos.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    public static void main(String[] args) {
        Reportexml d = new Reportexml();
        //d.crear();
        // d.editar();
        //d.descargar();
        //  d.cargarXml();
        //String filePath = request.getSession().getServletContext().getRealPath("/");

    }
}
