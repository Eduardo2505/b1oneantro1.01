<%-- 
    Document   : tiketBarra
    Created on : 28-abr-2013, 6:07:43
    Author     : RP
--%>
<%@page import="java.text.NumberFormat"%>
<%@page import="beans.ReporteBarraBean"%>
<%@page import="com.dao.impl.ReportesDaoImpl"%>
<%@page import="java.util.Properties"%>
<%@page import="java.io.FileInputStream"%>
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

                    response.setHeader("Content-Disposition", "attachment;filename=\"BarraCostos" + d.getTipoEvento() + "" + dia + ".xls\"");


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
                    out.println(" <div style='text-align: center'><a href='../" + url + "'><button>Regresar</button></a> <button onclick=\"javascript:imprSelec('muestra')\">Imprimir</button></div>");
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
                        NumberFormat nf = NumberFormat.getInstance();
                        nf.setMaximumFractionDigits(2);
                        consultasMysq con = new consultasMysq();
                        int ver = 0;
                        CategoriaDaoImpl dao = new CategoriaDaoImpl();

                        List res = dao.getFiltro();
                        Iterator itr = res.iterator();
                        double totaldetota = 0;
                        double subtota = 0;
                        while (itr.hasNext()) {
                            Categoria c = (Categoria) itr.next();

                            ver = con.verificarCategria(c.getIdCategoria(), idDia);

                            if (ver != 0) {
                    %>

                    <tr><th colspan="2"><h4><% out.println(c.getIdCategoria().toUpperCase());%></h4></th></tr>
                    <tr><th>Producto</th><th>Cantidad</th><th>Unitario</th><th>Total</th></tr>
                            <%



                                double sub = 0;



                                ReportesDaoImpl daop = new ReportesDaoImpl();
                                List resx = daop.getBarraCosto(idDia, c.getIdCategoria());
                                Iterator itrx = resx.iterator();
                                while (itrx.hasNext()) {
                                    ReporteBarraBean cc = (ReporteBarraBean) itrx.next();
                                    totaldetota += cc.getTotal();
                                    out.println("<tr><td>" + cc.getProducto() + " " + cc.getMedida() + "</td><td>" + cc.getCantida() + "</td><td> $ " + cc.getCosto() + "</td><td> $ " + nf.format(cc.getTotal()) + "</td></tr>");


                                };




                            %>







                    <%


                            }

                            // System.out.println(c.getIdCategoria());

                        }

                        if (totaldetota != 0) {


                    %>
                    <tr><td colspan="5"></td></tr>
                    <tr><td colspan="5"></td></tr>
                    <tr><td colspan="3"></td><td><h4>TOTAL:</h4></td><td><h4>$ <% out.println(nf.format(totaldetota));%></h4></td></tr>
                </table>

                <%
                    }



                %>

                </table>
            </div>
        </div>
    </body>
</html>
