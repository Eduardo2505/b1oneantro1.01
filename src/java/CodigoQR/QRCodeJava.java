/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package CodigoQR;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import net.glxn.qrgen.QRCode;
import net.glxn.qrgen.image.ImageType;

/**
 *
 * @author Eduardo
 */
public class QRCodeJava {

    public QRCodeJava() {
    }

    public void generarQR(String urlNombre,String Codificacion) {
        ByteArrayOutputStream out = QRCode.from(Codificacion)
                .to(ImageType.PNG).stream();

        try {
            FileOutputStream fout = new FileOutputStream(new File(
                    urlNombre));

            fout.write(out.toByteArray());

            fout.flush();
            fout.close();

        } catch (FileNotFoundException e) {
            // Do Logging
            e.printStackTrace();
        } catch (IOException e) {
            // Do Logging
            e.printStackTrace();
        }

    }
    public static void main(String[] args) {
        QRCodeJava d=new QRCodeJava();
        String url="c://imgQR/ejemplo.png";
        d.generarQR(url, "www.brava.mx");
    }

    
}
