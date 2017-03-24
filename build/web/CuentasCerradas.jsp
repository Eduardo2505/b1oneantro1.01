<%-- 
    Document   : CuentasCerradas
    Created on : 9/03/2013, 12:28:21 PM
    Author     : Eduardopc
--%>

<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="com.mapping.MesaVenta"%>
<%@page import="com.dao.impl.Mesa_ventaDaoImpl"%>
<%@page import="com.mapping.Altadia"%>
<%@page import="com.mapping.Empleado"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cuentas Cerradas</title>
        <%
            HttpSession sesion = request.getSession();
            //Empleado e = new Empleado();
            Altadia d = new Altadia();
            String nombre = "", nomMesero = "";
             String idBarra =(String)sesion.getAttribute("idBarra");
            //e = (Empleado) sesion.getAttribute("id");
            String idMesero = "";
            int idDia = 0;
            //out.println(e);
            if (idBarra== null) {
                response.sendRedirect("index.jsp");
            } else {
                nombre = " ByLatino";
                Empleado em = new Empleado();
                em = (Empleado) sesion.getAttribute("idMesero");
                if (nombre.equals(em.getIdEmpleado())) {
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
        <!--<link rel="stylesheet" type="text/css" href="css/jquery-ui-1.8.21.custom.css">-->
        <style>
            #sortable { list-style-type: none; margin: 0; padding: 0; width: 100%; }
            #sortable li { margin: 3px 3px 3px 0; padding: 1px;}
            .verimagen{
               float: left; width: 200px; height: 170px; font-size: 25px; text-align: center;background-image:url('images/candadoa.png')
                
            }
            .numHE{
                font-size:24px;
                font-weight:bold;
                height:110px;
                width:150px;
            }

            A:link {text-decoration: none}
            A:visited {text-decoration: none}
            A:active {text-decoration: none}
            A:hover {font-size:24; font-weight:bold; color: red;}


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


        <table width="100%" style="text-align:center" >
            <tr><td width="70%" style="padding:0px 20px 20px 20px">
                    <div style="OVERFLOW: auto; WIDTH:120%;HEIGHT:550px;padding-top:1%" >
                        <ul id="sortable">
                            <%
                                Mesa_ventaDaoImpl daomv = new Mesa_ventaDaoImpl();
                                MesaVenta m = new MesaVenta();


                                List resmv = daomv.getMesaVenta("Cerrado", idMesero, idDia);
                                Iterator itrmv = resmv.iterator();
                                while (itrmv.hasNext()) {
                                    MesaVenta mesasv = (MesaVenta) itrmv.next();
                                    m = daomv.bucarPorId(mesasv.getIdMesaVenta());


                                    out.println("<div id=\"" + mesasv.getIdMesaVenta() + "\" class=\"reveal-modal\" style=\"text-align:center\">\n"
                                            + "                                    <a href=\"SessionIdMesaCerradas?idMesaVenta=" + mesasv.getIdMesaVenta() + "&idComanda=VER\" class=\"btn btn-danger btn-large numHE\"><br><h1><samp style=\"color:black\">VER</samp></h1></a>\n"
                                            + "                                    <a href=\"AutorizarDescuentoCuenta.jsp?idMesaVenta=" + mesasv.getIdMesaVenta() + "\" class=\"btn btn-danger btn-large numHE\"><br><h1><samp style=\"color:black\">Descuento</samp></h1></a>\n"
                                            + "                                    <a class=\"close-reveal-modal\">&#215;</a>\n"
                                            + "\n"
                                            + "                                </div> ");

                                    out.println(" <li class='ui-state-default'><a href='#' class='verimagen' data-reveal-id='" + mesasv.getIdMesaVenta() + "' data-animation='fadeAndPop' data-animationspeed='300' data-closeonbackgroundclick='true' data-dismissmodalclass='close-reveal-modal'><br><h3>"+mesasv.getIdMesaVenta()+"</h3><br><h1>" + mesasv.getIdMesaCapturada() + " </h1><br><br><h4>Personas Aprox:" + mesasv.getPersonasAprox() + "</h4></a></li> ");
                                    //out.println("  <li class='ui-state-default'><a href='SessionIdMesa?idMesaVenta=" + mesasv.getIdMesaVenta() + "'></a></li>");

                                }




                            %>





                        </ul>
                    </div>
                </td> 
                <td valign="top" style="padding-top:1%;padding-right:2%" align="right">

                    <table height="100%">
                        <tr><td><a href="Mesas.jsp" data-closeonbackgroundclick="true" data-dismissmodalclass="close-reveal-modal" title="SALIR" class="btn btn-primary numHE"><BR><BR>REGRESAR</a></td></tr>
                        <tr><td><HR><a href="ImprimirTira.jsp" data-closeonbackgroundclick="true" data-dismissmodalclass="close-reveal-modal" title="SALIR" class="btn btn-primary numHE"><BR><BR>IMPRIMIR<BR><BR>TODO</a></td></tr>
                    </table>   

                </td>
            </tr>
        </table>
<script Language="JavaScript">

            $(document).ready(function() {
                if (history.forward(1)) {
                    history.replace(history.forward(1));
                    alert("entro");
                }
            });
        </script>
</html>

