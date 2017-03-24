/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Task;

import com.dao.impl.AltadiaDaoImpl;
import com.mapping.Altadia;
import java.util.Calendar;
import java.util.TimerTask;
import jdom.Reportexml;
import mail.EmailEnv;
import otrosNOsirve.PromocionesAutomatico;
import otrosNOsirve.consultasMysq;

/**
 *
 * @author hp g4
 */
public class SimpleTimer extends TimerTask {

    float total = 0;
    float totalc = 0;

    @Override
    public void run() {
        doCheck();
    }

    private void doCheck() {



        Calendar now = Calendar.getInstance();
        int MINUTE = Calendar.getInstance().get(Calendar.MINUTE);
        int HOUR = Calendar.getInstance().get(Calendar.HOUR_OF_DAY);
        if (((MINUTE % 15) == 0) || MINUTE == 0 && (HOUR >= 13 && HOUR <= 22)) {
            System.out.println("################## Se realizo la actualización #########################");
            PromocionesAutomatico dao = new PromocionesAutomatico();
            String dia = dao.diasemanal();
            System.out.println("Día: " + dia);
            dao.activarPromocion(dia);
            System.out.println("################## Fin de la actualización #########################");
        }
        if (MINUTE == 0 && ((HOUR >= 18 && HOUR <= 24) || HOUR <= 4)) {



            AltadiaDaoImpl daoDi = new AltadiaDaoImpl();
            Altadia dia = new Altadia();
            dia = daoDi.bucar();
            Reportexml d = new Reportexml();
            if (dia != null) {
                int idDia = dia.getIdaltadia();
                consultasMysq con = new consultasMysq();
                float total = con.reporte(idDia, "v");
                consultasMysq cona = new consultasMysq();
                float totalc = cona.reporte(idDia, "c");
                int aforo = 0;// d.buscarenXml("aforo", direccion);
                int totalcosto = 0;// d.buscarenXml("dinero", direccion);
                EmailEnv e = new EmailEnv();
                //  e.enviar("alex131974@live.com", total, totalcosto, aforo, totalc);

                e.enviar("conwereduardopc@hotmail.com", "carlosramosbar@hotmail.com", "israel.ampudia@hotmail.com", "alex131974@live.com", "beta_rga@hotmail.com", total, totalcosto, aforo, totalc);


            }
        }



        System.out.println("Minuto " + MINUTE + " Hora: " + HOUR);

    }
}
