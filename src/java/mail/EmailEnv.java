/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package mail;

import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Properties;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class EmailEnv {

    public static final String emailAuth = "conwereduardopc@gmail.com";
    public static final String passwordAuth = "Eduardo25%";

    public EmailEnv() {
    }

    public void enviar(String destinatario, String destinatario1, String destinatario2, String destinatario3, String destinatario4, double venta, double cover, int aforo, double cortesia) {
        try {

            Properties props = new Properties();//variable de propiedades, se usará el protocolo smtp
            //smpt: protocolo de transferencia de correo simple
            props.setProperty("mail.smtp.host", "smtp.gmail.com");//establece el host al que se conectara
            props.setProperty("mail.smtp.starttls.enable", "true");//habilitación y uso del protocolo TLS Transport Layer Security            
            props.setProperty("mail.smtp.port", "587");//uso del puerto 587, como nuevo puerto en lugar del 25
            props.setProperty("mail.smtp.user", "SIMTSA");//usuario
            props.setProperty("mail.smtp.auth", "true");//uso de usuario y password para conectarse


            Session session = Session.getDefaultInstance(props);//creacion de sesion
            session.setDebug(true);//muestra informacion de la sesion

            MimeMessage message = new MimeMessage(session);//creacion de mensaje
            message.setFrom(new InternetAddress(destinatario));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(destinatario));
            message.setFrom(new InternetAddress(destinatario1));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(destinatario1));
            message.setFrom(new InternetAddress(destinatario2));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(destinatario2));
            message.setFrom(new InternetAddress(destinatario3));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(destinatario3));
            message.setFrom(new InternetAddress(destinatario4));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(destinatario4));

            message.setSubject("REPORTE B1ONE");
            NumberFormat nf = NumberFormat.getInstance();
            nf.setMaximumFractionDigits(2);
            double to = venta + cover;
            double cp = to / aforo;
            double cpv = venta / aforo;
            String ste = nf.format(cp);
            String fcpv = nf.format(cpv);
            String body = "<table>\n"
                    + "            <tr><td colspan=\"2\"><h2>REPORTE B1ONE</h2></td></tr>\n"
                    + "            <tr><td><H5>Venta:</h5></td><td><H5>$ " + venta + "</h5></td></tr>\n"
                    + "            <tr><td><H5>Cover:</h3></td><td><H5>$ " + cover + "</h5></td></tr>\n"
                    + "            <tr><td><H4>TOTAL:</h4></td><td><H4>$ " + to + "</h4></td></tr>\n"
                    + "            <tr><td><H5>Aforo:</h5></td><td><H5>" + aforo + " prs.</h5></td></tr>\n"
                    + "            <tr><td><H3>Cheque <br>Promedio<br>con Cover:</h3></td><td><H3>$ " + ste + "</h3></td></tr>\n"
                    + "            <tr><td><H3>Cheque <br>Promedio<br>Venta:</h3></td><td><H3>$ " + fcpv + "</h3></td></tr>\n"
                    + "            <tr><td><H5>Cortesías:</h5></td><td><H5>$ " + cortesia + "</h5></td></tr>\n"
                    + "        </table>";
            //   String body = "<h2>" + Subjeto + "</h2>" + "<h3>" + hora + "</h3>" + "<h3>Venta $" + v + "</h3><h3>Cortesía $" + c + "</h3>";



            message.setContent(body,
                    "text/html");


            Transport t = session.getTransport("smtp");//variable de transporte con el protocolo smtp
            t.connect(emailAuth,passwordAuth);//usuario y contraseña
            t.sendMessage(message, message.getAllRecipients());
            t.close();

        } catch (Exception ex) {
            ex.printStackTrace();
        }



    }

    public void enviar(String destinatario, double venta, double cover, int aforo, double cortesia) {
        try {

            Properties props = new Properties();//variable de propiedades, se usará el protocolo smtp
            //smpt: protocolo de transferencia de correo simple
            props.setProperty("mail.smtp.host", "smtp.gmail.com");//establece el host al que se conectara
            props.setProperty("mail.smtp.starttls.enable", "true");//habilitación y uso del protocolo TLS Transport Layer Security            
            props.setProperty("mail.smtp.port", "587");//uso del puerto 587, como nuevo puerto en lugar del 25
            props.setProperty("mail.smtp.user", "SIMTSA");//usuario
            props.setProperty("mail.smtp.auth", "true");//uso de usuario y password para conectarse


            Session session = Session.getDefaultInstance(props);//creacion de sesion
            session.setDebug(true);//muestra informacion de la sesion

            MimeMessage message = new MimeMessage(session);//creacion de mensaje
            message.setFrom(new InternetAddress(destinatario));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(destinatario));
            message.setSubject("REPORTE RESTOBAR");
            NumberFormat nf = NumberFormat.getInstance();
            nf.setMaximumFractionDigits(2);
            double to = venta + cover;
            double cp = to / aforo;
            double cpv = venta / aforo;
            String ste = nf.format(cp);
            String fcpv = nf.format(cpv);
            String body = "<table>\n"
                    + "            <tr><td colspan=\"2\"><h2>REPORTE BY1ONE</h2></td></tr>\n"
                    + "            <tr><td><H5>Venta:</h5></td><td><H5>$ " + venta + "</h5></td></tr>\n"
                    + "            <tr><td><H5>Cover:</h3></td><td><H5>$ " + cover + "</h5></td></tr>\n"
                    + "            <tr><td><H4>TOTAL:</h4></td><td><H4>$ " + to + "</h4></td></tr>\n"
                    + "            <tr><td><H5>Aforo:</h5></td><td><H5>" + aforo + " prs.</h5></td></tr>\n"
                    + "            <tr><td><H3>Cheque <br>Promedio<br>con Cover:</h3></td><td><H3>$ " + ste + "</h3></td></tr>\n"
                    + "            <tr><td><H3>Cheque <br>Promedio<br>Venta:</h3></td><td><H3>$ " + fcpv + "</h3></td></tr>\n"
                    + "            <tr><td><H5>Cortesías:</h5></td><td><H5>$ " + cortesia + "</h5></td></tr>\n"
                    + "        </table>";
          


            message.setContent(body,
                    "text/html");


            Transport t = session.getTransport("smtp");//variable de transporte con el protocolo smtp
            t.connect("essy.reportes@gmail.com", "servidor25#");
            t.sendMessage(message, message.getAllRecipients());
            t.close();

        } catch (Exception ex) {
            ex.printStackTrace();
        }



    }

    public void enviarErrores(String destinatario, String destinatario2, String msg) {
        try {
            Date ahora = new Date();
            SimpleDateFormat dateFormat = new SimpleDateFormat("HH:mm:ss");
            SimpleDateFormat dateFormatf = new SimpleDateFormat("yyyy-MM-dd");
            String fechaAc = dateFormatf.format(ahora);
            String horaAc = dateFormat.format(ahora);
            String hora = fechaAc + " " + horaAc;
            Properties props = new Properties();//variable de propiedades, se usará el protocolo smtp
            //smpt: protocolo de transferencia de correo simple
            props.setProperty("mail.smtp.host", "smtp.gmail.com");//establece el host al que se conectara
            props.setProperty("mail.smtp.starttls.enable", "true");//habilitación y uso del protocolo TLS Transport Layer Security            
            props.setProperty("mail.smtp.port", "587");//uso del puerto 587, como nuevo puerto en lugar del 25
            props.setProperty("mail.smtp.user", "SIMTSA");//usuario
            props.setProperty("mail.smtp.auth", "true");//uso de usuario y password para conectarse


            Session session = Session.getDefaultInstance(props);//creacion de sesion
            session.setDebug(true);//muestra informacion de la sesion

            MimeMessage message = new MimeMessage(session);//creacion de mensaje
            message.setFrom(new InternetAddress(destinatario));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(destinatario));
            message.setFrom(new InternetAddress(destinatario2));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(destinatario2));
            message.setSubject("Error sitema");
            String body = "<h2>Error sistema</h2>" + "<h3>Hora:" + hora + "</h3>" + "<h3>" + msg + "</h3>";



            message.setContent(body,
                    "text/html");


            Transport t = session.getTransport("smtp");//variable de transporte con el protocolo smtp
            t.connect(emailAuth,passwordAuth);//usuario y contraseña
            t.sendMessage(message, message.getAllRecipients());
            t.close();

        } catch (Exception ex) {
            ex.printStackTrace();
        }



    }
}
