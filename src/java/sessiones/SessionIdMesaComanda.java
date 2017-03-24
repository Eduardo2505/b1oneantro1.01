/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package sessiones;

import com.dao.impl.ComandaDaoImpl;
import com.mapping.Altadia;
import com.mapping.Comanda;
import com.mapping.Empleado;
import com.mapping.MesaVenta;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
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
public class SessionIdMesaComanda extends HttpServlet {

    Altadia d = new Altadia();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String idDescuento = "Ninguno";
      
        String idMesa = request.getParameter("idMesaVenta");
        String nombremesa = request.getParameter("nombremesa");
        
        String idComanda = request.getParameter("idComanda").trim().toUpperCase();
        String tipo = request.getParameter("tipo").trim();
        if (tipo.equals("descuento")) {
            idDescuento = request.getParameter("idDescuento");

        }
        String observa = request.getParameter("observa").trim();
        String autorizacion = request.getParameter("autorizacion").trim();
        HttpSession sesion = request.getSession();
        Empleado em = new Empleado();
        em = (Empleado) sesion.getAttribute("idMesero");

        String nomMesero = em.getNombre() + " " + em.getApellidos();
        d = (Altadia) sesion.getAttribute("idDia");
       

        String gralComanda = "";
        int idDia = 0;

        try {
            

            if (idComanda.equals("VER")) {
                sesion.setAttribute("idDescuento", idDescuento);
                sesion.setAttribute("idComanda", idComanda);
                sesion.setAttribute("idMesa", idMesa);
                sesion.setAttribute("nombremesa", nombremesa);
                
            
                response.sendRedirect("Comanda_venta.jsp");

            } else {
       
                ComandaDaoImpl dao = new ComandaDaoImpl();
                // Comanda co = new Comanda();
                int contar = dao.contar(d.getIdaltadia(), idMesa, "") + 1;
                int contardia = dao.contar(d.getIdaltadia()) + 1;
           
               
                gralComanda = idMesa.substring(0, 3) + "C" + d.getIdaltadia() + contardia  +contar;


                ComandaDaoImpl daoi = new ComandaDaoImpl();
                Comanda coi = new Comanda();

                MesaVenta mv = new MesaVenta();
                d = (Altadia) sesion.getAttribute("idDia");
                Date ahora = new Date();
                SimpleDateFormat dateFormat = new SimpleDateFormat("HH:mm:ss");

                SimpleDateFormat dateFormatf = new SimpleDateFormat("yyyy-MM-dd");
                String fechaAc = dateFormatf.format(ahora);
                String horaActu = dateFormat.format(ahora);
                idDia = d.getIdaltadia();
                System.out.println(idDia);
                d.setIdaltadia(idDia);
                mv.setIdMesaVenta(idMesa);

                coi.setIdComanda(gralComanda);
                coi.setFechaHora(fechaAc + " " + horaActu);
                coi.setTipo(tipo);
                coi.setEstado("Activo");
                coi.setAltadia(d);
                coi.setObserva(observa);
                coi.setAutorizacion(autorizacion);
                coi.setMesaVenta(mv);
                coi.setImpreso("Pendiente");
                daoi.insertar(coi);
                sesion.setAttribute("idDescuento", gralComanda);
                sesion.setAttribute("idComanda", gralComanda);
                sesion.setAttribute("idMesa", idMesa);
                sesion.setAttribute("idDescuento", idDescuento);               
             
                response.sendRedirect("Comanda_venta.jsp");


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
