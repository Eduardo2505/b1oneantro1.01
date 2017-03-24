/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.adicionales;

import beans.Adicionalesbean;
import com.dao.impl.AdicionalesComprobarDaoImpl;
import com.dao.impl.AdicionalesDaoImpl;
import com.mapping.Adicionales;
import com.mapping.Producto;
import com.mapping.VentaComanda;
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
public class adicionalesrejuxml extends HttpServlet {

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
        int limite = Integer.parseInt(request.getParameter("limite"));
        int idventa = Integer.parseInt(request.getParameter("idventa"));
        String clase = request.getParameter("clase");
        String idclase = request.getParameter("idclase");
        String idProducto = request.getParameter("productos");
        String productoin = request.getParameter("productoin");
        int combinar = Integer.parseInt(request.getParameter("combinar"));//2


        try {
            AdicionalesComprobarDaoImpl daoaa = new AdicionalesComprobarDaoImpl();

            String va = daoaa.limite(productoin, limite, idventa);
            int valor = daoaa.limiteclases(clase, idventa);// refrescs
            int valorx = daoaa.limiteclases("IN ('" + idclase + "')", idventa);// jugos

           
            

            if (valorx == 1) {

                out.println("error<br><br>");
            }
            else if (valor == 3) {

                out.println("error<br><br>");
            } else if (va.equals("agregar")) {
                AdicionalesDaoImpl daoa = new AdicionalesDaoImpl();
                Adicionales a = new Adicionales();
                Producto p = new Producto();
                float aa = 0;
                a.setDescripcion(idclase);
                a.setPrecio(aa);
                p.setIdProducto(idProducto);
                a.setProducto(p);
                VentaComanda v = new VentaComanda();
                v.setIdVentaComandacol(idventa);
                a.setVentaComanda(v);
                daoa.insertar(a);

                out.println("Se agrego<br><br>");
            } else {
                out.println("Se bloqueo<br><br>");

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
