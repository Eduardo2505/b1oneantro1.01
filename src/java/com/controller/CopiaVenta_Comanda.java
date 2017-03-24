/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.controller;

import com.dao.AdicionalesDao;
import com.dao.impl.AdicionalesDaoImpl;
import com.dao.impl.ComandaDaoImpl;
import com.dao.impl.VentaComandaDaoImpl;
import com.mapping.Adicionales;
import com.mapping.Barra;
import com.mapping.Comanda;
import com.mapping.Descuento;
import com.mapping.Producto;
import com.mapping.VentaComanda;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Eduardo
 */
public class CopiaVenta_Comanda extends HttpServlet {

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
        int id = Integer.parseInt(request.getParameter("idventa"));
        int cantidad = Integer.parseInt(request.getParameter("cantida"));

        try {
            HttpSession sesion = request.getSession();
            String idComanda = (String) sesion.getAttribute("idComanda");
            ComandaDaoImpl co = new ComandaDaoImpl();
            Comanda man = new Comanda();
            man = co.bucarPorId(idComanda);
            if (!man.getImpreso().equals("Impreso")) {

                for (int i = 0; i < cantidad; i++) {

                    VentaComandaDaoImpl daocv = new VentaComandaDaoImpl();
                    VentaComanda veco = new VentaComanda();
                    veco = daocv.BuscarComanda(id);
                    Producto p = new Producto();
                    VentaComanda ve = new VentaComanda();
                    Comanda c = new Comanda();
                    c = veco.getComanda();
                    c.setIdComanda(c.getIdComanda());
                    ve.setComanda(c);
                    Descuento des = new Descuento();
                    des = veco.getDescuento();
                    des.setIdDescuento(des.getIdDescuento());
                    ve.setDescuento(des);//Asiga descuento*************++

                    p = veco.getProducto();
                    p.setIdProducto(p.getIdProducto());
                    ve.setProducto(p);
                    ve.setObservaciones(veco.getObservaciones());
                    ve.setRegistro(veco.getRegistro());
                    ve.setEstado(veco.getEstado());
                    ve.setActorizacion(veco.getActorizacion());
                    Barra b = new Barra();
                    b = veco.getBarra();
                    b.setIdBarra(b.getIdBarra());
                    ve.setBarra(b);
                    ve.setCosto(veco.getCosto());
                    int idnew = daocv.insertar(ve);

                    if (veco.getEstado().equals("Adicional")) {
                        AdicionalesDaoImpl daoa = new AdicionalesDaoImpl();
                        Adicionales aa = new Adicionales();
                        Adicionales an = new Adicionales();
                        aa = daoa.bucar(id);

                        an.setDescripcion(aa.getDescripcion());
                        an.setPrecio(aa.getPrecio());
                        p = aa.getProducto();
                        p.setIdProducto(p.getIdProducto());
                        an.setProducto(p);
                        ve = aa.getVentaComanda();
                        ve.setIdVentaComandacol(idnew);
                        an.setVentaComanda(ve);
                        daoa.insertar(an);


                    }


                }
            } else {
                out.println("ya impreso");
            }
            //      System.out.println("->" + a + "-->" + veco.getEstado());

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
