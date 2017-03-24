/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.impresion1;

import java.io.IOException;
import javax.print.Doc;
import javax.print.DocFlavor;
import javax.print.DocPrintJob;
import javax.print.PrintException;
import javax.print.PrintService;
import javax.print.PrintServiceLookup;
import javax.print.SimpleDoc;

/**
 *
 * @author Eduardo
 */
public class Ticket {

    public Ticket() {
    }
    private String contentTicket = "{{nameLocal}}\n\n ";
//El constructor que setea los valores a la instancia

    public Ticket(String nameLocal) {

        this.contentTicket = this.contentTicket.replace("{{nameLocal}}", nameLocal);

    }

    

    public void print() throws IOException {

        PrintService[] services = PrintServiceLookup.lookupPrintServices(null, null); //nos da el array de los servicios de impresion


        byte[] bytes = this.contentTicket.getBytes();

//Especificamos el tipo de dato a imprimir
//Tipo: bytes; Subtipo: autodetectado
        DocFlavor flavor = DocFlavor.BYTE_ARRAY.AUTOSENSE;

        Doc doc = new SimpleDoc(bytes, flavor, null);



//Creamos un trabajo de impresión
        DocPrintJob job = null;
        if (services.length > 0) {
            for (int i = 0; i < services.length; i++) {
                if (services[i].getName().equals("PDFCreatorLalo")) {//aqui escribimos/elegimos la impresora por la que queremos imprimir
                    job = services[i].createPrintJob();// System.out.println(i+": "+services[i].getName());
                }
            }
        }

//Imprimimos dentro de un try obligatoriamente
        try {
            job.print(doc, null);
        } catch (PrintException ex) {
            System.out.println(ex);
        }

    }
}
