<%-- 
    Document   : tiketBarra
    Created on : 28-abr-2013, 6:07:43
    Author     : RP
--%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.util.Properties"%>
<%@page import="com.mapping.Producto"%>
<%@page import="com.dao.impl.ProductoDaoImpl"%>
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
                response.sendRedirect("../index.jsp");
            } else {
                nombre = " ByLatino";
                Empleado em = new Empleado();

                d = (Altadia) sesion.getAttribute("idDia");
//out.println(d);
                idDia = d.getIdaltadia();
                dia = d.getFecha();
                String op = request.getParameter("op");
                if (op.equals("excel")) {

                    response.setContentType("application/vnd.ms-excel"); //Tipo de fichero.

                    response.setHeader("Content-Disposition", "attachment;filename=\"Importados" + d.getTipoEvento() + "" + dia + ".xls\"");


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
                    out.println(" <div style='text-align: center'><a href='../"+url+"'><button>Regresar</button></a> <button onclick=\"javascript:imprSelec('muestra')\">Imprimir</button></div>");
                }


            }

            double sumatota = 0, cumple = 0, inter = 0, nunguno = 0, promo = 0, promo10 = 10;
            double tott = 0;

        %>

    </head>
    <body>
        <div id="muestra" >
        <div style="text-align: center">
            <h4> B1ONE
               
                TEL. 41 69 18 20</h4>
            <h4>  Reporte del  <%  out.println(dia);%></h4>
        </div>

        <div>
            <div style="text-align:center">
                <label><H3>REPORTE PRODUCTOS  </h3></label>  </div>

            <table class="table">
                <%
                    try {
                        consultasMysq con = new consultasMysq();
                        int ver = 0;
                       ProductoDaoImpl dao = new ProductoDaoImpl();

                        List res = dao.getVErSucategorias();
                        Iterator itr = res.iterator();
                        double totaldetota = 0;
                        double subtota = 0;
                        while (itr.hasNext()) {
                            Producto c = (Producto) itr.next();
                            String subcate=c.getImportacion()==null?"":c.getImportacion();
                           
                %>

                <tr><th colspan="2"><h4><% out.println(subcate.toUpperCase());%></h4></th></tr>
                <tr><th>Producto</th><th>Cantidad</th><th>Observacion</th><th>Unitario</th><th>Total</th></tr>
                        <%



                            double sub = 0;
                            double r = 0;


                            //sSQl="select p.nombre,count(a.idAdicionales) FROM Empleado em, Mesa_venta mv, Comanda c,Venta_Comanda vc,Adicionales a,Producto p where em.idEmpleado=mv.idEmpleado and mv.idMesa_venta=c.idMesa_venta and p.idProducto=a.idProducto and  c.idComanda=vc.idComanda and vc.idVenta_Comandacol=a.idVenta_Comandacol and c.estado='Activo' and em.idBarra like '%%' and c.idaltadia=4 and mv.idaltadia=4 group by a.idProducto";
                            sSQl = "select p.nombre,count(vc.idVenta_Comandacol),vc.costo,d.idDescuento from empleado em, producto p,venta_comanda vc,comanda c,mesa_venta mv,descuento d where d.idDescuento=vc.idDescuento and vc.idComanda=c.idComanda and p.idProducto=vc.idProducto and c.idaltadia=" + idDia + " and c.estado='Activo' and em.idEmpleado=mv.idEmpleado and mv.idMesa_venta=c.idMesa_venta  and mv.estado!='Cancelado' and p.importacion='" + c.getImportacion() + "' and em.idEmpleado like '%%' group by vc.idProducto,p.importacion";
                            // sSQl = "select p.nombre,count(vc.idVenta_Comandacol),vc.Observaciones from Empleado em, Producto p,Venta_Comanda vc,Comanda c,Mesa_venta mv where vc.idComanda=c.idComanda and p.idProducto=vc.idProducto and c.idaltadia=" + idDia + " and c.estado='Activo' and em.idEmpleado=mv.idEmpleado and em.idBarra='Barra 1'and mv.idMesa_venta=c.idMesa_venta group by vc.idProducto";
                            st = cn.prepareStatement(sSQl);
                            rs = st.executeQuery();

                            while (rs.next()) {
                                r = Double.parseDouble(rs.getString(3));

                                sub = Integer.parseInt(rs.getString(2)) * r;
                                totaldetota += sub;
                                out.println("<tr><td>" + rs.getString(1).toUpperCase() + "</td><td>" + rs.getString(2) + "</td><td>" + rs.getString(4) + "</td><td> $ " + rs.getString(3) + "</td><td> $ " + sub + "</td></tr>");


                            };




                        %>







                <%

                        


                        // System.out.println(c.getIdCategoria());

                    }

                %>
                <tr><td colspan="5"></td></tr>
                <tr><td colspan="5"></td></tr>
                <tr><td colspan="3"></td><td><h4>TOTAL:</h4></td><td><h4>$ <% out.println(totaldetota);%></h4></td></tr>
            </table>

            <%
                } catch (SQLException ex) {
                    System.out.println(ex);
                } finally {

                    try {
                        System.out.println("TiketBarra");
                        st.close();
                        rs.close();
                        cn.close();
                    } catch (SQLException ex) {
                    }

                }
            %>

        </table>
    </div>
        </div>
</body>
</html>
