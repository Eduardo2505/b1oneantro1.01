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
import java.util.Iterator;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Eduardopc
 */
public class insertarController extends HttpServlet {

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
        String nom = request.getParameter("nompro").trim();
        String ti = request.getParameter("tipo").trim();
        String t = request.getParameter("tamano").trim();
        String pr = request.getParameter("precio").trim();
        String cate = request.getParameter("categoria").trim();
        String opEvento = request.getParameter("opEvento").trim();
        String Importado = request.getParameter("Importado").trim();
        String medida = request.getParameter("medida").trim();
        String opcion = request.getParameter("opcion").trim();
        String estado = request.getParameter("estado").trim();
        //out.println("Nombre" + nom + "<br>Tipo" + ti + "<br>Tamaño:" + t + "<br>Precio" + pr + "<br>Categoria" + cate);
        String add = "";
        try {
            if (ti.equals("Botella")) {
                add = "Bot";
            } else if (ti.equals("Copa")) {
                add = "Copa";
                
            } else {
                add = "";
                
            }
            ProductoDaoImpl dao = new ProductoDaoImpl();
            String tipoEveneto = opEvento;
            String Categoria = cate;
            String tipo = ti;
            int contar = dao.contar() + 1;
            String nombre = add + " " + nom;
            int tamano = Integer.parseInt(t);
            float costo = Float.parseFloat(pr);
            String idProducto = Categoria.substring(0, 3) + "-" + tipo.substring(0, 1) + tipoEveneto.substring(0, 1) + contar;
            Producto p = new Producto();
            Categoria c = new Categoria();
            p.setIdProducto(idProducto.toUpperCase());
            p.setNombre(nombre);
            p.setTamano(tamano);
            p.setMedida(medida);
            p.setOpcion(opcion);
            p.setUrl(estado);
            c.setIdCategoria(Categoria);
            p.setCategoria(c);
            p.setTipo(tipo);
            p.setTipoEvento(tipoEveneto);
            p.setPrecio(costo);            
            if (!Importado.equals("")) {
                p.setImportacion(Importado);                
            }
            dao.insertar(p);
            out.println("Se inserto corectamente el nuevo producto :<h3> " + nombre + "</h4>");
            
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
