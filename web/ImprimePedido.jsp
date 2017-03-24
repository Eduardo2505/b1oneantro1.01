<%-- 
    Document   : ImprimePedido
    Created on : 27-abr-2013, 17:44:15
    Author     : RP
--%>

<%@page import="otrosNOsirve.consultasMysq"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <%
            HttpSession sesion = request.getSession();
            //Empleado e = new Empleado();
            Altadia d = new Altadia();
            String nombre = "", nomMesero = "", tipoEvento = "";
             String idBarra =(String)sesion.getAttribute("idBarra");
            //e = (Empleado) sesion.getAttribute("id");
            String idMesero = "", idMesa = "", idComanda = "", idComandaTras = "", op = "";
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
            Mesa_ventaDaoImpl mv = new Mesa_ventaDaoImpl();
            MesaVenta mvv = new MesaVenta();
            String clave = "";
            if (idBarra == null) {
                response.sendRedirect("index.jsp");
            } else {
               nombre = " ByLatino";
                Empleado em = new Empleado();
                idComanda = (String) sesion.getAttribute("idComanda");
                op = "Imprimir";
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
                    mvv = mv.bucarPorId(idMesa);
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

        <div id="muestra" style="display:none">
            <table >
                <tr><td colspan="4" style=" text-align:center"><b>B1One<BR>PEDIDO<BR><hr></td></tr>

                            <tr><td colspan="4">
                                    <table>

                                        <tr><td>Mesero:</td><td><h3><% out.println(nomMesero.toUpperCase());%></h3><td></tr>
                                        <tr><td>Cleve: </td><td><h3><% out.println(clave);%></h3><td></tr>
                                        <tr><td>Cuenta: </td><td><% out.println(idMesa);%><td></tr>
                                        <tr><td>Comanda: </td><td><% out.println(idComanda);%><td></tr>
                                        <tr><td>FECHA: </td><td><% out.println(fechaAc);%><td></tr>
                                        <tr><td>HORA: </td><td><% out.println(horaAc);%><td></tr>
                                    </table>



                                </td></tr>
                            <tr><td colspan="4"> <HR><td></tr>

                            <%
                                conexion mysql = new conexion();
                                Connection cn = mysql.Conectar();
                                PreparedStatement st = null;
                                ResultSet rs = null;
                                PreparedStatement sta = null;
                                ResultSet rsa = null;
                                float sumatotal = 0;
                                String sSQl = "", sSQla = "";
                                try {
                                    if (idComanda.equals("VER")) {
                                        out.println("<tr><th colspan='2'>Producto</th><th style='text-align:center'>Cantidad</th><th>Precio</th></tr>");

                                        sSQl = "select CONCAT(p.nombre,'// ',p.tamano,' ml') ,ROUND((count(v.idProducto)*p.precio)*(d.porcentaje/100)),count(v.idProducto),d.porcentaje,d.Observaciones,v.idcomanda,v.idVenta_Comandacol,v.Observaciones from producto p,venta_comanda v,comanda c,descuento d where  p.idProducto=v.idProducto and c.idComanda=v.idComanda and v.idDescuento=d.idDescuento and c.idMesa_venta='" + idMesa + "' and  v.idcomanda='" + idComanda + "' and c.estado='activo'  group by v.idProducto,v.idDescuento,v.estado order by v.registro DESC";
                                        st = cn.prepareStatement(sSQl);
                                        rs = st.executeQuery();

                                        while (rs.next()) {

                                            double res = Float.parseFloat(rs.getString(2));
                                            sumatotal += res;
                                            if (rs.getString(5).equals("")) {//$" + rs.getString(2) + "</td><td>" + rs.getString(3) + "
                                                out.println("<tr><td colspan='2'>" + rs.getString(1) + "</td><td style='text-align:center'> " + rs.getString(3) + "</td><td style='text-align:left'> $ " + rs.getString(2) + "</td></tr>");
                                                int id = Integer.parseInt(rs.getString(7));
                                                sSQla = "select CONCAT(p.nombre,'// ',p.tamano,' ml') as producto ,count(a.idProducto) as cantidad,(count(a.idProducto)*a.precio) as total,a.idAdicionales from producto p,adicionales a where p.idProducto=a.idProducto and idVenta_Comandacol=" + id + "  group by a.idProducto,a.precio";
                                                sta = cn.prepareStatement(sSQla);
                                                rsa = sta.executeQuery();
                                                while (rsa.next()) {
                                                    out.println("<tr><td width='70px'></td><td style='background-color:yellow'>" + rsa.getString(1) + "</td><td style='background-color:yellow'> " + rsa.getString(2) + "</td><td style='background-color:yellow'> $ " + rsa.getString(3) + "</td></tr>");
                                                    double adicio = Float.parseFloat(rsa.getString(3));
                                                    sumatotal += adicio;
                                                }


                                            } else {
                                                out.println("<tr><td colspan='2'>" + rs.getString(1) + "<br>     <b>[" + rs.getString(5) + "<br>**" + rs.getString(8) + "**]</b></td><td style='text-align:center'>" + rs.getString(3) + "</td><td style='text-align:left'> $ " + rs.getString(2) + "</td></tr>");

                                                int id = Integer.parseInt(rs.getString(7));
                                                sSQla = "select CONCAT(p.nombre,'// ',p.tamano,' ml') as producto ,count(a.idProducto) as cantidad,(count(a.idProducto)*a.precio) as total,a.idAdicionales from producto p,adicionales a where p.idProducto=a.idProducto and idVenta_Comandacol=" + id + "  group by a.idProducto,a.precio";
                                                sta = cn.prepareStatement(sSQla);
                                                rsa = sta.executeQuery();
                                                while (rsa.next()) {
                                                    out.println("<tr><td width='70px'></td><td style='background-color:yellow'>" + rsa.getString(1) + "</td><td style='background-color:yellow'>" + rsa.getString(2) + "</td><td style='background-color:yellow'> $ " + rsa.getString(3) + "</td></tr>");
                                                    double adicio = Float.parseFloat(rsa.getString(3));
                                                    sumatotal += adicio;
                                                }
                                            }

                                        };







                                    }
                                } finally {

                                    System.out.println("se cerro conexión.!!!");
                                    cn.close();
                                    st.close();
                                    rs.close();
                                    sta.close();
                                    rsa.close();
                                }




                            %> 

                            <tr><td colspan="4" style="text-align:center"><img src="images/brava.png" width="100" height="100"></td></tr>


            </table>
        </div>

        <%

            String mensaje = "Se imprimio correctamente el tiket";


            out.println(" <script src=\"js/jquery-1.7.2.min.js\"></script>");
            out.println("<script src=\"js/jquery-ui-1.8.21.custom.min.js\"></script>");
            out.println(" <link rel='stylesheet' type='text/css' href='css/jquery-ui-1.8.21.custom.css'>");
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
            if (op.equals("close")) {
                out.println("	$(location).attr('href','CuentasCerradas.jsp');");
            } else {
                out.println("	$(location).attr('href','Comanda_venta.jsp');");
            }
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
            if (op.equals("close")) {
                out.println("<a href=\"CuentasCerradas.jsp\"/><button style=\"height:100px; color:#03F\">SE GENERO TIKET CORRECATEMENTE<BR>ACPETAR<HR>REGRESAR <-- </button></a>");
            } else {
                out.println("<a href=\"Comanda_venta.jsp\"/><button style=\"height:100px; color:#03F\">SE GENERO TIKET CORRECATEMENTE<BR>ACPETAR<HR>REGRESAR <-- </button></a>");
            }
            // out.println("<a href=\"CajaCover.jsp?dia="+diaS+"\"><button style=\"height:100px; color:#03F\">SE GENERO TIKET CORRECATEMENTE<BR>ACPETAR<HR>REGRESAR <-- </button></a>");
            out.println(" </div>");

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
