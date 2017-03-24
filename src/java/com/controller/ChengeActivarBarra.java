/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.controller;

import com.dao.impl.EmpleadoDaoImpl;
import com.mapping.Barra;
import com.mapping.Empleado;
import com.mapping.Puesto;
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
public class ChengeActivarBarra extends HttpServlet {

    Iterator itr = null, itrp = null;
    List resm = null, resz = null;
    List res = null, resp = null;
    EmpleadoDaoImpl dao = new EmpleadoDaoImpl();
    Puesto pu = new Puesto();
    Barra vb = new Barra();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String idbarra = request.getParameter("idBarra");
        try {
            res = dao.getFiltro();
            itr = res.iterator();

            out.println(" <select name=\"idEmpleado\" required>\n"
                    + "                                    <option value=\"\" >Seleccione</option>");
            while (itr.hasNext()) {
                Empleado em = (Empleado) itr.next();

                vb = em.getBarra();
                if (vb != null) {
                    if (vb.getIdBarra().equals(idbarra)) {
                        if (em.getEmpleadocol() != null) {

                            out.print(" <option  value ='" + em.getIdEmpleado() + "'>" + em.getEmpleadocol() + "</option>");

                        }

                    }

                }
            }


            out.println("</select>");
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
