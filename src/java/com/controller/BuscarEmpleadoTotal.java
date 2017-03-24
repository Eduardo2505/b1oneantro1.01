/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.controller;

import com.dao.PagoscorteDao;
import com.dao.impl.EmpleadoDaoImpl;
import com.dao.impl.Mesa_ventaDaoImpl;
import com.dao.impl.PagoscorteDaoImpl;
import com.mapping.Altadia;
import com.mapping.Empleado;
import com.mapping.Pagoscorte;
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
 * @author Eduardo
 */
public class BuscarEmpleadoTotal extends HttpServlet {

    /**
     * Processes requests for both HTTP
     * <code>GET</code> and
     * <code>POST</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error oc
     * curs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String filtro = request.getParameter("filtro");
        HttpSession sesion = request.getSession();
        EmpleadoDaoImpl daoe = new EmpleadoDaoImpl();        
        Altadia di = new Altadia();
        int idDia = 0;
        String dia = "";
        // System.out.println(op);
        di = (Altadia) sesion.getAttribute("idDia");
        idDia = di.getIdaltadia();
        Mesa_ventaDaoImpl dao = new Mesa_ventaDaoImpl();
        try {
            /* TODO output your page here. You may use following sample code. */
            out.println(" <table class=\"table table-striped\">\n"
                    + "                            <tr>                        \n"
                    + "                                <th>Nombre</th>\n"
                    + "                                <th>Clave</th>\n"
                    + "                                <th>Total</th>\n"
                    + "                                <th>Efectivo</th>\n"
                    + "                                <th>Tarjetas</th>\n"
                    + "                                <th>Editar</th>\n"
                    + "                            </tr>");

            PagoscorteDaoImpl daoEm = new PagoscorteDaoImpl();
            System.out.println("###################################"+filtro);
            List res = daoe.buscarEmpleado(filtro);
            Pagoscorte r=new Pagoscorte();
            Iterator itr = res.iterator();
            int verMesesa = 0;
            while (itr.hasNext()) {
                Empleado vc = (Empleado) itr.next();
                verMesesa = dao.MesaAbiertas(vc.getIdEmpleado());
                r=daoEm.buscar(vc.getIdEmpleado(), idDia);
                if (verMesesa > 0) {
                    out.println("<tr><td style='background-color:red' >" + vc.getNombre() + " " + vc.getApellidos() + "</td><td style='background-color:red' >" + vc.getEmpleadocol() + "</td><td style='background-color:red' >" + r.getTotal() + "</td><td style='background-color:red' >" + r.getEfectivo() + "</td><td style='background-color:red' >" + r.getTarjetas() + "</td><td style='background-color:red' ></td></tr>");
                } else {
                    if (r.getEfectivo() == 0 && r.getTarjetas() == 0) {
                        out.println("<tr><td style='background-color:yellow' >" + vc.getNombre() + " " + vc.getApellidos() + "</td><td style='background-color:yellow' >" + vc.getEmpleadocol() + "</td><td style='background-color:yellow' >" + r.getTotal() + "</td><td style='background-color:yellow' >" + r.getEfectivo() + "</td><td style='background-color:yellow' >" + r.getTarjetas() + "</td><td style='background-color:yellow'><button class='btn btn-large btn-primary btncuenta' name='" + r.getIdPagosCorte() + "' type='button'>PAGAR</button></td></tr>");
                    } else {
                        out.println("<tr><td>" + vc.getNombre() + " " + vc.getApellidos() + "</td><td>" + vc.getEmpleadocol() + "</td><td>" + r.getTotal() + "</td><td>" + r.getEfectivo() + "</td><td>" + r.getTarjetas() + "</td><td><button class='btn btn-large btn-primary btncuenta' name='" + r.getIdPagosCorte() + "' type='button'>Editar</button></td></tr>");
                    }


                }


            }

            out.println("  </table>");

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
