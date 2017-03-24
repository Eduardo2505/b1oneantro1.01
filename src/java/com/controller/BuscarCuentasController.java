/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.controller;

import com.dao.impl.Mesa_ventaDaoImpl;
import com.mapping.Altadia;
import com.mapping.Empleado;
import com.mapping.MesaVenta;
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
public class BuscarCuentasController extends HttpServlet {

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
        String filtro = request.getParameter("filtro");
        HttpSession sesion = request.getSession();
        Empleado e = new Empleado();
        Altadia di = new Altadia();

        int idDia = 0;
        String dia = "";
        // System.out.println(op);
        di = (Altadia) sesion.getAttribute("idDia");
        idDia = di.getIdaltadia();


        Mesa_ventaDaoImpl dao = new Mesa_ventaDaoImpl();
        try {
            out.println("<script type=\"text/javascript\">\n"
                    + "            $(document).ready(function() {\n"
                    + "                $('.btncuenta').click(function() {\n"
                    + "                    // var user = $(this).val();\n"
                    + "                    var user = $(this).attr(\"name\");\n"
                    + "                    var dataString = 'idMesa=' + user + '&op=mostrar';\n"
                    + "                    //alert(user);\n"
                    + "                    if (user != \"\") {\n"
                    + "                        $('#editar').html('<img src=\"../img/ajax-loader.gif\" alt=\"\"/>');\n"
                    + "                        $.ajax({\n"
                    + "                            type: \"POST\",\n"
                    + "                            url: \"../CerrarCuentasController\",\n"
                    + "                            data: dataString,\n"
                    + "                            success: function(data) {\n"
                    + "                                //alert(data)\n"
                    + "\n"
                    + "                                $('#editar').fadeIn(500).html(data);\n"
                    + "                                \n"
                    + "\n"
                    + "\n"
                    + "                            }\n"
                    + "                        });\n"
                    + "                        //}\n"
                    + "                    }\n"
                    + "                }\n"
                    + "\n"
                    + "\n"
                    + "                );\n"
                    + "            });\n"
                    + "\n"
                    + "\n"
                    + "        </script>"
                    + "<table class=\"table table-striped\" style=\"width:70%\">\n"
                    + "                            <tr>                        \n"
                    + "                                <th>Clave</th>\n"
                    + "                                <th>Cuenta</th>\n"
                    + "                                <th>Total</th>\n"
                    + "                                <th>Efectivo</th>\n"
                    + "                                <th>Tarjetas</th>\n"
                    + "                                <th>Editar</th>\n"
                    + "                            </tr>");
            // Mesa_ventaDaoImpl dao = new Mesa_ventaDaoImpl();
            List res = dao.getCuentasAbiertas("Cerrado", idDia, filtro);
            Iterator itr = res.iterator();
            //    Empleado e=new Empleado();

            while (itr.hasNext()) {
                MesaVenta em = (MesaVenta) itr.next();
                e = em.getEmpleado();
                if (em.getEfectivo() == 0 && em.getTarjeta() == 00) {
                    out.println("<tr><td style='background-color:yellow'>" + e.getEmpleadocol() + "</td><td style='background-color:yellow'>" + em.getIdMesaVenta() + "</td><td style='background-color:yellow'>" + em.getTotalcuenta() + "</td><td style='background-color:yellow'>" + em.getEfectivo() + "</td><td style='background-color:yellow'>" + em.getTarjeta() + "</td><td style='background-color:yellow' ><button class='btn btn-large btn-primary btncuenta' type='button' name='" + em.getIdMesaVenta() + "'>PAGAR</button></td></tr>");
                } else {
                    out.println("<tr><td>" + e.getEmpleadocol() + "</td><td>" + em.getIdMesaVenta() + "</td><td>" + em.getTotalcuenta() + "</td><td>" + em.getEfectivo() + "</td><td>" + em.getTarjeta() + "</td><td><button class='btn btn-large btn-primary btncuenta' name='" + em.getIdMesaVenta() + "' type='button'>PAGAR</button></td></tr>");
                }




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
