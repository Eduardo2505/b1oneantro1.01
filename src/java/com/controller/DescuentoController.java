/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.controller;

import com.dao.impl.DescuentoDaoImpl;
import com.mapping.Descuento;
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
public class DescuentoController extends HttpServlet {

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
        String valor=request.getParameter("porcentaje");
        float porcentaje = Float.parseFloat(valor);
        try {
            DescuentoDaoImpl daodes = new DescuentoDaoImpl();
            Descuento d=new Descuento();
            d.setIdDescuento("Descuento"+valor);
            double va=100-porcentaje;
            d.setPorcentaje(va);
            d.setObservaciones("DESC "+valor+"%");
            daodes.insertar(d);
            /* TODO output your page here. You may use following sample code. */
            out.println(" <select name=\"idDescuento\" style=\"width:150px\" required=\"\">\n"
                    + "                        <option value=\"\">Seleccione</option>");

            
            List resdes = daodes.getVer();
            Iterator itrdes = resdes.iterator();
            while (itrdes.hasNext()) {
                Descuento des = (Descuento) itrdes.next();
                String checar = des.getIdDescuento().trim();

                if (!checar.equals("Ninguno")) {


                    out.println(" <option value='" + des.getIdDescuento() + "'>" + checar + "</option>");

                }


            }
            out.println(" </select>");

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
