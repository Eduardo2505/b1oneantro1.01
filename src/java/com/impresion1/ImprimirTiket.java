/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.impresion1;

import beans.Adicionalesbean;
import beans.Comandaventabean;
import com.dao.impl.AdicionalesComprobarDaoImpl;
import com.dao.impl.AdicionalesDaoImpl;
import com.dao.impl.CuentaDaoImpl;
import com.dao.impl.Mesa_ventaDaoImpl;
import com.mapping.Descuento;
import com.mapping.Empleado;
import com.mapping.MesaVenta;
import com.mapping.Mesas;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 */
public class ImprimirTiket extends HttpServlet {

    /**
     * Processes requests for both HTTP
     * <code>GET</code> and
     * <code>POST</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        HttpSession sesion = request.getSession();

        String nombre = "", nomMesero = "", tipoEvento = "";

        String idMesero = "", idMesa = "", idComandaTras = "", op = "";
        int idDia = 0;

        double total = 0, sub = 0, iva = 0;

        Date ahora = new Date();
        String espacio = " ";
        SimpleDateFormat dateFormat = new SimpleDateFormat("HH:mm:ss");
        SimpleDateFormat dateFormatf = new SimpleDateFormat("yyyy-MM-dd");
        String fechaAc = dateFormatf.format(ahora);
        String horaAc = dateFormat.format(ahora);
        Mesa_ventaDaoImpl mv = new Mesa_ventaDaoImpl();
        MesaVenta mvv = new MesaVenta();
        String clave = "";
        Mesas msa = new Mesas();
        float sumatotal = 0;


        Empleado em = new Empleado();
        //idComanda = (String) sesion.getAttribute("idComanda");
        idMesa = (String) sesion.getAttribute("idMesa");
        em = (Empleado) sesion.getAttribute("idMesero");
        nomMesero = em.getNombre() + " " + em.getApellidos();
        mvv = mv.bucarPorId(idMesa);
        msa = mvv.getMesas();
        String mesaCuenta = mvv.getIdMesaCapturada();
        clave = em.getEmpleadocol();


        try {
            AdicionalesDaoImpl daoas = new AdicionalesDaoImpl();
            String Supervisor = (String) sesion.getAttribute("Supervisor");

            String tipo = request.getParameter("imp");
            if (tipo.equals("d")) {
                mv.cerrardescuento(idMesa, "Cerrado", fechaAc + " " + horaAc, Supervisor);
            } else {
                mv.cerrar(idMesa, "Cerrado", fechaAc + " " + horaAc, Supervisor);
            }



            StringBuffer resultado = new StringBuffer("");


            float sumita = 0, sumitax = 0;
            CuentaDaoImpl dac = new CuentaDaoImpl();
            List resa = dac.getmostrar(idMesa, "adicional");
            Iterator itra = resa.iterator();
            while (itra.hasNext()) {
                Comandaventabean a = (Comandaventabean) itra.next();
                sumita += a.getTotalcosto();
                resultado.append(a.getProducto() + " " + a.getMedida() + "\n" + a.getCantidad() + "pz ----> $ " + a.getTotalcosto() + "\n");

                AdicionalesComprobarDaoImpl daoEm = new AdicionalesComprobarDaoImpl();
                List res = daoEm.getAdicionales(a.getIdventa());
                Iterator itr = res.iterator();
                int verMesesa = 0;
                while (itr.hasNext()) {
                    Adicionalesbean vcx = (Adicionalesbean) itr.next();
                    resultado.append("_____(" + vcx.getProducto() + " " + vcx.getMedida() + "-> " + vcx.getCantidad() + " pz)\n\n");


                }
                if (a.getTipo().equals("cortesia")) {
                    resultado.append(" --- *(Autorización -> " + a.getAutorizacion() + ")\n\n");
                    resultado.append(" --- *(Observaciones -> " + a.getObservaciones() + ")\n\n");

                }
            }
            List resax = dac.getmostrar(idMesa, "np");
            Iterator itrax = resax.iterator();
            while (itrax.hasNext()) {
                Comandaventabean a = (Comandaventabean) itrax.next();
                sumitax += a.getTotalcosto();
                resultado.append(a.getProducto() + " " + a.getMedida() + "\n" + a.getCantidad() + "pz ----> $ " + a.getTotalcosto() + "\n");

                if (a.getTipo().equals("cortesia")) {
                    resultado.append(" --- *(Autorización -> " + a.getAutorizacion() + ")\n\n");
                    resultado.append(" --- *(Observaciones -> " + a.getObservaciones() + ")\n\n");
                }

            }
            if (!mvv.getObservaciones().equals("-")) {
                resultado.append("\n\n Descuento \n\n");
                resultado.append("Autorización : \n");
                resultado.append(mvv.getAtorizacion() + "\n");
                resultado.append("Observaciones : \n");
                resultado.append(mvv.getObservaciones() + "\n");
                resultado.append("Descuento: \n");
                Descuento des = new Descuento();
                des = mvv.getDescuento();
                if (des != null) {
                    resultado.append(des.getObservaciones() + "\n\n");
                }

            }
            DecimalFormat df = new DecimalFormat("0.##");
            sumatotal = sumitax + sumita;

            //mv.actualiza(idMesa, Float.parseFloat(nf.format(sumatotal)));


            total = sumatotal * (.16);
            sub = sumatotal / 1.16;
            iva = sub * (.16);
            String ste = df.format(iva);
            String subto = df.format(sub);

            TiketImprimir dao = new TiketImprimir();
            //System.out.println(msa.getPosiscion()+"\n"+mvv.getPersonasAprox());
            String tike = dao.Imprimirtiket(nomMesero.toUpperCase(), clave, msa.getPosiscion(), mesaCuenta + "\n#" + idMesa, mvv.getPersonasAprox(), fechaAc, horaAc, subto, ste, Float.parseFloat(df.format(sumatotal)), resultado.toString());
            // System.out.println(tike);
            out.println(tike);

        } finally {
            out.close();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP
     * <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP
     * <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
