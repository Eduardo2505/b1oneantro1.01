<%-- 
    Document   : Mesas
    Created on : 16/01/2013, 07:37:33 PM
    Author     : Eduardopc
--%>

<%@page import="com.mapping.Puesto"%>
<%@page import="com.dao.impl.EmpleadoDaoImpl"%>
<%@page import="com.mapping.MesaVenta"%>
<%@page import="com.dao.impl.Mesa_ventaDaoImpl"%>
<%@page import="com.mapping.Mesas"%>
<%@page import="com.dao.impl.MesasDaoImpl"%>
<%@page import="com.mapping.Zona"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="com.dao.impl.ZonaDaoImpl"%>
<%@page import="com.mapping.Altadia"%>
<%@page import="com.mapping.Empleado"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Menú</title>
        <%
            HttpSession sesion = request.getSession();
            Altadia d = new Altadia();
            String idBarra = (String) sesion.getAttribute("idBarra");
            String nombre = "", nomMesero = "";

            String idMesero = "";
            int idDia = 0;
            int idpuesto = Integer.parseInt((String) sesion.getAttribute("idpuesto"));
           
            Empleado em = new Empleado();
            Mesa_ventaDaoImpl daomv = new Mesa_ventaDaoImpl();
            MesaVenta m = new MesaVenta();
            // Empleado emv = new Empleado();
            if (idBarra == null) {
                response.sendRedirect("index.jsp");
            } else {
                nombre = " B1One";
                // emv = (Empleado) sesion.getAttribute("idEmpleadoSuper");
                em = (Empleado) sesion.getAttribute("idMesero");
                if ("ByLatino".equals(em.getIdEmpleado())) {
                    response.sendRedirect("Menu.jsp");
                } else {
                    nomMesero = em.getNombre() + " " + em.getApellidos();
                    d = (Altadia) sesion.getAttribute("idDia");
                    idMesero = em.getIdEmpleado();
                    idDia = d.getIdaltadia();
                }
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
                padding-top: 5%;
                padding-bottom: 40px;
            }
            .sidebar-nav {
                padding: 9px 0;
            }
        </style>
        <link href="assets/css/bootstrap-responsive.css" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="css/jquery-ui-1.8.21.custom.css">


        <!--####################################siti#################-->

        <style>
            .numH{
                font-size:25px;
                font-weight:bold;
                /*height:120px;*/
                width:160px;
                padding-top:4%;
                padding-bottom:4%;

            }
            .numHE{
                font-size:24px;
                font-weight:bold;
                height:110px;
                width:150px;
            }


        </style>
        <style>
            #sortable { list-style-type: none; margin: 0; padding: 0; width: 100%; }
            #sortable li { margin: 3px 3px 3px 0; padding: 1px; float: left;  }

            .btnli{

                margin: 3px 3px 3px 0; padding: 1px; float: left; width: 165px; height: 155px; font-size: 1em; text-align: center;
            }
            .imagenVer{

                background-image:url('images/opentable.png');
            }


            .ocupado{

                background-image:url('images/ocupado.png');
            }
        </style>
    </head>
    <body  style="overflow:hidden">
        <div class="navbar navbar-fixed-top">
            <div class="navbar-inner">
                <div class="container-fluid">
                    <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </a>
                    <a class="brand" href="#">Usuario:<samp style="font-size:17px"><% out.println(nombre);%></samp></a>
                    <a class="brand" href="#">Mesero(a):<samp style="font-size:17px"><% out.println(nomMesero);%></samp></a>
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
        <div >
            <script type="text/javascript">
                $(document).ready(function() {
                    $('#MesasBuscar').keyup(function() {
                        var user = $(this).val();
                        var dataString = 'MesasBuscar=' + user;
                        //alert(user);
                        if (user != "") {
                            $('#sortable').html('<img src="img/ajax-loader.gif" alt=""/>');
                            $.ajax({
                                type: "POST",
                                url: "BuscarMesa_ComandaController",
                                data: dataString,
                                success: function(data) {
                                    //alert(data)

                                    $('#contenidoBody').fadeIn(500).html(data);

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



            <div style="padding-right:1%" >
                <table style="text-align:center" WIDTH="100%" >
                    <tr><td style="padding-left:7%;" valign="top">
                            <div style="OVERFLOW: auto; WIDTH:850px;HEIGHT:550px;padding-top:1%" >
                                <div id="contenidoBody">
                                    <script type="text/javascript">


                                        $(function() {
                                            $('#AgregarMesa').submit(function() {
                                                var data = $(this).serialize();
                                                //alert(data);
                                                $('#contenidover').html('<img src="img/ajax-loader.gif" alt=""/>').fadeOut(1000);
                                                $.post('Mesa_ventaController', data, function(respuesta) {

                                                    $('#AgregarMesa')[0].reset();
                                                    jAlert("Se agrego correctamente", "Confirmación", function(r) {
                                                        if (r) {
                                                           $(location).attr('href','Mesas.jsp');
                                                          //  $('#contenidoBody').html(respuesta);
                                                            //  $(location).attr('href','Mesas.jsp');
                                                        }
                                                    });






                                                });
                                                return false;
                                            });
                                        });
                                    </script>
                                    <script type="text/javascript">

                                        //

                                        $(document).ready(function() {
                                            $('.addnewMesa').click(function() {
                                                var a = $(this).attr("name");

                                                $('#mesitaverid').fadeIn(500).html(a);
                                                $('#idMesaadd').val(a);

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
                                    <div id="agregarMesaDiv" class="reveal-modal" style="text-align:center">
                                        <form id="AgregarMesa">
                                            <label class="label-warning"><H3>#MESA</H3></label>
                                            <input type="text" name="idMesaCap" required="" >
                                            <input type="hidden" name="idMesa" id="idMesaadd" value="">
                                            
                                            <label class="label-warning"><H3>PERSONAS APROX</H3></label>
                                            <input type="text" onkeypress="return isNumberKey(event)" name="persAprox" required="" >    

                                            <br>

                                            <input type="submit" value="Aceptar" class="btn btn-primary btn-large" >
                                            <div id="contenidover"></div>
                                        </form>
                                        <a class="close-reveal-modal">&#215;</a>

                                    </div>

                                    <ul id="sortable">

                                        <%





                                            List resmv = daomv.getMesaVenta("Activo", idMesero, idDia);
                                            Iterator itrmv = resmv.iterator();
                                            while (itrmv.hasNext()) {
                                                MesaVenta mesasv = (MesaVenta) itrmv.next();
                                                m = daomv.bucarPorId(mesasv.getIdMesaVenta());

                                             
                                               
                                                  out.println(" <li class='ui-state-default ocupado'><a  href='SessionIdMesaComanda?idMesaVenta=" + mesasv.getIdMesaVenta() + "&idComanda=VER&tipo=venta&observa=-&autorizacion=-&nombremesa="+m.getIdMesaCapturada().replace(" ","-")+"' class=\"btnli\" ><br><h1>" + m.getIdMesaCapturada() + "</h1><br><h4>Personas Aprox:" + mesasv.getPersonasAprox() + "</h4></a></li> ");
                                       


                                            }

                                            if (idpuesto == 5 || idpuesto == 8 || idpuesto == 22|| idpuesto ==2|| idpuesto == 3) {
                                                MesasDaoImpl daom = new MesasDaoImpl();
                                                List resm = daom.getMesas("Activo", em.getIdEmpleado(), "");
                                                Iterator itrm = resm.iterator();

                                                while (itrm.hasNext()) {
                                                    Mesas mesas = (Mesas) itrm.next();


                                                    out.println(" <li class='ui-state-default imagenVer'><a href='#' class=\"btnli addnewMesa\" data-reveal-id='agregarMesaDiv' data-animation='fadeAndPop' data-animationspeed='300' data-closeonbackgroundclick='true' data-dismissmodalclass='close-reveal-modal' name='" + mesas.getIdMesa() + "'><br><h1>" + mesas.getPosiscion() + "</h1><br><h2>" + mesas.getIdMesa() + "</h2></a></li> ");


                                                    
                                                }
                                            }

                                        %>
                                    </ul>
                                </div>
                            </div>
                        </td> 
                        <td valign="top">
                            <script type="text/javascript">

                                //

                                $(document).ready(function() {
                                    $('.ct').click(function() {
                                        var a = $(this).attr("name");
                                        var title = $(this).attr("title");

                                        $('#tituloop').html(title);
                                        $('#opcancelacion').val(a);

                                    });

                                });
                                //cearraa
                                $(document).ready(function() {
                                    $('.closeventana').click(function() {
                                        $('#fromcancelarCuenta')[0].reset();

                                        $('#mostrarCanceladiv').html("");

                                    });

                                });
                                //cerarra
                                $(document).ready(function() {
                                    $("#changeIdCuenta").change(function(event) {
                                        //  alert("Hola");
                                        var idCargoria = $(this).attr("title");
                                        var changeIdCuenta = $(this).val();

                                        //alert(idCargoria)
                                        $("#mostrarCanceladiv").load(idCargoria + changeIdCuenta);
                                    });
                                });

                                $(document).ready(function() {
                                    $("#traIdCuenta").change(function(event) {
                                        //  alert("Hola");
                                        var idCargoria = $(this).attr("title");
                                        var changeIdCuenta = $(this).val();

                                        //alert(idCargoria)
                                        $("#traCanceladiv").load(idCargoria + changeIdCuenta);
                                    });
                                });
                                //###############################
                                $(document).ready(function() {
                                    $("#idCuentas").change(function(event) {
                                        //  alert("Hola");

                                        var changeIdCuenta = $(this).val();

                                        //alert(idCargoria)
                                        $("#mostracuentas").load("Changecuentas?idClave=" + changeIdCuenta);
                                    });
                                });

                                $(document).ready(function() {
                                    $('.closeTras').click(function() {
                                        $('#fromtrasCuenta')[0].reset();

                                        $('#traCanceladiv').html("");

                                    });

                                });
                            </script>

                            <table height="100%" >
                                <!--  <tr><td>
                                        <input type="text" id="MesasBuscar" name="MesasBuscar" class="input-medium search-query" placeholder="Búscar mesa.....">
                                     </td><td> <a href="Mesas.jsp" class="btn">Ver Todo</a>
 
                                     </td></tr>-->
                                <tr><td><a href="closeSessionMeseroCuenta"  data-dismissmodalclass="close-reveal-modal" title="SALIR" class="btn btn-primary numHE"><BR><BR>SALIR</a></td><td>
                                        <a href="CuentasCerradas.jsp"  id="coresiasver"  data-dismissmodalclass="close-reveal-modal" title="MESAS CERRADAS" class="btn btn-primary numHE"><BR><BR>MESAS<br><br>CERRADAS</a>
                                    </td>                             

                                </tr>
                                <tr>
                                    <td>
                                        <a href="#" data-reveal-id="cancelacioncuenta" data-animation="fadeAndPop" data-animationspeed="300" data-closeonbackgroundclick="true" data-dismissmodalclass="close-reveal-modal"  title="CANCELACION CUENTA" name="cancelar" class="btn btn-primary numHE ct" ><br><br>Cancelación <br><br>CUENTA</a>
                                    </td>
                                    <td>
                                        <a href="#" data-reveal-id="Trascuenta" data-animation="fadeAndPop" data-animationspeed="300" data-closeonbackgroundclick="true" data-dismissmodalclass="close-reveal-modal"  title="TRANSLACCION CUENTA"  class="btn btn-primary numHE" ><br><br>Transladar <br><br>CUENTA</a>
                                    </td>

                                </tr>

                            </table>  
                            <!--##################################################-->
                            <script type="text/javascript">
                                $(function() {
                                    $('#fromcancelarCuenta').submit(function() {
                                        var data = $(this).serialize();
                                        //  $('#verif').html('<img src="img/ajax-loader.gif" alt=""/>').fadeOut(1000);
                                        $.post('Cancelacion_MesaController', data, function(respuesta) {
                                            // $('#verif').fadeIn(1000).html(respuesta);
                                            var r = respuesta.length;
                                            // alert(r);
                                            if (r != 0) {

                                                jAlert(respuesta, "Autorización");
                                            } else {

                                                $(location).attr('href', "tiket/TiketCancelacion.jsp");
                                            }


                                        });
                                        return false;
                                    });
                                });
//#####################################
                                $(function() {
                                    $('#fromtrasCuenta').submit(function() {
                                        var data = $(this).serialize();
                                        //  $('#verif').html('<img src="img/ajax-loader.gif" alt=""/>').fadeOut(1000);
                                        $.post('Cancelacion_MesaController', data, function(respuesta) {
                                            //  $('#verif').fadeIn(1000).html(respuesta);
                                            var r = respuesta.length;
                                            // alert(r);
                                            if (r != 0) {

                                                jAlert(respuesta, "Autorización");
                                            } else {
                                                $('#fromtrasCuenta')[0].reset();
                                                jAlert("Se realizo el translado correctamente", "Confirmación", function(r) {
                                                    if (r) {
                                                        $(location).attr('href', "Mesas.jsp");
                                                    }
                                                });
                                                // $(location).attr('href', "tiket/TiketCancelacion.jsp");
                                            }


                                        });
                                        return false;
                                    });
                                });

                            </script>
                            <div id="cancelacioncuenta" class="reveal-modal" style="text-align:center">
                                <form id="fromcancelarCuenta">
                                    <input type="hidden" name="op" id="opcancelacion" value="">
                                    <label class="label-warning"><H3 id="tituloop">#Cuenta</H3></label>                                              
                                    <br>
                                    <select name="idCuenta" required="" id="changeIdCuentax" title="ChageCuentas?idCuenta=">
                                        <option value="">Seleccion</option>
                                        <%
                                            List r = daomv.getMesaVenta("Activo", idMesero, idDia);
                                            Iterator rb = r.iterator();
                                            while (rb.hasNext()) {
                                                MesaVenta mesasv = (MesaVenta) rb.next();
                                                out.println("<option value='" + mesasv.getIdMesaVenta() + "'>" + mesasv.getIdMesaCapturada() + "</option>");

                                            }
                                        %>
                                    </select><br>
                                    <input type="password" name="pass" required="" placeholder="PASSWORD"><br>
                                    <textarea name="obser" required></textarea>


                                    <div id="mostrarCanceladiv"></div>
                                    <input type="submit" value="Acepatr" class="btn btn-primary btn-large">
                                </form>
                                <a class="close-reveal-modal closeventana">&#215;</a>

                            </div>
                            <!--"""""""""""""""""""""""""""""""""Translado-->
                            <div id="Trascuenta" class="reveal-modal" style="text-align:center">
                                <form id="fromtrasCuenta">
                                    <input type="hidden" name="op"  value="transladar">
                                    <label class="label-warning"><H3 >TRANSLADO CUENTA</H3></label>                                              
                                    <br>
                                    <select name="idCuenta" required="" id="traIdCuentax" title="ChageCuentas?idCuenta=">
                                        <option value="">Seleccion</option>
                                        <%
                                            List rt = daomv.getMesaVenta("Activo", idMesero, idDia);
                                            Iterator rbt = rt.iterator();
                                            while (rbt.hasNext()) {
                                                MesaVenta mesasv = (MesaVenta) rbt.next();
                                                out.println("<option value='" + mesasv.getIdMesaVenta() + "'>" + mesasv.getIdMesaCapturada() + "</option>");

                                            }
                                        %>
                                    </select><br>
                                    a<br>
                                    <select name="idClave">
                                        <option value="">Seleccion</option>
                                        <%
                                            EmpleadoDaoImpl daoc = new EmpleadoDaoImpl();
                                            List resc = daoc.getFiltro("activo");
                                            Iterator rbtc = resc.iterator();
                                            while (rbtc.hasNext()) {
                                                Empleado emr = (Empleado) rbtc.next();
                                                out.println("<option value='" + emr.getEmpleadocol() + "'>" + emr.getEmpleadocol() + "</option>");

                                            }
                                        %>
                                    </select><br>
                                    <div id="mostracuentas">

                                    </div>
                                    <input type="password" name="pass" required="" placeholder="PASSWORD EMPLEADO"><br>
                                    <textarea name="obser" required></textarea>


                                    <div id="traCanceladiv"></div>
                                    <br>
                                    <input type="submit" value="Enviar" class="btn btn-info btn-large">
                                </form>
                                <a class="close-reveal-modal closeTras">&#215;</a>

                            </div>

                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </body>
     <script Language="JavaScript">

           
                if (history.forward(1)) {
                    history.replace(history.forward(1));
                    
                }
          
        </script>
</html>
