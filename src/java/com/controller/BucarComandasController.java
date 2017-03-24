/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.controller;

import beans.Adicionalesbean;
import beans.Comandaventabean;
import com.dao.impl.AdicionalesComprobarDaoImpl;
import com.dao.impl.ComandaVentaBeansImpl;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.NumberFormat;
import java.util.Iterator;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import otrosNOsirve.conexion;

/**
 *
 * @author Eduardopc
 */
public class BucarComandasController extends HttpServlet {

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
        String mostraridComanda = request.getParameter("mostraridComanda");

        float sumita = 0, sumitax = 0;
        NumberFormat nf = NumberFormat.getInstance();
        nf.setMaximumFractionDigits(2);
        try {
            out.println("<table class=\"table table-striped\">");
            out.println("<tr><th colspan='2'>Producto</th><th>Cantidad</th><th>Precio</th><th>Opc</th></tr>");

            ComandaVentaBeansImpl dac = new ComandaVentaBeansImpl();
            List resa = dac.getBuscar(mostraridComanda, "adicional");
            Iterator itra = resa.iterator();
            while (itra.hasNext()) {
                Comandaventabean a = (Comandaventabean) itra.next();
                sumita += a.getTotalcosto();
                out.println("<tr><td colspan='2'> " + a.getProducto() + " " + a.getMedida() + "</td><td>" + a.getCantidad() + "</td><td>$ " + nf.format(a.getTotalcosto()) + "</td></tr>");

                AdicionalesComprobarDaoImpl daoEm = new AdicionalesComprobarDaoImpl();
                List res = daoEm.getAdicionales(a.getIdventa());
                Iterator itr = res.iterator();
                int verMesesa = 0;
                while (itr.hasNext()) {
                    Adicionalesbean vcx = (Adicionalesbean) itr.next();
                    out.println("<tr><td width='70px'></td><td style='background-color:yellow'>" + vcx.getProducto() + " " + vcx.getMedida() + "</td><td style='background-color:yellow'>" + vcx.getCantidad() + "</td><td style='background-color:yellow'>$ 0</td><td></td></tr>");



                }
            }
            List resax = dac.getBuscar(mostraridComanda, "np");
            Iterator itrax = resax.iterator();
            while (itrax.hasNext()) {
                Comandaventabean a = (Comandaventabean) itrax.next();
                sumitax += a.getTotalcosto();
                out.println("<tr><td colspan='2'> " + a.getProducto() + " " + a.getMedida() + "</td><td>" + a.getCantidad() + "</td><td>$ " + nf.format(a.getTotalcosto()) + "</td></tr>");


            }
            out.println(" <input type=\"hidden\" name=\"sumatotal\" value=\"" + nf.format((sumita + sumitax)) + "\">");
            out.println(" <tr><td colspan=\"2\"><H3>TOTAL:</h3></td><td><H3>$ " + nf.format((sumita + sumitax)) + "</h3> </td></tr>\n"
                    + "\n"
                    + "                            <tr><td colspan=\"3\" id=\"cargarCerrar\"></td></tr>\n"
                    + "\n"
                    + "\n"
                    + "                        </table>");
        } finally {
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
