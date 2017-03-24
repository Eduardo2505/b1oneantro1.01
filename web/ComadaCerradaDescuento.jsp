
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.util.Properties"%>
<%@page import="com.mapping.MesaVenta"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="beans.Adicionalesbean"%>
<%@page import="com.dao.impl.AdicionalesComprobarDaoImpl"%>
<%@page import="beans.Comandaventabean"%>
<%@page import="com.dao.impl.CuentaDaoImpl"%>
<%@page import="com.dao.impl.DescuentoDaoImpl"%>
<%@page import="java.sql.SQLException"%>
<%-- 
    Document   : ComadaCerrada
    Created on : 9/03/2013, 01:57:16 PM
    Author     : Eduardopc
--%>

<%@page import="com.mapping.Adicionales"%>
<%@page import="com.dao.impl.VentaComandaDaoImpl"%>
<%@page import="com.mapping.Descuento"%>
<%@page import="com.mapping.VentaComanda"%>
<%@page import="com.mapping.Comanda"%>
<%@page import="com.dao.impl.Mesa_ventaDaoImpl"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="otrosNOsirve.conexion"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="com.mapping.Producto"%>
<%@page import="com.dao.impl.AdicionalesDaoImpl"%>
<%@page import="com.dao.impl.ComandaDaoImpl"%>
<%@page import="com.mapping.Empleado"%>
<%@page import="com.mapping.Altadia"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Venta</title>
        <%
            HttpSession sesion = request.getSession();
            // Empleado e = new Empleado();
            Altadia d = new Altadia();
            String nombre = "", nomMesero = "", tipoEvento = "";
            String idBarra = (String) sesion.getAttribute("idBarra");
            //e = (Empleado) sesion.getAttribute("id");
            String idMesero = "", idMesa = "", idComanda = "", idComandaTras = "";
            int idDia = 0;

            Producto p = new Producto();
            conexion mysql = new conexion();
            Connection cn = mysql.Conectar();
            ResultSet rs = null, rs1 = null;
            String idDescuento = (String) sesion.getAttribute("idDescuento");

            PreparedStatement st = null, st1 = null;
            //Descuento deg = null;
            if (idBarra == null) {
                response.sendRedirect("index.jsp");
            } else {
                nombre = " ByLatino";
                Empleado em = new Empleado();

                idMesa = (String) sesion.getAttribute("idMesa");
                em = (Empleado) sesion.getAttribute("idMesero");
                if (nombre.equals(em.getIdEmpleado())) {
                    response.sendRedirect("Menu.jsp");
                } else {
                    nomMesero = em.getNombre() + " " + em.getApellidos();
                    d = (Altadia) sesion.getAttribute("idDia");
                    idMesero = em.getIdEmpleado();
                    idDia = d.getIdaltadia();
                    tipoEvento = d.getTipoEvento();






                }


            }

            float sumita = 0, sumitax = 0;
            NumberFormat nf = NumberFormat.getInstance();
            nf.setMaximumFractionDigits(2);

            String ruta = getServletContext().getRealPath("/");
            Properties propiedades = new Properties();
            propiedades
                    .load(new FileInputStream(ruta + "/config/configuracion.properties"));
            String urlimpresora = propiedades.getProperty("urlimpresora");
            // out.println(urlimpresora);

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
                padding-top: 60px;
                padding-bottom: 40px;
            }
            .sidebar-nav {
                padding: 9px 0;
            }
        </style>
        <link href="assets/css/bootstrap-responsive.css" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="css/jquery-ui-1.8.21.custom.css">
        <link rel="stylesheet" type="text/css" href="css/style2.css" />

        <!--####################################siti#################-->
        <script type="text/javascript">

            $(function() {
                $('#cobro').submit(function() {
                    var data = $(this).serialize();
                    $('#verif').html('<img src="img/ajax-loader.gif" alt=""/>').fadeOut(1000);
                    $.post('CoverController', data, function(respuesta) {
                        $('#verif').fadeIn(1000).html(respuesta);

                    });
                    return false;
                });
            });
            $(function() {
                $('#RCortesia').submit(function() {
                    var data = $(this).serialize();
                    $('#verif').html('<img src="img/ajax-loader.gif" alt=""/>').fadeOut(1000);
                    $.post('ImprimeCortesia', data, function(respuesta) {
                        $('#verif').fadeIn(1000).html(respuesta);

                    });
                    return false;
                });
            });

            $(function() {

                $('#RRerservacion').submit(function() {
                    var data = $(this).serialize();

                    $('#verif').html('<img src="img/ajax-loader.gif" alt=""/>').fadeOut(1000);
                    $.post('ImprimeReservacion', data, function(respuesta) {
                        $('#verif').fadeIn(1000).html(respuesta);

                    });
                    return false;
                });
            });
            //############################


            $(document).ready(function() {
                $('.precio').change(generarSubIva);
            });

            function generarSubIva()
            {
                /* var iva=parseFloat($(this).parent().parent().find(".iva").val());
                 $(this).parent().parent().find(".final").val(parseFloat($(this).val())*iva/100);*/

                var total = 0;
                $(".final").each(function() {
                    total += parseFloat($(this).val());
                });

                $("#finalIva").val(total);
            }

        </script>

        <style>
            .numH{
                font-size:12px;
                font-weight:bold;
                height:50px;
                width:210px;

            }
            .num{
                font-size:20px;
                font-weight:bold;
                height:60px;
                width:150px;

            }
            .negrita{
                font-size:20px;
                font-weight:bold;


            }



        </style>
        <link rel="stylesheet" type="text/css" href="css/BotononesIndex.css">
    </head>
    <body style="overflow:hidden">
    <body id="demo-frame">

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
                        <ul class="dropdown-menu" >

                            <li><a href="closeSessionMesero">Salir</a></li>
                        </ul>
                    </div>

                </div>
            </div>
        </div>

        <table width="100%" style="text-align:center" >
            <tr><td width="35%" style="padding:20px 20px 20px 20px" valign="top" id="vercancelacion">

                    <div class="well" id="ComandaVirtual" style="OVERFLOW: auto; WIDTH:90%;HEIGHT:480px;padding-top:0%">
                        <script type="text/javascript">

                            $(document).ready(function() {
                                $(".eliminarProducto").click(function(event) {

                                    var idCargoria = $(this).attr("name");
                                    //alert(idCargoria)
                                    $("#ComandaVirtual").load(idCargoria);
                                });
                            });

                            $(document).ready(function() {
                                $(".eliminarAdicional").click(function(event) {

                                    var idCargoria = $(this).attr("name");
                                    //alert(idCargoria)
                                    $("#ComandaVirtual").load(idCargoria);
                                });
                            });

                            $(document).ready(function() {
                                $(".addAdicionales").click(function(event) {
                                    //alert("Adicional");

                                    var idCargoria = $(this).attr("value");
                                    var nompro = $(this).attr("alt");


                                    $("#textIdventa").val(idCargoria);
                                    $("#nomprodiv").html(nompro);

                                    $("#Activar").click();
                                    //alert(idCargoria);
                                });
                            });
                        </script>
                        <table class="table table-striped" >

                            <%
                                Mesa_ventaDaoImpl mv = new Mesa_ventaDaoImpl();
                                MesaVenta mvv = new MesaVenta();
                                mvv = mv.bucarPorId(idMesa);
                               
                                out.println("<tr><th colspan='2'>Producto</th><th>Cantidad</th><th>Precio</th></tr>");

                                CuentaDaoImpl dac = new CuentaDaoImpl();
                                List resa = dac.getmostrar(idMesa, "adicional");
                                Iterator itra = resa.iterator();
                                while (itra.hasNext()) {
                                    Comandaventabean a = (Comandaventabean) itra.next();
                                    sumita += a.getTotalcosto();
                                    out.println("<tr><td colspan='2'>" + a.getProducto() + " " + a.getMedida() + "</td><td>" + a.getCantidad() + "</td><td>$ " + nf.format(a.getTotalcosto()) + "</td></tr>");

                                    AdicionalesComprobarDaoImpl daoEm = new AdicionalesComprobarDaoImpl();
                                    List res = daoEm.getAdicionales(a.getIdventa());
                                    Iterator itr = res.iterator();
                                    int verMesesa = 0;
                                    while (itr.hasNext()) {
                                        Adicionalesbean vcx = (Adicionalesbean) itr.next();
                                        out.println("<tr><td width='70px'></td><td style='background-color:yellow'>" + vcx.getProducto() + " " + vcx.getMedida() + "</td><td style='background-color:yellow'>" + vcx.getCantidad() + "</td><td style='background-color:yellow'>$ 0</td><td></td></tr>");



                                    }
                                    if (a.getTipo().equals("cortesia")) {
                                        out.println("<tr><td></td><td >Autorización </td><td colspan='4' >" + a.getAutorizacion() + "</td></tr>");
                                        out.println("<tr><td></td><td >Observaciones </td><td colspan='4' >" + a.getObservaciones() + "</td></tr>");
                                    }
                                }
                                List resax = dac.getmostrar(idMesa, "np");
                                Iterator itrax = resax.iterator();
                                while (itrax.hasNext()) {
                                    Comandaventabean a = (Comandaventabean) itrax.next();
                                    sumitax += a.getTotalcosto();
                                    out.println("<tr><td colspan='2'>" + a.getProducto() + " " + a.getMedida() + "</td><td>" + a.getCantidad() + "</td><td>$ " + nf.format(a.getTotalcosto()) + "</td></tr>");
                                    if (a.getTipo().equals("cortesia")) {
                                        out.println("<tr><td></td><td >Autorización </td><td colspan='4' >" + a.getAutorizacion() + "</td></tr>");
                                        out.println("<tr><td></td><td >Observaciones </td><td colspan='4' >" + a.getObservaciones() + "</td></tr>");
                                    }

                                }

                                if (!mvv.getObservaciones().equals("-")) {
                                    out.println("<tr><td></td><td ><h4>Autorización</h4> </td><td colspan='4' ><h4>" + mvv.getAtorizacion() + "</h4></td></tr>");
                                    out.println("<tr><td></td><td ><h4>Observaciones</h4> </td><td colspan='4' ><h4>" + mvv.getObservaciones() + "</h4></td></tr>");
                                    Descuento des = new Descuento();
                                    des = mvv.getDescuento();
                                    if (des != null) {
                                        out.println("<tr><td></td><td ><h4>Descuento</h4> </td><td colspan='4' ><h4>" + des.getObservaciones() + "</h4></td></tr>");
                                    }

                                }
                                float sumatotal = sumitax + sumita;
                                DecimalFormat df = new DecimalFormat("0.##");
                                float descuformat = Float.valueOf(df.format(sumatotal));
                                mv.actualiza(idMesa, descuformat);
                            %>

                            <tr><td colspan="2">TOTAL:</td><td>$<%out.println(nf.format((sumita + sumitax)));%> </td></tr>


                        </table>

                    </div>



                <td style="position:absolute; top:10; left:50;" width="64%">
                    <table width="100%">
                        <tr><td width="85%" valign="top" style="padding-right:1%">


                                <div class="well" style="OVERFLOW: auto; WIDTH:93%;HEIGHT:540px;padding-top:0%" >
                                    <h3>TOTAL  </h3><HR>
                                    <H1>$<%out.println(nf.format((sumita + sumitax)));%></h1><HR>

                                    <form id="CerarCuentaMesaFrom">

                                        <input type="submit" value="CERRAR E IMPRIMIR" class="btn btn-primary numH">


                                    </form>
                                    <div id="cargarCerrar" style="display:none">
                                        <a href="CuentasCerradas.jsp" class="btn btn-danger btn-large">REGRESAR</a>


                                    </div>



                                </div>


                            </td>
                        </tr>
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
        <input type="hidden" id="uerlimpresion" value="<%=urlimpresora%>">
        <script type="text/javascript">
            //CERRAR CUENTE E IMPRIMIT
            $(function() {
                $('#CerarCuentaMesaFrom').submit(function() {
                    var data = $(this).serialize();

                    jConfirm("¿Seguro que desea CERRAR la MESA?", "Cerrar e Imprimir", function(r) {
                        if (r) {

                            var urli = $('#uerlimpresion').val();
                            var dataString = 'imp=d';
                            $.ajax({
                                type: "POST",
                                url: "ImprimirTiket",
                                data: dataString,
                                success: function(data) {

                                    var encodedUrl = encodeURIComponent(data);
                                    // alert(encodedUrl)
                                    $("#cargarCerrar").load(urli + encodedUrl);

                                    $("#cargarCerrar").show();
                                    ///$(location).attr('href', "tike.jsp");


                                }
                            });



                        } else {
                            return false;
                        }
                    });

                    return false;
                });
            });

        </script>
    </body>