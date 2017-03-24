<%-- 
    Document   : Comanda_Cortesia
    Created on : 17/01/2013, 12:08:54 AM
    Author     : Eduardopc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cortesía</title>
        <%
            HttpSession sesion = request.getSession();
            String idMesero = "";
            String nombre = (String) sesion.getAttribute("idusuario");
            if (nombre == null) {
                response.sendRedirect("index.jsp");
            } else {
                idMesero = (String) sesion.getAttribute("idMesero");


            }



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
                padding-top: 60px;
                padding-bottom: 40px;
            }
            .sidebar-nav {
                padding: 9px 0;
            }
        </style>
        <link href="assets/css/bootstrap-responsive.css" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="css/jquery-ui-1.8.21.custom.css">
        <link rel="stylesheet" type="text/css" href="css/style2.css" />

        <!--####################################siti#################-->
        <script>
            $('input').bind('blur', function() {
                $(this).val(function( i, val ) {
                    return val.toUpperCase();
                });
            });
        </script>
        <script type="text/javascript">
       
            $(function(){
                $('#cobro').submit(function(){
                    var data=$(this).serialize();
                    $('#verif').html('<img src="img/ajax-loader.gif" alt=""/>').fadeOut(1000);
                    $.post('CoverController',data,function(respuesta){
                        $('#verif').fadeIn(1000).html(respuesta);
			   
                    });
                    return false;
                });
            });
            $(function(){
                $('#RCortesia').submit(function(){
                    var data=$(this).serialize();
                    $('#verif').html('<img src="img/ajax-loader.gif" alt=""/>').fadeOut(1000);
                    $.post('ImprimeCortesia',data,function(respuesta){
                        $('#verif').fadeIn(1000).html(respuesta);
			   
                    });
                    return false;
                });
            });
            
            $(function(){
                $('#RRerservacion').submit(function(){
                    var data=$(this).serialize();
                   
                    $('#verif').html('<img src="img/ajax-loader.gif" alt=""/>').fadeOut(1000);
                    $.post('ImprimeReservacion',data,function(respuesta){
                        $('#verif').fadeIn(1000).html(respuesta);
			   
                    });
                    return false;
                });
            });
           
        </script>
        <style>
            .numH{
                font-size:23px;
                font-weight:bold;
                height:100px;
                width:180px;

            }
            .num{
                font-size:20px;
                font-weight:bold;
                height:70px;
                width:170px;

            }



        </style>
        <link rel="stylesheet" type="text/css" href="css/BotononesIndex.css">
    </head>
    <body style="overflow:hidden">
    <body id="demo-frame">

        <div class="navbar navbar-fixed-top">
            <div class="navbar-inner">
                <div class="container-fluid">
                    <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </a>
                    <a class="brand" href="#">Usuario:<samp style="font-size:17px"><% out.println(nombre);%></samp></a>
                    <a class="brand" href="#">Mesero(a):<samp style="font-size:17px"><% out.println(nombre);%></samp></a>
                    <div class="btn-group pull-right">
                        <a class="btn dropdown-toggle" data-toggle="dropdown" href="#">
                            <i class="icon-user"></i> Usuario
                            <span class="caret"></span>
                        </a>
                        <ul class="dropdown-menu">

                            <li><a href="closeSessionMesero">Salir</a></li>
                        </ul>
                    </div>

                </div>
            </div>
        </div>

        <table width="100%" style="text-align:center" >
            <tr><td width="35%" style="padding:20px 20px 20px 20px" valign="top">

                    <div class="well" style="OVERFLOW: auto; WIDTH:90%;HEIGHT:490px;padding-top:0%">


                    </div>
                    <button class="btn btn-primary cuenta" type="button">CERARA CUENTA E IMPRIMIR</button>
                </td> 
                <td style="position:absolute; top:10; left:50;" width="64%">
                    <table width="100%">
                        <tr><td width="85%" valign="top" style="padding-right:1%">

                                <div class="well" style="OVERFLOW: auto; WIDTH:93%;HEIGHT:540px;padding-top:0%">

                                    categorias
                                </div>


                            </td>
                            <td>
                                <a href="Menu.jsp" class="btn btn-primary num">SALIR</a>
                                <br><br>
                                <a href="Mesas.jsp" class="btn btn-primary num">MESAS</a>
                                <hr>
                                <form id="fromCategoria">
                                    <input type="hidden" value="c" name="tipo">
                                    <input type="submit" class="btn btn-primary numH" value="CATEGORIAS">
                                </form>
                                <hr>
                                <form id="fromCategoria">
                                    <input type="hidden" value="P" name="tipo">
                                    <input type="submit" class="btn btn-primary numH" value="PRODUCTO">
                                </form>
                                <hr>
                                <input type="radio" id="radio-2-1" name="radio-2-set" class="regular-radio big-radio" checked/><label for="radio-2-1"></label>
                                <samp style="font-weight:bold;font-size:25px">BOTELLA</samp><br>
                                <input type="radio" id="radio-2-2" name="radio-2-set" class="regular-radio big-radio" /><label for="radio-2-2"></label><samp style="font-weight:bold;font-size:25px">COPEO</samp>
                            </td></tr>
                    </table>
                </td>
            </tr>
        </table>
    </body>
</html>
