<%-- 
    Document   : link
    Created on : 4/05/2013, 03:39:18 AM
    Author     : Eduardo
--%>

<%@page import="com.mapping.Altadia"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Administrador</title>
        <%
            HttpSession sesion = request.getSession();
            // Empleado e = new Empleado();
            String superuser = (String) sesion.getAttribute("SusperUsuario");
        
             Integer idpuesto= Integer.parseInt((String) sesion.getAttribute("idpuesto"));
            Altadia d = new Altadia();
            String dia = "";
//out.println(idpuesto);
            if (superuser == null) {
                response.sendRedirect("Menu.jsp");
            } else {
                if (superuser.equals("Admin")) {

                    d = (Altadia) sesion.getAttribute("idDia");
                    dia = d.getFecha();
                } else {
                    response.sendRedirect("Menu.jsp");
                }

            }



        %>

        <!-- ================================Los styles =============================== -->
        <link href="assets/css/bootstrap.css" rel="stylesheet">
        <script src="js/jquery-1.7.2.min.js"></script>
        <script src="js/jquery-ui-1.8.21.custom.min.js"></script>
        <script src="js/jquery.alerts.js"></script>        
        <link rel="stylesheet" type="text/css" href="js/jquery.alerts.css">

    </head>
    <body style="overflow:hidden">


        <style type="text/css">
            .img{
                width:100px;
                height:100px;

            }	
        </style>
        <style type="text/css">
            body {
                padding-top: 4%;
                padding-left:4%;
                padding-right:4%;
                padding-bottom: 40px;
            }

        </style>
        <script type="text/javascript">

            $(document).ready(function() {
                $("#verCuentas").click(function(event) {
                    var idCargoria = $(this).attr("name");
                    //alert(idCargoria)
                    $("#div_mostrar").load(idCargoria);
                });
            });


            $(document).ready(function() {
                $("#reporteAv").click(function(event) {

                    var idCargoria = "http://dfiestadf.com/CoverBy/ReporteXml";
                    $("#reportediarioko").load(idCargoria);
                   jAlert("Se enviara reporte", "Respaldo", function(r) {
                      
                    if (r) {
                    
                     $("#enviarD").load("ReporteEmail");
                    }
                });
                   
                   
                });
            });

        </script>
        <!--<a href="#" id="reporteAv">R</a>-->
        <div id="reportediarioko"></div>
        <div id="enviarD"></div>
        <div>
            <div class="navbar navbar-inverse navbar-fixed-top">
                <div class="navbar-inner">
                    <div class="container">
                        <button type="button" class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                        </button>
                        <a class="brand" href="#">Administración</a>
                        <div class="nav-collapse collapse">
                            <div class="navbar-form pull-right">
                                <a href="SessionReporte?usuario=close&op=close" class="btn btn-large btn-danger">Salir</a>
                            </div>
                        </div><!--/.nav-collapse -->
                    </div>
                </div>
            </div>
 
            <table  style="width:100%">
                <tr><td>

                        <h5>Reporte Barra</h5>

                    </td>
                    <td><a href="tiketBarra.jsp?op=excel" class="thumbnail">
                            <img data-src="holder.js/300x200" src="images/descargar.png" class="img" alt="">
                        </a></td><td> <a href="tiketBarra.jsp?op=consulta&pt=1" class="thumbnail verbtn">
                            <img data-src="holder.js/300x200" src="images/consultar.png" class="img" alt="">
                        </a></td>
                    <td>
                        <h5>Costos</h5>
                    </td><td><a href="Reportes/tiketBarra.jsp?op=excel" class="thumbnail">
                            <img data-src="holder.js/300x200" src="images/descargar.png" class="img" alt="">
                        </a></td><td>
                        <a href="Reportes/tiketBarra.jsp?op=otro&pt=1" class="thumbnail verbtn">
                            <img data-src="holder.js/300x200" src="images/consultar.png" class="img" alt="">
                        </a>
                    </td></tr>
                <tr><td>
                     <!--   <h5>Adicionales</h5>
                    </td><td><a href="adicionalesVenta.jsp?desciorio=botella&op=excel" class="thumbnail">
                            <img data-src="holder.js/300x200" src="images/descargar.png" class="img" alt="">
                        </a></td><td><a href="adicionalesVenta.jsp?desciorio=botella&op=otro&pt=1" class="thumbnail verbtn">
                            <img data-src="holder.js/300x200" src="images/consultar.png" class="img" alt="">
                        </a></td>
                    <td>-->
                        <h5>Reporte</h5>
                    </td><td> <a href="Reportes/ReporteVenta.jsp?op=excel" class="thumbnail">
                            <img data-src="holder.js/300x200" src="images/descargar.png" class="img" alt="">
                        </a></td><td><a href="Reportes/ReporteVenta.jsp?op=otro&pt=1" class="thumbnail verbtn">
                            <img data-src="holder.js/300x200" src="images/consultar.png" class="img" alt="">
                        </a></td></tr>
                <tr><td>
                        <h5>Adicionales Ticket</h5>
                    </td><td><a href="adicionalesVentaticket.jsp?desciorio=botella&op=excel" class="thumbnail">
                            <img data-src="holder.js/300x200" src="images/descargar.png" class="img" alt="">
                        </a></td><td><a href="adicionalesVentaticket.jsp?desciorio=botella&op=otro&pt=1" class="thumbnail verbtn">
                            <img data-src="holder.js/300x200" src="images/consultar.png" class="img" alt="">
                        </a></td>
                    </tr>
                <tr>  <td>
                        <h5>Corte</h5>
                    </td><td><a href="Reportes/CierreExcel.jsp" class="thumbnail">
                            <img data-src="holder.js/300x200" src="images/descargar.png" class="img" alt="">
                        </a></td><td>
                        <a href="Reportes/Cierre.jsp?pt=1" class="thumbnail verbtn">
                            <img data-src="holder.js/300x200" src="images/consultar.png" class="img" alt="">
                        </a>
                    </td>
                    <td>
                        <h5>Estadística</h5>
                    </td><td> <a href="ReporteHoraVenta" target="_blank" class="thumbnail">
                            <img data-src="holder.js/300x200" src="images/estadistica.png" class="img" alt="">
                        </a></td><td>
                        <a href="ReporteVentaMesas" target="_blank" class="thumbnail">
                            <img data-src="holder.js/300x200" src="images/cuentas.jpg" class="img" alt="">
                        </a>
                    </td>
                   <!--  <td>
                      <h5>Importados</h5>
                    </td><td><a href="Reportes/Importados.jsp?op=excel" class="thumbnail">
                            <img data-src="holder.js/300x200" src="images/descargar.png" class="img" alt="">
                        </a></td><td>
                        <a href="Reportes/Importados.jsp?op=otro&pt=1" class="thumbnail verbtn">
                            <img data-src="holder.js/300x200" src="images/consultar.png" class="img" alt="">
                        </a>
                    </td>-->
                    <td><h5> Cortesías </h5> </td><td>
                                    <a href="Reportes/ReporteCortesias.jsp" target="_blank" class="thumbnail">
                                        <img data-src="holder.js/300x200" src="images/excel.png" class="img" alt="">
                                    </a>
                                </td>
                </tr>

 <tr>
                             <td><h5>Cancelaciones Cuentas</h5> </td><td>
                                    <a href="Reportes/CancelarCuentas.jsp" target="_blank" class="thumbnail">
                                        <img data-src="holder.js/300x200" src="images/excel.png" class="img" alt="">
                                    </a>
                                </td>
                                <td><h5>Cancelaciones Comandas</h5> </td><td>
                                    <a href="Reportes/CancelarComandas.jsp" target="_blank" class="thumbnail">
                                        <img data-src="holder.js/300x200" src="images/excel.png" class="img" alt="">
                                    </a>
                                </td>

                            </tr>
            </table>

        </div>

    </body>
</html>
