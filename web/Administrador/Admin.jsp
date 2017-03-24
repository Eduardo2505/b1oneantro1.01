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
      
        <script src="../js/jquery.alerts.js"></script>
        <link rel="stylesheet" type="text/css" href="../js/jquery.alerts.css">

        <script type="text/javascript" src="../js/jquery.reveal.js"></script>
        <link rel="stylesheet" href="../css/reveal.css">-->
        <!-- ================================Los styles =============================== -->
        <script src="../js/jquery-1.7.2.min.js"></script>
        <script src="../js/jquery-ui-1.8.21.custom.min.js"></script>
        <link href="../assets/css/bootstrap.css" rel="stylesheet">
        <!-- <link rel='stylesheet' type='text/css' href='../css/jquery.autocomplete.css' />
         <script src='../js/jquery.autocomplete.js'></script>
         
         <link href="../assets/css/bootstrap-responsive.css" rel="stylesheet">
         <link rel="stylesheet" type="text/css" href="../css/jquery-ui-1.8.21.custom.css">
         <link rel="stylesheet" type="text/css" href="../css/styles.css" />-->
        <script type="text/javascript">
            $(function() {
                $(".fe").datepicker({
                    autoSize: true,
                    dayNames: ['Domingo', 'Lunes', 'Martes', 'Mi�rcoles', 'Jueves', 'Viernes', 'S�bado'],
                    dayNamesMin: ['Dom', 'Lu', 'Ma', 'Mi', 'Je', 'Vi', 'Sa'],
                    firstDay: 1,
                    monthNames: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'],
                    monthNamesShort: ['Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic'],
                    dateFormat: 'yy-mm-dd',
                    changeMonth: true,
                    changeYear: true,
                    yearRange: "-10:+0"


                });



            });
            $(function() {
                $('#insertarDia').submit(function() {
                    var data = $(this).serialize();
                    $('#resultados').html('<img src="../img/ajax-loader.gif" alt=""/>').fadeOut(1000);

                    $.post('../AltadiaController', data, function(respuesta) {

                        $('#insertarDia')[0].reset();
                        $('#resultados').fadeIn(1000).html(respuesta);


                    });
                    return false;
                });
            });
            $(document).ready(function() {
                $('.desactivar').click(function() {

                    var user = $(this).val();

                    //alert(user);

                    var dataString = 'iddia=' + user + '&op=actualizar';
                    //  alert(dataString);
                    if (user != "") {
                        // $('#verResultadoBuscados').html('<img src="img/ajax-loader.gif" alt=""/>');
                        $.ajax({
                            type: "POST",
                            url: "../AdmindiaController",
                            data: dataString,
                            success: function(data) {


                                $('#resultados').fadeIn(1000).html(data);
                            }
                        });
                        //}
                    }
                }


                );
            });
            
           
        </script>
       
        <script type="text/javascript">
            
              $(document).ready(function() {
                $('.cerrarctacero').click(function() {

                    var user = $(this).attr("name");
                    var remov = $(this).attr("title");

                    var dataString = 'idMesa=' + user;
                   
                        $.ajax({
                            type: "POST",
                            url: "../CerrarCuentasCero",
                            data: dataString,
                            success: function(data) {


                                $('#'+remov).remove();
                            }
                        });
                    
                    
                }


                );
            });
        </script>
        <script type="text/javascript">

            $(document).ready(function() {
                $(".ver").click(function(event) {
                    var idCargoria = $(this).attr("name");
                    // alert(idCargoria)
                    $("#div_mostrar").load(idCargoria);
                });
            });


        </script>
    </head>

    <body>


        <div class="container-fluid">
            <div class="row-fluid">
                <div class="span3">
                    <div class="sidebar-nav">
                        <form  id="insertarDia">
                            <input type="hidden" name="op" value="insertar">
                            <div class="control-group">
                                <label class="control-label" for="inputEmail">Día</label>
                                <div class="controls">
                                    <input type="text" class="fe" name="dia"  placeholder="FECHA.." required="">
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label" for="inputPassword">Tipo</label>
                                <div class="controls">
                                    <select name="opEvento" required="">
                                        <option value="">Seleccionar</option>
                                        <option value="Nocturno">Normal</option>
                                         <option value="EventoDomingo">EventoDomingo</option>
                                        <!--  <option value="Tardeada">Tardeada</option>-->
                                    </select>
                                </div>
                            </div>
                            <div class="control-group">
                                <div class="controls">

                                    <button type="submit" class="btn">Agregar</button>
                                </div>
                            </div>
                        </form>
                    </div><!--/.well -->
                </div><!--/span-->
                <div class="span9" >
                    <div class="well" id="resultados">
                        <table class="table table-hover">

                            <thead>
                                <tr>
                                    <th>Dia</th>
                                    <th>Tipo</th>
                                    <th>Resgistro</th>
                                    <th>Estado</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    HttpSession sesion = request.getSession();
                                    int idpuesto = (Integer) sesion.getAttribute("idpuesto");

                                    AltadiaDaoImpl dao = new AltadiaDaoImpl();
                                    List res = dao.getDias();
                                    Iterator itr = res.iterator();
                                    String color = "";
                                    if (idpuesto == 1 || idpuesto == 8) {
                                        while (itr.hasNext()) {
                                            Altadia des = (Altadia) itr.next();
                                            if (des.getEstado().equals("Activo")) {
                                                color = "success";
                                            } else {
                                                color = "danger";
                                            }


                                            out.println("<tr><td>" + des.getFecha() + "</td><td>" + des.getTipoEvento() + "</td><td>" + des.getHora() + "</td><td><button class='btn btn-" + color + " desactivar' value='" + des.getIdaltadia() + "&estado=" + des.getEstado() + "' type='button'>" + des.getEstado() + "</button></td>");




                                        }
                                    } else {
                                        while (itr.hasNext()) {
                                            Altadia des = (Altadia) itr.next();
                                            if (des.getEstado().equals("Activo")) {
                                                color = "success";
                                            } else {
                                                color = "danger";
                                            }


                                            out.println("<tr><td>" + des.getFecha() + "</td><td>" + des.getTipoEvento() + "</td><td>" + des.getHora() + "</td><td><button class='btn btn-" + color + " desactivar' value='" + des.getIdaltadia() + "&estado=" + des.getEstado() + "' type='button'>" + des.getEstado() + "</button> <a href='../AltadiaController?iddia=" + des.getIdaltadia() + "&op=impAdmin'  class='btn btn-primary' >VER</a> <a href='#' name='../AltadiaController?iddia=" + des.getIdaltadia() + "&op=actcuentas'  class='btn btn-primary ver' >Cuentas</a></td>");




                                        }
                                    }

                                %>


                            </tbody>
                        </table>
                    </div><!--/.well -->
                </div><!--/span-->

            </div><!--/row-->



        </div><!--/.fluid-container-->
    </body>
</html>
