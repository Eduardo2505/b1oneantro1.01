<%-- 
    Document   : tike
    Created on : 9/03/2013, 02:13:35 PM
    Author     : Eduardopc
--%>

<%@page import="java.sql.SQLException"%>
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
            Empleado e = new Empleado();
            Altadia d = new Altadia();
            String nombre = "", nomMesero = "", tipoEvento = "";
            e = (Empleado) sesion.getAttribute("id");
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
            if (e == null) {
                response.sendRedirect("index.jsp");
            } else {
                nombre = e.getNombre() + " " + e.getApellidos();
                Empleado em = new Empleado();
                idComanda = (String) sesion.getAttribute("idComanda");
                op = (String) sesion.getAttribute("op");
                idMesa = (String) sesion.getAttribute("idMesa");
                em = (Empleado) sesion.getAttribute("idMesero");
                if (e.getIdEmpleado().equals(em.getIdEmpleado())) {
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
    <body >

        <div id="muestra">
            <div style="text-align:center">
                <a href="../Comanda_venta.jsp"><h1>REGRESAR</h1></a>
            </div>
            
            <table >
               

                <tr><td colspan="4">
                        <table>

                            <tr><td>Mesero:</td><td><h3><% out.println(nomMesero.toUpperCase());%></h3><td></tr>
                            <tr><td>Cleve: </td><td><h3><% out.println(clave);%></h3><td></tr>
                            <tr><td>Cuenta: </td><td><% out.println(idMesa);%><td></tr>                                        
                            <tr><td>Personas Aprox: </td><td><% out.println(mvv.getPersonasAprox());%><td></tr>
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
                           out.println("<tr><th colspan='2'>Producto</th><th>Cantidad</th><th>Precio</th></tr>");

                                        sSQl = "select CONCAT(p.nombre,'// ',p.tamano,' ml') ,v.costo,count(v.idProducto),d.porcentaje,d.Observaciones,v.idcomanda,v.idVenta_Comandacol,v.Observaciones,c.observa,c.Autorizacion from producto p,venta_comanda v,comanda c,Descuento d where  p.idProducto=v.idProducto and c.idComanda=v.idComanda and v.idDescuento=d.idDescuento and c.idMesa_venta='" + idMesa + "' and c.estado='activo'  group by v.idProducto,v.idDescuento,v.estado order by v.registro DESC";
                                        st = cn.prepareStatement(sSQl);
                                        rs = st.executeQuery();
                                        String obsercort = "", autoriza = "";
                                        while (rs.next()) {
                                            obsercort = rs.getString("c.observa");
                                            autoriza = rs.getString("c.Autorizacion");
                                            double res = Float.parseFloat(rs.getString(2));

                                            //double res = Float.parseFloat(rs.getString(2));

                                            if (rs.getString(5).equals("")) {//$" + rs.getString(2) + "</td><td>" + rs.getString(3) + "

                                                //SE Agrega el codigo de cortesía
                                                out.println("<tr><td colspan='2'>" + rs.getString(1) + "</td><td class='precio'> " + rs.getString(3) + "</td><td> $ " + rs.getString(2) + "</td></tr>");
                                                if (!obsercort.equals("-") && !autoriza.equals("-")) {
                                                    
                                                    out.println("<tr><td colspan='3' style='padding-left:15%'>Cortesía: " + rs.getString("c.observa") + "<BR>Autorización: " + rs.getString("c.Autorizacion") + "</td></tr>");
                                                    
                                                } 
                                                //############################

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
                                                out.println("<tr><td colspan='2'>" + rs.getString(1) + "<h5> ||" + rs.getString(5) + " //" + rs.getString(8) + "</h5></td><td class='precio'>" + rs.getString(3) + "</td><td> $ " + rs.getString(2) + "</td></tr>");
                                                //SE Agrega el codigo de cortesía
                                                if (!obsercort.equals("-") && !autoriza.equals("-")) {
                                                    out.println("<tr><td colspan='3' style='padding-left:15%'>Cortesía: " + rs.getString("c.observa") + "<BR>Autorización: " + rs.getString("c.Autorizacion") + "</td></tr>");
                                                    
                                                } 

                                                //############################
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
                                            sumatotal += res;
                                        };







                        }
                     } catch (SQLException ex) {
                                                                if (cn != null) {
                                                                    try {
                                                                        System.err.print("Transaction is being rolled back");
                                                                        cn.rollback();
                                                                    } catch (SQLException excep) {
                                                                    }
                                                                }
                                                            } finally {

                        System.out.println("se cerro conexión. tikePrevio");
                        cn.close();
                        st.close();
                        rs.close();
                        sta.close();
                        rsa.close();
                    }


                    Mesa_ventaDaoImpl mvt = new Mesa_ventaDaoImpl();
                    //mvt.actualiza(idMesa, sumatotal);
                    NumberFormat nf = NumberFormat.getInstance();
                    nf.setMaximumFractionDigits(2);
                    total = sumatotal * (.16);
                    sub = sumatotal - total;
                    iva = sub * (.16);
                    String ste = nf.format(iva);


                %> 
                <tr><td ></td><td colspan="3" style="text-align:right">_________________</td></tr>
                <tr><td colspan="2">Subtotal:</td><td>$<%out.println(sub);%> </td></tr>
                <tr><td colspan="2">IVA 16%:</td><td>$<%out.println(ste);%>  </td></tr>
                <tr><td></td><td colspan="3" style="text-align:right">___________________</td></tr>
                <tr><td colspan="2">TOTAL:</td><td><b>$<%out.println(sumatotal);%></b></td></tr>
                


            </table>
               <div style="text-align:center">
                <a href="../Comanda_venta.jsp"><h1>REGRESAR</h1></a>
            </div>
        </div>

        
    </body>
</html>
