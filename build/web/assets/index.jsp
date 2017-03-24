<%-- 
    Document   : index
    Created on : 17/01/2013, 02:28:44 AM
    Author     : Eduardopc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Punto de Venta</title>
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
        <!-- ================================Los styles =============================== -->
        <link href="assets/css/bootstrap.css" rel="stylesheet">
        <style type="text/css">
            body {
                padding-top: 8%;
                padding-bottom: 40px;
            }
            .sidebar-nav {
                padding: 9px 0;
            }
            .login{
                width:290px;

            }	
        </style>
        <link href="assets/css/bootstrap-responsive.css" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="css/jquery-ui-1.8.21.custom.css">
        <!-- =============================================================================== -->
        <script type="text/javascript">
            $(function(){
                $('#entrar').submit(function(){
                    var data=$(this).serialize();
                    $('#contenido').html('<img src="img/ajax-loader.gif" alt=""/>').fadeOut(1000);
                   
                    $.post('Entrar',data,function(respuesta){
                        // alert(respuesta);
                        
                        if(respuesta=="Empleado"){
                   
                            $(location).attr('href',"Menu.jsp"); 
                        }
                    
                        else{
                     
                            $('#contenido').fadeIn(1000).html(respuesta);
               
                        }
                    });
                    return false;
                });
            });
            
        </script>

    </head>
    <body>
        <div class="navbar navbar-fixed-top">
            <div class="navbar-inner">
                <div class="container-fluid">
                    <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </a>
                    <a class="brand">ESSY</a>
                </div>
            </div>
        </div>


        <div align="center">
            <div class="well login">
                <label><h4>Sistema PuntoVenta</h4></label>

                <img src="img/ess.png" >
                <hr>
                <table>
                    <form class="well form-inline" id="entrar">
                        <tr><td>Email:</td><td> <input type="email" name="email"  class="input-large" placeholder="email@ejemplo.com" required>    </td></tr>
                        <tr><td>Password:</td><td align="left"><input type="password" class="input-small"  name="pass" placeholder="Password" required></td></tr>
                        <tr><td colspan="2" align="center">
                                <input type="submit" class="btn" value="Entrar"></td></tr>
                    </form>
                    <tr><td colspan="2" id="contenido">
                        </td></tr>



            </div>
            
        </div> 
    </body>
</html>
