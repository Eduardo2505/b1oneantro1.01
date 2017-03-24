<%-- 
    Document   : adicionalesVenta
    Created on : 29/04/2013, 01:59:31 PM
    Author     : Eduardo
--%>

<%@page import="beans.Adicionalesbean"%>
<%@page import="com.dao.impl.AdicionalesComprobarDaoImpl"%>
<%@page import="com.mapping.Producto"%>
<%@page import="com.dao.impl.ProductoDaoImpl"%>
<%@page import="jdom.jdom"%>
<%@page import="com.dao.impl.Mesa_ventaDaoImpl"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="com.mapping.Mesas"%>
<%@page import="com.mapping.MesaVenta"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.util.Properties"%>
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
            String ruta = getServletContext().getRealPath("/");
            HttpSession sesion = request.getSession();
            // Empleado e = new Empleado();
            Altadia d = new Altadia();


            d = (Altadia) sesion.getAttribute("idDia");

            int idDia = 0;
            String dia = "", idMesa = "";
            idDia = d.getIdaltadia();
            dia = d.getFecha();
            String op = request.getParameter("op");
            if (op.equals("excel")) {

                response.setContentType("application/vnd.ms-excel"); //Tipo de fichero.

                response.setHeader("Content-Disposition", "attachment;filename=\"Complementos " + d.getTipoEvento() + "" + dia + ".xls\"");

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

                propiedades
                        .load(new FileInputStream(ruta + "/config/configuracion.properties"));
                String url = "";
                if (request.getParameter("pt") == null) {
                    url = propiedades.getProperty("url");
                } else {
                    url = propiedades.getProperty("urladmin");

                }
                out.println(" <div style='text-align: center'><a href='" + url + "'><button>Regresar</button></a> <button onclick=\"javascript:imprSelec('muestra')\">Imprimir</button></div>");
            }



        %>

    </head>
    <body>
        <div id="muestra">
            <div style="text-align: center">
                <h4>  B1ONE

                    TEL. 41 69 18 20</h4>
                <h4>  Reporte del  <%  out.println(dia);%></h4>
            </div>

            <div class="well">
                <label><H3>REPORTE COMPLEMENTOS</h3></label>



                <table class="table table-striped">
                    <tr><th>Producto</th><th>Cantidad</th><th>Categoría</th></tr>
                            <%



                                AdicionalesComprobarDaoImpl dao = new AdicionalesComprobarDaoImpl();
                                List res = dao.getAdicionalesReporte(idDia);
                                Iterator itr = res.iterator();
                                while (itr.hasNext()) {
                                    Adicionalesbean p = (Adicionalesbean) itr.next();

                                    out.println("<tr><td>"+ p.getProducto() + " " + p.getMedida() + "</td><td>" + p.getCantidad() + "</td><td>" + p.getCategoria() + "</td><tr>");



                                }


                            %>

                </table>

            </div>
    </body>
</html>
