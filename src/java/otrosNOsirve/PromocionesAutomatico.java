/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package otrosNOsirve;

import com.dao.impl.CategoriaDaoImpl;
import com.mapping.Categoria;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

/**
 *
 * @author Eduardo
 */
public class PromocionesAutomatico {

    public void activarPromocion(String Dia) {
        CategoriaDaoImpl dao = new CategoriaDaoImpl();

        int va = dao.buscar("Z-" + Dia);
      //  System.out.println("Z-" + Dia);

        if (va == 1) {
            Categoria c = new Categoria();
            List res = dao.getFiltro("where descripcion='Auto'");
            Iterator itr = res.iterator();
            while (itr.hasNext()) {
                Categoria p = (Categoria) itr.next();
                dao.actulizar(p.getIdCategoria(), "0");
                //  System.out.println(p.getNombre());
            }

            dao.actulizar("Z-" + Dia, "1");
        }

    }

    public String diasemanal() {

        String[] dias = {"DOMINGO", "LUNES", "MARTES", "MIERCOLES", "JUEVES", "VIERNES", "SABADO"};
        Date hoy = new Date();
        int numeroDia = 0;
        Calendar cal = Calendar.getInstance();
        cal.setTime(hoy);
        numeroDia = cal.get(Calendar.DAY_OF_WEEK);
        return dias[numeroDia - 1];

    }

    public static void main(String[] args) {

        PromocionesAutomatico dao = new PromocionesAutomatico();
        String dia = dao.diasemanal();
        dao.activarPromocion(dia);
    }
}
