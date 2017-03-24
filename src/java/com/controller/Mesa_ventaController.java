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
 * @author Eduardopc
 */
public class Mesa_ventaController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String idMesa = request.getParameter("idMesa");
        String idMesaCap = request.getParameter("idMesaCap");
        int persAprox = Integer.parseInt(request.getParameter("persAprox"));
        HttpSession sesion = request.getSession();
        Empleado e = new Empleado();
        Altadia d = new Altadia();
        e = (Empleado) sesion.getAttribute("idMesero");
        d = (Altadia) sesion.getAttribute("idDia");
        String idEmpleado = e.getIdEmpleado();
        int idDia = d.getIdaltadia();
        float inicio = 0;
        String idMesero = e.getIdEmpleado();
        Date ahora = new Date();
        SimpleDateFormat dateFormat = new SimpleDateFormat("HH:mm:ss");
        SimpleDateFormat dateFormatf = new SimpleDateFormat("yyyy-MM-dd");
        String fechaAc = dateFormatf.format(ahora);
        String horaAc = dateFormat.format(ahora);
        String hora = fechaAc + " " + horaAc;

        try {
            MesasDaoImpl daom = new MesasDaoImpl();
            //Mesas m = new Mesas();

            Mesa_ventaDaoImpl dao = new Mesa_ventaDaoImpl();
            MesaVenta m = new MesaVenta();
            Mesas me = new Mesas();
            me = daom.bucarPorId(idMesa);
            Zona z = new Zona();
            z = me.getZona();
            int posicion = me.getPosiscion();
            int a = dao.contar() + 1;
            m.setIdMesaVenta(idMesa + "-" + a);
            me.setIdMesa(idMesa);
            m.setMesas(me);
            m.setPersonasAprox(persAprox);
            m.setEstado("Activo");
            e.setIdEmpleado(idEmpleado);
            m.setEmpleado(e);
            d.setIdaltadia(idDia);
            m.setAltadia(d);
            m.setHoraAbierta(hora);            
            m.setTotalcuenta(inicio);
           // m.setHoraCerrada("0000-00-00 00:00:00");
            float et=0;
            m.setEfectivo(et);
            m.setTarjeta(et);
            m.setTipo(d.getTipoEvento());
            m.setPosicion(posicion);
            Zona zu = new Zona();
            zu.setIdzona(z.getIdzona());
            m.setZona(zu);
            m.setIdMesaCapturada(idMesaCap);
            dao.insertar(m);
            //Actualizar
            // MesasDaoImpl daom = new MesasDaoImpl();
            daom.actulizar(idMesa, "Desactivar");
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
                    + "                });"
                    + "function isNumberKey(evt)\n" +
"                                        {\n" +
"                                            var charCode = (evt.which) ? evt.which : event.keyCode\n" +
"                                            if (charCode > 31 && (charCode < 48 || charCode > 57))\n" +
"                                                return false;\n" +
"\n" +
"                                            return true;\n" +
"                                        }\n"
                    + "            </script>");
            out.println(" <div id=\"agregarMesaDiv\" class=\"reveal-modal\" style=\"text-align:center\">\n"
                    + "                <form id=\"AgregarMesa\">\n"
                    + "                    <label class=\"label-warning\"><H3>#MESA</H3></label>\n"
                    + "                    <input type=\"hidden\" name=\"idMesa\" id=\"idMesaadd\" value=\"\">\n"
                    + "                    <lable><h2 id=\"mesitaverid\"></h2></lable>\n"
                    + "\n"
                    + "                    <label class=\"label-warning\"><H3>PERSONAS APROX</H3></label>\n"
                    + "                    <input type=\"text\" onkeypress=\"return isNumberKey(event)\" name=\"persAprox\" required=\"\" >    \n"
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

            Mesa_ventaDaoImpl daomv = new Mesa_ventaDaoImpl();
            // MesaVenta m = new MesaVenta();


            List resmv = daomv.getMesaVenta("Activo", idMesero, idDia);
            Iterator itrmv = resmv.iterator();
            while (itrmv.hasNext()) {
                MesaVenta mesasv = (MesaVenta) itrmv.next();
                m = daomv.bucarPorId(mesasv.getIdMesaVenta());

                out.println(" <div id=\"" + mesasv.getIdMesaVenta() + "\" class=\"reveal-modal\" style=\"text-align:center\">"
                        + "<label class=\"label-warning\"><H3>#ACCIONES</H3></label>  \n");


                out.println("<a href='SessionIdMesaComanda?idMesaVenta=" + mesasv.getIdMesaVenta() + "&idComanda=crear&tipo=venta&observa=-&autorizacion=-'  data-animation='fadeAndPop' data-animationspeed='300' data-closeonbackgroundclick='true' data-dismissmodalclass='close-reveal-modal' title='CREAR MESA' class='btn btn-primary numHE'> <BR>CREAR<br><BR>COMANDA</a>");
                out.println("<a href='Autorizar.jsp?idMesaVenta=" + mesasv.getIdMesaVenta() + "&idComanda=crear&tipo=cortesia'  data-animation='fadeAndPop' data-animationspeed='300' data-closeonbackgroundclick='true' data-dismissmodalclass='close-reveal-modal' title='CREAR CORTESIA' class='btn btn-primary numHE'> <BR>CREAR<br><BR>CORTESIA</a><br><br>");
                out.println("<a href='SessionIdMesaComanda?idMesaVenta=" + mesasv.getIdMesaVenta() + "&idComanda=VER&tipo=venta&observa=-&autorizacion=-'  data-animation='fadeAndPop' data-animationspeed='300' data-closeonbackgroundclick='true' data-dismissmodalclass='close-reveal-modal' title='MOVIMIENTOS' class='btn btn-primary numHE'> <BR><br>Movimientos</a>");
              //  out.println("<a href='AutorizarDescuento.jsp?idMesaVenta=" + mesasv.getIdMesaVenta() + "&idComanda=crear&tipo=descuento'  data-animation='fadeAndPop' data-animationspeed='300' data-closeonbackgroundclick='true' data-dismissmodalclass='close-reveal-modal' title='Descuentos' class='btn btn-primary numHE'> <BR><br>Descuentos</a>");
                out.println("  <a class=\"close-reveal-modal\">&#215;</a>\n"
                        + "\n"
                        + "        </div>");
               
                out.println(" <li class='ui-state-default ocupado'><a href='#' class=\"btnli\" data-reveal-id='" + mesasv.getIdMesaVenta() + "' data-animation='fadeAndPop' data-animationspeed='300' data-closeonbackgroundclick='true' data-dismissmodalclass='close-reveal-modal'><br><h1>" + m.getIdMesaCapturada() + "</h1><br><br><h4>Personas Aprox:" + mesasv.getPersonasAprox() + "</h4></a></li> ");
               
            }
            // MesasDaoImpl daom = new MesasDaoImpl();
            List resm = daom.getMesas("Activo", idMesero, "");
            Iterator itrm = resm.iterator();
            while (itrm.hasNext()) {
                Mesas mesas = (Mesas) itrm.next();
                out.println(" <li class='ui-state-default imagenVer'><a href='#' class=\"btnli addnewMesa\" data-reveal-id='agregarMesaDiv' data-animation='fadeAndPop' data-animationspeed='300' data-closeonbackgroundclick='true' data-dismissmodalclass='close-reveal-modal' name='" + mesas.getIdMesa() + "'><br><h1>" + mesas.getPosiscion() + "</h1><br><h2>" + mesas.getIdMesa() + "</h2></a></li> ");
            
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
