<%-- 
    Document   : NuevProducto
    Created on : 9/03/2013, 06:58:48 PM
    Author     : Eduardopc
--%>

<%@page import="com.mapping.Producto"%>
<%@page import="com.dao.impl.ProductoDaoImpl"%>
<%@page import="com.mapping.Categoria"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="com.dao.impl.CategoriaDaoImpl"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <%

            CategoriaDaoImpl dao = new CategoriaDaoImpl();
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

        <link href="../assets/css/bootstrap-responsive.css" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="../css/jquery-ui-1.8.21.custom.css">
        <link rel="stylesheet" type="text/css" href="../css/styles.css" />
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
                            <a href="Menu.jsp" class="btn btn-large btn-warning"><--Regresar</a>
                            <a href="../close" class="btn btn-large btn-danger">Salir</a>
                        </div>
                    </div><!--/.nav-collapse -->
                </div>
            </div>
        </div>
        <script type="text/javascript">
            $(document).ready(function() {
                $('#nuevobotella').submit(function() {
                    var data = $(this).serialize();
                    $('#contenido').html('<img src="../img/ajax-loader.gif" alt=""/>').fadeOut(1000);

                    $.post('../insertarController', data, function(respuesta) {
                        // alert(respuesta);



                        $('#contenido').fadeIn(1000).html(respuesta);


                    });
                    return false;
                });
            });
            $(document).ready(function() {
                $('#nuevocopa').submit(function() {
                    var data = $(this).serialize();
                    $('#contenido').html('<img src="../img/ajax-loader.gif" alt=""/>').fadeOut(1000);

                    $.post('../insertarController', data, function(respuesta) {
                        // alert(respuesta);



                        $('#contenido').fadeIn(1000).html(respuesta);


                    });
                    return false;
                });
            });

            $(function() {
                $('#nomr').keydown(function() {
                    var data = $(this).val();
                    //alert(data);
                    $('#num2').val(data);
                });
            });
            function isNumberKey(evt)
            {
                var charCode = (evt.which) ? evt.which : event.keyCode
                if (charCode > 31 && (charCode < 48 || charCode > 57))
                    return false;

                return true;
            }
        </script>

        <div>
            <div class="well">
                <div id="editarprod">
                    <table><tr><td>
                                <form class="nuevo" id="nuevobotella">
                                    Nombre:<input type="text" id="nomr" name="nompro" required=""> <br>
                                    Tipo<select name="tipo" required="">
                                        <option value="">Seleccionar</option>
                                        <option value="Botella">Botella</option>
                                        <option value="Copa">Copa</option>
                                        <option value="Otro">Otro</option>
                                        <option value="Cocina">Cocina</option>
                                    </select><br>
                                    Tamaño<input type="text" name="tamano" onkeypress="return isNumberKey(event)" required> <br>
                                    <select name="medida" required="">
                                        <option value="">Medida</option>
                                        <option value="lt">lt</option>
                                        <option value="ml">ml</option>
                                        <option value="kg">kg</option>
                                        <option value="pz">pz</option>
                                        <option value="g">g</option>
                                    </select><br>
                                    Precio<input type="text" name="precio" onkeypress="return isNumberKey(event)" required> <br>
                                    <select name="categoria" required="">
                                        <option value="">Categoría</option>
                                        <%


                                            List res = dao.getFiltro();
                                            Iterator itr = res.iterator();
                                            while (itr.hasNext()) {
                                                Categoria c = (Categoria) itr.next();
                                                out.println("<option value='" + c.getIdCategoria() + "'>" + c.getIdCategoria() + "</option>");


                                            }
                                        %>
                                    </select><br>
                                    <select name="opEvento" required="">
                                        <option value="Nocturno">Nocturno</option>
                                        <option value="Tardeada">Tardeada</option>
                                        <option value="EventoDomingo">EventoDomingo</option>

                                    </select><br>
                                    <select name="Importado" >

                                        <option value="Importados">Importados</option>
                                        <option value="Nacionales">Nacionales</option>

                                    </select><br>
                                    OPCION<br>
                                    <select name="opcion" required="" class="Adicionalx">
                                        <option value="np">NP</option>     
                                        <option value="Adicional">Adicional</option>
                                    </select><br>

                                    <div id="mistraddiv" style="display: none;">
                                        <h3>COPIA XML Adicional</h3>
                                        Botella <input type="radio" name="xml" value="bote"> Copa <input type="radio" name="xml" value="copa">
                                    </div><br>
                                    <div style="display: none;">
                                        Estado <br>Activo <input type="radio" name="estado" value="1" checked=""> Inactivo <input type="radio" name="estado" value="0">

                                    </div>
                                    <input type="submit" value="Enviar">
                                </form></td><td>


                            </td></tr></table>


                </div>
                <script type="text/javascript">


            $(document).ready(function() {
                $('#NombreProductoe').keyup(function() {
                    var user = $(this).val();
                    var dataString = 'nomproducto=' + user;
//alert(user);
                    if (user != "") {

                        $.ajax({
                            type: "POST",
                            url: "../BuscarProductoAc",
                            data: dataString,
                            success: function(data) {
                                //alert(data)

                                $('#contenido').html(data);

                                //	 response.sendRedirect("index.jsp");	
                                //alert(data);
                            }
                        });
                        //}
                    }
                }


                );
            });

            $(document).ready(function() {
                $('.Adicionalx').change(function() {
                    var user = $(this).val();


                    if (user == "Adicional") {
                        $('#mistraddiv').show();
                    } else {
                        $('#mistraddiv').hide();

                    }
                });
            });
                </script>
                <label class="label-important" style="text-align:center"><h3>Buscador</h3></label>
                <input type="text" id="NombreProductoe" placeholder="Buscarl..."/>

                <div id="contenido" style="OVERFLOW:auto;height:250px;padding-top:0%">



                </div>
            </div>
    </body>
</html>
