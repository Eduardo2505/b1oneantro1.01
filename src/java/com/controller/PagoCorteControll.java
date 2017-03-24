/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.controller;

import com.dao.impl.EmpleadoDaoImpl;
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
public class PagoCorteControll extends HttpServlet {

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
        int id = Integer.parseInt(request.getParameter("idpagocorte"));
        String op = request.getParameter("op");
        HttpSession sesion = request.getSession();
        Empleado e = new Empleado();
        Altadia di = new Altadia();

        int idDia = 0;
        String dia = "";

        // System.out.println(op);


        di = (Altadia) sesion.getAttribute("idDia");

        idDia = di.getIdaltadia();
        PagoscorteDaoImpl dao = new PagoscorteDaoImpl();
        Pagoscorte d = new Pagoscorte();
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
                    + "                            url: \"../PagoCorteControll\",\n"
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
                d = dao.buscar(id);
                e = d.getEmpleado();
                System.out.println(id);
                System.out.println(d.getTotal());
                out.println("<script type=\"text/javascript\">\n"
                        + "\n"
                        + "            $(document).ready(function() {\n"
                        + "                $(\"#calcularTar\").click(function(event) {\n"
                        + "\n"
                        + "                    var totalc = parseFloat($('#totalc').val());\n"
                        + "                    var taltarjeta = parseFloat($('#taltarjeta').val());\n"
                        + "                    var cal=totalc-taltarjeta;\n"
                        + "                    $('#talEfec').val(cal);\n"
                        + "                   \n"
                        + "                });\n"
                        + "            });\n"
                        + "\n"
                        + "\n"
                        + "        </script>");
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
                        + "                                            $.post('../PagoCorteControll', data, function(respuesta) {\n"
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
                        + "      <label><h4>" + e.getNombre() + " " + e.getApellidos() + "</h4> </label>"
                        + "<label><h4>" + e.getEmpleadocol() + "</h4> </label>"
                        + "                      <label><h4>Total: " + d.getTotal() + "</h4> </label>\n"
                        + "                            <form class=\"form-horizontal\" id=\"enviarCuenta\">                                \n"
                        + "                                <input type=\"hidden\" name=\"totalc\" id=\"totalc\" value=\"" + d.getTotal() + "\">\n"
                        + "                                <input type=\"hidden\" name=\"op\" value=\"actualizar\">\n"
                        + "                                <input type=\"hidden\" name=\"idpagocorte\" value=\"" + d.getIdPagosCorte() + "\">\n"
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
                        + "                                        <input type=\"text\" name=\"tarjeta\" id='taltarjeta' value='" + d.getTarjetas() + "'  placeholder=\"$$$$\" required=\"\">\n"
                        + "                                    </div>\n"
                        + "                                </div>\n"
                        + "                                <div class=\"control-group\">\n"
                        + "                                    <div class=\"controls\">      \n"
                        + "                                        <button type=\"submit\"  class=\"btn\" >Guardar</button> "
                        + "<a href=\"#\" class=\"btn btn-danger\" id=\"calcularTar\">Calcular</a>\n"
                        + "                                    </div>\n"
                        + "                                </div>\n"
                        + "                            </form>");


            } else if (op.equals("actualizar")) {
                float efectivo = Float.parseFloat(request.getParameter("efectivo"));
                float tarjeta = Float.parseFloat(request.getParameter("tarjeta"));
                String filtro = request.getParameter("filtro");
                dao.actualizar(id, efectivo, tarjeta);
                // out.println(id+" "+efectivo+" "+ tarjeta);
                out.println(" <div class=\"alert alert-success\">\n"
                        + "  <a href=\"Cierre.jsp\" class=\"close\" data-dismiss=\"\">&times;</a>\n"
                        + "\n"
                        + "  <h2>Muy bien!</h2>\n"
                        + "   Se actualizo correctamente pago del corte del día. <br><br>\n"
                        + "<div style=\"text-align:center\"><img src=\"../img/palomita.png\" alt=\"\"/><hr>"
                        + "   <a href=\"Cierre.jsp\" class=\"btn btn-large btn btn-success\">Aceptar</a></div>\n"
                        + "</div>");

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
