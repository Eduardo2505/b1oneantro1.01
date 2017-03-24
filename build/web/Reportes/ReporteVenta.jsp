<%-- 
    Document   : ReporteVenta
    Created on : 4/05/2013, 06:59:20 PM
    Author     : Eduardo
--%>

<%@page import="java.io.FileInputStream"%>
<%@page import="java.util.Properties"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="com.mapping.MesaVenta"%>
<%@page import="com.dao.impl.Mesa_ventaDaoImpl"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="otrosNOsirve.conexion"%>
<%@page import="com.mapping.Altadia"%>
<%@page import="com.mapping.Empleado"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"

         pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
    <head>

        <title>Reporte</title>
        <%
            HttpSession sesion = request.getSession();
            String idBarra = (String) sesion.getAttribute("idBarra");
            Altadia d = new Altadia();
            String nombre = "", nomMesero = "", tipoEvento = "";

            String idMesero = "", idMesa = "", idComanda = "";
            int idDia = 0;
            String dia = "";
            conexion mysql = new conexion();
            Connection cn = mysql.Conectar();
            PreparedStatement st = null, sta = null;

            ResultSet rs = null, rsa = null;

            String sSQl = "", sSQld = "";
            Empleado em = new Empleado();

            if (idBarra == null) {
                response.sendRedirect("../index.jsp");
            } else {
                nombre = " ByLatino";


                d = (Altadia) sesion.getAttribute("idDia");

                idDia = d.getIdaltadia();
                dia = d.getFecha();

                String op = request.getParameter("op");
                if (op.equals("excel")) {
                    response.setContentType("application/vnd.ms-excel"); //Tipo de fichero.

                    response.setHeader("Content-Disposition", "attachment;filename=\"Venta" + d.getTipoEvento() + "" + dia + ".xls\"");


                } else {

                    out.println(" <script type=\"text/javascript\">\n"
                            + "            function imprSelec(muestra)\n"
                            + "            {\n"
                            + "\n"
                            + "                var ficha = document.getElementById(muestra);\n"
                            + "                var ventimp = window.open(' ', 'popimpr');\n"
                            + "                ventimp.document.write(ficha.innerHTML);\n"
                            + "                ventimp.document.close();\n"
                            + "                ventimp.print();\n"
                            + "                ventimp.close();\n"
                            + "               \n"
                            + "\n"
                            + "\n"
                            + "            }\n"
                            + "\n"
                            + "\n"
                            + "\n"
                            + "        </script> ");

                    Properties propiedades = new Properties();
                    String ruta = getServletContext().getRealPath("/");
                    propiedades
                            .load(new FileInputStream(ruta + "/config/configuracion.properties"));
                    String url = "";
                    if (request.getParameter("pt") == null) {
                        url = propiedades.getProperty("url");
                    } else {
                        url = propiedades.getProperty("urladmin");

                    }
                    out.println(" <div style='text-align: center'><a href='../" + url + "'><button>Regresar</button></a> <button onclick=\"javascript:imprSelec('muestra')\">Imprimir</button></div>");
                }

            }

            double totalCorte = 0, cumple = 0, inter = 0, nunguno = 0, promo = 0, promo10 = 10;
            double valor = 0, valor2 = 0;
            double total = 0, total2 = 0;

        %>

    </head>
    <body>
        <div id="muestra">
            <div style="text-align: center">
                <h4>   B1One

                    TEL. 41 69 18 20</h4>
                <h4>  Reporte del  <%  out.println(dia);%></h4>
            </div>

            <div class="well">
                <table class="table table-striped">
                    <tr><td colspan="2"><h4>########Cuentas Abiertas#######</h4></td></tr>
                    <tr><th>Clave</th><th>Cuenta</th></tr>
                            <%
                                Mesa_ventaDaoImpl dao = new Mesa_ventaDaoImpl();
                                List res = dao.getCuentasAbiertas("Activo", idDia, "");
                                Iterator itr = res.iterator();


                                while (itr.hasNext()) {
                                    MesaVenta ee = (MesaVenta) itr.next();
                                    em = ee.getEmpleado();
                                    out.println("<tr><td>" + em.getEmpleadocol() + "</td><td>" + ee.getIdMesaVenta() + "</td></tr>");
                                }

                                //  out.println("<tr><td>" + e.getNombre() + " " + e.getApellidos() + "</td><td>" + e.getRegistro() + "</td><td><a class=\"btn btn-small\" TARGET='_new' href='ImprimirTarjeta?idUsuario=" + e.getIdCliente() + "&nombre=" + e.getNombre() + " " + e.getApellidos() + "'><i class='icon-print'></i>Imprimir</a></td></tr>");


                            %>
                </table>


                <label><H4>##############REPORTE VENTA##########</h4></label>
                <table class="table table-striped" >
                    <tr><th>Nombre</th><th>Clave</th><th>%</th><th>TOTAL</th></tr>
                            <%

                                try {
                                    NumberFormat formatter = new DecimalFormat("#0.00");


                                    //   sSQld = "select e.Nombre,e.apellidos,mv.idMesa_venta,mv.totalcuenta from empleado e,mesa_venta mv,Comanda c where mv.idMesa_venta=c.idMesa_venta and mv.idEmpleado=e.idEmpleado and mv.idaltadia=" + idDia + " and e.Empleadocol!='CA' and e.Empleadocol!='CAg' and e.Empleadocol!='cac' and e.Empleadocol!='cash' group by mv.idMesa_venta";
                                    //  sSQld = "select e.Nombre,e.apellidos,sum(mv.totalcuenta) from empleado e,mesa_venta mv  where  mv.idEmpleado=e.idEmpleado and mv.idaltadia=" + idDia + " and e.idpuesto!=1  and e.idpuesto!=8 and mv.estado!='Cancelado' group by e.idEmpleado";
                                    sSQld = "select e.Nombre,e.apellidos,e.Empleadocol,ROUND(sum(vc.costo)) as total from venta_comanda vc,comanda c,mesa_venta mv,empleado e where e.idEmpleado=mv.idEmpleado and mv.idMesa_venta=c.idMesa_venta and c.idComanda=vc.idComanda and c.idaltadia=" + idDia + " and mv.estado!='Cancelado' and c.estado!='Cancelado' and e.idpuesto!=1  and e.idpuesto!=8 group by mv.idEmpleado";
                                    st = cn.prepareStatement(sSQld);
                                    rs = st.executeQuery();

                                    while (rs.next()) {

                                        valor = (Float.parseFloat(rs.getString(4)) * .067);
                                        valor2 = Float.parseFloat(rs.getString(4));
                                        out.println("<tr><td>" + rs.getString(1) + " " + rs.getString(2) + "</td><td>" + rs.getString(3) + "</td><td> $ " + formatter.format(valor) + "</td><td> $ " + valor2 + "</td></tr>");

                                        total += valor;
                                        total2 += valor2;

                                    }

                                    out.println("<tr><td></td><td></td><td><h2>$ " + formatter.format(total) + "</h2></td><td><h2>$ " + total2 + "</h2></td></tr>");


                            %>

                </table>
                <label><H4>REPORTE CORTESIA</h4></label>
                <table class="table table-striped">
                    <tr><th>Nombre</th><th>Clave</th><th>TOTAL</th></tr>
                            <%
                                sSQl = "select e.Nombre,e.apellidos,e.Empleadocol,ROUND(sum(vc.costo)) as total from venta_comanda vc,comanda c,mesa_venta mv,empleado e where e.idEmpleado=mv.idEmpleado and mv.idMesa_venta=c.idMesa_venta and c.idComanda=vc.idComanda and c.idaltadia=" + idDia + " and mv.estado!='Cancelado' and c.estado!='Cancelado' and (e.idpuesto=1  or e.idpuesto=8) group by mv.idEmpleado";
                                //  sSQl = "select e.Nombre,e.apellidos,sum(mv.totalcuenta) from empleado e,mesa_venta mv where  mv.idEmpleado=e.idEmpleado and mv.idaltadia=" + idDia + " and (e.idpuesto=1  or e.idpuesto=8) and mv.estado!='Cancelado' and c.estado!='Cancelado' group by e.idEmpleado";
                                sta = cn.prepareStatement(sSQl);
                                rsa = sta.executeQuery();

                                while (rsa.next()) {



                                    inter = Float.parseFloat(rsa.getString(4));
                                    out.println("<tr><td>" + rsa.getString(1) + " " + rsa.getString(2) + "</td><td>" + rsa.getString(3) + "</td><td> $ " + rsa.getString(4) + "</td></tr>");

                                    cumple += inter;

                                }

                                out.println("<tr><td></td><td></td><td><h2>$ " + cumple + "</h2></td></tr>");


                            %>

                </table>
                <table class="table table-striped">
                       <!--  <tr><th colspan="2">VENTA TOTAL :</th><th><h1>$<% out.println(cumple + total);%></h1></th></tr> -->
                </table>

            </div>
            <%
                } catch (SQLException ex) {
                    System.out.println(ex);
                } finally {

                    try {
                        st.close();
                        rs.close();
                        cn.close();
                    } catch (SQLException ex) {
                    }

                }
            %>
        </div>
    </body>
</html>

