<%-- 
    Document   : ReporteVenta
    Created on : 4/05/2013, 06:59:20 PM
    Author     : Eduardo
--%>

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
        <%

            // response.setContentType("application/vnd.ms-excel"); //Tipo de fichero.

            //response.setHeader("Content-Disposition", "attachment;filename=\"report.xls\"");

        %>
        <title>Reporte</title>
        <%
            HttpSession sesion = request.getSession();
            Empleado e = new Empleado();
            Altadia d = new Altadia();
            String nombre = "", nomMesero = "", tipoEvento = "";
            e = (Empleado) sesion.getAttribute("id");
            String idMesero = "", idMesa = "", idComanda = "";
            int idDia = 0;
            String dia = "";
            conexion mysql = new conexion();
            Connection cn = mysql.Conectar();
            PreparedStatement st = null, sta = null;

            ResultSet rs = null, rsa = null;

            String sSQl = "", sSQld = "";


            if (e == null) {
                response.sendRedirect("../index.jsp");
            } else {
                nombre = e.getNombre() + " " + e.getApellidos();
                Empleado em = new Empleado();

                d = (Altadia) sesion.getAttribute("idDia");

                idDia = d.getIdaltadia();
                dia = d.getFecha();


            }

            double totalCorte = 0, cumple = 0, inter = 0, nunguno = 0, promo = 0, promo10 = 10;
            float valor = 0;
            double total = 0;

        %>
        <script src="../assets/js/jquery.js"></script>
        <script src="../assets/js/bootstrap-transition.js"></script>
        <script src="../assets/js/bootstrap-alert.js"></script>
        <script src="../assets/js/bootstrap-modal.js"></script>
        <script src="../assets/js/bootstrap-dropdown.js"></script>
        <script src="../assets/js/bootstrap-scrollspy.js"></script>
        <script src="../assets/js/bootstrap-tab.js"></script>
        <script src="../assets/js/bootstrap-tooltip.js"></script>
        <script src="../assets/js/bootstrap-popover.js"></script>
        <script src="../assets/js/bootstrap-button.js"></script>
        <script src="../assets/js/bootstrap-collapse.js"></script>
        <script src="../assets/js/bootstrap-carousel.js"></script>
        <script src="../assets/js/bootstrap-typeahead.js"></script>
        <script src="../js/jquery-1.7.2.min.js"></script>
        <script src="../js/jquery-ui-1.8.21.custom.min.js"></script>
        <script src="../js/jquery.alerts.js"></script>
        <link rel="stylesheet" type="text/css" href="../js/jquery.alerts.css">

        <script type="text/javascript" src="js/jquery.reveal.js"></script>
        <link rel="stylesheet" href="../css/reveal.css">
        <!-- ================================Los styles =============================== -->
        <link href="../assets/css/bootstrap.css" rel="stylesheet">
        <link rel='stylesheet' type='text/css' href='../css/jquery.autocomplete.css' />
        <script src='../js/jquery.autocomplete.js'></script>
        <style type="text/css">
            body {
                padding-top: 60px;
                padding-bottom: 40px;
            }
            .sidebar-nav {
                padding: 9px 0;
            }
        </style>
        <link href="../assets/css/bootstrap-responsive.css" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="../css/jquery-ui-1.8.21.custom.css">
        <link rel="stylesheet" type="text/css" href="../css/style2.css" />
    </head>
    <body>
        <div style="text-align: center">
            <h4> B1ONE
                TEL. 41 69 18 20</h4>
            <h4>  Reporte del  <%  out.println(dia);%></h4>
        </div>

        <div class="well">

            <label><H4>Combinadas</h4></label>
            <table class="table table-striped">
                <tr><th>Producto</th><th>Mesa</th><th>Saldo</th></tr>
                        <%

                            try {


                                sSQld = "select e.Empleadocol from empleado e,mesa_venta mv,comanda c,venta_comanda vc where e.idEmpleado=mv.idEmpleado and mv.idMesa_venta=c.idMesa_venta and vc.idComanda=c.idComanda and vc.idProducto='CER-ON125' and c.idaltadia=" + idDia + "";
                                st = cn.prepareStatement(sSQld);
                                rs = st.executeQuery();

                                while (rs.next()) {

                                   
                                    out.println("<tr><td>$ " + rs.getString(1) + "</td></tr>");

                                    total += valor;

                                }

                                


                        %>

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
    </body>
</html>

