<%-- 
    Document   : tiketBarra
    Created on : 28-abr-2013, 6:07:43
    Author     : RP
--%>
<%@page import="beans.ReporteBarraBean"%>
<%@page import="com.dao.impl.ReportesDaoImpl"%>
<%@page import="com.dao.impl.ComandaVentaBeansImpl"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.util.Properties"%>
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

        <title>Reporte</title>
        <%
            HttpSession sesion = request.getSession();
            // Empleado e = new Empleado();
            Altadia d = new Altadia();
            String nombre = "", nomMesero = "", tipoEvento = "";
            String idBarra = (String) sesion.getAttribute("idBarra");
            //e = (Empleado) sesion.getAttribute("id");
            String idMesero = "", idMesa = "", idComanda = "";
            int idDia = 0;
            String dia = "";


            if (idBarra == null) {
                response.sendRedirect("index.jsp");
            } else {
                nombre = " B1One";
                Empleado em = new Empleado();

                d = (Altadia) sesion.getAttribute("idDia");
//out.println(d);
                idDia = d.getIdaltadia();
                dia = d.getFecha();
                String op = request.getParameter("op");
                if (op.equals("excel")) {
                    response.setContentType("application/vnd.ms-excel"); //Tipo de fichero.

                    response.setHeader("Content-Disposition", "attachment;filename=\"Barra" + d.getTipoEvento() + "" + dia + ".xls\"");
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
                    String url = "";
                    if (request.getParameter("pt") == null) {
                        url = propiedades.getProperty("url");
                    } else {
                        url = propiedades.getProperty("urladmin");

                    }

                    out.println(" <div style='text-align: center'><a href='" + url + "'><button>Regresar</button></a> <button onclick=\"javascript:imprSelec('muestra')\">Imprimir</button></div>");
                }
            }

            double totalCorte = 0, cumple = 0, inter = 0, nunguno = 0, promo = 0, promo10 = 10;

        %>

    </head>
    <body>

        <div id="muestra">
            <div style="text-align: center">
                <h4>   B1One

                    TEL. 41 69 18 20</h4>
                <h4>  Reporte del  <%  out.println(dia);%></h4>
            </div>

            <div>
                <div style="text-align:center">
                    <label><H3>REPORTE PRODUCTOS  </h3></label>  </div>


                <%

                    consultasMysq con = new consultasMysq();
                    int ver = 0;
                    CategoriaDaoImpl dao = new CategoriaDaoImpl();

                    List res = dao.getFiltro();
                    Iterator itr = res.iterator();
                    while (itr.hasNext()) {
                        Categoria c = (Categoria) itr.next();
                        ver = con.verificarCategria(c.getIdCategoria(), idDia);
                        // out.println(ver);
                        if (ver != 0) {
                %>

                <table class="table">
                    <tr><th colspan="2"><h4><% out.println(c.getIdCategoria().toUpperCase());%></h4></th></tr>
                    <tr><th>Producto</th><th style='text-align:center'>Cantidad</th></tr>
                            <%

                                ReportesDaoImpl daop = new ReportesDaoImpl();
                                List resx = daop.getBarra(idDia,c.getIdCategoria());
                                Iterator itrx = resx.iterator();
                                while (itrx.hasNext()) {
                                      ReporteBarraBean cc = (ReporteBarraBean) itrx.next();
                                    
                                    out.println("<tr><td>" + cc.getProducto() + " "+cc.getMedida()+"</td><td style='text-align:center' >" + cc.getCantida() + "</td></tr>");
                                }

                               



                            %>

                </table>




                <%
                        }


                        // System.out.println(c.getIdCategoria());

                    }



                %>
                <!--  <table >
                      <tr><th></th><th></th></tr>
                      <tr><th></th><th></th></tr>
                      <tr><th></th><th></th></tr>
                      <tr><th></th><th></th></tr>
                      <tr><th></th><th></th></tr>
                  </table>
                  <div style="text-align: center">
  
  
                      <label><H5> DISTRIBUCION </h5></label> 
                  </div>
                  <label><H4> BARRA1 </h4></label>            
                  <table >
  
                      <tr><th>Producto</th><th style='text-align:center' >Cantidad</th></tr>
                <%



                    /*         //sSQl="select p.nombre,count(a.idAdicionales) FROM Empleado em, Mesa_venta mv, Comanda c,Venta_Comanda vc,Adicionales a,Producto p where em.idEmpleado=mv.idEmpleado and mv.idMesa_venta=c.idMesa_venta and p.idProducto=a.idProducto and  c.idComanda=vc.idComanda and vc.idVenta_Comandacol=a.idVenta_Comandacol and c.estado='Activo' and em.idBarra like '%Barra 1%' and c.idaltadia=4 and mv.idaltadia=4 group by a.idProducto";
                     sSQl = "select p.nombre,count(vc.idVenta_Comandacol),vc.Observaciones from empleado em, producto p,venta_comanda vc,comanda c,mesa_venta mv where vc.idComanda=c.idComanda and p.idProducto=vc.idProducto and c.idaltadia=" + idDia + " and c.estado='Activo' and em.idEmpleado=mv.idEmpleado and em.idBarra='Barra 1' and mv.idMesa_venta=c.idMesa_venta and mv.estado!='Cancelado' group by vc.idProducto";
                     // sSQl = "select p.nombre,count(vc.idVenta_Comandacol),vc.Observaciones from Empleado em, Producto p,Venta_Comanda vc,Comanda c,Mesa_venta mv where vc.idComanda=c.idComanda and p.idProducto=vc.idProducto and c.idaltadia=" + idDia + " and c.estado='Activo' and em.idEmpleado=mv.idEmpleado and em.idBarra='Barra 1'and mv.idMesa_venta=c.idMesa_venta group by vc.idProducto";
                     st = cn.prepareStatement(sSQl);
                     rs = st.executeQuery();

                     while (rs.next()) {



                     out.println("<tr><td>" + rs.getString(1).toUpperCase() + "</td><td style='text-align:center' >" + rs.getString(2) + "</td></tr>");


                     };
                     */



                %>

    </table>


    <label><H4> BARRA 2 </h4></label>            
    <table>
        <tr><th>Producto</th><th>Cantidad</th></tr>
                <%


                    /*
                     //sSQl="select p.nombre,count(a.idAdicionales) FROM Empleado em, Mesa_venta mv, Comanda c,Venta_Comanda vc,Adicionales a,Producto p where em.idEmpleado=mv.idEmpleado and mv.idMesa_venta=c.idMesa_venta and p.idProducto=a.idProducto and  c.idComanda=vc.idComanda and vc.idVenta_Comandacol=a.idVenta_Comandacol and c.estado='Activo' and em.idBarra like '%Barra 2%' and c.idaltadia=4 and mv.idaltadia=4 group by a.idProducto";
                     sSQl = "select p.nombre,count(vc.idVenta_Comandacol),vc.Observaciones from empleado em, producto p,venta_comanda vc,comanda c,mesa_venta mv where vc.idComanda=c.idComanda and p.idProducto=vc.idProducto and c.idaltadia=" + idDia + " and c.estado='Activo' and em.idEmpleado=mv.idEmpleado and em.idBarra='Barra 2' and mv.idMesa_venta=c.idMesa_venta and mv.estado!='Cancelado' group by vc.idProducto";
                     // sSQl = "select p.nombre,count(vc.idVenta_Comandacol),vc.Observaciones from Empleado em, Producto p,Venta_Comanda vc,Comanda c,Mesa_venta mv where vc.idComanda=c.idComanda and p.idProducto=vc.idProducto and c.idaltadia=" + idDia + " and c.estado='Activo' and em.idEmpleado=mv.idEmpleado and em.idBarra='Barra 1'and mv.idMesa_venta=c.idMesa_venta group by vc.idProducto";
                     st = cn.prepareStatement(sSQl);
                     rs = st.executeQuery();

                     while (rs.next()) {



                     out.println("<tr><td>" + rs.getString(1).toUpperCase() + "</td><td>" + rs.getString(2) + "</td></tr>");


                     };



                     } catch (SQLException ex) {
                     ex.printStackTrace();
                     if (cn != null) {
                     try {
                     System.err.print("Transaction is being rolled back");
                     cn.rollback();
                     } catch (SQLException excep) {
                     }
                     }
                     }*/
                %>

    </table>
</div>
</div>
<script Language="JavaScript">


if (history.forward(1)) {
    history.replace(history.forward(1));

}

</script>-->


                </body>
                </html>
