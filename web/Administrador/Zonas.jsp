<%-- 
    Document   : Actualizar
    Created on : 24/04/2013, 03:27:46 PM
    Author     : Eduardopc
--%>

<%@page import="com.mapping.Altadia"%>
<%@page import="com.dao.impl.AltadiaDaoImpl"%>
<%@page import="com.dao.impl.BarraDaoImpl"%>
<%@page import="com.mapping.Barra"%>
<%@page import="com.dao.impl.MesasDaoImpl"%>
<%@page import="com.mapping.Mesas"%>
<%@page import="com.mapping.Zona"%>
<%@page import="com.dao.impl.ZonaDaoImpl"%>
<%@page import="com.mapping.Puesto"%>
<%@page import="com.dao.impl.PuestoDaoImpl"%>
<%@page import="com.mapping.Empleado"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="com.dao.impl.EmpleadoDaoImpl"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>


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
            .desactivar{
                width:150px;

            }
            .ver{
                width:70px;

            }

        </style>
        <link href="../assets/css/bootstrap-responsive.css" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="../css/jquery-ui-1.8.21.custom.css">
        <link rel="stylesheet" type="text/css" href="../css/styles.css" />

        <script type="text/javascript">
            $(function() {
                $('#enviar').click(function() {

                    var idEmpleado = $('#idempleado').val();
                    var idZona = $('#idZona').val();
                    //var f = $('.ck').val();

                    if (idZona != "") {
                        $("input[@name='categoria[]']:checked").each(function() {
                            var idmesa = $(this).val();

                            var dataString = 'idMesa=' + idmesa + '&idempleado=' + idEmpleado + '&idZona=' + idZona + '&op=asigar';

                            $.ajax({
                                type: "POST",
                                url: "../AsigarMesaController",
                                data: dataString,
                                success: function(data) {
                                    $('#actualimesa').html(data);
                                }
                            });

                        });


                    } else {
                        jAlert("Seleccione zona", "Error", function(r) {
                            if (r) {
                                $('#idZona').focus();
                            }
                        });

                    }
                });
            });
            $(document).ready(function() {
                $('.pp').click(function() {

                    var idmesa = $(this).val();
                    var idEmpleado = $('#idempleado').val();
                    var idZona = $('#idZona').val();
                    alert(idmesa);
                    var dataString = 'idMesa=' + idmesa + '&idempleado=' + idEmpleado + '&idZona=' + idZona + '&op=pp';


                    //  alert(dataString);


                    $.ajax({
                        type: "POST",
                        url: "../AsigarMesaController",
                        data: dataString,
                        success: function(data) {
                            //  alert(data);
                            $('#actualimesa').html(data);
                            //  $('#verresultador').html(data);
                        }
                    });
                    //}

                }


                );
            });
            $(document).ready(function() {
                $('#idempleado').change(function() {

                    var user = $(this).val();

                    // alert(user);

                    var dataString = 'idEmpleado=' + user + '';
                    //  alert(dataString);
                    if (user != "") {
                        $('#verresultador').html('<img src="../img/ajax-loader.gif" alt=""/>').fadeOut(1000);
                        //   $('#resultadosw').html('<img src="../img/ajax-loader.gif" alt=""/>');
                        $.ajax({
                            type: "POST",
                            url: "../ChangeMesas",
                            data: dataString,
                            success: function(data) {
                                //  alert(data);
                                $('#verresultador').fadeIn(1000).html(data);
                                //  $('#verresultador').html(data);
                            }
                        });
                        //}
                    }
                }


                );
            });
        </script>
    </head>

    <body>
        <div class="navbar navbar-inverse navbar-fixed-top">
            <div class="navbar-inner">
                <div class="container">
                    <button type="button" class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="brand" href="#">Administrador</a>
                    <a class="brand" href="Actualizar.jsp"><h1>Regresar</h1></a>
                    <div class="nav-collapse collapse">
                        <ul class="nav">                            
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown">USUARIO <b class="caret"></b></a>
                                <ul class="dropdown-menu">
                                    <li><a href="Actualizar.jsp">Salir</a></li>

                                </ul>
                            </li>
                        </ul>

                    </div><!--/.nav-collapse -->
                </div>
            </div>
        </div>

        <div class="container-fluid">
            <div class="row-fluid">
                <div class="span3">
                    <div class="sidebar-nav">
                        <div class="well" style="text-align: center">
                            <select name="idEmpleado" id="idempleado" required="">
                                <option value="">Seleccionar</option>
                                <%
                                    EmpleadoDaoImpl dao = new EmpleadoDaoImpl();

                                    List res = dao.getFiltro();
                                    Iterator itr = res.iterator();

                                    while (itr.hasNext()) {
                                        Empleado em = (Empleado) itr.next();

                                        if (em.getEmpleadocol() != null) {




                                            out.print(" <option  value ='" + em.getIdEmpleado() + "'>" + em.getEmpleadocol() + "</option>");
                                        }
                                    }

                                %>  
                            </select>
                            <select id="idZona" required="">
                                <option value="">Seleccionar</option>
                                <%
                                    ZonaDaoImpl daoz = new ZonaDaoImpl();

                                    List resz = daoz.getZona();
                                    Iterator itrz = resz.iterator();

                                    while (itrz.hasNext()) {
                                        Zona em = (Zona) itrz.next();






                                        out.print(" <option  value ='" + em.getIdzona() + "'>" + em.getIdzona() + "</option>");

                                    }

                                %>  
                            </select><br>
                            <input type="button" id="enviar" class="btn btn-inverse btn-large" value="enviar" />
                        </div>
                    </div><!--/.well -->
                </div><!--/span-->
                <div class="span9" >
                    <div class="well" id="verresultador">
                        <h1>Selecciona al empleado</h1>
                    </div><!--/.well -->
                </div><!--/span-->

            </div><!--/row-->

            <hr>

            <footer>
                <p>&copy; Company 2013</p>
            </footer>

        </div><!--/.fluid-container-->
    </body>
</html>
