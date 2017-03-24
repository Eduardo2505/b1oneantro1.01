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
            Altadia d = new Altadia();
            d = (Altadia) sesion.getAttribute("idDia");
//out.println(d);

            String dia = d.getFecha();


        %>
        <script src="../assets/js/jquery.js"></script>
        <script src="../assets/js/bootstrap-transition.js"></script>
        <script src="../assets/js/bootstrap-alert.js"></script>
        <script src="../assets/js/bootstrap-modal.js"></script>
        <script src="../assets/js/bootstrap-dropdown.js"></script>
        <script src="../assets/js/bootstrap-scrollspy.js"></script>
        <script src="../assets/js/bootstrap-tab.js"></script>
        <script src="../assets/js/bootstrap-tooltip.js"></script>
        <script src="../assets/js/bootstrap-popover.js"></script>
        <script src="../assets/js/bootstrap-button.js"></script>
        <script src="../assets/js/bootstrap-collapse.js"></script>
        <script src="../assets/js/bootstrap-carousel.js"></script>
        <script src="../assets/js/bootstrap-typeahead.js"></script>
        <script src="../js/jquery-1.7.2.min.js"></script>
        <script src="../js/jquery-ui-1.8.21.custom.min.js"></script>
        <script src="../js/jquery.alerts.js"></script>
        <link rel="stylesheet" type="text/css" href="../js/jquery.alerts.css">

        <script type="text/javascript" src="../js/jquery.reveal.js"></script>
        <link rel="stylesheet" href="../css/reveal.css">
        <!-- ================================Los styles =============================== -->
        <link href="../assets/css/bootstrap.css" rel="stylesheet">
        <link rel='stylesheet' type='text/css' href='../css/jquery.autocomplete.css' />
        <script src='../js/jquery.autocomplete.js'></script>
    </head>
    <body>
        <!-- <div class="navbar navbar-inverse navbar-fixed-top">
             <div class="navbar-inner">
                 <div class="container">
                     <button type="button" class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
                         <span class="icon-bar"></span>
                         <span class="icon-bar"></span>
                         <span class="icon-bar"></span>
                     </button>
                     
                      <a class="brand" href="#"><h1>Reportes del día <% out.println(dia);%></h1></a>
                       
                        <a class="btn-danger btn-large" href="Administrador/Admin.jsp">Regresar</a>
                  
                    
                 </div>
                     
             </div>
         </div>
        <!-- <a href="Menu.jsp">Atras</a>-->
        <!--<a href="tiketBarra.jsp">Barra</a>-->
        <!-- <a href="Reportes/tiketBarra.jsp">BarradINER</a>-->
        <!--  <a href="adicionalesVenta.jsp?desciorio=botella">Adicionales Botella</a>
         <a href="adicionalesVenta.jsp?desciorio=adicionales">Adicionales Cobro</a>-->
        <!--<a href="Reportes/ReporteVenta.jsp"> Reporte</a>
        <a href="Reportes/Cuentas.jsp"> Cuentas</a>-->
        <!-- <a href="Reportes/Cierre.jsp"> Cierre</a>-->

        <!--<a href="tiketProductoImportado.jsp" target="_blank"> Nacionales/Importados</a>-->
        <!--<a href="ReporteHoraVenta" target="_blank"> Reporte Graficas</a>
        <a href="ReporteVentaMesas" target="_blank"> Reporte Cuentas</a>-->
        <a href="Reportes/Cuentas.jsp" class="verbtn"> Cuentas</a>
         <script type="text/javascript">

            $(document).ready(function() {
                $(".verbtn").click(function(event) {
                    var idCargoria = $(this).attr("name");
                    //alert(idCargoria)
                    $("#div_mostrar").load(idCargoria);
                });
            });


        </script>
        <style type="text/css">
           .img{
                width:100px;
                height:100px;

            }	
        </style>
        <div>

            <table style="text-align:center">
                <tr><td>

                        <h5>Reporte Barra</h5>

                    </td>
                    <td><a href="../tiketBarra.jsp?op=excel" class="thumbnail">
                                    <img data-src="holder.js/300x200" src="../images/descargar.png" class="img" alt="">
                        </a></td><td> <a href="#" name="../tiketBarra.jsp?op=consulta" class="thumbnail verbtn">
                                    <img data-src="holder.js/300x200" src="../images/consultar.png" class="img" alt="">
                                </a></td>
                <td>
                        <h5>Costos</h5>
                    </td><td><a href="../Reportes/tiketBarra.jsp?op=excel" class="thumbnail">
                                    <img data-src="holder.js/300x200" src="../images/descargar.png" class="img" alt="">
                        </a></td><td>
                             <a href="#" name="../Reportes/tiketBarra.jsp?op=otro" class="thumbnail verbtn">
                                    <img data-src="holder.js/300x200" src="../images/consultar.png" class="img" alt="">
                                </a>
                        </td></tr>
                <tr><td>
                        <h5>Adicionales</h5>
                    </td><td><a href="../adicionalesVenta.jsp?desciorio=botella&op=excel" class="thumbnail">
                                    <img data-src="holder.js/300x200" src="../images/descargar.png" class="img" alt="">
                        </a></td><td><a href="#" name="../adicionalesVenta.jsp?desciorio=botella&op=otro" class="thumbnail verbtn">
                                    <img data-src="holder.js/300x200" src="../images/consultar.png" class="img" alt="">
                                </a></td>
                <td>
                        <h5>Reporte</h5>
                    </td><td> <a href="../Reportes/ReporteVenta.jsp?op=excel" class="thumbnail">
                                    <img data-src="holder.js/300x200" src="../images/descargar.png" class="img" alt="">
                        </a></td><td><a href="#" name="../Reportes/ReporteVenta.jsp?op=otro" class="thumbnail verbtn">
                                    <img data-src="holder.js/300x200" src="../images/consultar.png" class="img" alt="">
                                </a></td></tr>
                <tr>  <td>
                        <h5>Corte</h5>
                    </td><td><a href="../Reportes/CierreExcel.jsp" class="thumbnail">
                                    <img data-src="holder.js/300x200" src="../images/descargar.png" class="img" alt="">
                        </a></td><td>
                            <a href="#" name="../Reportes/Cierre.jsp" class="thumbnail verbtn">
                                    <img data-src="holder.js/300x200" src="../images/consultar.png" class="img" alt="">
                                </a>
                        </td>
                 <td>
                        <h5>Estadística</h5>
                    </td><td> <a href="../ReporteHoraVenta" target="_blank" class="thumbnail">
                                    <img data-src="holder.js/300x200" src="../images/estadistica.png" class="img" alt="">
                        </a></td><td>
                             <a href="#" name="../ReporteVentaMesas" target="_blank" class="thumbnail">
                                    <img data-src="holder.js/300x200" src="../images/cuentas.jpg" class="img" alt="">
                                </a>
                        </td>
                </tr>


            </table>


        </div>

    </body>
</html>
