/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package jdom;

import java.io.FileWriter;
import org.jdom.output.Format;
import org.jdom.output.XMLOutputter;
import java.io.IOException;
import java.util.List;
import org.jdom.Document;			// |
import org.jdom.Element;			// |\ Librerias
import org.jdom.JDOMException;		// |/ JDOM
import org.jdom.input.SAXBuilder;	// |
import java.io.File;
import org.jdom.Namespace;

/**
 *
 * @author Eduardo
 */
public class jdom {

    public jdom() {
    }

    public int buscar(String archivo, String producto) {
        SAXBuilder builder = new SAXBuilder();
        File xmlFile = new File(archivo);
        int valor = 0;
        try {

            Document document = (Document) builder.build(xmlFile);
            Element rootNode = document.getRootElement();
            List list = rootNode.getChildren("producto");

            String nombreTabla = rootNode.getAttributeValue("id");



            for (int i = 0; i < list.size(); i++) {

                Element node = (Element) list.get(i);



                if (node.getChildText(producto) != null) {
                    valor = Integer.parseInt(node.getChildText(producto));
                }



            }

        } catch (IOException io) {
            //System.out.println(io.getMessage()+"unoxxxxx");
        } catch (JDOMException jdomex) {
            //System.out.println(jdomex.getMessage()+"unoxxxxx333333");
        }
        // System.out.println(valor);
        return valor;
    }

    public void crear(String archivo, String id, String nombre, String nodo) {
        try {

            Element company = new Element("company");
            Document doc = new Document(company);
            doc.setRootElement(company);

            Element staff = new Element(nodo);

            staff.addContent(new Element("id").setText(id));
            staff.addContent(new Element("nombre").setText(nombre));


            doc.getRootElement().addContent(staff);



            // new XMLOutputter().output(doc, System.out);
            XMLOutputter xmlOutput = new XMLOutputter();

            // display nice nice
            xmlOutput.setFormat(Format.getPrettyFormat());
            xmlOutput.output(doc, new FileWriter(archivo));

            System.out.println("File Saved!");
        } catch (IOException io) {
            System.out.println(io.getMessage());
        }

    }

    public void editar(String archivo, String id, String nombre, String nodo) {
        try {

            SAXBuilder builder = new SAXBuilder();
            File xmlFile = new File(archivo);

            Document doc = (Document) builder.build(xmlFile);

            //
            Element rootNode = doc.getRootElement();
            Element user = new Element(nodo).setAttribute("id",id);
            rootNode.addContent(user);
            Element age = new Element("id").setText(id);
            Element agen = new Element("nombre").setText(nombre);
            user.addContent(age);
            user.addContent(agen);
           

            XMLOutputter xmlOutput = new XMLOutputter();

            // display nice nice
            xmlOutput.setFormat(Format.getPrettyFormat());
            xmlOutput.output(doc, new FileWriter(archivo));

            // xmlOutput.output(doc, System.out);

            System.out.println("File updated!");
        } catch (IOException io) {
            io.printStackTrace();
        } catch (JDOMException e) {
            e.printStackTrace();
        }
    }

    public String remove1(String input) {
        // Cadena de caracteres original a sustituir.
        String original = "áàäéèëíìïóòöúùuñÁÀÄÉÈËÍÌÏÓÒÖÚÙÜÑçÇ/*'&";
        // Cadena de caracteres ASCII que reemplazarán los originales.
        String ascii = "aaaeeeiiiooouuunAAAEEEIIIOOOUUUNcC____";
        String output = input;
        for (int i = 0; i < original.length(); i++) {
            // Reemplazamos los caracteres especiales.
            output = output.replace(original.charAt(i), ascii.charAt(i));
        }//for i
        return output;
    }//remove1

    public String Buscar(String archivo, String estadox, String nodo) {

        String estado = "";
        SAXBuilder builder = new SAXBuilder();
        File xmlFile = new File(archivo);

        try {

            Document document = (Document) builder.build(xmlFile);
            Element rootNode = document.getRootElement();
            List list = rootNode.getChildren(nodo);
            for (int i = 0; i < list.size(); i++) {

                Element node = (Element) list.get(i);
                estado = node.getChildText(estadox);

            }

        } catch (IOException io) {
            //System.out.println(io.getMessage()+"unoxxxxx");
        } catch (JDOMException jdomex) {
            //System.out.println(jdomex.getMessage()+"unoxxxxx333333");
        }
        // System.out.println(valor);

        return estado;
    }

    public List mostrarPro(String archivo, String estadox) {
        SAXBuilder builder = new SAXBuilder();
        File xmlFile = new File(archivo);
        List list = null;
        try {

            Document document = (Document) builder.build(xmlFile);
            Element rootNode = document.getRootElement();
            list = rootNode.getChildren(estadox);



        } catch (IOException io) {
            System.out.println(io.getMessage());
        } catch (JDOMException jdomex) {
            System.out.println(jdomex.getMessage());
        }
        return list;

    }

    
}
