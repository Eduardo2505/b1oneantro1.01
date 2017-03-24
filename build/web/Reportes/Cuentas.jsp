<%-- 
    Document   : Actualizar
    Created on : 24/04/2013, 03:27:46 PM
    Author     : Eduardopc
--%>

<%@page import="com.mapping.MesaVenta"%>
<%@page import="com.dao.impl.Mesa_ventaDaoImpl"%>
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
        <%
            HttpSession sesion = request.getSession();
            Empleado e = new Empleado();
            Altadia d = new Altadia();
            String nombre = "", nomMesero = "", tipoEvento = "";
            String idBarra = (String) sesion.getAttribute("idBarra");
            String idMesero = "", idMesa = "", idComanda = "";
            int idDia = 0;
            String dia = "";



            if (idBarra== null) {
                response.sendRedirect("../index.jsp");
            } else {

                d = (Altadia) sesion.getAttribute("idDia");

                idDia = d.getIdaltadia();
                dia = d.getFecha();


           response.setContentType("application/vnd.ms-excel"); //Tipo de fichero.

            response.setHeader("Content-Disposition", "attachment;filename=\"Corte" + d.getTipoEvento() + "" + dia + ".xls\"");

            }
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

        <style type="text/css">
            body {
                padding-top: 5%;
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
            $(document).ready(function() {
                $('.btncuenta').click(function() {
                    // var user = $(this).val();
                    var user = $(this).attr("name");
                    var dataString = 'idMesa=' + user + '&op=mostrar';
                    //alert(user);
                    if (user != "") {
                        $('#editar').html('<img src="../img/ajax-loader.gif" alt=""/>');
                        $.ajax({
                            type: "POST",
                            url: "../CerrarCuentasController",
                            data: dataString,
                            success: function(data) {
                                //alert(data)

                                $('#editar').fadeIn(500).html(data);



                            }
                        });
                        //}
                    }
                }


                );
            });

            $(document).ready(function() {
                $('#filtro').keyup(function() {
                    var user = $(this).val();
                    var dataString = 'filtro=' + user;
                    //alert(user);
                    if (user != "") {
                        $('#mostrarres').html('<img src="../img/ajax-loader.gif" alt=""/>');
                        $.ajax({
                            type: "POST",
                            url: "../BuscarCuentasController",
                            data: dataString,
                            success: function(data) {
                                //alert(data)

                                $('#mostrarres').fadeIn(500).html(data);

                                //	 response.sendRedirect("index.jsp");	
                                //alert(data);
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
                    <table ><tr><td>
                                <a class="brand" href="#">Administrador</a>
                            </td><td style="text-align:right;width:100%">
                                <a class="btn-large btn btn-danger navbar-form pull-righ" href="../link.jsp" style="height:40px">Regresar</a>
                            </td></tr>

                    </table>
                </div>
            </div>
        </div>
        <div class="container-fluid">
            <div class="row-fluid">
                <div class="span7">
                    <div style="text-align:right">
                        <input type="text" id="filtro" placeholder="Buscar">
                    </div>
                    <div class="hero-unit" id='mostrarres'>
                        <table class="table table-striped" style="width:70%">
                            <tr>                        
                                <th>Clave</th>
                                <th>Cuenta</th>
                                <th>Total</th>
                                <th>Efectivo</th>
                                <th>Tarjetas</th>
                                <th>Editar</th>
                            </tr>
                            <%
                                Mesa_ventaDaoImpl dao = new Mesa_ventaDaoImpl();
                                List res = dao.getCuentasAbiertas("Cerrado", idDia, "");
                                Iterator itr = res.iterator();
                                //    Empleado e=new Empleado();

                                while (itr.hasNext()) {
                                    MesaVenta em = (MesaVenta) itr.next();
                                    e = em.getEmpleado();
                                    if (em.getEfectivo() == 0 && em.getTarjeta() == 0) {
                                        out.println("<tr><td style='background-color:yellow'>" + e.getEmpleadocol() + "</td><td style='background-color:yellow'>" + em.getIdMesaVenta() + "</td><td style='background-color:yellow'>" + em.getTotalcuenta() + "</td><td style='background-color:yellow'>" + em.getEfectivo() + "</td><td style='background-color:yellow'>" + em.getTarjeta() + "</td><td style='background-color:yellow' ><button class='btn btn-large btn-primary btncuenta' type='button' name='" + em.getIdMesaVenta() + "'>PAGAR</button></td></tr>");
                                    } else {
                                        out.println("<tr><td>" + e.getEmpleadocol() + "</td><td>" + em.getIdMesaVenta() + "</td><td>" + em.getTotalcuenta() + "</td><td>" + em.getEfectivo() + "</td><td>" + em.getTarjeta() + "</td><td><button class='btn btn-large btn-primary btncuenta' name='" + em.getIdMesaVenta() + "' type='button'>PAGAR</button></td></tr>");
                                    }




                                }
                            %>
                        </table>
                    </div>
                </div><!--/span-->
                <div class="span5">
                    <div class="hero-unit">
                        <div id="editar" style="text-align:center">
                            <h1>Actualiza</h1>

                            <!--
                            
                                                        <script type="text/javascript">
                            
                            
                                                            $(function() {
                                                                $('#enviarCuenta').submit(function() {
                            
                                                                    var data = $(this).serialize()+"&filtro=";
                                                                    var totalc = parseFloat($('#totalc').val());
                                                                    var talEfec = parseFloat($('#talEfec').val());
                                                                    var taltarjeta = parseFloat($('#taltarjeta').val());
                                                                    var sum = talEfec + taltarjeta;
                            
                                                                    if (totalc == sum) {
                                                                        alert(data);
                                                                        $('#mostrarres').html('<img src="../img/ajax-loader.gif" alt=""/>').fadeOut(1000);
                                                                        $.post('../CerrarCuentasController', data, function(respuesta) {
                                                                            $('#mostrarres').fadeIn(1000).html(respuesta);
                            
                                                                        });
                                                                    } else {
                                                                        jAlert("No coincide el dinero", "Error", function(r) {
                                                                            if (r) {
                                                                                $('#taltarjeta').focus();
                                                                                $('#talEfec').focus();
                            
                                                                            }
                                                                        });
                                                                    }
                            
                                                                    return false;
                            
                                                                });
                            
                            
                                                            });
                                                        </script>
                                                        <label><h3>Cuenta:</h3></label>
                                                        <label><h4>Total:</h4> </label>
                                                        <form class="form-horizontal" id="enviarCuenta">                                
                                                            <input type="hidden" name="totalc" id="totalc" value="149.0">
                                                            <input type="hidden" name="op" value="actualizar">
                                                            <input type="hidden" name="idMesa" value="A2-1-1">
                            
                                                            <div class="control-group">
                                                                <label class="control-label" for="inputEmail">Efectivo</label>
                                                                <div class="controls">
                                                                    <input type="text" name="efectivo" id='talEfec'  placeholder="$$$$" required=""> 
                                                                </div>
                                                            </div>
                                                            <div class="control-group">
                                                                <label class="control-label" for="inputPassword">Tarjeta</label>
                                                                <div class="controls">
                                                                    <input type="text" name="tarjeta" id='taltarjeta'  placeholder="$$$$" required="">
                                                                </div>
                                                            </div>
                                                            <div class="control-group">
                                                                <div class="controls">      
                                                                    <button type="submit"  class="btn" >Guardar</button>
                                                                </div>
                                                            </div>
                                                        </form>
                            -->
                        </div>
                    </div>          

                </div><!--/span-->
            </div><!--/row-->

            <hr>

            <footer>
                <p>&copy; Company 2013</p>
            </footer>

        </div><!--/.fluid-container-->




    </body>
</html>
