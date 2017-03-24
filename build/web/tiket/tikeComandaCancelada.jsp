<%-- 
    Document   : tike
    Created on : 9/03/2013, 02:13:35 PM
    Author     : Eduardopc
--%>

<%@page import="beans.Adicionalesbean"%>
<%@page import="com.dao.impl.AdicionalesComprobarDaoImpl"%>
<%@page import="beans.Comandaventabean"%>
<%@page import="com.dao.impl.ComandaVentaBeansImpl"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.mapping.CancelacionComanda"%>
<%@page import="com.mapping.MesaVenta"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="com.dao.impl.Mesa_ventaDaoImpl"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="com.mapping.Producto"%>
<%@page import="com.dao.impl.AdicionalesDaoImpl"%>
<%@page import="com.dao.impl.ComandaDaoImpl"%>
<%@page import="com.mapping.Altadia"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="otrosNOsirve.conexion"%>
<%@page import="com.mapping.Empleado"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Tiket</title>


        <%
            HttpSession sesion = request.getSession();

            Altadia d = new Altadia();
            String nombre = "", nomMesero = "", tipoEvento = "";

            String idMesero = "", idMesa = "", idComanda = "", idComandaTras = "";
            int idDia = 0;
            ComandaDaoImpl daocan = new ComandaDaoImpl();
            AdicionalesDaoImpl daol = new AdicionalesDaoImpl();
            double total = 0, sub = 0, iva = 0;
            Producto p = new Producto();
            List rescan = null;
            Iterator itrcan = null;
            String idBarra = (String) sesion.getAttribute("idBarra");

            Mesa_ventaDaoImpl mv = new Mesa_ventaDaoImpl();
            MesaVenta mvv = new MesaVenta();
            String clave = "";
            CancelacionComanda c = new CancelacionComanda();
            c = (CancelacionComanda) sesion.getAttribute("cancelacion");
            if (idBarra == null) {
                response.sendRedirect("index.jsp");
            } else {
                nombre = " B1ONE";
                Empleado em = new Empleado();
                idComanda = (String) sesion.getAttribute("idComanda");
                idMesa = (String) sesion.getAttribute("idMesa");
                em = (Empleado) sesion.getAttribute("idMesero");
                if (nombre.equals(em.getIdEmpleado())) {
                    response.sendRedirect("Menu.jsp");
                } else {
                    nomMesero = em.getNombre() + " " + em.getApellidos();
                    d = (Altadia) sesion.getAttribute("idDia");
                    idMesero = em.getIdEmpleado();
                    idDia = d.getIdaltadia();
                    tipoEvento = d.getTipoEvento();

                    clave = em.getEmpleadocol();

                }


            }

        %>
        <script type="text/javascript">
            function imprSelec(muestra)
            {
                var ficha = document.getElementById(muestra);
                var ventimp = window.open(' ', 'popimpr');
                ventimp.document.write(ficha.innerHTML);
                ventimp.document.close();
                ventimp.print();
                ventimp.close();
            }
        </script> 

    </head>
    <body onload="javascript:imprSelec('muestra')">

        <div id="muestra" >
            <table >
                <tr><td colspan="4" style=" text-align:center"><b>CANCELACION<BR>COMANDA<BR><hr></td></tr>

                            <tr><td colspan="4">
                                    <table>

                                        <tr><td>Mesero:</td><td><h3><% out.println(nomMesero.toUpperCase());%></h3><td></tr>
                                        <tr><td>Cleve: </td><td><h3><% out.println(clave);%></h3><td></tr>
                                        <tr><td>Cuenta: </td><td><% out.println(idMesa);%><td></tr>
                                        <tr><td>Comanda: </td><td><% out.println(idComanda);%><td></tr>
                                        <tr><td>Autorizado: </td><td><td></tr>
                                        <tr><td colspan="2"><% out.println(c.getAutorizacion());%><td></tr>
                                        <tr><td>Observaciones: </td><td><td></tr>
                                        <tr><td colspan="2"><h5><% out.println(c.getDescripcion());%><h5><td></tr>

                                                        <tr><td>FECHA: </td><td><% out.println(c.getRegistro());%><td></tr>


                                                        </table>



                                                        </td></tr>


                                                        <tr><td colspan="4"> <HR><td></tr>

                                                        <%
                                                            float sumita = 0, sumitax = 0;
                                                            NumberFormat nf = NumberFormat.getInstance();
                                                            nf.setMaximumFractionDigits(2);
                                                            out.println("<table class=\"table table-striped\">");
                                                            out.println("<tr><th colspan='2'>Producto</th><th>Cantidad</th><th>Precio</th><th>Opc</th></tr>");

                                                            ComandaVentaBeansImpl dac = new ComandaVentaBeansImpl();
                                                            List resa = dac.getBuscar(idComanda, "adicional");
                                                            Iterator itra = resa.iterator();
                                                            while (itra.hasNext()) {
                                                                Comandaventabean a = (Comandaventabean) itra.next();
                                                                sumita += a.getTotalcosto();
                                                                out.println("<tr><td colspan='2'> " + a.getProducto() + " " + a.getMedida() + "</td><td>" + a.getCantidad() + "</td><td>$ " + nf.format(a.getTotalcosto()) + "</td></tr>");

                                                                AdicionalesComprobarDaoImpl daoEm = new AdicionalesComprobarDaoImpl();
                                                                List res = daoEm.getAdicionales(a.getIdventa());
                                                                Iterator itr = res.iterator();
                                                                int verMesesa = 0;
                                                                while (itr.hasNext()) {
                                                                    Adicionalesbean vcx = (Adicionalesbean) itr.next();
                                                                    out.println("<tr><td width='70px'></td><td style='background-color:yellow'>" + vcx.getProducto() + " " + vcx.getMedida() + "</td><td style='background-color:yellow'>" + vcx.getCantidad() + "</td><td style='background-color:yellow'>$ 0</td><td></td></tr>");



                                                                }
                                                            }
                                                            List resax = dac.getBuscar(idComanda, "np");
                                                            Iterator itrax = resax.iterator();
                                                            while (itrax.hasNext()) {
                                                                Comandaventabean a = (Comandaventabean) itrax.next();
                                                                sumitax += a.getTotalcosto();
                                                                out.println("<tr><td colspan='2'> " + a.getProducto() + " " + a.getMedida() + "</td><td>" + a.getCantidad() + "</td><td>$ " + nf.format(a.getTotalcosto()) + "</td></tr>");


                                                            }

                                                            out.println(" <tr><td colspan=\"2\"><H3>TOTAL:</h3></td><td><H3>$ " + nf.format((sumita + sumitax)) + "</h3> </td></tr>\n"
                                                                    + "\n"
                                                                    + "                            <tr><td colspan=\"3\" id=\"cargarCerrar\"></td></tr>\n"
                                                                    + "\n"
                                                                    + "\n"
                                                                    + "                        </table>");




                                                        %> 




                                                        </table>
                                                        </div>

                                                        <%

                                                            String mensaje = "Se imprimio correctamente el tiket";


                                                            out.println(" <script src=\"../js/jquery-1.7.2.min.js\"></script>");
                                                            out.println("<script src=\"../js/jquery-ui-1.8.21.custom.min.js\"></script>");
                                                            out.println(" <link rel='stylesheet' type='text/css' href='../css/jquery-ui-1.8.21.custom.css'>");
                                                            out.println("  <style type=\"text/css\">");
                                                            out.println("  body {");
                                                            out.println("    padding-top: 210px;");
                                                            out.println("    </style>");
                                                            out.println(" </head>");
                                                            out.println("<body>");
                                                            out.println("<script>");

                                                            out.println("$(function() {");
                                                            // a workaround for a flaw in the demo system (http://dev.jqueryui.com/ticket/4375), ignore!
                                                            out.println("$( \"#dialog:ui-dialog\" ).dialog( \"disable\" );");

                                                            out.println("$( \"#dialog-message\" ).dialog({");

                                                            out.println("modal: true,");
                                                            out.println("buttons: {");
                                                            out.println("	Ok: function() {");
                                                            out.println("  $( this ).dialog( \"close\" );");
                                                            out.println("	$(location).attr('href','../Comanda_venta.jsp');");
                                                            // out.println("	$(location).attr('href','CajaCover.jsp?dia="+diaS+"');");
                                                            out.println("	}");
                                                            out.println("}");
                                                            out.println("});");
                                                            out.println("});");
                                                            out.println("</script>");

                                                            out.println("   <div id='dialog-message' title='Comprobación'>");
                                                            out.println("<p>");
                                                            out.println(" <br><span class='ui-icon ui-icon-circle-check' style='float:left; margin:0 7px 50px 0;'></span>");
                                                            out.println("         " + mensaje + "");
                                                            out.println("     </p>");

                                                            out.println("</div>");

                                                            out.println("<div align=\"center\">");
                                                            out.println("<a href=\"../Comanda_venta.jsp\"/><button style=\"height:100px; color:#03F\">SE GENERO TIKET CORRECATEMENTE<BR>ACPETAR<HR>REGRESAR <-- </button></a>");
                                                            // out.println("<a href=\"CajaCover.jsp?dia="+diaS+"\"><button style=\"height:100px; color:#03F\">SE GENERO TIKET CORRECATEMENTE<BR>ACPETAR<HR>REGRESAR <-- </button></a>");
                                                            out.println(" </div>");

                                                        %>
                                                        </body>
                                                        </html>
