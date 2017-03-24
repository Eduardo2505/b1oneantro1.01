<%-- 
    Document   : tike
    Created on : 9/03/2013, 02:13:35 PM
    Author     : Eduardopc
--%>

<%@page import="com.mapping.Descuento"%>
<%@page import="beans.Adicionalesbean"%>
<%@page import="com.dao.impl.AdicionalesComprobarDaoImpl"%>
<%@page import="beans.Comandaventabean"%>
<%@page import="com.dao.impl.CuentaDaoImpl"%>
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
                <tr><td colspan="4" style=" text-align:center"><b>B1ONE<BR>CUENTAS CANCELACIONES</b><hr></td></tr>

                <tr><td colspan="4"><td></tr>
                    <%


                        float sumatotal = 0, sumcu = 0;

                        try {

                            MesaVenta m = new MesaVenta();
                            Mesas msa = new Mesas();
                            double bucarTota = 0;
                            List resmv = daomv.getMesaVenta("Cancelado", idDia);
                            Iterator itrmv = resmv.iterator();
                            while (itrmv.hasNext()) {
                                MesaVenta mesasv = (MesaVenta) itrmv.next();
                                idMesa = mesasv.getIdMesaVenta();
                                m = daomv.bucarPorId(mesasv.getIdMesaVenta());
                                Empleado em = new Empleado();
                                em = m.getEmpleado();
                                CancelacionmesaDaoImpl dacx = new CancelacionmesaDaoImpl();
                                CancelacionMesa cmm = new CancelacionMesa();
                                cmm = dacx.getBuscar(idMesa);
                                out.println("<tr><td colspan='4' style='text-align:center'>MESERO: " + em.getNombre() + " " + em.getApellidos() + "<td></tr>"
                                        + "<tr><td colspan='4' style='text-align:center'>######## Cuenta: " + idMesa + " #######<td></tr>"
                                        + "<tr><td>Mesa: </td><td colspan='3'>" + m.getPosicion() + "<td></tr>");

                                out.println("<tr><td colspan='4' style='text-align:center'>CANCELACION<td></tr>"
                                        + "<tr><td>Registro: </td><td colspan='3'>" + cmm.getRegistro() + "<td></tr>"
                                        + "<tr><td>Observaciones: </td><td colspan='3'>" + cmm.getObservaciones() + "<td>"
                                        + "<tr><td>Autorización </td><td colspan='3'>" + cmm.getAutorizacion() + "<td>"
                                        + "</tr>");

                                out.println("<tr><td colspan=\"4\" style='text-align:center'> ================================ <td></tr>\n"
                                        + "");
                                out.println("<tr><th colspan='2'>Producto</th><th>Cantidad</th><th>Precio</th></tr>");
                                StringBuffer resultado = new StringBuffer("");


                                float sumita = 0, sumitax = 0;
                                CuentaDaoImpl dac = new CuentaDaoImpl();
                                List resa = dac.getmostrar(idMesa, "adicional");
                                Iterator itra = resa.iterator();
                                while (itra.hasNext()) {
                                    Comandaventabean a = (Comandaventabean) itra.next();
                                    sumita += a.getTotalcosto();
                                    out.println("<tr><td colspan='2'>" + a.getProducto() + " " + a.getMedida() + "</td><td>" + a.getCantidad() + "</td><td>$ " + a.getTotalcosto() + "</td></tr>");


                                    AdicionalesComprobarDaoImpl daoEm = new AdicionalesComprobarDaoImpl();
                                    List res = daoEm.getAdicionales(a.getIdventa());
                                    Iterator itr = res.iterator();
                                    int verMesesa = 0;
                                    while (itr.hasNext()) {
                                        Adicionalesbean vcx = (Adicionalesbean) itr.next();
                                        out.println("<tr><td colspan='3'>_______" + vcx.getProducto() + " " + vcx.getMedida() + "</td><td>" + vcx.getCantidad() + "</td></tr>");



                                    }
                                    if (a.getTipo().equals("cortesia")) {
                                        out.println("<tr><td>******</td><td colspan='2'>Autorización: </td><td>" + a.getAutorizacion() + "</td></tr>");
                                        out.println("<tr><td>******</td><td colspan='2'>Observaciones: </td><td>" + a.getObservaciones() + "</td></tr>");



                                    }
                                }
                                List resax = dac.getmostrar(idMesa, "np");
                                Iterator itrax = resax.iterator();
                                while (itrax.hasNext()) {
                                    Comandaventabean ax = (Comandaventabean) itrax.next();
                                    sumitax += ax.getTotalcosto();
                                    out.println("<tr><td colspan='2'>" + ax.getProducto() + " " + ax.getMedida() + "</td><td>" + ax.getCantidad() + "</td><td>$ " + ax.getTotalcosto() + "</td></tr>");


                                    if (ax.getTipo().equals("cortesia")) {
                                        out.println("<tr><td>******</td><td colspan='2'>Autorización: </td><td>" + ax.getAutorizacion() + "</td></tr>");
                                        out.println("<tr><td>******</td><td colspan='2'>Observaciones: </td><td>" + ax.getObservaciones() + "</td></tr>");

                                    }

                                }
                                if (!m.getObservaciones().equals("-")) {
                                    out.println("<tr><td colspan='4'>*****************Descuento******************</td></tr>");
                                    out.println("<tr><td>******</td><td colspan='2'>Autorización : </td><td>" + m.getAtorizacion() + "</td></tr>");
                                    out.println("<tr><td>******</td><td colspan='2'>Observaciones: </td><td>" + m.getObservaciones() + "</td></tr>");


                                    Descuento des = new Descuento();
                                    des = m.getDescuento();
                                    resultado.append(des.getObservaciones() + "\n\n");
                                    out.println("<tr><td>******</td><td colspan='3'>" + des.getObservaciones() + "</td></tr>");

                                }
                                NumberFormat nf = NumberFormat.getInstance();
                                nf.setMaximumFractionDigits(2);
                                sumatotal = sumitax + sumita;
                                 out.println("<tr><td></td><td colspan='2'></td><td>_____________</td></tr>");
                                out.println("<tr><td>******</td><td colspan='2'> TOTAL</td><td>$" + sumatotal + "</td></tr>");
                                out.println("<tr><td colspan='4'>*****************FIN DE CUENTA******************</td></tr>");







                               

                            }
                            out.println("<tr><td colspan=\"4\"> <HR><td></tr>\n"
                                    + "");

                        } finally {
                            /* cn.close();
                             st.close();
                             rs.close();
                             sta.close();
                             rsa.close();*/
                        }

                    %>











            </table>
        </div>


    </body>
</html>
