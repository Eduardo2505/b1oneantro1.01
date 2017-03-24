<%-- 
    Document   : Reporte
    Created on : 13/02/2013, 11:09:38 PM
    Author     : Eduardopc
--%>

<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="otrosNOsirve.conexion"%>
<%@page import="com.mapping.Altadia"%>
<%@page import="com.mapping.Empleado"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Reporte</title>
        <%
            HttpSession sesion = request.getSession();
            Empleado e = new Empleado();
            Altadia d = new Altadia();
            String nombre = "", nomMesero = "", tipoEvento = "";
            e = (Empleado) sesion.getAttribute("id");
            String idMesero = "", idMesa = "", idComanda = "";
            int idDia = 0;
            conexion mysql = new conexion();
            Connection cn = mysql.Conectar();
            PreparedStatement st = null;
            ResultSet rs = null;
            ResultSet rss = null;
            String sSQl = "";
            if (e == null) {
                response.sendRedirect("index.jsp");
            } else {
                nombre = e.getNombre() + " " + e.getApellidos();
                Empleado em = new Empleado();

                d = (Altadia) sesion.getAttribute("idDia");

                idDia = d.getIdaltadia();



            }



        %>
        <script src="assets/js/jquery.js"></script>
        <script src="assets/js/bootstrap-transition.js"></script>
        <script src="assets/js/bootstrap-alert.js"></script>
        <script src="assets/js/bootstrap-modal.js"></script>
        <script src="assets/js/bootstrap-dropdown.js"></script>
        <script src="assets/js/bootstrap-scrollspy.js"></script>
        <script src="assets/js/bootstrap-tab.js"></script>
        <script src="assets/js/bootstrap-tooltip.js"></script>
        <script src="assets/js/bootstrap-popover.js"></script>
        <script src="assets/js/bootstrap-button.js"></script>
        <script src="assets/js/bootstrap-collapse.js"></script>
        <script src="assets/js/bootstrap-carousel.js"></script>
        <script src="assets/js/bootstrap-typeahead.js"></script>
        <script src="js/jquery-1.7.2.min.js"></script>
        <script src="js/jquery-ui-1.8.21.custom.min.js"></script>
        <script src="js/jquery.alerts.js"></script>
        <link rel="stylesheet" type="text/css" href="js/jquery.alerts.css">

        <script type="text/javascript" src="js/jquery.reveal.js"></script>
        <link rel="stylesheet" href="css/reveal.css">
        <!-- ================================Los styles =============================== -->
        <link href="assets/css/bootstrap.css" rel="stylesheet">
        <link rel='stylesheet' type='text/css' href='css/jquery.autocomplete.css' />
        <script src='js/jquery.autocomplete.js'></script>
        <style type="text/css">
            body {
                padding-top: 60px;
                padding-bottom: 40px;
            }
            .sidebar-nav {
                padding: 9px 0;
            }
        </style>
        <link href="assets/css/bootstrap-responsive.css" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="css/jquery-ui-1.8.21.custom.css">
        <link rel="stylesheet" type="text/css" href="css/style2.css" />
    </head>
    <body>
        <div class="navbar navbar-fixed-top">
            <div class="navbar-inner">
                <div class="container-fluid">
                    <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </a>
                    <a class="brand" href="#">Usuario:<samp style="font-size:17px"><% out.println(nombre);%></samp></a>
                    <a class="brand" href="#">Mesero(a):<samp style="font-size:17px"><% out.println(nombre);%></samp></a>
                    <div class="btn-group pull-right">
                        <a class="btn dropdown-toggle" data-toggle="dropdown" href="#">
                            <i class="icon-user"></i> Usuario
                            <span class="caret"></span>
                        </a>
                        <ul class="dropdown-menu">

                            <li><a href="closeSessionMesero">Salir</a></li>
                        </ul>
                    </div>

                </div>
            </div>
        </div>

        <div class="well">

            <label><H1>REPORTE PRODUCTOS</h1></label>
            <table class="table table-striped">
                <tr><th>Producto</th><th>Cantidas</th></tr>
                <%





                    sSQl = "select p.nombre,count(vc.idVenta_Comandacol) from Producto p,Venta_Comanda vc,Comanda c where vc.idComanda=c.idComanda and p.idProducto=vc.idProducto and c.idaltadia=1 group by vc.idProducto";
                    st = cn.prepareStatement(sSQl);
                    rs = st.executeQuery();

                    while (rs.next()) {



                        out.println("<tr><td>" + rs.getString(1) + "</td><td>" + rs.getString(2) + "</td></tr>");


                    };




                %>

            </table>

            <label><H1>REPORTE VENTA</h1></label>
            <table class="table table-striped">
                <tr><th>Producto</th><th>Mesa</th><th>Saldo</th></tr>
                <%

                    try {


                        String sSQlv = "select e.Nombre,e.apellidos,mv.idMesa_venta,mv.totalcuenta from empleado e,mesa_venta mv where mv.idEmpleado=e.idEmpleado and mv.idaltadia=" + idDia + " group by mv.idMesa_venta";
                        st = cn.prepareStatement(sSQlv);
                        rss = st.executeQuery();
                        float total = 0;
                        while (rss.next()) {
                            float valor = 0;
                            if (rss.getString(4) == null) {
                                valor = 0;
                            } else {

                                valor = Float.parseFloat(rss.getString(4));
                            }

                            out.println("<tr><td>" + rss.getString(1) + " " + rss.getString(2) + "</td><td>" + rss.getString(3) + "</td><td>$ " +  valor  + "</td></tr>");

                            total = valor + valor;
                        }

                        out.println("<tr><td></td><td></td><td><h2>$ " + total + "</h2></td></tr>");
                    } finally {

                        System.out.println("se cerro conexión.!!!");
                        cn.close();
                        st.close();
                        rs.close();
                    }

                %>

            </table>
        </div>
    </body>
</html>
