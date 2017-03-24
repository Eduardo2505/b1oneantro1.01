/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.controller;

import com.dao.impl.Mesa_ventaDaoImpl;
import com.dao.impl.MesasDaoImpl;
import com.dao.impl.ZonaDaoImpl;
import com.mapping.Altadia;
import com.mapping.Empleado;
import com.mapping.MesaVenta;
import com.mapping.Mesas;
import com.mapping.Zona;
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
public class MesasController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String idMesa = request.getParameter("idMesa").toUpperCase().trim();
        String idZona = request.getParameter("idZona");
        //out.print(idMesa + "<br>");
        //out.print(idZona + "<br>");
        HttpSession sesion = request.getSession();
        Empleado e = new Empleado();
        Altadia d = new Altadia();
        e = (Empleado) sesion.getAttribute("idMesero");
        d = (Altadia) sesion.getAttribute("idDia");
        String idEmpleado = e.getIdEmpleado();
        String idMesero = e.getIdEmpleado();
        int idDia = d.getIdaltadia();
        try {
            MesasDaoImpl dao = new MesasDaoImpl();
            Mesas m = new Mesas();
            m = dao.bucarPorId(idMesa);
            //  out.print(m+"<br>");
            if (m == null) {
                // MesasDaoImpl dao = new MesasDaoImpl();
                //int posiscion = m.getPosiscion();
                //out.print(posiscion+ "ddddddddddddddddddddd<br>");
                Zona z = new Zona();
                Mesas m1 = new Mesas();
                m1.setIdMesa(idMesa);
                m1.setEstado("Activo");
                z.setIdzona(idZona);
                m1.setZona(z);
                //m1.setPosiscion(m.getPosiscion());
                dao.insertar(m1);
                /*  Zona z = new Zona();
                 m.setIdMesa(idMesa);
                 m.setEstado("Activo");
                 z.setIdzona(idZona);
                 m.setZona(z);
                 dao.insertar(m);*/
                out.println("<script type=\"text/javascript\">\n"
                        + "            $(function(){\n"
                        + "                $('#formrearMesa').submit(function(){\n"
                        + "                    var data=$(this).serialize();\n"
                        + "                    $('#Info').html('<img src=\"img/ajax-loader.gif\" alt=\"\"/>').fadeOut(1000);\n"
                        + "                    $.post('MesasController',data,function(respuesta){\n"
                        + "                        var verir=\"<div class='ui-widget'><div class='ui-state-error ui-corner-all' style='padding: 0 .7em;'><p><span class='ui-icon ui-icon-alert' style='float: left; margin-right: .3em;'></span> <strong>Error:</strong> <br> YA SE ENCUENTRA EL ID DE LA MESA INTENTE OTRO</p></div>\";\n"
                        + "                       \n"
                        + "                        var inres=respuesta.length;\n"
                        + "							  \n"
                        + "                        if(inres<=0){\n"
                        + "                            $('#idMesain').focus();\n"
                        + "                            $('#Info').fadeIn(1000).html(verir);\n"
                        + "                        }else{\n"
                        + "                            $('#formrearMesa')[0].reset();                       \n"
                        + "                            \n"
                        + "                            \n"
                        + "                            jAlert(\"Se agrego correctamente\", \"Confirmación\", function(r) {  \n"
                        + "                                if(r) {  \n"
                        + "                                    $('#contenidoBody').html(respuesta);\n"
                        + "                                }  \n"
                        + "                            });  \n"
                        + "                          \n"
                        + "											\n"
                        + "                        }\n"
                        + "       \n"
                        + "                      \n"
                        + "			   \n"
                        + "                    });\n"
                        + "                    return false;\n"
                        + "                });\n"
                        + "            });\n"
                        + "            \n"
                        + "            \n"
                        + "            $(function(){\n"
                        + "                $('#AgregarMesa').submit(function(){\n"
                        + "                    var data=$(this).serialize();\n"
                        + "                    //alert(data);\n"
                        + "                    $('#contenidover').html('<img src=\"img/ajax-loader.gif\" alt=\"\"/>').fadeOut(1000);\n"
                        + "                    $.post('Mesa_ventaController',data,function(respuesta){\n"
                        + "                        \n"
                        + "                            $('#AgregarMesa')[0].reset();      \n"
                        + "                        jAlert(\"Se agrego correctamente\", \"Confirmación\", function(r) {  \n"
                        + "                            if(r) {\n"
                        + "                               //  $(location).attr('href','Mesas.jsp');\n"
                        + "                                  $('#contenidoBody').html(respuesta);\n"
                        + "                              //  $(location).attr('href','Mesas.jsp');\n"
                        + "                            }  \n"
                        + "                        });  \n"
                        + "                          \n"
                        + "											\n"
                        + "                        \n"
                        + "      \n"
                        + "                      \n"
                        + "			   \n"
                        + "                    });\n"
                        + "                    return false;\n"
                        + "                });\n"
                        + "            });\n"
                        + "        </script>");
                out.println(" <div id=\"corte\" class=\"reveal-modal\" style=\"text-align:center\">\n"
                        + "                <form name=\"agregar\">\n"
                        + "                    <label class=\"label-warning\"><H1># MESA</H1></label>\n"
                        + "                    <input type=\"text\" name=\"nummesa\" required>\n"
                        + "                    <label class=\"label-warning\"><H1>#PERSONAS APROXIMADAS</H1></label>\n"
                        + "                    <input type=\"number\" name=\"nummesa\" required><br>\n"
                        + "                    <input type=\"submit\" value=\"Agregar\" class=\"btn btn-primary btn-large\" >\n"
                        + "                </form>\n"
                        + "                <a class=\"close-reveal-modal\">&#215;</a>\n"
                        + "\n"
                        + "            </div>\n"
                        + "            <!--###########Crear Mesa#################-->\n"
                        + "            <div id=\"crearMesa\" class=\"reveal-modal\" style=\"text-align:center\">\n"
                        + "                <form id=\"formrearMesa\">\n"
                        + "\n"
                        + "                    <!-- <form action=\"MesasController\">-->\n"
                        + "                    <label class=\"label-warning\"><H1># IDMESA</H1></label>\n"
                        + "                    <input type=\"text\" name=\"idMesa\" id=\"idMesain\" required>\n"
                        + "\n"
                        + "                    <label class=\"label-warning\"><H1>ZONA</H1></label>\n"
                        + "                    <select name=\"idZona\" required>\n"
                        + "                        <option value=\"\">Seleccione</option>");
                ZonaDaoImpl daoz = new ZonaDaoImpl();
                List res = daoz.getZona();
                Iterator itr = res.iterator();
                while (itr.hasNext()) {
                    Zona zona = (Zona) itr.next();
                    out.println("<option value='" + zona.getIdzona() + "'>" + zona.getIdzona() + "</option>");
                }
                out.println("</select>\n"
                        + "                    <br>\n"
                        + "                    <input type=\"submit\" value=\"Agregar\" class=\"btn btn-primary btn-large\" >\n"
                        + "                    <div id=\"Info\">\n"
                        + "                    </div>\n"
                        + "                </form>\n"
                        + "                <a class=\"close-reveal-modal\">&#215;</a>\n"
                        + "\n"
                        + "            </div>\n"
                        + "            <!--###############Agregar mesa################-->\n"
                        + "            <div id=\"agregarMesaDiv\" class=\"reveal-modal\" style=\"text-align:center\">\n"
                        + "                <form id=\"AgregarMesa\">\n"
                        + "                    <label class=\"label-warning\"><H3>#MESA</H3></label>\n"
                        + "                    <select name=\"idMesa\" required>\n"
                        + "                        <option value=\"\">Seleccione</option>");
                MesasDaoImpl daom1 = new MesasDaoImpl();
                List resm = daom1.getMesas("Activo");
                Iterator itrm = resm.iterator();
                while (itrm.hasNext()) {
                    Mesas mesas = (Mesas) itrm.next();
                    out.println("<option value='" + mesas.getIdMesa() + "'>" + mesas.getIdMesa() + "</option>");
                }
                out.println(" </select>\n"
                        + "\n"
                        + "                    <label class=\"label-warning\"><H3>PERSONAS APROX</H3></label>\n"
                        + "                    <input type=\"number\" name=\"persAprox\" required=\"\" >                    \n"
                        + "                    <br>\n"
                        + "\n"
                        + "                    <input type=\"submit\" value=\"Aceptar\" class=\"btn btn-primary btn-large\" >\n"
                        + "                    <div id=\"contenidover\"></div>\n"
                        + "                </form>\n"
                        + "                <a class=\"close-reveal-modal\">&#215;</a>\n"
                        + "\n"
                        + "            </div>\n"
                        + "\n"
                        + "            <div style=\"padding-right:1%\" >\n"
                        + "                <table style=\"text-align:center\" >\n"
                        + "                    <tr><td style=\"padding-left:7%;\" valign=\"top\">\n"
                        + "                            <div style=\"OVERFLOW: auto; WIDTH:1000px;HEIGHT:550px;padding-top:1%\" >\n"
                        + "                                <ul id=\"sortable\">");
                Mesa_ventaDaoImpl daomv = new Mesa_ventaDaoImpl();
                List resmv = daomv.getMesaVenta("Activo", idMesero, idDia);
                MesaVenta mv = new MesaVenta();
                Iterator itrmv = resmv.iterator();
                while (itrmv.hasNext()) {
                    MesaVenta mesasv = (MesaVenta) itrmv.next();
                    mv = daomv.bucarPorId(mesasv.getIdMesaVenta());
                    out.println(" <div id=\"" + mesasv.getIdMesaVenta() + "\" class=\"reveal-modal\" style=\"text-align:center\">"
                            + "<label class=\"label-warning\"><H3>#ACCIONES</H3></label>  \n");

                    out.println("<a href='SessionIdMesaComanda?idMesaVenta=" + mesasv.getIdMesaVenta() + "&idComanda=crear&tipo=venta'  data-animation='fadeAndPop' data-animationspeed='300' data-closeonbackgroundclick='true' data-dismissmodalclass='close-reveal-modal' title='AGREGAR MESA' class='btn btn-primary numHE'> <BR>CREAR<br><BR>COMANDA</a>");
                    out.println("<a href='SessionIdMesaComanda?idMesaVenta=" + mesasv.getIdMesaVenta() + "&idComanda=VER&tipo=venta'  data-animation='fadeAndPop' data-animationspeed='300' data-closeonbackgroundclick='true' data-dismissmodalclass='close-reveal-modal' title='AGREGAR MESA' class='btn btn-primary numHE'> <BR><br>Movimientos</a>");

                    out.println("  <a class=\"close-reveal-modal\">&#215;</a>\n"
                            + "\n"
                            + "        </div>");
                    out.println(" <li class='ui-state-default'><a href='#' class=\"btnli\" data-reveal-id='" + mesasv.getIdMesaVenta() + "' data-animation='fadeAndPop' data-animationspeed='300' data-closeonbackgroundclick='true' data-dismissmodalclass='close-reveal-modal'><br><br><h2>" + mesasv.getIdMesaVenta() + "</h2><br><br><h4>Personas Aprox:" + mesasv.getPersonasAprox() + "</h4></a></li> ");
                    //out.println(" <li class='ui-state-default'><a href='#' data-reveal-id='" + mesasv.getIdMesaVenta() + "' data-animation='fadeAndPop' data-animationspeed='300' data-closeonbackgroundclick='true' data-dismissmodalclass='close-reveal-modal'>" + mesasv.getIdMesaVenta() + "<br><br><br><h1>$ " + mv.getTotalcuenta() + "</h1><br><br><h4>Personas Aprox:" + mesasv.getPersonasAprox() + "</h4></a></li> ");
                    //out.println("  <li class='ui-state-default'><a href='SessionIdMesa?idMesaVenta=" + mesasv.getIdMesaVenta() + "'></a></li>");

                }
                out.println("</ul>\n"
                        + "                            </div>\n"
                        + "                        </td> \n"
                        + "                        <td valign=\"top\">\n"
                        + "\n"
                        + "                            <table height=\"100%\" >\n"
                        + "                                <tr><td><a href=\"Menu.jsp\"  data-dismissmodalclass=\"close-reveal-modal\" title=\"SALIR\" class=\"btn btn-primary numHE\"><BR><BR>SALIR</a></td><td>\n"
                        + "                                        <a href=\"Cerradas.jsp\"  id=\"coresiasver\"  data-dismissmodalclass=\"close-reveal-modal\" title=\"MESAS CERRADAS\" class=\"btn btn-primary numHE\"><BR><BR>MESAS<br><br>CERRADAS</a>\n"
                        + "                                    </td></tr>\n"
                        + "                                <tr><td><a href=\"#\" data-reveal-id=\"agregarMesaDiv\" data-animation=\"fadeAndPop\" data-animationspeed=\"300\" data-closeonbackgroundclick=\"true\" data-dismissmodalclass=\"close-reveal-modal\" title=\"AGREGAR MESA\" class=\"btn btn-success numHE\"> <BR><BR>AGREGAR<br><br>MESA</a></td>\n"
                        + "                                <tr><td><a href=\"#\" data-reveal-id=\"crearMesa\" data-animation=\"fadeAndPop\" data-animationspeed=\"300\" data-closeonbackgroundclick=\"true\" data-dismissmodalclass=\"close-reveal-modal\" title=\"CREAR MESA\" class=\"btn btn-danger numHE\"> <BR><BR>CREAR<br><br>MESA</a></td><td></td></tr>\n"
                        + "                            </table>   \n"
                        + "\n"
                        + "                        </td>\n"
                        + "                    </tr>\n"
                        + "                </table>\n"
                        + "            </div>");
            } else {
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
