

<%@page import="beans.Adicionalesbean"%>
<%@page import="com.dao.impl.AdicionalesComprobarDaoImpl"%>
<%@page import="beans.Comandaventabean"%>
<%@page import="com.dao.impl.CuentaDaoImpl"%>
<%@page import="otrosNOsirve.consultasMysq"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.mapping.CancelacionMesa"%>
<%@page import="java.text.NumberFormat"%>
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

            CancelacionMesa c = new CancelacionMesa();
            String idBarra = (String) sesion.getAttribute("idBarra");
            c = (CancelacionMesa) sesion.getAttribute("Cancelacion");


            String nomMesero = "", clave = "", idMesa = "";
            double total = 0, sub = 0, iva = 0;
            if (idBarra == null) {

                response.sendRedirect("index.jsp");
            } else {
                Empleado em = new Empleado();
                em = (Empleado) sesion.getAttribute("idMesero");

                idMesa = (String) sesion.getAttribute("idMesa");
                nomMesero = em.getNombre() + " " + em.getApellidos();
                //  mvv = mv.bucarPorId(idMesa);
                clave = em.getEmpleadocol();




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

        <div id="muestra">
            <table >
                <tr><td colspan="4" style=" text-align:center"><b>CANCELACION<BR>CUENTA</b><hr></td></tr>

                <tr><td colspan="4">
                        <table>

                            <tr><td>Mesero:</td><td><h4><% out.println(nomMesero.toUpperCase());%></h4><td></tr>
                            <tr><td>Cleve: </td><td><h4><% out.println(clave);%></h4><td></tr>
                            <tr><td>Cuenta: </td><td><% out.println(idMesa);%><td></tr>
                            <tr><td>Autorizado por: </td><td><td></tr>
                            <tr><td colspan="2"><% out.println(c.getAutorizacion());%><td></tr>
                            <tr><td>Observaciones: </td><td><td></tr>
                            <tr><td colspan="2"><% out.println(c.getObservaciones());%><td></tr>
                            <tr><td>Hora: </td><td><% out.println(c.getRegistro());%><td></tr>

                        </table>



                    </td></tr>
                <tr><td colspan="4"> <HR><td></tr>

                <%
                    consultasMysq co = new consultasMysq();
                    int v = co.verificar(idMesa);
                    float sumatotal = 0;
                    float sumita = 0, sumitax = 0;
                    try {
                        if (v != 0) {
                            out.println("<tr><th colspan='2'>Producto</th><th>Cantidad</th><th>Precio</th></tr>");

                            CuentaDaoImpl dac = new CuentaDaoImpl();
                            List resa = dac.getmostrar(idMesa, "adicional");
                            Iterator itra = resa.iterator();
                            while (itra.hasNext()) {
                                Comandaventabean a = (Comandaventabean) itra.next();
                                sumita += a.getTotalcosto();
                                out.println("<tr><td colspan='2'>" + a.getProducto() + "</td><td>" + a.getCantidad() + "</td><td>$ " + a.getTotalcosto() + "</td></tr>");

                                AdicionalesComprobarDaoImpl daoEm = new AdicionalesComprobarDaoImpl();
                                List res = daoEm.getAdicionales(a.getIdventa());
                                Iterator itr = res.iterator();
                                int verMesesa = 0;
                                while (itr.hasNext()) {
                                    Adicionalesbean vcx = (Adicionalesbean) itr.next();
                                    out.println("<tr><td width='70px'></td><td style='background-color:yellow'>" + vcx.getProducto() + "</td><td style='background-color:yellow'>" + vcx.getCantidad() + "</td><td style='background-color:yellow'>$ 0</td><td></td></tr>");



                                }
                                if (a.getTipo().equals("cortesia")) {
                                    out.println("<tr><td></td><td >Autorización </td><td colspan='4' >" + a.getAutorizacion() + "</td></tr>");
                                    out.println("<tr><td></td><td >Observaciones </td><td colspan='4' >" + a.getObservaciones() + "</td></tr>");
                                }
                            }
                            List resax = dac.getmostrar(idMesa, "np");
                            Iterator itrax = resax.iterator();
                            while (itrax.hasNext()) {
                                Comandaventabean a = (Comandaventabean) itrax.next();
                                sumitax += a.getTotalcosto();
                                out.println("<tr><td colspan='2'>" + a.getProducto() + "</td><td>" + a.getCantidad() + "</td><td>$ " + a.getTotalcosto() + "</td></tr>");
                                if (a.getTipo().equals("cortesia")) {
                                    out.println("<tr><td></td><td >Autorización </td><td colspan='4' >" + a.getAutorizacion() + "</td></tr>");
                                    out.println("<tr><td></td><td >Observaciones </td><td colspan='4' >" + a.getObservaciones() + "</td></tr>");
                                }

                            }
                            sumatotal = sumita + sumitax;
                            NumberFormat nf = NumberFormat.getInstance();
                            nf.setMaximumFractionDigits(2);
                            total = sumatotal * (.16);
                            sub = sumatotal - total;
                            iva = sub * (.16);
                            String ste = nf.format(iva);
                %>
                <tr><td ></td><td colspan="3" style="text-align:right">_________________</td></tr>
                <tr><td colspan="2">Subtotal:</td><td>$<%out.println(sub);%> </td></tr>
                <tr><td colspan="2">IVA 16%:</td><td>$<%out.println(ste);%>  </td></tr>
                <tr><td></td><td colspan="3" style="text-align:right">___________________</td></tr>
                <tr><td colspan="2">TOTAL:</td><td><b>$<%out.println(sumatotal);%></b></td></tr>
                <%
                } else {

                %>
                <tr><td ></td><td colspan="3" style="text-align:right"></td></tr>
                <tr><td colspan="2"></td><td></td></tr>
                <tr><td colspan="2"></td><td></td></tr>
                <tr><td></td><td colspan="3" style="text-align:right"></td></tr>
                <tr><td colspan="2"></td><td><b></b></td></tr>
                            <%                                    }
                                } finally {
                                    sesion.setAttribute("idMesa", "SINAsignar");
                                }





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

            out.println("	$(location).attr('href','../Mesas.jsp');");

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

            out.println("<a href=\"../Mesas.jsp\"/><button style=\"height:100px; color:#03F\">SE GENERO TIKET CORRECATEMENTE<BR>ACPETAR<HR>REGRESAR <-- </button></a>");

            // out.println("<a href=\"CajaCover.jsp?dia="+diaS+"\"><button style=\"height:100px; color:#03F\">SE GENERO TIKET CORRECATEMENTE<BR>ACPETAR<HR>REGRESAR <-- </button></a>");
            out.println(" </div>");

        %>
    </body>
</html>
