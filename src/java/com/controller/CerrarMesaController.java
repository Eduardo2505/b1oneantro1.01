/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.controller;

import com.dao.impl.ComandaDaoImpl;
import com.dao.impl.Mesa_ventaDaoImpl;
import com.dao.impl.MesasDaoImpl;
import com.mapping.Altadia;
import com.mapping.MesaVenta;
import com.mapping.Mesas;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import otrosNOsirve.consultasMysq;

/**
 *
 * @author Eduardopc
 */
public class CerrarMesaController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String idMesaCuenta = request.getParameter("idMesaCuenta").trim();
        String idComanda = request.getParameter("idComanda").trim().toUpperCase();

        HttpSession sesion = request.getSession();
        String op = request.getParameter("op");
        Altadia d = new Altadia();
        d = (Altadia) sesion.getAttribute("idDia");
        int idDia = d.getIdaltadia();
        ComandaDaoImpl daoc = new ComandaDaoImpl();
        int ve = 0;
        Date ahora = new Date();
        SimpleDateFormat dateFormat = new SimpleDateFormat("HH:mm:ss");
        SimpleDateFormat dateFormatf = new SimpleDateFormat("yyyy-MM-dd");
        String fechaAc = dateFormatf.format(ahora);
        String horaAc = dateFormat.format(ahora);
        String hora = fechaAc + " " + horaAc;
        String Supervisor = (String) sesion.getAttribute("Supervisor");
        // out.println(Supervisor);
        try {
            /* TODO output your page here. You may use following sample code. */
            consultasMysq c = new consultasMysq();
            ve = c.verificar(idMesaCuenta);
            //ve = daoc.contar(idDia, idMesaCuenta, "Activo");
            //out.println(idMesaCuenta);
            Mesa_ventaDaoImpl mv = new Mesa_ventaDaoImpl();
            MesaVenta mvv = new MesaVenta();
            Mesas msa = new Mesas();
            mvv = mv.bucarPorId(idMesaCuenta);
            //msa = mvv.getMesas();


            if (!mvv.getEstado().equals("Cerrado")) {
                if (ve != 0) {
                    // out.println(ve);
                    if (op.equals("close")) {
                        Mesa_ventaDaoImpl dao = new Mesa_ventaDaoImpl();
                        dao.cerrar(idMesaCuenta, "Imprimiendo", hora, Supervisor);
                        MesaVenta m = new MesaVenta();
                        m = dao.bucarPorId(idMesaCuenta);
                        Mesas me = new Mesas();
                        me = m.getMesas();
                        String idMesa = me.getIdMesa();

                        MesasDaoImpl dam = new MesasDaoImpl();

                        dam.actulizar(idMesa, "Activo");
                        sesion.setAttribute("idComanda", idComanda);
                        sesion.setAttribute("idMesa", idMesaCuenta);
                        sesion.setAttribute("op", "close");
                    } else {
                        sesion.setAttribute("idComanda", idComanda);
                        sesion.setAttribute("idMesa", idMesaCuenta);
                        //response.sendRedirect("tike.jsp");
                        sesion.setAttribute("op", "imprimir");
                    }

                } else {

                    out.println("NO HAY");
                }
            } else {
                out.println("NO HAY");
            }
            //out.println(idMesaCuenta);

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
