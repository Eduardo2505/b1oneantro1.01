/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.controller;

import com.dao.impl.Mesa_ventaDaoImpl;
import com.mapping.Altadia;
import com.mapping.MesaVenta;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
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
public class AbrirCuenta extends HttpServlet {

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
        String idCuentas = request.getParameter("idCuentas");
        HttpSession sesion = request.getSession();
        // Empleado e = new Empleado();
        Altadia d = new Altadia();
        d = (Altadia) sesion.getAttribute("idDia");
//out.println(d);

        int idDia = d.getIdaltadia();
        try {
            Date ahora = new Date();
            SimpleDateFormat dateFormat = new SimpleDateFormat("HH:mm:ss");
            SimpleDateFormat dateFormatf = new SimpleDateFormat("yyyy-MM-dd");
            String fechaAc = dateFormatf.format(ahora);
            String horaAc = dateFormat.format(ahora);
            String hora = fechaAc + " " + horaAc;
            /* TODO output your page here. You may use following sample code. */
            Mesa_ventaDaoImpl dao = new Mesa_ventaDaoImpl();
            String Supervisor = (String) sesion.getAttribute("Supervisor");
            String observa = Supervisor + " " + hora;
            dao.AbrirCuenta(idCuentas, "Activo", observa);

            out.println("<script type=\"text/javascript\">\n"
                    + "                $(document).ready(function() {\n"
                    + "                    $('.ver').click(function() {\n"
                    + "\n"
                    + "\n"
                    + "                        var user = $(this).attr(\"name\");\n"
                    + "                        //alert(user);\n"
                    + "\n"
                    + "                        var dataString = 'idCuentas=' + user;\n"
                    + "                        //  alert(dataString);\n"
                    + "                        if (user != \"\") {\n"
                    + "                            // $('#verResultadoBuscados').html('<img src=\"img/ajax-loader.gif\" alt=\"\"/>');\n"
                    + "                            $.ajax({\n"
                    + "                                type: \"POST\",\n"
                    + "                                url: \"AbrirCuenta\",\n"
                    + "                                data: dataString,\n"
                    + "                                success: function(data) {\n"
                    + "                                    $('#resultados').html(data);\n"
                    + "                                }\n"
                    + "                            });\n"
                    + "                            //}\n"
                    + "                        }\n"
                    + "                    }\n"
                    + "\n"
                    + "\n"
                    + "                    );\n"
                    + "                });\n"
                    + "            </script>");
            out.println(" <table class=\"table table-striped\">\n"
                    + "                    <tr><td colspan=\"3\"><h4>########Cuentas Cerradas#######</h4></td></tr>\n"
                    + "                    <tr><th>Cuenta</th><th>Estado</th><th>Opciones</th></tr>");
            List res = dao.getCuentasAbiertas("", idDia, "");
            Iterator itr = res.iterator();

            String color = "", nom = "";
            while (itr.hasNext()) {
                MesaVenta ee = (MesaVenta) itr.next();
                if (ee.getEstado().equals("Cerrado")) {
                    color = "btn-primary";
                    nom = "Abrir";

                } else {
                    color = "btn-danger";
                    nom = "Cerrar";
                }


                out.println("<tr><td>" + ee.getIdMesaVenta() + "</td><td>" + ee.getEstado() + "</td><td><a href='#' name='" + ee.getIdMesaVenta() + "'  class='btn btn-large " + color + " ver' >" + nom + "</a></td></tr>");
            }

            out.println("</table>");

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
