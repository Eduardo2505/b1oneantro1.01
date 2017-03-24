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
public class CerrarCuentasController extends HttpServlet {

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
        String id = request.getParameter("idMesa");
        String op = request.getParameter("op");
        HttpSession sesion = request.getSession();
        Empleado e = new Empleado();
        Altadia di = new Altadia();

        int idDia = 0;
        String dia = "";

        // System.out.println(op);


        di = (Altadia) sesion.getAttribute("idDia");

        idDia = di.getIdaltadia();



        Mesa_ventaDaoImpl dao = new Mesa_ventaDaoImpl();
        MesaVenta d = new MesaVenta();
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
                    + "        </script>");
            if (op.equals("mostrar")) {
               // System.out.println("Entro e mostrarr");
                d = dao.bucarPorId(id);
                System.out.println(id);
                // System.out.println(d.getIdMesaVenta());

                out.println("<script type=\"text/javascript\">\n"
                        + "\n"
                        + "\n"
                        + "                                $(function() {\n"
                        + "                                    $('#enviarCuenta').submit(function() {\n"
                        + " var filtro = $('#filtro').val();"
                        + "\n"
                        + "                                        var data = $(this).serialize()+\"&filtro=\"+filtro;\n"
                        + "                                        var totalc = parseFloat($('#totalc').val());\n"
                        + "                                        var talEfec = parseFloat($('#talEfec').val());\n"
                        + "                                        var taltarjeta = parseFloat($('#taltarjeta').val());\n"
                        + "                                        var sum = talEfec + taltarjeta;\n"
                        + "\n"
                        + "                                        if (totalc == sum) {\n"
                        + "                                            \n"
                        + "                                            $('#mostrarres').html('<img src=\"../img/ajax-loader.gif\" alt=\"\"/>').fadeOut(1000);\n"
                        + "                                            $.post('../CerrarCuentasController', data, function(respuesta) {\n"
                        + "                                                $('#mostrarres').fadeIn(1000).html(respuesta);"
                        + "$('#editar').html('<h1>Actualizar</h1>');\n"
                        + "\n"
                        + "                                            });\n"
                        + "                                        } else {\n"
                        + "                                            jAlert(\"No coincide el dinero\", \"Error\", function(r) {\n"
                        + "                                                if (r) {\n"
                        + "                                                    $('#taltarjeta').focus();\n"
                        + "                                                    $('#talEfec').focus();\n"
                        + "\n"
                        + "                                                }\n"
                        + "                                            });\n"
                        + "                                        }\n"
                        + "\n"
                        + "                                        return false;\n"
                        + "\n"
                        + "                                    });\n"
                        + "\n"
                        + "\n"
                        + "                                });\n"
                        + "                            </script>\n"
                        + "                            <label><h3>Cuenta: " + d.getIdMesaVenta() + "</h3></label>\n"
                        + "                            <label><h4>Total: " + d.getTotalcuenta() + "</h4> </label>\n"
                        + "                            <form class=\"form-horizontal\" id=\"enviarCuenta\">                                \n"
                        + "                                <input type=\"hidden\" name=\"totalc\" id=\"totalc\" value=\"" + d.getTotalcuenta() + "\">\n"
                        + "                                <input type=\"hidden\" name=\"op\" value=\"actualizar\">\n"
                        + "                                <input type=\"hidden\" name=\"idMesa\" value=\"" + d.getIdMesaVenta() + "\">\n"
                        + "\n"
                        + "                                <div class=\"control-group\">\n"
                        + "                                    <label class=\"control-label\" for=\"inputEmail\">Efectivo</label>\n"
                        + "                                    <div class=\"controls\">\n"
                        + "                                        <input type=\"text\" name=\"efectivo\" id='talEfec' value='" + d.getEfectivo() + "'  placeholder=\"$$$$\" required=\"\"> \n"
                        + "                                    </div>\n"
                        + "                                </div>\n"
                        + "                                <div class=\"control-group\">\n"
                        + "                                    <label class=\"control-label\" for=\"inputPassword\">Tarjeta</label>\n"
                        + "                                    <div class=\"controls\">\n"
                        + "                                        <input type=\"text\" name=\"tarjeta\" id='taltarjeta' value='" + d.getTarjeta() + "'  placeholder=\"$$$$\" required=\"\">\n"
                        + "                                    </div>\n"
                        + "                                </div>\n"
                        + "                                <div class=\"control-group\">\n"
                        + "                                    <div class=\"controls\">      \n"
                        + "                                        <button type=\"submit\"  class=\"btn\" >Guardar</button>\n"
                        + "                                    </div>\n"
                        + "                                </div>\n"
                        + "                            </form>");


            } else if (op.equals("actualizar")) {
                float efectivo = Float.parseFloat(request.getParameter("efectivo"));
                float tarjeta = Float.parseFloat(request.getParameter("tarjeta"));
                String filtro = request.getParameter("filtro");
                dao.actualiza(id, efectivo, tarjeta);
                // out.println(id+" "+efectivo+" "+ tarjeta);
                out.println(" <table class=\"table table-striped\" style=\"width:70%\">\n"
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
                //String efectivo = request.getParameter("efectivo");

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
