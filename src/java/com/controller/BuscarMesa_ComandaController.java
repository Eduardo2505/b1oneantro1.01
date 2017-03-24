/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.controller;

import com.dao.impl.EmpleadoDaoImpl;
import com.dao.impl.Mesa_ventaDaoImpl;
import com.dao.impl.MesasDaoImpl;
import com.mapping.Altadia;
import com.mapping.Empleado;
import com.mapping.MesaVenta;
import com.mapping.Mesas;
import com.mapping.Puesto;
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
 * @author Eduardopc
 */
public class BuscarMesa_ComandaController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        HttpSession sesion = request.getSession();
        int idDia = 0;
        String idMesero = "";
        Altadia d = new Altadia();
        Empleado em = new Empleado();
        em = (Empleado) sesion.getAttribute("idMesero");
        d = (Altadia) sesion.getAttribute("idDia");
        idMesero = em.getIdEmpleado();
        idDia = d.getIdaltadia();

        String idmesa = request.getParameter("MesasBuscar");
        if (idmesa.equals("todo")) {
            idmesa = "";
        }

        Mesa_ventaDaoImpl daomv = new Mesa_ventaDaoImpl();
        MesaVenta m = new MesaVenta();



        try {
            out.println(" <script type=\"text/javascript\">          \n"
                    + "\n"
                    + "\n"
                    + "            $(function() {\n"
                    + "                $('#AgregarMesa').submit(function() {\n"
                    + "                    var data = $(this).serialize();\n"
                    + "                    //alert(data);\n"
                    + "                    $('#contenidover').html('<img src=\"img/ajax-loader.gif\" alt=\"\"/>').fadeOut(1000);\n"
                    + "                    $.post('Mesa_ventaController', data, function(respuesta) {\n"
                    + "\n"
                    + "                        $('#AgregarMesa')[0].reset();\n"
                    + "                        jAlert(\"Se agrego correctamente\", \"Confirmación\", function(r) {\n"
                    + "                            if (r) {\n"
                    + "                                //  $(location).attr('href','Mesas.jsp');\n"
                    + "                                $('#contenidoBody').html(respuesta);\n"
                    + "                                //  $(location).attr('href','Mesas.jsp');\n"
                    + "                            }\n"
                    + "                        });\n"
                    + "\n"
                    + "\n"
                    + "\n"
                    + "\n"
                    + "\n"
                    + "\n"
                    + "                    });\n"
                    + "                    return false;\n"
                    + "                });\n"
                    + "            });\n"
                    + "        </script>");

            out.println("<script type=\"text/javascript\">\n"
                    + "                $(document).ready(function() {\n"
                    + "                    $('.addnewMesa').click(function() {\n"
                    + "                        var a = $(this).attr(\"name\");\n"
                    + "\n"
                    + "                        $('#mesitaverid').fadeIn(500).html(a);\n"
                    + "                        $('#idMesaadd').val(a);\n"
                    + "\n"
                    + "                    });\n"
                    + "\n"
                    + "                });\n"
                    + "            </script>");
            out.println(" <div id=\"agregarMesaDiv\" class=\"reveal-modal\" style=\"text-align:center\">\n"
                    + "                <form id=\"AgregarMesa\">\n"
                    + "                    <label class=\"label-warning\"><H3>#MESA</H3></label>\n"
                    + "                    <input type=\"hidden\" name=\"idMesa\" id=\"idMesaadd\" value=\"\">\n"
                    + "                    <lable><h2 id=\"mesitaverid\"></h2></lable>\n"
                    + "\n"
                    + "                    <label class=\"label-warning\"><H3>PERSONAS APROX</H3></label>\n"
                    + "                    <input type=\"number\" name=\"persAprox\" required=\"\" >    \n"
                    + "\n"
                    + "                    <br>\n"
                    + "\n"
                    + "                    <input type=\"submit\" value=\"Aceptar\" class=\"btn btn-primary btn-large\" >\n"
                    + "                    <div id=\"contenidover\"></div>\n"
                    + "                </form>\n"
                    + "                <a class=\"close-reveal-modal\">&#215;</a>\n"
                    + "\n"
                    + "            </div>");
            out.println("  <ul id=\"sortable\">");
            MesasDaoImpl daomm = new MesasDaoImpl();
            List resmm = daomm.getMesas("Activo", em.getIdEmpleado(), idmesa);
            Iterator itrmm = resmm.iterator();
            while (itrmm.hasNext()) {
                Mesas mesasm = (Mesas) itrmm.next();
                out.println(" <li class='ui-state-default imagenVer'><a href='#' class=\"btnli addnewMesa\" data-reveal-id='agregarMesaDiv' data-animation='fadeAndPop' data-animationspeed='300' data-closeonbackgroundclick='true' data-dismissmodalclass='close-reveal-modal' name='" + mesasm.getIdMesa() + "'><br><br><h2>" + mesasm.getIdMesa() + "</h2></a></li> ");
                //  out.println("<option value='" + mesas.getIdMesa() + "'>" + mesas.getIdMesa() + "</option>");
            }
            // 



            List resmv = daomv.BuscarMesaVenta("Activo", idMesero, idDia, idmesa);
            Iterator itrmv = resmv.iterator();
            while (itrmv.hasNext()) {
                MesaVenta mesasv = (MesaVenta) itrmv.next();
                m = daomv.bucarPorId(mesasv.getIdMesaVenta());

                out.println(" <div id=\"" + mesasv.getIdMesaVenta() + "\" class=\"reveal-modal\" style=\"text-align:center\">"
                        + "<label class=\"label-warning\"><H3>#ACCIONES</H3></label>  \n");

                out.println("<a href='SessionIdMesaComanda?idMesaVenta=" + mesasv.getIdMesaVenta() + "&idComanda=crear&tipo=venta'  data-animation='fadeAndPop' data-animationspeed='300' data-closeonbackgroundclick='true' data-dismissmodalclass='close-reveal-modal' title='AGREGAR MESA' class='btn btn-primary numHE'> <BR>CREAR<br><BR>COMANDA</a>");
                out.println("<a href='SessionIdMesaComanda?idMesaVenta=" + mesasv.getIdMesaVenta() + "&idComanda=VER&tipo=venta'  data-animation='fadeAndPop' data-animationspeed='300' data-closeonbackgroundclick='true' data-dismissmodalclass='close-reveal-modal' title='AGREGAR MESA' class='btn btn-primary numHE'> <BR><br>Movimientos</a>");

                out.println("  <a class=\"close-reveal-modal\">&#215;</a>\n"
                        + "\n"
                        + "        </div>");
                out.println(" <li class='ui-state-default ocupado'><a href='#' class=\"btnli\" data-reveal-id='" + mesasv.getIdMesaVenta() + "' data-animation='fadeAndPop' data-animationspeed='300' data-closeonbackgroundclick='true' data-dismissmodalclass='close-reveal-modal'><br><br><h2>" + mesasv.getIdMesaVenta() + "</h2><br><br><h4>Personas Aprox:" + mesasv.getPersonasAprox() + "</h4></a></li> ");


            }
            out.println("</ul>");
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
