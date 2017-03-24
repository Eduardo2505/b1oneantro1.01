<%-- 
    Document   : ReporteCortesias
    Created on : 17/08/2013, 05:04:00 PM
    Author     : Eduardo
--%>

<%@page import="beans.CortesiaBean"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="com.dao.impl.CortesiaBeanDaoImpl"%>
<%@page import="com.mapping.Altadia"%>
<%@page import="com.mapping.Altadia"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="otrosNOsirve.conexion"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cortesías</title>
    </head>
    <body>
        <%
            HttpSession sesion = request.getSession();
            Altadia d = new Altadia();

            d = (Altadia) sesion.getAttribute("idDia");
            String dia = d.getFecha();
            response.setContentType("application/vnd.ms-excel"); //Tipo de fichero.

            response.setHeader("Content-Disposition", "attachment;filename=\"ReporteCortesía" + d.getTipoEvento() + "" + dia + ".xls\"");

        %>
        <div style="text-align: center">
            <h4>   B1One

                TEL. 41 69 18 20</h4>
            <h4>  Reporte del  <%  out.println(dia);%></h4>
        </div>
        <table >
            <tr><th>Producto</th><th>Cantidad</th><th>P/U</th><th>P/T</th><th>Autorización</th><th>Observación</th></tr>

            <%

                CortesiaBeanDaoImpl dao = new CortesiaBeanDaoImpl();
                List resmv = dao.getVer(d.getIdaltadia());
                Iterator itrmv = resmv.iterator();
                float valor = 0, total = 0;
                while (itrmv.hasNext()) {
                    CortesiaBean v = (CortesiaBean) itrmv.next();
                    valor = v.getPreciTotal();
                    out.println("<tr><td> " + v.getProducto() + " "+v.getMedida()+"</td> <td> " + v.getCantidad() + "</td><td> $ " + v.getPreciUnitario() + "</td><td> $ " + valor + "</td><td> " + v.getAutorizacion() + "</td><td> " + v.getObservacion() + "</td></tr>");

                    total += valor;

                }


                out.println("<tr><td> </td> <td> </td><td></td><td><h3>$ " + total + "</h3></td><td> </td><td> </td></tr>");



            %>
        </table>
    </body>
</html>
