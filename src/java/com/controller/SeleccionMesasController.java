/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.controller;

import com.dao.impl.Mesa_ventaDaoImpl;
import com.mapping.Altadia;
import com.mapping.MesaVenta;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Eduardopc
 */
public class SeleccionMesasController extends HttpServlet {

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
        String idEmpleado = request.getParameter("idEmpleado");
        //String idComada = request.getParameter("idComada");

        HttpSession sesion = request.getSession();
        Altadia d = new Altadia();
        d = (Altadia) sesion.getAttribute("idDia");
        String idMesa = (String) sesion.getAttribute("idMesa");
        int idDia = d.getIdaltadia();
        try {
            //out.println(idComada);
            Mesa_ventaDaoImpl daoMv = new Mesa_ventaDaoImpl();
            List res = daoMv.getMesaVenta("Activo", idEmpleado, idDia);
            Iterator itr = res.iterator();
            out.println("<option value=\"\">idCuentaMesa</option>");
            while (itr.hasNext()) {
                MesaVenta em = (MesaVenta) itr.next();
                if (!idMesa.equals(em.getIdMesaVenta())) {
                    out.print(" <option  value ='" + em.getIdMesaVenta() + "'>" + em.getIdMesaCapturada() + "</option>");
                }
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
