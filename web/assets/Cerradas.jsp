<%-- 
    Document   : Cerradas
    Created on : 16/01/2013, 08:48:17 PM
    Author     : Eduardopc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cuentas Cerradas</title>
        <%
            HttpSession sesion = request.getSession();
            String nombre = (String) sesion.getAttribute("idusuario");

            if (nombre == null) {
                response.sendRedirect("index.jsp");
            } else {
                String idMesero = (String) sesion.getAttribute("idMesero");
                //  out.print(idMesero);
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
        <style>
            #sortable { list-style-type: none; margin: 0; padding: 0; width: 100%; }
            #sortable li { margin: 3px 3px 3px 0; padding: 1px; float: left; width: 200px; height: 170px; font-size: 4em; text-align: center; }

            .numHE{
                font-size:24px;
                font-weight:bold;
                height:110px;
                width:150px;
            }


        </style>
        <!--#################################-->
    </head>
    <body style="overflow:hidden" >
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
        <div id="trasladarv" class="reveal-modal" style="text-align:center">
            <form name="agregar">
                <label class="label-warning"><H1># MESA</H1></label>
                <select name="Mesa" requerid>
                    <option value="">Seleccione</option>
                </select>
                <label class="label-warning"><H1>MESERO</H1></label>
                <select name="idempleado" requerid>
                    <option value="">Seleccione</option>
                </select><br>
                <input type="submit" value="Trasladar" class="btn btn-primary btn-large" >
            </form>
            <a class="close-reveal-modal">&#215;</a>

        </div>

        <table width="100%" style="text-align:center" >
            <tr><td width="70%" style="padding:0px 20px 20px 20px">
                    <div style="OVERFLOW: auto; WIDTH:120%;HEIGHT:550px;padding-top:1%" >
                        <ul id="sortable">
                            <li class="ui-state-default">

                                <div id="cuentanum" class="reveal-modal" style="text-align:center">
                                    <form name="agregar">
                                        <label class="label-warning"><H1>#CUENTAS</H1></label>
                                        <select name="idCuenta" required>
                                            <option value="">Seleccione</option>
                                        </select>
                                        <label class="label-warning"><H1>#ACCION</H1></label>
                                        <select name="accion" required>
                                            <option value="">Seleccione</option>
                                        </select>
                                        <br>
                                        <input type="submit" value="Aceptar" class="btn btn-primary btn-large" >
                                    </form>
                                    <a class="close-reveal-modal">&#215;</a>

                                </div>    
                                <a href="#" data-reveal-id="cuentanum" data-animation="fadeAndPop" data-animationspeed="300" data-closeonbackgroundclick="true" data-dismissmodalclass="close-reveal-modal" title="AGREGAR MESA"> <BR><BR><h1>#MESA</h1><br><br>10<br></a>




                            </li>
                            <li class="ui-state-default">1</li>
                            <li class="ui-state-default">3</li>
                            <li class="ui-state-default">4</li>
                            <li class="ui-state-default">5</li>
                            <li class="ui-state-default">6</li>
                            <li class="ui-state-default">7</li>
                            <li class="ui-state-default">8</li>
                            <li class="ui-state-default">9</li>
                            <li class="ui-state-default">4</li>
                            <li class="ui-state-default">5</li>
                            <li class="ui-state-default">6</li>
                            <li class="ui-state-default">9</li>
                            <li class="ui-state-default">4</li>
                            <li class="ui-state-default">5</li>
                            <li class="ui-state-default">6</li>


                        </ul>
                    </div>
                </td> 
                <td valign="top" style="padding-top:1%;padding-right:2%" align="right">

                    <table height="100%">
                        <tr><td><a href="Mesas.jsp" data-closeonbackgroundclick="true" data-dismissmodalclass="close-reveal-modal" title="SALIR" class="btn btn-primary numHE"><BR><BR>REGRESAR</a></td></tr>
                        <tr><td><HR><a href="#" data-closeonbackgroundclick="true" data-dismissmodalclass="close-reveal-modal" title="SALIR" class="btn btn-primary numHE"><BR><BR>IMPRIMIR<BR><BR>TODO</a></td></tr>
                    </table>   

                </td>
            </tr>
        </table>

</html>
