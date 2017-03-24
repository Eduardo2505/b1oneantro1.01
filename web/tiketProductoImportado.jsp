<%-- 
    Document   : tiketProductoImportado
    Created on : 9/05/2013, 03:25:43 AM
    Author     : Eduardo
--%>

<%@page import="java.util.logging.Logger"%>
<%@page import="java.util.logging.Level"%>
<%@page import="otrosNOsirve.consultasMysq"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.mapping.Categoria"%>
<%@page import="java.util.List"%>
<%@page import="com.dao.impl.CategoriaDaoImpl"%>
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

            //response.setContentType("application/vnd.ms-excel"); //Tipo de fichero.

            //  response.setHeader("Content-Disposition", "attachment;filename=\"report.xls\"");

        %>
        <title>Reporte</title>
        <%
            HttpSession sesion = request.getSession();

            Altadia d = new Altadia();
            String nombre = "", nomMesero = "", tipoEvento = "";
            String idBarra = (String) sesion.getAttribute("idBarra");
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

            if (idBarra == null) {
                response.sendRedirect("index.jsp");
            } else {
                nombre = " B1One";
                Empleado em = new Empleado();

                d = (Altadia) sesion.getAttribute("idDia");
//out.println(d);
                idDia = d.getIdaltadia();
                dia = d.getFecha();


            }

            double totalCorte = 0, cumple = 0, inter = 0, nunguno = 0, promo = 0, promo10 = 10;

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
        <div style="text-align: center">
            <h4>   B1One
             
                TEL. 41 69 18 20</h4>
            <h4>  Reporte del  <%  out.println(dia);%></h4>
        </div>

        <div class="well">
            <div style="text-align:center">
                <label><H3>REPORTE PRODUCTOS  </h3></label>  </div>



            <table class="table">
                <tr><th colspan="2"><h4>Internacional</h4></th></tr>
                <tr><th>Producto</th><th>Cantidad</th></tr>
                        <%



                            //sSQl="select p.nombre,count(a.idAdicionales) FROM Empleado em, Mesa_venta mv, Comanda c,Venta_Comanda vc,Adicionales a,Producto p where em.idEmpleado=mv.idEmpleado and mv.idMesa_venta=c.idMesa_venta and p.idProducto=a.idProducto and  c.idComanda=vc.idComanda and vc.idVenta_Comandacol=a.idVenta_Comandacol and c.estado='Activo' and em.idBarra like '%%' and c.idaltadia=4 and mv.idaltadia=4 group by a.idProducto";
                            sSQl = "select p.nombre,count(vc.idVenta_Comandacol),(p.precio) from empleado em, producto p,venta_comanda vc,comanda c,mesa_venta mv where vc.idComanda=c.idComanda and p.idProducto=vc.idProducto and c.idaltadia=" + idDia + " and c.estado='Activo' and em.idEmpleado=mv.idEmpleado and mv.idMesa_venta=c.idMesa_venta  and mv.estado!='Cancelado' and p.importacion='Internacional' group by vc.idProducto";
                            // sSQl = "select p.nombre,count(vc.idVenta_Comandacol),vc.Observaciones from Empleado em, Producto p,Venta_Comanda vc,Comanda c,Mesa_venta mv where vc.idComanda=c.idComanda and p.idProducto=vc.idProducto and c.idaltadia=" + idDia + " and c.estado='Activo' and em.idEmpleado=mv.idEmpleado and em.idBarra='Barra 1'and mv.idMesa_venta=c.idMesa_venta group by vc.idProducto";
                            try {
                                st = cn.prepareStatement(sSQl);
                                rs = st.executeQuery();

                                while (rs.next()) {



                                    out.println("<tr><td>" + rs.getString(1).toUpperCase() + "</td><td>" + rs.getString(2) + "</td><td>" + rs.getString(3) + "</td></tr>");


                                };




                        %>

            </table>
            <table class="table">
                <tr><th colspan="2"><h4>Nacional</h4></th></tr>
                <tr><th>Producto</th><th>Cantidad</th></tr>
                        <%



                                //sSQl="select p.nombre,count(a.idAdicionales) FROM Empleado em, Mesa_venta mv, Comanda c,Venta_Comanda vc,Adicionales a,Producto p where em.idEmpleado=mv.idEmpleado and mv.idMesa_venta=c.idMesa_venta and p.idProducto=a.idProducto and  c.idComanda=vc.idComanda and vc.idVenta_Comandacol=a.idVenta_Comandacol and c.estado='Activo' and em.idBarra like '%%' and c.idaltadia=4 and mv.idaltadia=4 group by a.idProducto";
                                sSQlc = "select p.nombre,count(vc.idVenta_Comandacol),(p.precio) from empleado em, producto p,venta_comanda vc,comanda c,mesa_venta mv where vc.idComanda=c.idComanda and p.idProducto=vc.idProducto and c.idaltadia=" + idDia + " and c.estado='Activo' and em.idEmpleado=mv.idEmpleado and mv.idMesa_venta=c.idMesa_venta  and mv.estado!='Cancelado' and p.importacion='Nacional' group by vc.idProducto";
                                // sSQl = "select p.nombre,count(vc.idVenta_Comandacol),vc.Observaciones from Empleado em, Producto p,Venta_Comanda vc,Comanda c,Mesa_venta mv where vc.idComanda=c.idComanda and p.idProducto=vc.idProducto and c.idaltadia=" + idDia + " and c.estado='Activo' and em.idEmpleado=mv.idEmpleado and em.idBarra='Barra 1'and mv.idMesa_venta=c.idMesa_venta group by vc.idProducto";
                                stc = cn.prepareStatement(sSQlc);
                                rsc = stc.executeQuery();

                                while (rsc.next()) {



                                    out.println("<tr><td>" + rsc.getString(1).toUpperCase() + "</td><td>" + rsc.getString(2) + "</td><td>" + rsc.getString(3) + "</td></tr>");


                                };

                            } catch (SQLException ex) {
                                if (cn != null) {
                                    try {
                                        System.err.print("Transaction is being rolled back");
                                        cn.rollback();
                                    } catch (SQLException excep) {
                                    }
                                }
                            } finally {

                                try {
                                    st.close();
                                    rs.close();
                                    cn.close();
                                    stc.close();
                                    rsc.close();
                                } catch (SQLException ex) {
                                }

                            }





                        %>

            </table>



        </div>

    </body>
     <script Language="JavaScript">

           
                if (history.forward(1)) {
                    history.replace(history.forward(1));
                    
                }
          
        </script>
</html>
