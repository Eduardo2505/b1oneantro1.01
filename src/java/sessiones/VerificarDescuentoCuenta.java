/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package sessiones;

import beans.Comandaventabean;
import com.dao.impl.CuentaDaoImpl;
import com.dao.impl.DescuentoDaoImpl;
import com.dao.impl.EmpleadoDaoImpl;
import com.dao.impl.Mesa_ventaDaoImpl;
import com.dao.impl.VentaComandaDaoImpl;
import com.mapping.Descuento;
import com.mapping.Empleado;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Eduardo
 */
public class VerificarDescuentoCuenta extends HttpServlet {

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
        String idMesaVenta = request.getParameter("idMesaVenta").trim();
        String pass = request.getParameter("pass").trim();
        String idDescuento = request.getParameter("idDescuento").trim();
        String observa = request.getParameter("observa").trim();

        Empleado em = new Empleado();
        DescuentoDaoImpl des = new DescuentoDaoImpl();
        Descuento d = new Descuento();
        d = des.Buscarid(idDescuento);
        EmpleadoDaoImpl dao = new EmpleadoDaoImpl();
        String autorizacion = "";
        try {
            /* TODO output your page here. You may use following sample code. */

            em = dao.verificarCantras(pass);

            if (em != null) {
                autorizacion = em.getNombre() + " " + em.getApellidos();
                Mesa_ventaDaoImpl daod = new Mesa_ventaDaoImpl();
                daod.actualizaDescuento(idMesaVenta, autorizacion, observa, idDescuento);
                CuentaDaoImpl daox = new CuentaDaoImpl();

                List resa = daox.getUpdateDescuento(idMesaVenta);
                Iterator itra = resa.iterator();
                VentaComandaDaoImpl vcvf = new VentaComandaDaoImpl();
                while (itra.hasNext()) {
                    Comandaventabean a = (Comandaventabean) itra.next();
                    double co = a.getCosto() * ((100 - d.getPorcentaje()) / 100);
                    double ct = a.getCosto() - co;
                    float c = (float) ct;
                    vcvf.actualizaDes(a.getIdventa(), idDescuento, d.getObservaciones(), c);
                }
                // out.println(idMesaVenta +autorizacion + observa);
                //out.println("SessionIdMesaComanda?idMesaVenta="+idMesaVenta+"&idComanda="+idComanda+"&tipo="+tipo+"&observa="+observa+"&autorizacion="+autorizacion+"");
                out.println("ComadaCerradaDescuento.jsp");

            } else {
                // out.println("NO tiene autorizacion");
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
