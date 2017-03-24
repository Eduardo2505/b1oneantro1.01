<%-- 
    Document   : Pruebas
    Created on : 7/02/2013, 12:24:42 AM
    Author     : Eduardopc
--%>

<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="otrosNOsirve.conexion"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <%

            conexion mysql = new conexion();
            Connection cn = mysql.Conectar();

            ResultSet rs = null;
            PreparedStatement st = null;
            String sSQl = "";


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
                padding-top: 5%;
                padding-bottom: 40px;
            }
            .sidebar-nav {
                padding: 9px 0;
            }
        </style>
        <link href="assets/css/bootstrap-responsive.css" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="css/jquery-ui-1.8.21.custom.css">
    </head>
    <body>
        <script type="text/javascript">
            $(function(){
                $('#from').submit(function(){
                    var data=$(this).serialize();
                    $('#cargar').html('<img src="img/ajax-loader.gif" alt=""/>').fadeOut(1000);
                    $.post('SessionIdMesa',data,function(respuesta){
                        var verir="<div class='ui-widget'><div class='ui-state-error ui-corner-all' style='padding: 0 .7em;'><p><span class='ui-icon ui-icon-alert' style='float: left; margin-right: .3em;'></span> <strong>Error:</strong> <br> YA SE ENCUENTRA EL ID DE LA MESA INTENTE OTRO</p></div>";
                       
                        var inres=respuesta.length;
                        alert(inres);			  
                        if(inres==0){
                            // alert("AQui entro");
                            $('#from')[0].reset();               
                            
                            
                            $(location).attr('href',"Comanda_venta.jsp"); 
                          
                        }else{
                            
                            $('#idComanda').focus();
                            $('#cargar').fadeIn(1000).html(verir);
                            
                            
                               
                          
											
                        }
       
                      
			   
                    });
                    return false;
                });
            });
        </script>


        <div id="agregarMesaDiv" class="reveal-modal" style="text-align:center">
            <form id="from">
                <input type="hidden" value="venta" name="tipo">
                <input type="hidden" value="ISAC2-20130206" name="idMesaVenta">
                <label class="label-warning"><H3>#ID COMANDA</H3></label>     


                <input type="text" name="idComanda" id="idComanda" required="" >    

                <br>

                <input type="submit" value="Aceptar" class="btn btn-primary btn-large" >
                <div id="cargar"></div>
            </form>
            <a class="close-reveal-modal">&#215;</a>

        </div>


        <a href="#" data-reveal-id="agregarMesaDiv" data-animation="fadeAndPop" data-animationspeed="300" data-closeonbackgroundclick="true" data-dismissmodalclass="close-reveal-modal" title="TRASLADAR" class="btn btn-primary numHE"> <BR><BR>ver</a>


        <div class="alert alert-block">

            <h4>MODO VER</h4>
            Esta en modo ver así que sólo podra ver la cuenta y consultar los precios de los productos.
        </div>
       
        <script type="text/javascript">
            
            $(document).ready(function() {
                $(".eliminarProducto").click(function(event) {
                                            
                    var idCargoria = $(this).attr("name");
                    //alert(idCargoria)
                    $("#ComandaVirtual").load(idCargoria);
                });
            });
        </script>
        <a href="#" class="eliminarProducto"  name="EliminarProductoController?idIdventComanda=uno"> <img src="img/iconoE.png"></a>
        <a href="#" class="eliminarProducto"  name="EliminarProductoController?idIdventComanda=dos"> <img src="img/iconoE.png"></a>
        <div id="divmostrr">
            
        </div>
    
    </body>

</html>
