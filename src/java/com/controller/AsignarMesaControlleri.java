/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.controller;

import com.dao.impl.EmpleadoDaoImpl;
import com.dao.impl.MesasDaoImpl;
import com.mapping.Empleado;
import com.mapping.Mesas;
import com.mapping.Zona;
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
public class AsignarMesaControlleri extends HttpServlet {

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
        int finalv = Integer.parseInt(request.getParameter("finalv"));
        String idZona = request.getParameter("idZona");
        EmpleadoDaoImpl daoe = new EmpleadoDaoImpl();
        Empleado em = new Empleado();
        em = daoe.bucarPorId(idEmpleado);
        String clave = em.getEmpleadocol();
        MesasDaoImpl dao = new MesasDaoImpl();

        Zona z = new Zona();

        Mesas m = new Mesas();
        System.out.println(idEmpleado);
        System.out.println(finalv);
        System.out.println(idZona);
        int valormax = dao.mesasMaximas(idEmpleado) + 1;
        System.out.println(valormax);
        int valorf=valormax+finalv;
        try {
            for (int i = valormax; i <= valorf; i++) {

                System.out.println(clave + "-" + i);
                m.setIdMesa(clave + "-" + i);

                m.setEstado("Activo");
                m.setPosiscion(i);
                z.setIdzona(idZona);
                m.setZona(z);
                em.setIdEmpleado(idEmpleado);
                m.setEmpleado(em);
                m.setTipo("Venta");
                dao.insertar(m);
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
