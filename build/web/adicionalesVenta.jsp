<%-- 
    Document   : adicionalesVenta
    Created on : 29/04/2013, 01:59:31 PM
    Author     : Eduardo
--%>

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
            HttpSession sesion = request.getSession();
            // Empleado e = new Empleado();
            Altadia d = new Altadia();
            String nombre = "", nomMesero = "", tipoEvento = "";
            //e = (Empleado) sesion.getAttribute("id");
            String idMesero = "", idMesa = "", idComanda = "";
            int idDia = 0;
            String dia = "";
            conexion mysql = new conexion();
            Connection cn = mysql.Conectar();
            PreparedStatement st = null, sta = null;
            PreparedStatement stc = null, star = null;
            ResultSet rs = null, rsa = null;
            ResultSet rss = null;
            String sSQl = "", sSQld = "";
            String sSQlc = "", sSQldr = "";
            ResultSet rsc = null, rsar = null;
            String des = request.getParameter("desciorio");
            String idBarra = (String) sesion.getAttribute("idBarra");

            if (idBarra == null) {
                response.sendRedirect("index.jsp");
            } else {
                nombre = " ByLatino";
                Empleado em = new Empleado();

                d = (Altadia) sesion.getAttribute("idDia");

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
                    String ruta = getServletContext().getRealPath("/");
                    propiedades
                            .load(new FileInputStream(ruta + "/config/configuracion.properties"));
                    String url ="";
                    if(request.getParameter("pt")==null){
                        url = propiedades.getProperty("url");
                    }else{
                        url = propiedades.getProperty("urladmin");
                    
                    }
                    out.println(" <div style='text-align: center'><a href='"+url+"'><button>Regresar</button></a> <button onclick=\"javascript:imprSelec('muestra')\">Imprimir</button></div>");
                }


            }

            double totalCorte = 0, cumple = 0, inter = 0, nunguno = 0, promo = 0, promo10 = 10;

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

                <label><H5>CERVEZAS CAMPECHANAS</h5></label>
                <table class="table table-striped">
                    <tr><th>Producto</th><th style="text-align:center">Cantidad</th></tr>
                            <%

                                try {

                                    sSQl = "select p.nombre,count(a.idAdicionales) FROM empleado em, mesa_venta mv, comanda c,venta_comanda vc,adicionales a,producto p where em.idEmpleado=mv.idEmpleado and mv.idMesa_venta=c.idMesa_venta and p.idProducto=a.idProducto and  c.idComanda=vc.idComanda and vc.idVenta_Comandacol=a.idVenta_Comandacol and c.estado='Activo' and em.idBarra like '%%' and c.idaltadia=" + idDia + " and mv.idaltadia=" + idDia + " and a.descripcion='" + des + "' and p.idCategoria='CERVEZA' group by a.idProducto";
                                    //sSQl = "select p.nombre,count(vc.idVenta_Comandacol),vc.Observaciones from Empleado em, Producto p,Venta_Comanda vc,Comanda c,Mesa_venta mv where vc.idComanda=c.idComanda and p.idProducto=vc.idProducto and c.idaltadia=4 and c.estado='Activo' and em.idEmpleado=mv.idEmpleado and em.idBarra like '%%' and mv.idMesa_venta=c.idMesa_venta  and c.estado='Activo' group by vc.idProducto";
                                    // sSQl = "select p.nombre,count(vc.idVenta_Comandacol),vc.Observaciones from Empleado em, Producto p,Venta_Comanda vc,Comanda c,Mesa_venta mv where vc.idComanda=c.idComanda and p.idProducto=vc.idProducto and c.idaltadia=" + idDia + " and c.estado='Activo' and em.idEmpleado=mv.idEmpleado and em.idBarra='Barra 1'and mv.idMesa_venta=c.idMesa_venta group by vc.idProducto";
                                    st = cn.prepareStatement(sSQl);
                                    rs = st.executeQuery();

                                    while (rs.next()) {



                                        out.println("<tr><td>" + rs.getString(1).toUpperCase() + "</td><td style='text-align:center' >" + rs.getString(2) + "</td></tr>");


                                    };



                            %>

                </table>
                <label><H5>BOTELLAS</h5></label>
                <table class="table table-striped">
                    <tr><th>Producto</th><th>Cantidad</th></tr>
                            <%


                                sSQl = "select p.nombre,count(a.idAdicionales) FROM empleado em, mesa_venta mv, comanda c,venta_comanda vc,adicionales a,producto p where em.idEmpleado=mv.idEmpleado and mv.idMesa_venta=c.idMesa_venta and p.idProducto=a.idProducto and  c.idComanda=vc.idComanda and vc.idVenta_Comandacol=a.idVenta_Comandacol and c.estado='Activo' and em.idBarra like '%%' and c.idaltadia=" + idDia + " and mv.idaltadia=" + idDia + " and a.descripcion='" + des + "' and p.idCategoria!='CERVEZA' group by a.idProducto";
                                //sSQl = "select p.nombre,count(vc.idVenta_Comandacol),vc.Observaciones from Empleado em, Producto p,Venta_Comanda vc,Comanda c,Mesa_venta mv where vc.idComanda=c.idComanda and p.idProducto=vc.idProducto and c.idaltadia=4 and c.estado='Activo' and em.idEmpleado=mv.idEmpleado and em.idBarra like '%%' and mv.idMesa_venta=c.idMesa_venta  and c.estado='Activo' group by vc.idProducto";
                                // sSQl = "select p.nombre,count(vc.idVenta_Comandacol),vc.Observaciones from Empleado em, Producto p,Venta_Comanda vc,Comanda c,Mesa_venta mv where vc.idComanda=c.idComanda and p.idProducto=vc.idProducto and c.idaltadia=" + idDia + " and c.estado='Activo' and em.idEmpleado=mv.idEmpleado and em.idBarra='Barra 1'and mv.idMesa_venta=c.idMesa_venta group by vc.idProducto";
                                st = cn.prepareStatement(sSQl);
                                rs = st.executeQuery();

                                while (rs.next()) {



                                    out.println("<tr><td>" + rs.getString(1).toUpperCase() + "</td><td style='text-align:center'>" + rs.getString(2) + "</td></tr>");


                                };



                            %>

                </table>
                <label><H5>COPA</h5></label>
                <table class="table table-striped">
                    <tr><th>Producto</th><th>Cantidad</th></tr>
                            <%


                                    sSQl = "select p.nombre,count(a.idAdicionales) FROM empleado em, mesa_venta mv, comanda c,venta_comanda vc,adicionales a,producto p where em.idEmpleado=mv.idEmpleado and mv.idMesa_venta=c.idMesa_venta and p.idProducto=a.idProducto and  c.idComanda=vc.idComanda and vc.idVenta_Comandacol=a.idVenta_Comandacol and c.estado='Activo' and em.idBarra like '%%' and c.idaltadia=" + idDia + " and mv.idaltadia=" + idDia + " and a.descripcion='Copa' and p.idCategoria!='CERVEZA' group by a.idProducto";
                                    //sSQl = "select p.nombre,count(vc.idVenta_Comandacol),vc.Observaciones from Empleado em, Producto p,Venta_Comanda vc,Comanda c,Mesa_venta mv where vc.idComanda=c.idComanda and p.idProducto=vc.idProducto and c.idaltadia=4 and c.estado='Activo' and em.idEmpleado=mv.idEmpleado and em.idBarra like '%%' and mv.idMesa_venta=c.idMesa_venta  and c.estado='Activo' group by vc.idProducto";
                                    // sSQl = "select p.nombre,count(vc.idVenta_Comandacol),vc.Observaciones from Empleado em, Producto p,Venta_Comanda vc,Comanda c,Mesa_venta mv where vc.idComanda=c.idComanda and p.idProducto=vc.idProducto and c.idaltadia=" + idDia + " and c.estado='Activo' and em.idEmpleado=mv.idEmpleado and em.idBarra='Barra 1'and mv.idMesa_venta=c.idMesa_venta group by vc.idProducto";
                                    st = cn.prepareStatement(sSQl);
                                    rs = st.executeQuery();

                                    while (rs.next()) {



                                        out.println("<tr><td>" + rs.getString(1).toUpperCase() + "</td><td style='text-align:center'>" + rs.getString(2) + "</td></tr>");


                                    };

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

                </table>
            </div>
    </body>
</html>
