/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.controller;

import com.dao.impl.ProductoDaoImpl;
import com.mapping.Categoria;
import com.mapping.Producto;
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
public class ActualizarProducto extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
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
        String idProducto = request.getParameter("idProducto");
        String nombre = request.getParameter("nompro");
        String tipo = request.getParameter("tipo");
        int tamano = Integer.parseInt(request.getParameter("tamano"));
        float precio = Float.parseFloat(request.getParameter("precio"));
        String categoria = request.getParameter("categoria");
        String evento = request.getParameter("opEvento");
        String Importado = request.getParameter("Importado");
        String medida = request.getParameter("medida");
        String opcion = request.getParameter("opcion");
        String estado = request.getParameter("estado");

        try {
            ProductoDaoImpl dao = new ProductoDaoImpl();
            Producto p = new Producto();
            p.setIdProducto(idProducto);
            p.setNombre(nombre);
            p.setTipo(tipo);
            p.setTamano(tamano);
            p.setPrecio(precio);
            p.setMedida(medida);
            p.setOpcion(opcion);
            p.setUrl(estado);
            Categoria c = new Categoria();
            c.setIdCategoria(categoria);
            p.setCategoria(c);
            p.setTipoEvento(evento);
            p.setImportacion(Importado);
            dao.actualizar(p);
        } finally {
            out.close();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
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
     * Handles the HTTP <code>POST</code> method.
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
