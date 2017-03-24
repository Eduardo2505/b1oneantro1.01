/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.controller;

import beans.Adicionalesbean;
import beans.Comandaventabean;
import com.dao.impl.AdicionalesComprobarDaoImpl;
import com.dao.impl.CancelacionComandaDaoImpl;
import com.dao.impl.ComandaDaoImpl;
import com.dao.impl.ComandaVentaBeansImpl;
import com.dao.impl.EmpleadoDaoImpl;
import com.dao.impl.Mesa_ventaDaoImpl;
import com.impresion1.TiketImprimir;
import com.mapping.Barra;
import com.mapping.CancelacionComanda;
import com.mapping.Comanda;
import com.mapping.Empleado;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import otrosNOsirve.conexion;

/**
 *
 * @author Eduardopc
 */
public class CancelacionComandaControll extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String observa = request.getParameter("Observa").trim().toUpperCase();
        String idComanda = request.getParameter("idComanda");
        HttpSession sesion = request.getSession();
        String idMesa = (String) sesion.getAttribute("idMesa");
        String pass = request.getParameter("atorizar");

        EmpleadoDaoImpl daoe = new EmpleadoDaoImpl();
        Empleado e = new Empleado();

        try {
            System.out.println(pass);
            e = daoe.verificarCantras(pass);
            //System.out.println(e);
            if (e != null) {
                // System.out.println(e.getEmpleadocol());
                Date ahora = new Date();
                SimpleDateFormat dateFormat = new SimpleDateFormat("HH:mm:ss");
                SimpleDateFormat dateFormatf = new SimpleDateFormat("yyyy-MM-dd");
                String fechaAc = dateFormatf.format(ahora);
                String horaAc = dateFormat.format(ahora);
                String hora = fechaAc + " " + horaAc;

                ComandaDaoImpl dao = new ComandaDaoImpl();
                Comanda co = new Comanda();
                co.setIdComanda(idComanda);
                dao.actulizar(idComanda, "Cancelado");

                CancelacionComandaDaoImpl daoc = new CancelacionComandaDaoImpl();
                CancelacionComanda c = new CancelacionComanda();
                c.setDescripcion(observa);
                c.setComanda(co);
                c.setRegistro(hora);
                c.setAutorizacion(e.getNombre() + " " + e.getApellidos());
                c = daoc.insertar(c);
                //sesion.setAttribute("idComanda", idComanda);
                //sesion.setAttribute("cancelacion", c);
                TiketImprimir daox = new TiketImprimir();
                Empleado em = new Empleado();
                em = (Empleado) sesion.getAttribute("idMesero");
                String mesero = em.getNombre() + " " + em.getApellidos();

                StringBuilder resultado = new StringBuilder("");

                ComandaVentaBeansImpl dac = new ComandaVentaBeansImpl();
                List resa = dac.getMostrarCancelacion(idComanda, "adicional");
                Iterator itra = resa.iterator();
                while (itra.hasNext()) {
                    Comandaventabean a = (Comandaventabean) itra.next();

                    resultado.append(a.getProducto() + " " + a.getMedida() + " ----> " + a.getCantidad() + " pz\n");

                    AdicionalesComprobarDaoImpl daoEm = new AdicionalesComprobarDaoImpl();
                    List res = daoEm.getAdicionales(a.getIdventa());
                    Iterator itr = res.iterator();
                    int verMesesa = 0;
                    while (itr.hasNext()) {
                        Adicionalesbean vcx = (Adicionalesbean) itr.next();

                        resultado.append("_____(" + vcx.getProducto() + " " + vcx.getMedida() + "-> " + vcx.getCantidad() + " pz)\n\n");




                    }
                }
                List resax = dac.getMostrarCancelacion(idComanda, "np");
                Iterator itrax = resax.iterator();
                while (itrax.hasNext()) {
                    Comandaventabean a = (Comandaventabean) itrax.next();
                    resultado.append(a.getProducto() + " " + a.getMedida() + " ----> " + a.getCantidad() + " pz\n");



                }
                String tiket = daox.ImprimirComandaCancelad(mesero, em.getEmpleadocol(), idMesa, idComanda, fechaAc, horaAc, "", e.getNombre() + " " + e.getApellidos(), observa, resultado.toString());

                out.println(tiket);

            } else {

                //out.println("No tiene Autorización");
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
