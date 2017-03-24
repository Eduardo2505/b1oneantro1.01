/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package sessiones;

import com.dao.impl.AltadiaDaoImpl;
import com.mapping.Altadia;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Eduardopc
 */
public class SessionBarra extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String idBarra = request.getParameter("idbarra");
        HttpSession sesion = request.getSession();

        try {
            Thread.sleep(500);
            AltadiaDaoImpl daoDi = new AltadiaDaoImpl();
            Altadia dia = new Altadia();
            dia = daoDi.bucar();
            try {               
                sesion.setAttribute("idDia", dia);              
                System.out.println(dia.getEstado());
                sesion.setAttribute("idBarra", idBarra);
            } catch (Exception e) {
                out.print("<div class='ui-widget'>");
                out.print("<div class='ui-state-error ui-corner-all' style='padding: 0 .7em;'>");
                out.print("<p><span class='ui-icon ui-icon-alert' style='float: left; margin-right: .3em;'></span> <strong>Error:</strong> "
                        + "<br>NINGUN DIA ACTIVO Ó DOS O MÁS DIAS ESTAN ACTIVOS COMPRUEBE!</p>");
                out.print("</div>");
            }


        } catch (InterruptedException ex) {
            Logger.getLogger(SessionBarra.class.getName()).log(Level.SEVERE, null, ex);
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
