/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.reportes;

import com.dao.impl.AltadiaDaoImpl;
import com.mapping.Altadia;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import jdom.Reportexml;
import mail.EmailEnv;
import otrosNOsirve.consultasMysq;

/**
 *
 * @author Eduardo
 */
public class ReporteEmail extends HttpServlet {

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
        try {
            AltadiaDaoImpl daoDi = new AltadiaDaoImpl();
            Altadia dia = new Altadia();
            dia = daoDi.bucar();
         //   Reportexml d = new Reportexml();
            if (dia != null) {
                int idDia = dia.getIdaltadia();
                consultasMysq con = new consultasMysq();
                float total = con.reporte(idDia, "v");
                consultasMysq cona = new consultasMysq();
                float totalc = cona.reporte(idDia, "c");
                // System.out.println(idDia);
                // String direccion = "C:\\Users\\Eduardo\\Desktop\\Reporte.xml";
              //  String direccion = "C:\\Users\\Cover\\Documents\\Reporte.xml";
              //  d.descargar(direccion);
                int aforo =0;// d.buscarenXml("aforo", direccion);
                int totalcosto = 0;//d.buscarenXml("dinero", direccion);
                EmailEnv e = new EmailEnv();
                e.enviar("conwereduardopc@hotmail.com", total, totalcosto, aforo, totalc);
               //e.enviar("conwereduardopc@hotmail.com", "carlosramosbar@hotmail.com", "israel.ampudia@hotmail.com", "mario.olivares@hotmail.com", "beta_rga@hotmail.com", total, totalcosto, aforo, totalc);



            }
            /* TODO output your page here. You may use following sample code. */
            out.println("SE ENVIO CORRECTAMENTE EL REPORTE");

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
