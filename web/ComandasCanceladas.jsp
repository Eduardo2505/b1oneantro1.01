<%-- 
    Document   : ComandasCanceladas
    Created on : 29/04/2013, 02:54:35 PM
    Author     : Eduardo
--%>

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
           // Empleado e = new Empleado();
            Altadia d = new Altadia();
            String nombre = "", nomMesero = "", tipoEvento = "";
            String idBarra =(String)sesion.getAttribute("idBarra");
          //  e = (Empleado) sesion.getAttribute("id");
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
            Mesa_ventaDaoImpl mv = new Mesa_ventaDaoImpl();
            MesaVenta mvv = new MesaVenta();
            String clave = "";
            if (idBarra == null) {
                response.sendRedirect("index.jsp");
            } else {
            }
            conexion mysql = new conexion();
            Connection cn = mysql.Conectar();
            PreparedStatement st = null;
            ResultSet rs = null;
            PreparedStatement sta = null;
            ResultSet rsa = null;
            PreparedStatement stac = null;
            ResultSet rsac = null;

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
    <body>

        <div id="muestra">
            <%


                String sSQlc = "select em.Nombre,em.apellidos,em.Empleadocol,mv.idMesa_venta,c.idcomanda,cc.Registro,cc.descripcion from empleado em, mesa_venta mv, comanda c, cancelacion_comanda cc where c.estado='Cancelado' and c.idComanda=cc.idComanda and c.idaltadia=4 and em.idEmpleado=mv.idEmpleado and mv.idMesa_venta=c.idMesa_venta";
                try {
                    stac = cn.prepareStatement(sSQlc);
                    rsac = stac.executeQuery();
                    while (rsac.next()) {

                        //double adicio = Float.parseFloat(rsac.getString(3));
                        out.println("<table >\n"
                                + "                <tr><td colspan=\"4\" style=\" text-align:center\"><b>BRAVA<BR>CANCELADAS<BR><hr></td></tr>\n"
                                + "\n"
                                + "                            <tr><td colspan=\"4\">\n"
                                + "                                    <table>\n"
                                + "\n"
                                + "                                        <tr><td>Mesero:</td><td><h3>" + rsac.getString(1) + " " + rsac.getString(2) + " </h3><td></tr>\n"
                                + "                                        <tr><td>Cleve: </td><td><h3>" + rsac.getString(3) + "</h3><td></tr>\n"
                                + "                                        <tr><td>Cuenta: </td><td>" + rsac.getString(4) + "<td></tr>\n"
                                + "                                        <tr><td>Comanda: </td><td>" + rsac.getString(5) + "<td></tr>\n"
                                + "                                        <tr><td>FECHA: </td><td>" + rsac.getString(6) + "<td></tr>\n"
                                + "                                        <tr><td>Descripción: </td><td>" + rsac.getString(7) + "<td></tr>\n"
                                + "                                    </table>\n"
                                + "\n"
                                + "\n"
                                + "\n"
                                + "                                </td></tr>\n"
                                + "\n"
                                + "\n"
                                + "                            <tr><td colspan=\"4\"> <HR><td></tr>");

                        
                         float sumatotal = 0;
                         String sSQl = "", sSQla = "";


                         out.println("<tr><th colspan='2'>Producto</th><th style='text-align:center'>Cantidad</th></tr>");

                         sSQl = "select CONCAT(p.nombre,'// ',p.tamano,' ml') ,((count(v.idProducto)*p.precio)*(d.porcentaje/100)),count(v.idProducto),d.porcentaje,d.Observaciones,v.idcomanda,v.idVenta_Comandacol,v.Observaciones from producto p,venta_comanda v,comanda c,descuento d where  p.idProducto=v.idProducto and c.idComanda=v.idComanda and v.idDescuento=d.idDescuento and c.idMesa_venta='" + rsac.getString(4)  + "' and v.idcomanda='" + rsac.getString(5) + "' and c.estado='Cancelado'  group by v.idProducto,v.idDescuento,v.estado order by v.registro DESC";
                         st = cn.prepareStatement(sSQl);
                         rs = st.executeQuery();

                         while (rs.next()) {

                         double res = Float.parseFloat(rs.getString(2));
                         sumatotal += res;
                         if (rs.getString(5).equals("")) {//$" + rs.getString(2) + "</td><td>" + rs.getString(3) + "
                         out.println("<tr><td colspan='2'>" + rs.getString(1) + "</td><td style='text-align:center'> " + rs.getString(3) + "</td></tr>");
                         int id = Integer.parseInt(rs.getString(7));
                         sSQla = "select CONCAT(p.nombre,'// ',p.tamano,' ml') as producto ,count(a.idProducto) as cantidad,(count(a.idProducto)*a.precio) as total,a.idAdicionales from producto p,adicionales a where p.idProducto=a.idProducto and idVenta_Comandacol=" + id + "  group by a.idProducto,a.precio";
                         sta = cn.prepareStatement(sSQla);
                         rsa = sta.executeQuery();
                         while (rsa.next()) {
                         out.println("<tr><td width='70px'></td><td style='background-color:yellow'>" + rsa.getString(1) + "</td><td style='background-color:yellow' style='text-align:center'> " + rsa.getString(2) + "</td></tr>");
                                    
                         //double adicioc = Float.parseFloat(rsa.getString(3));
                         //sumatotal += adicioc;
                         }


                         } else {
                         out.println("<tr><td colspan='2'>" + rs.getString(1) + "<br> **" + rs.getString(5) + "**<br>[" + rs.getString(8) + "]</b></td><td style='text-align:center'>" + rs.getString(3) + "</td></tr>");

                         int id = Integer.parseInt(rs.getString(7));
                         sSQla = "select CONCAT(p.nombre,'// ',p.tamano,' ml') as producto ,count(a.idProducto) as cantidad,(count(a.idProducto)*a.precio) as total,a.idAdicionales from producto p,adicionales a where p.idProducto=a.idProducto and idVenta_Comandacol=" + id + "  group by a.idProducto,a.precio";
                         sta = cn.prepareStatement(sSQla);
                         rsa = sta.executeQuery();
                         while (rsa.next()) {
                         out.println("<tr><td width='70px'></td><td style='background-color:yellow'>" + rsa.getString(1) + "</td><td style='background-color:yellow' style='text-align:center'>" + rsa.getString(2) + "</td></tr>");
                         //double adiciov = Float.parseFloat(rsa.getString(3));
                         // sumatotal += adiciov;
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
                    stac.close();
                    rsa.close();
                    rsac.close();
                }
            %>

        </table>
    </div>
            <script Language="JavaScript">

            $(document).ready(function() {
                if (history.forward(1)) {
                    history.replace(history.forward(1));
                    alert("entro");
                }
            });
        </script>
</html>
