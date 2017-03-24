<%-- 
    Document   : tike
    Created on : 9/03/2013, 02:13:35 PM
    Author     : Eduardopc
--%>

<%@page import="com.mapping.Descuento"%>
<%@page import="beans.Adicionalesbean"%>
<%@page import="com.dao.impl.AdicionalesComprobarDaoImpl"%>
<%@page import="beans.Comandaventabean"%>
<%@page import="com.dao.impl.CuentaDaoImpl"%>
<%@page import="com.mapping.Mesas"%>
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
            //  Empleado e = new Empleado();
            Altadia d = new Altadia();
            String nombre = "", nomMesero = "", tipoEvento = "";
            String idBarra = (String) sesion.getAttribute("idBarra");
            // e = (Empleado) sesion.getAttribute("id");
            String idMesero = "", idMesa = "", idComanda = "", idComandaTras = "";
            int idDia = 0;
            ComandaDaoImpl daocan = new ComandaDaoImpl();
            AdicionalesDaoImpl daol = new AdicionalesDaoImpl();
            double total = 0, sub = 0, iva = 0;
            Producto p = new Producto();
            List rescan = null;
            Iterator itrcan = null;
            Date ahora = new Date();
            String espacio = " ";
            SimpleDateFormat dateFormat = new SimpleDateFormat("HH:mm:ss");
            SimpleDateFormat dateFormatf = new SimpleDateFormat("yyyy-MM-dd");
            String fechaAc = dateFormatf.format(ahora);
            String horaAc = dateFormat.format(ahora);
            Mesa_ventaDaoImpl daomv = new Mesa_ventaDaoImpl();
            String clave = "";
            if (nombre == null) {
                response.sendRedirect("index.jsp");
            } else {
                nombre = " ByLatino";
                Empleado em = new Empleado();
                //idMesa = (String) sesion.getAttribute("idMesa");
                em = (Empleado) sesion.getAttribute("idMesero");
                if (nombre.equals(em.getIdEmpleado())) {
                    response.sendRedirect("Menu.jsp");
                } else {
                    int a = daomv.MesaAbiertas(em.getIdEmpleado());
                    //out.println(a);

                    if (a > 0) {
                        response.sendRedirect("CuentasCerradas.jsp");
                    } else {
                    }
                    // response.sendRedirect("Menu.jsp");


                    nomMesero = em.getNombre() + " " + em.getApellidos();
                    d = (Altadia) sesion.getAttribute("idDia");
                    idMesero = em.getIdEmpleado();
                    idDia = d.getIdaltadia();
                    tipoEvento = d.getTipoEvento();
                    //mvv = mv.bucarPorId(idMesa);
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
        <style type="text/css">
            .obser {
                font-size:11px; }
            </style>

        </head>
        <body onload="javascript:imprSelec('muestra')">

            <div id="muestra" >
            <table >
                <tr><td colspan="4" style=" text-align:center"><b>-<BR></b><hr></td></tr>
                <tr><td colspan="4">
                        <table>

                            <tr><td>Mesero:</td><td><td></tr>
                            <tr><td colspan="2"><h3><% out.println(nomMesero.toUpperCase());%></h3><td></tr>
                            <tr><td>Cleve: </td><td><h3><% out.println(clave);%></h3><td></tr>                           
                            <tr><td>FECHA: </td><td><% out.println(fechaAc);%><td></tr>
                            <tr><td>HORA: </td><td><% out.println(horaAc);%><td></tr>
                        </table>



                    </td></tr>
                <tr><td colspan="4"> <HR><td></tr>
                        <%


                            float sumatotal = 0, sumcu = 0;
                            float sumita = 0, sumitax = 0;
                            Mesa_ventaDaoImpl mv = new Mesa_ventaDaoImpl();
                            MesaVenta mvv = new MesaVenta();
                            NumberFormat nf = NumberFormat.getInstance();
                            nf.setMaximumFractionDigits(2);
                            //Mesa_ventaDaoImpl daomv = new Mesa_ventaDaoImpl();
                            MesaVenta m = new MesaVenta();
                            Mesas msa = new Mesas();
                            double bucarTota = 0;
                            int cantidad = 0;
                            List resmv = daomv.getMesaVenta("Cerrado", idMesero, idDia);
                            Iterator itrmv = resmv.iterator();
                            while (itrmv.hasNext()) {
                                MesaVenta mesasv = (MesaVenta) itrmv.next();
                                m = daomv.bucarPorId(mesasv.getIdMesaVenta());
                                //   msa=
                                idMesa = mesasv.getIdMesaVenta();
                                //out.println(mesasv.getIdMesaVenta() + "<BR>");
                                out.println("<tr><td colspan='4' style='text-align:center'>######## Cuenta: " + idMesa + " #######<br>"+m.getIdMesaCapturada()+"<td></tr>"
                                        + "<tr><td>Mesa: </td><td colspan='3'>" + m.getPersonasAprox() + "<td></tr>"
                                        + "<tr><td>Personas Aprox: </td><td colspan='3'>" + m.getPersonasAprox() + "<td></tr>");
                                out.println("<tr><td colspan=\"4\" style='text-align:center'> ================================ <td></tr>\n"
                                        + "");
                                out.println("<tr><th colspan='2'>Producto</th><th>Cantidad</th><th>Precio</th></tr>");

                                mvv = mv.bucarPorId(idMesa);
                                CuentaDaoImpl dac = new CuentaDaoImpl();
                                List resa = dac.getmostrar(idMesa, "adicional");
                                Iterator itra = resa.iterator();
                                while (itra.hasNext()) {
                                    Comandaventabean a = (Comandaventabean) itra.next();
                                    sumita += a.getTotalcosto();
                                    out.println("<tr><td colspan='2'>" + a.getProducto() + " " + a.getMedida() + "</td><td>" + a.getCantidad() + "</td><td>$ " + nf.format(a.getTotalcosto()) + "</td></tr>");

                                    AdicionalesComprobarDaoImpl daoEm = new AdicionalesComprobarDaoImpl();
                                    List res = daoEm.getAdicionales(a.getIdventa());
                                    Iterator itr = res.iterator();
                                    int verMesesa = 0;
                                    while (itr.hasNext()) {
                                        Adicionalesbean vcx = (Adicionalesbean) itr.next();
                                        out.println("<tr><td width='70px'></td><td style='background-color:yellow'>" + vcx.getProducto() + " " + vcx.getMedida() + "</td><td style='background-color:yellow'>" + vcx.getCantidad() + "</td><td style='background-color:yellow'>$ 0</td><td></td></tr>");



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
                                    out.println("<tr><td colspan='2'>" + a.getProducto() + " " + a.getMedida() + "</td><td>" + a.getCantidad() + "</td><td>$ " + nf.format(a.getTotalcosto()) + "</td></tr>");
                                    if (a.getTipo().equals("cortesia")) {
                                        out.println("<tr><td></td><td >Autorización </td><td colspan='4' >" + a.getAutorizacion() + "</td></tr>");
                                        out.println("<tr><td></td><td >Observaciones </td><td colspan='4' >" + a.getObservaciones() + "</td></tr>");
                                    }

                                }

                                if (mvv.getObservaciones() != null) {
                                    if (!mvv.getObservaciones().equals("-")) {
                                        out.println("<tr><td></td><td ><h4>Autorización</h4> </td><td colspan='4' ><h4>" + mvv.getAtorizacion() + "</h4></td></tr>");
                                        out.println("<tr><td></td><td ><h4>Observaciones</h4> </td><td colspan='4' ><h4>" + mvv.getObservaciones() + "</h4></td></tr>");
                                        Descuento des = new Descuento();
                                        des = mvv.getDescuento();
                                        out.println("<tr><td></td><td ><h4>Descuento</h4> </td><td colspan='4' ><h4>" + des.getObservaciones() + "</h4></td></tr>");
                                    }
                                }
                              //  float sumatotalx = sumitax + sumita;





                                bucarTota = m.getTotalcuenta();

                                sumcu += bucarTota;
                                out.println("<tr><td colspan=\"4\">.<td></tr>\n"
                                        + "");
                                out.println("<tr><td colspan=\"2\" style='text-align:right'>TOTAL:</td><td><b>$ " + nf.format(bucarTota) + "</b></td></tr>");


                            }




                            out.println(
                                    "<tr><td colspan=\"4\"> <HR><td></tr>\n"
                                    + "");

                            total = sumcu * (.16);
                            sub = sumcu / 1.16;
                            iva = sub * (.16);
                            String ste = nf.format(iva);
                            String stesub = nf.format(sub);
                        %>


                <tr><td ></td><td colspan="3" style="text-align:center">***********************************</td></tr>

                <tr><td ></td><td colspan="2" style="text-align:right">Subtotal: $ </td><td><%out.println(stesub);%></td></tr>
                <tr><td ></td><td colspan="2" style="text-align:right">IVA 16%: $ </td><td><%out.println(ste);%> </td></tr>
                <tr><td ></td><td colspan="2" style="text-align:right"></td><td>_________</td></tr>
                <tr><td ></td><td colspan="2" style="text-align:right">TOTAL: $ </td><td><%out.println(sumcu);%></td></tr>



                <tr><td colspan="4" style="text-align:center"><img src="images/brava.png" width="100" height="100"></td></tr>


            </table>
        </div>

        <%            String mensaje = "Se imprimio correctamente el tiket";

            out.println(
                    " <script src=\"js/jquery-1.7.2.min.js\"></script>");
            out.println(
                    "<script src=\"js/jquery-ui-1.8.21.custom.min.js\"></script>");
            out.println(
                    " <link rel='stylesheet' type='text/css' href='css/jquery-ui-1.8.21.custom.css'>");
            out.println(
                    "  <style type=\"text/css\">");
            out.println(
                    "  body {");
            out.println(
                    "    padding-top: 210px;");
            out.println(
                    "    </style>");
            out.println(
                    " </head>");
            out.println(
                    "<body>");
            out.println(
                    "<script>");

            out.println(
                    "$(function() {");
            // a workaround for a flaw in the demo system (http://dev.jqueryui.com/ticket/4375), ignore!
            out.println(
                    "$( \"#dialog:ui-dialog\" ).dialog( \"disable\" );");

            out.println(
                    "$( \"#dialog-message\" ).dialog({");

            out.println(
                    "modal: true,");
            out.println(
                    "buttons: {");
            out.println(
                    "	Ok: function() {");
            out.println(
                    "  $( this ).dialog( \"close\" );");
            out.println(
                    "	$(location).attr('href','CuentasCerradas.jsp');");
            // out.println("	$(location).attr('href','CajaCover.jsp?dia="+diaS+"');");
            out.println(
                    "	}");
            out.println(
                    "}");
            out.println(
                    "});");
            out.println(
                    "});");
            out.println(
                    "</script>");

            out.println(
                    "   <div id='dialog-message' title='Comprobación'>");
            out.println(
                    "<p>");
            out.println(
                    " <br><span class='ui-icon ui-icon-circle-check' style='float:left; margin:0 7px 50px 0;'></span>");
            out.println(
                    "         " + mensaje + "");
            out.println(
                    "     </p>");

            out.println(
                    "</div>");

            out.println(
                    "<div align=\"center\">");
            out.println(
                    "<a href=\"CuentasCerradas.jsp\"/><button style=\"height:100px; color:#03F\">SE GENERO TIKET CORRECATEMENTE<BR>ACPETAR<HR>REGRESAR <-- </button></a>");
            // out.println("<a href=\"CajaCover.jsp?dia="+diaS+"\"><button style=\"height:100px; color:#03F\">SE GENERO TIKET CORRECATEMENTE<BR>ACPETAR<HR>REGRESAR <-- </button></a>");
            out.println(
                    " </div>");

        %>
    </body>
    <script Language="JavaScript">

            $(document).ready(function() {
                if (history.forward(1)) {
                    history.replace(history.forward(1));
                    alert("entro");
                }
            });
    </script>
</html>
