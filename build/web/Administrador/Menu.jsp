<%-- 
    Document   : Menu
    Created on : 20/07/2013, 02:16:49 PM
    Author     : Eduardo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Menu</title>
        <!--<script src="../assets/js/jquery.js"></script>
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
        
        
        <script src="../js/jquery.alerts.js"></script>-->
       <!-- <link rel="stylesheet" type="text/css" href="../js/jquery.alerts.css">

       <!-- <script type="text/javascript" src="../js/jquery.reveal.js"></script>
        <link rel="stylesheet" href="../css/reveal.css">
        <!-- ================================Los styles =============================== -->
        <link href="../assets/css/bootstrap.css" rel="stylesheet">
        <script src="../js/jquery-1.7.2.min.js"></script>
        <script src="../js/jquery-ui-1.8.21.custom.min.js"></script>
        <!--<link rel='stylesheet' type='text/css' href='../css/jquery.autocomplete.css' />
        <script src='../js/jquery.autocomplete.js'></script>-->
        <style type="text/css">
            body {
                padding-top: 4%;
                padding-bottom: 40px;
            }
            .sidebar-nav {
                padding: 9px 0;
            }
            .login{
                width:290px;

            }	
        </style>
        <link href="../assets/css/bootstrap-responsive.css" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="../css/jquery-ui-1.8.21.custom.css">
        <link rel="stylesheet" type="text/css" href="../css/styles.css" />
        <link href="../css/bootstrap.css" rel="stylesheet">
        <link href="../css/bootstrap-responsive.css" rel="stylesheet">
        <link href="../css/docs.css" rel="stylesheet">
        <link href="../css/prettify.css" rel="stylesheet">
        <script type="text/javascript">

            $(document).ready(function() {
                $(".menu").click(function(event) {
                    var idCargoria = $(this).attr("name");
                    //alert(idCargoria)
                    $("#div_mostrar").load(idCargoria);
                });
            });


        </script>
    </head>
    <body style="overflow:hidden">
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
                            <a href="../close" class="btn btn-large btn-danger">Salir</a>
                        </div>
                    </div><!--/.nav-collapse -->
                </div>
            </div>
        </div>

        <!-- Docs nav
        ================================================== -->
        <div class="container-fluid">
            <div class="row-fluid">
                <div class="span3">
                    <div class="span3 bs-docs-sidebar">
                        <ul class="nav nav-list bs-docs-sidenav">
                            <li><a href="Actualizar.jsp"><i class="icon-chevron-right"></i> Empleados</a></li>
                            <li><a href="#" class="menu" name="Admin.jsp"><i class="icon-chevron-right"></i>Administrar</a></li>
                            <li><a href="NuevProducto.jsp" ><i class="icon-chevron-right"></i>Nuevo Producto</a></li>
                            
                        </ul>
                    </div>
                </div>
                <div class="span9" style="padding-top:1%">
                    <div class="well" id="div_mostrar" style="OVERFLOW:auto;height:580px;padding-top:0%">



                    </div>
                </div>
                </body>
                </html>
