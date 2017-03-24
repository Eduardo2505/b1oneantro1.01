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
        
        <script src="js/jquery-1.7.2.min.js"></script>        
        <link href="assets/css/bootstrap.css" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="css/jquery-ui-1.8.21.custom.css">
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
        
        <script type="text/javascript">
            $(function(){
                $('#entrar').submit(function(){
                    var data=$(this).serialize();
                    $('#contenido').html('<img src="img/ajax-loader.gif" alt=""/>').fadeOut(1000);
                   
                    $.post('Entrar',data,function(respuesta){
                     // alert(respuesta);
                        
                        if(respuesta=="Empleado"){
                   
                            $(location).attr('href',"Administrador/Menu.jsp"); 
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
                        <span class="icon-bar"><a class="btn-danger btn-large" href="index.jsp">Regresar</a></span>
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
                            <!--<a href="Administrador/NuevProducto.jsp">ir</a>
                            <a href="Administrador/Actualizar.jsp">Administracion</a>-->                            
                        </td></tr>
                </table>



            </div>
            
        </div> 
    </body>
    <script Language="JavaScript">

            $(document).ready(function() {
                if (history.forward(1)) {
                    history.replace(history.forward(1));
                    alert("entro");
                }
            });
        </script>
</html>
