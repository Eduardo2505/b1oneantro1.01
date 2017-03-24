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
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Eduardopc
 */
public class ControllerEmpleado extends HttpServlet {

    EmpleadoDaoImpl dao = new EmpleadoDaoImpl();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String pass = request.getParameter("pass").trim();
        String passauv = request.getParameter("passr").trim();
        String Clave = request.getParameter("Clave").trim().toUpperCase();

        Empleado e = new Empleado();
        Puesto p = new Puesto();
        Barra b = new Barra();
        Date ahora = new Date();
        SimpleDateFormat dateFormat = new SimpleDateFormat("HH:mm:ss");
        SimpleDateFormat dateFormatf = new SimpleDateFormat("yyyy-MM-dd");
        String fechaAc = dateFormatf.format(ahora);
        String Hora = dateFormat.format(ahora);
        String hc = fechaAc + " " + Hora;
        int ver = dao.verificarClave(Clave);


        try {
            /* TODO output your page here. You may use following sample code. */
            if (ver > 0) {
                System.out.println("Error");
                out.println("<div class='ui-widget'><div class='ui-state-error ui-corner-all' style='padding: 0 .7em;'><p><span class='ui-icon ui-icon-alert' style='float: left; margin-right: .3em;'></span> <strong>Error:</strong> <br> Ya existe el la clave </p></div>");

            } else {
                System.out.println("entro");

                if (pass.equals(passauv)) {
                    String op = request.getParameter("op");
                    if (op.equals("regis")) {
                        String nom = request.getParameter("nom").trim().toUpperCase();
                        String ape = request.getParameter("ape").trim().toUpperCase();
                        String emil = request.getParameter("txtemail").trim();
                        int pu = Integer.parseInt(request.getParameter("pu"));
                        String idMesero = idEmpleado(pu);
                        e.setIdEmpleado(idMesero);
                        e.setNombre(nom);
                        e.setApellidos(ape);
                        e.setPass(passauv);
                        e.setEmpleadocol(Clave);
                        e.setMail(emil);
                        b.setIdBarra("Desactivar");
                        e.setBarra(b);
                        p.setIdpuesto(pu);
                        e.setPuesto(p);
                        e.setRegistro(hc);
                        e.setEstado("Activo");
                        dao.insertar(e);
                        // out.println("<h2>Se inserto correctamente</h2>");
                    } else {
                        String opac = request.getParameter("group1");
                        String idMesero = request.getParameter("idEmpleado").trim();
                        String idBarra = request.getParameter("idBarra").trim();
                        int idPuesto = Integer.parseInt(request.getParameter("idPuesto").trim());

                        if (opac.equals("pass")) {

                            dao.actulizarpass(idMesero, pass);
                        } else if (opac.equals("puesto")) {
                            dao.actulizarpue(idMesero, idPuesto);
                        } else {
                            dao.actulizarDato(idMesero, pass, Clave, idBarra, idPuesto);
                            //out.println("<h2>Se actualizo correctamente</h2>");

                        }
                    }



                } else {


                    out.println("<div class='ui-widget'><div class='ui-state-error ui-corner-all' style='padding: 0 .7em;'><p><span class='ui-icon ui-icon-alert' style='float: left; margin-right: .3em;'></span> <strong>Error:</strong> <br> No coincide el password</p></div>");

                }
            }
        } finally {
            out.close();
        }
    }

    public String idEmpleado(int pu) {
        String id = "";
        Date ahora = new Date();        
        SimpleDateFormat dateFormatf = new SimpleDateFormat("yyyyMMddHHmmss");
        String fechaAc = dateFormatf.format(ahora);         
        int contar = dao.contar() + 1;      
        id = fechaAc+ contar;
        return id;
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
