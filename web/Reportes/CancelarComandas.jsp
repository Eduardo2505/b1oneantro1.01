<%-- 
    Document   : tike
    Created on : 9/03/2013, 02:13:35 PM
    Author     : Eduardopc
--%>

<%@page import="beans.Adicionalesbean"%>
<%@page import="com.dao.impl.AdicionalesComprobarDaoImpl"%>
<%@page import="beans.Comandaventabean"%>
<%@page import="beans.ComandaCancelada"%>
<%@page import="com.dao.impl.ComandaVentaBeansImpl"%>
<%@page import="com.mapping.Adicionales"%>
<%@page import="com.mapping.CancelacionMesa"%>
<%@page import="com.dao.impl.CancelacionmesaDaoImpl"%>
<%@page import="com.mapping.Mesas"%>
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
            Altadia d = new Altadia();
            String idMesa = "";
            int idDia = 0;
            d = (Altadia) sesion.getAttribute("idDia");

            idDia = d.getIdaltadia();

            Mesa_ventaDaoImpl daomv = new Mesa_ventaDaoImpl();










        %>

        <style type="text/css">
            .obser {
                font-size:10px; }
            </style>

        </head>
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
        <body onload="javascript:imprSelec('muestra')">

            <div id="muestra" >
            <table >
                <tr><td colspan="4" style=" text-align:center">B1ONE<BR>COMANDAS CANCELADAS<hr></td></tr>

                <tr><td colspan="4"><td></tr>
                    <%


                        ComandaVentaBeansImpl daco = new ComandaVentaBeansImpl();
                        List rs = daco.getMostrarCancelacionDatos(idDia);
                        Iterator itrax = rs.iterator();
                        while (itrax.hasNext()) {
                            ComandaCancelada a = (ComandaCancelada) itrax.next();

                            out.println("<tr><th colspan='4' style='text-align:center'>#######idComanda: " + a.getIdComanda() + "########</th></tr>");
                            out.println("<tr><th colspan='4' style='text-align:center'>Mesero: " + a.getNomEmpleado() + " " + a.getApellido() + "</th></tr>");
                            out.println("<tr><th colspan='4' >Observación: " + a.getDescripcionCancelacion() + " <br>Registro: " + a.getRegistro() + "<br> Autorización: " + a.getAutorizacionCancelacion() + "</th></tr>");
                            out.println("<tr><th colspan='2'>Producto</th><th>Cant</th></tr>");

                            ComandaVentaBeansImpl dac = new ComandaVentaBeansImpl();
                            List resa = dac.getMostrarCancelacion(a.getIdComanda(), "adicional");
                            Iterator itra = resa.iterator();
                            while (itra.hasNext()) {
                                Comandaventabean b = (Comandaventabean) itra.next();
                                out.println("<tr><td colspan='2'>" + b.getProducto() + " " + b.getMedida() + "</td><td>" + b.getCantidad() + "</td></tr>");



                                AdicionalesComprobarDaoImpl daoEm = new AdicionalesComprobarDaoImpl();
                                List res = daoEm.getAdicionales(b.getIdventa());
                                Iterator itr = res.iterator();
                                int verMesesa = 0;
                                while (itr.hasNext()) {
                                    Adicionalesbean vcx = (Adicionalesbean) itr.next();
                                    out.println("<tr><td>-----></td><td>" + vcx.getProducto() + " " + vcx.getMedida() + "</td><td>" + vcx.getCantidad() + "</td></tr>");






                                }
                            }
                            List resax = dac.getMostrarCancelacion(a.getIdComanda(), "np");
                            Iterator itraxv = resax.iterator();
                            while (itraxv.hasNext()) {
                                Comandaventabean ac = (Comandaventabean) itraxv.next();
                                out.println("<tr><td colspan='2'>" + ac.getProducto() + " " + ac.getMedida() + "</td><td>" + ac.getCantidad() + "</td></tr>");




                            }


                            //######################

                        }
                        // 


                    %>











            </table>
        </div>


    </body>
</html>
