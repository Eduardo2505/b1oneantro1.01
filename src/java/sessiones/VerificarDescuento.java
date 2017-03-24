/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package sessiones;

import com.dao.impl.EmpleadoDaoImpl;
import com.mapping.Empleado;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Eduardo
 */
public class VerificarDescuento extends HttpServlet {

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
        String idMesaVenta = request.getParameter("idMesaVenta");
        String idComanda = request.getParameter("idComanda");
        String idDescuento = request.getParameter("idDescuento");
        String tipo = request.getParameter("tipo");
        String observa = request.getParameter("observa");
        String pass = request.getParameter("pass").trim();
        //&observa=\"\"&autorizacion=\"\"
        Empleado em = new Empleado();
        EmpleadoDaoImpl dao = new EmpleadoDaoImpl();
        String autorizacion = "";
        try {
            /* TODO output your page here. You may use following sample code. */

            em = dao.verificarCantras(pass);
            // out.println(em);
            if (em != null) {
                autorizacion = em.getNombre() + "+" + em.getApellidos();
                //out.println("SessionIdMesaComanda?idMesaVenta="+idMesaVenta+"&idComanda="+idComanda+"&tipo="+tipo+"&observa="+observa+"&autorizacion="+autorizacion+"");
                out.println("SessionIdMesaComanda?idMesaVenta=" + idMesaVenta + "&idComanda=" + idComanda + "&tipo=" + tipo + "&observa=" + observa + "&autorizacion=" + autorizacion + "&idDescuento="+idDescuento);

            } else {
                out.println("NO tiene autorizacion");

            }
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
