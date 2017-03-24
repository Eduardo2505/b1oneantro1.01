<%-- 
    Document   : Comanda_venta
    Created on : 17/01/2013, 12:56:34 AM
    Author     : Eduardopc
--%>

<%@page import="java.util.Date"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.util.Properties"%>
<%@page import="com.mapping.MesaVenta"%>
<%@page import="com.dao.impl.CuentaDaoImpl"%>
<%@page import="beans.Adicionalesbean"%>
<%@page import="com.dao.impl.AdicionalesComprobarDaoImpl"%>
<%@page import="beans.Comandaventabean"%>
<%@page import="com.dao.impl.ComandaVentaBeansImpl"%>
<%@page import="com.dao.impl.ProductoBeanDaoImpl"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="com.mapping.Puesto"%>
<%@page import="com.dao.impl.ProductoDaoImpl"%>
<%@page import="otrosNOsirve.consultasMysq"%>
<%@page import="com.mapping.Descuento"%>
<%@page import="com.mapping.VentaComanda"%>
<%@page import="com.dao.impl.VentaComandaDaoImpl"%>
<%@page import="java.util.logging.Logger"%>
<%@page import="mail.EmailEnv"%>
<%@page import="java.util.logging.Level"%>
<%@page import="com.mapping.Producto"%>
<%@page import="com.mapping.Adicionales"%>
<%@page import="com.dao.impl.AdicionalesDaoImpl"%>
<%@page import="com.mapping.Barra"%>
<%@page import="com.dao.impl.EmpleadoDaoImpl"%>
<%@page import="com.dao.impl.Mesa_ventaDaoImpl"%>
<%@page import="com.mapping.Comanda"%>
<%@page import="com.dao.impl.ComandaDaoImpl"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="otrosNOsirve.conexion"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="com.dao.impl.CategoriaDaoImpl"%>
<%@page import="com.mapping.Categoria"%>
<%@page import="com.mapping.Altadia"%>
<%@page import="com.mapping.Empleado"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Venta</title>
        <%
            HttpSession sesion = request.getSession();
            //Empleado e = new Empleado();
            Altadia d = new Altadia();
            String nombre = "", nomMesero = "", tipoEvento = "";
            String idBarra = (String) sesion.getAttribute("idBarra");

            String idMesero = "", idMesa = "", idComanda = "", idComandaTras = "", idDescuento = "", nombremesa = "";
            int idDia = 0;


            ComandaDaoImpl daocan = new ComandaDaoImpl();

            List rescan = null;

            Iterator itrcan = null;

            int idpuesto = 0, idp = 0;
            if (idBarra == null) {
                response.sendRedirect("index.jsp");
            } else {
                nombre = "By1ONE";
                Empleado em = new Empleado();
                idComanda = (String) sesion.getAttribute("idComanda");
                idMesa = (String) sesion.getAttribute("idMesa");
                nombremesa = (String) sesion.getAttribute("nombremesa");
                em = (Empleado) sesion.getAttribute("idMesero");

                if (nombre.equals(em.getIdEmpleado())) {
                    response.sendRedirect("Menu.jsp");

                } else {
                    idpuesto = Integer.parseInt((String) sesion.getAttribute("idpuesto"));

                    nomMesero = em.getNombre() + " " + em.getApellidos();
                    Puesto p = new Puesto();
                    p = em.getPuesto();
                    idp = p.getIdpuesto();
                    //out.println(idp);
                    d = (Altadia) sesion.getAttribute("idDia");
                    idMesero = em.getIdEmpleado();
                    idDia = d.getIdaltadia();
                    tipoEvento = d.getTipoEvento();
                    idDescuento = (String) sesion.getAttribute("idDescuento");

                }

            }
            String ruta = getServletContext().getRealPath("/");
            Properties propiedades = new Properties();
            propiedades
                    .load(new FileInputStream(ruta + "/config/configuracion.properties"));
            String urlimpresora = propiedades.getProperty("urlimpresora");

           
            int timeout = session.getMaxInactiveInterval();
            response.setHeader("Refresh", timeout + "; URL = Menu.jsp");


        %>
    <input type="hidden" id="uerlimpresion" value="<%=urlimpresora%>">
    <script src="js/jquery-1.7.2.min.js"></script>
    <script src="js/jquery-ui-1.8.21.custom.min.js"></script>
    <script src="js/jquery.alerts.js"></script>
    <link rel="stylesheet" type="text/css" href="js/jquery.alerts.css">

    <script type="text/javascript" src="js/jquery.reveal.js"></script>
    <link rel="stylesheet" href="css/reveal.css">
    <!-- ================================Los styles =============================== -->
    <link href="assets/css/bootstrap.css" rel="stylesheet">


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

        $(document).ready(function() {
            var manuca = screen.height;
            var categoria = 170;
            var productos = ((manuca * 340) / 768) + 150;
            var comandaVirtual = (manuca * 480) / 768;
            //   alert(manuca);
            $("#menuCategoriascss").css({"height": "" + categoria + "px"});
            $("#verResultadoBuscados").css({"height": "" + productos + "px"});
            $("#ComandaVirtual").css({"height": "" + comandaVirtual + "px"});

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
        .numI{
            font-size:12px;
            font-weight:bold;

            height:40px;
            width:210px;

        }
        .num{
            font-size:15px;
            font-weight:bold;
            height:60px;
            width:90px;

        }
        .numg{
            font-size:15px;
            font-weight:bold;
            height:90px;
            width:90px;

        }
        .negrita{
            font-size:15px;
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
                <a class="brand" href="#">Usuario:<samp style="font-size:17px"> <% out.println(nombre);%></samp></a>
                <a class="brand" href="#">Empleado(a):<samp style="font-size:17px"> <% out.println(nomMesero);%></samp></a>
               <!-- <a class="brand" href="#">Mesa:<samp style="font-size:17px"> <% out.println(idMesa);%></samp></a>-->





            </div>
        </div>
    </div>
    <div  id="acpetarBtn" style="display:none">
        <div class="container"  >
            <div class="row ">

                <div class="well" style="text-align:center">

                    <h1>Se imprio correctamente</h1><br>
                    <a href="Mesas.jsp" class="btn btn-success ">Aceptar</a>

                </div>

            </div>
        </div>
    </div>
    <div  id="formImprimioCorrecto">
        <table width="100%" style="text-align:center" >
            <tr><td width="35%" style="padding:20px 20px 20px 20px" valign="top" id="vercancelacion">

                    <div class="well" id="ComandaVirtual" style="OVERFLOW: auto; WIDTH:90%;padding-top:0%">
                        <div id="copiarProducto" class="reveal-modal" style="text-align:center">
                            <form id="AgregarMesaCopiar">
                                <label class="label-warning"><H3>#COPIAR CANTIDAD</H3></label>
                                <input type="hidden" name="idventa" id="mosrraid" value="">              


                                <input type="text" onkeypress="return isNumberKey(event)" name="cantida" required="" >    

                                <br>

                                <input type="submit" value="Aceptar" class="btn btn-primary btn-large" >


                            </form>
                            <a class="close-reveal-modal">&#215;</a>

                        </div>
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


                        </script>
                        <script type="text/javascript">

                            $(document).ready(function() {
                                $('.addAdicionales').click(function() {
                                    var idproducto = $(this).attr("name");
                                    var idventa = $(this).val();
                                    var dataString = 'idProducto=' + idproducto + '&idventa=' + idventa;
                                    $.ajax({
                                        type: "POST",
                                        url: "comprobarcomandaadicional",
                                        data: dataString,
                                        success: function(data) {
                                            var inres = data.length;
                                            //alert(inres)
                                            if (inres != 0) {
                                                $("#menuproductos").hide();

                                                var urla = "adicionalesxml.jsp?idProducto=" + idproducto;

                                                $("#adicionalemenu").fadeIn(800).load(urla);

                                            }
                                            return false;
                                        }

                                    });

                                    return false;
                                });

                            });
                        </script>
                        <%if (!idComanda.equals("VER")) {%>
                        <div style='align-text:center'><h1>COMANDA</h1></div><br>
                        <%} else {%>
                        <div style='align-text:center'><h3>CUENTA <%=nombremesa%></h3></div><br>
                        <%}%>

                        <table class="table table-striped" >

                            <%
                                float sumita = 0, sumitax = 0;
                                float sumatotal = 0;

                                DecimalFormat df = new DecimalFormat("0.##");
                                Mesa_ventaDaoImpl mv = new Mesa_ventaDaoImpl();
                                MesaVenta mvv = new MesaVenta();
                                mvv = mv.bucarPorId(idMesa);
                                //out.println(idMesa);
                                // out.println(idMesa);
                                //System.out.println(idMesa);
                                if (!idComanda.equals("VER")) {
                                    out.println("<tr><th colspan='2'>Producto</th><th>Cantidad</th><th>Precio</th><th>Opc</th></tr>");

                                    ComandaVentaBeansImpl dac = new ComandaVentaBeansImpl();
                                    List resa = dac.getBuscar(idComanda, "adicional");
                                    Iterator itra = resa.iterator();
                                    while (itra.hasNext()) {
                                        Comandaventabean a = (Comandaventabean) itra.next();
                                        sumita += a.getTotalcosto();
                                        out.println("<tr><td colspan='2'><a href=\"#\" class=\"eliminarProducto\"  name=\"EliminarProductoController?idIdventComanda=" + a.getIdventa() + "\"> <img src=\"img/iconoE.png\"> </a> " + a.getProducto() + " " + a.getMedida() + "</td><td>" + a.getCantidad() + "</td><td>$ " + df.format(a.getTotalcosto()) + "</td><td><input type=\"radio\" class='addAdicionales' name=\"" + a.getIdProducto() + "\" value='" + a.getIdventa() + "'></td></tr>");

                                        AdicionalesComprobarDaoImpl daoEm = new AdicionalesComprobarDaoImpl();
                                        List res = daoEm.getAdicionales(a.getIdventa());
                                        Iterator itr = res.iterator();
                                        int verMesesa = 0;
                                        while (itr.hasNext()) {
                                            Adicionalesbean vcx = (Adicionalesbean) itr.next();
                                            out.println("<tr><td width='70px'></td><td style='background-color:yellow'><a href=\"#\" class=\"eliminarAdicional\"  name=\"EliminarAdicionController?idAdicion=" + vcx.getIdadicional() + "\"> <img src=\"img/iconoE.png\"> </a> " + vcx.getProducto() + " " + vcx.getMedida() + "</td><td style='background-color:yellow'>" + vcx.getCantidad() + "</td><td style='background-color:yellow'>$ 0</td><td></td></tr>");



                                        }
                                    }
                                    List resax = dac.getBuscar(idComanda, "np");
                                    Iterator itrax = resax.iterator();
                                    while (itrax.hasNext()) {
                                        Comandaventabean a = (Comandaventabean) itrax.next();
                                        sumitax += a.getTotalcosto();
                                        out.println("<tr><td colspan='2'><a href=\"#\" class=\"eliminarProducto\"  name=\"EliminarProductoController?idIdventComanda=" + a.getIdventa() + "\"> <img src=\"img/iconoE.png\"> </a> " + a.getProducto() + " " + a.getMedida() + "</td><td>" + a.getCantidad() + "</td><td>$ " + df.format(a.getTotalcosto()) + "</td></tr>");


                                    }

                                } else {

                                    out.println("<tr><th colspan='2'>Producto</th><th>Cantidad</th><th>Precio</th></tr>");

                                    CuentaDaoImpl dac = new CuentaDaoImpl();
                                    List resa = dac.getmostrar(idMesa, "adicional");
                                    Iterator itra = resa.iterator();
                                    while (itra.hasNext()) {
                                        Comandaventabean a = (Comandaventabean) itra.next();
                                        sumita += a.getTotalcosto();
                                        out.println("<tr><td colspan='2'>" + a.getProducto() + " " + a.getMedida() + "</td><td>" + a.getCantidad() + "</td><td>$ " + df.format(a.getTotalcosto()) + "</td></tr>");

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
                                        out.println("<tr><td colspan='2'>" + a.getProducto() + " " + a.getMedida() + "</td><td>" + a.getCantidad() + "</td><td>$ " + df.format(a.getTotalcosto()) + "</td></tr>");
                                        if (a.getTipo().equals("cortesia")) {
                                            out.println("<tr><td></td><td >Autorización </td><td colspan='4' >" + a.getAutorizacion() + "</td></tr>");
                                            out.println("<tr><td></td><td >Observaciones </td><td colspan='4' >" + a.getObservaciones() + "</td></tr>");
                                        }

                                    }
                                }
                                //  out.println(mvv.getObservaciones());
                                if (mvv.getObservaciones() != null) {

                                    if (!mvv.getObservaciones().equals("-")) {

                                        out.println("<tr><td></td><td ><h4>Autorización</h4> </td><td colspan='4' ><h4>" + mvv.getAtorizacion() + "</h4></td></tr>");
                                        out.println("<tr><td></td><td ><h4>Observaciones</h4> </td><td colspan='4' ><h4>" + mvv.getObservaciones() + "</h4></td></tr>");
                                        Descuento des = new Descuento();
                                        des = mvv.getDescuento();
                                        if (des != null) {
                                            out.println("<tr><td></td><td ><h4>Descuento</h4> </td><td colspan='4' ><h4>" + des.getObservaciones() + "</h4></td></tr>");
                                        }
                                    }

                                }
                                sumatotal = sumitax + sumita;
                                float totalito = Float.parseFloat(df.format(sumatotal));
                                mv.actualiza(idMesa, totalito);
                            %>
                            <tr><td colspan="2"><H3>TOTAL:</h3></td><td><H3>$ <%out.println(df.format((sumatotal)));%></h3> </td></tr>

                            <tr><td colspan="3" id="cargarCerrar"></td></tr>


                        </table>

                    </div>
                    <script type="text/javascript">
                        //CERRAR CUENTE E IMPRIMIT
                        $(function() {
                            $('#CerarCuentaMesaFrom').submit(function() {
                                var data = $(this).serialize();

                                jConfirm("¿Seguro que desea CERRAR la MESA?", "Cerrar e Imprimir", function(r) {
                                    if (r) {
                                        $('#cargarCerrar').html('<img src="img/ajax-loader.gif" alt=""/>').fadeOut(1000);
                                        $.post('CerrarMesaController', data, function(respuesta) {

                                            var inres = respuesta.length;
                                            //alert(respuesta);
                                            //  alert(inres);
                                            if (inres != 0) {
                                                jAlert("No hay producto o ya esta impreso", "Error");

                                            } else {
                                                var dataString = 'imp=i';
                                                $.ajax({
                                                    type: "POST",
                                                    url: "ImprimirTiket",
                                                    data: dataString,
                                                    success: function(data) {
                                                        var urli = $('#uerlimpresion').val();
                                                        var encodedUrl = encodeURIComponent(data);
                                                        // alert(encodedUrl)
                                                        $("#formImprimioCorrecto").load(urli + encodedUrl);

                                                        $("#formImprimioCorrecto").hide();
                                                        $("#acpetarBtn").show();
                                                        ///$(location).attr('href', "tike.jsp");


                                                    }
                                                });

                                            }


                                            //$('#verCerrada').html(respuesta);


                                            return false;




                                        });



                                    } else {
                                        return false;
                                    }
                                });

                                return false;
                            });
                        });
                        ///
                        $(document).ready(function() {
                            $('#reimprmir').click(function() {
                                // var user = $(this).val();
                                var user = $(this).attr("name");

                                if (user != "") {

                                    $.ajax({
                                        type: "POST",
                                        url: "CerrarMesaController",
                                        data: user,
                                        success: function(data) {
                                            // alert(data);
                                            var inres = data.length;
                                            //  alert(inres);
                                            if (inres > 0) {
                                                jAlert("No hay producto", "Error");
                                            } else {
                                                //  alert("redireccionar");
                                                $(location).attr('href', "tiket/tiketPrevio.jsp");
                                            }


                                        }
                                    });
                                    //}
                                }
                            }


                            );
                        });
                        ///##################
                        $(document).ready(function() {
                            $('#impedidoww').click(function() {



                                var user = "op=i";
                                $.ajax({
                                    type: "POST",
                                    url: "ImprimirComanda",
                                    data: user,
                                    success: function(data) {
                                        // alert(data);
                                        var inres = data.length;

                                        // alert(inres);
                                        if (inres == 0) {
                                            jAlert("NO TIENE PRODUCTO LA COMANDA", "Error");
                                        } else if (inres == 9) {
                                            $(location).attr('href', "Mesas.jsp");
                                        } else {
                                            var encodedUrl = encodeURIComponent(data);
                                            var urli = $('#uerlimpresion').val();
                                            //alert('http://localhost:8084/ImpresionPuntoPv/imprimir.jsp?tiket=' + encodedUrl);
                                            $("#formImprimioCorrecto").load(urli + encodedUrl);


                                            $("#formImprimioCorrecto").hide();
                                            $("#acpetarBtn").show();
                                        }

                                        return false;
                                    }
                                });

                                return false;
                            }


                            );
                        });
                        //######################################################
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
                    <div id="verCerrada"></div>
                    <!--#################Cerrar cuenta#################-->

                    <form id="CerarCuentaMesaFrom">
                        <input type="hidden" name="idMesaCuenta" value="<% out.println(idMesa);%>">
                        <input type="hidden" name="op" value="close">
                        <input type="hidden" name="idComanda" value="VER">

                        <% if (!idComanda.equals(
                                    "VER")) {%>

                     <!--  <a id="impedidoww" href="#" name="idMesaCuenta=<% out.println(idMesa);%>" class="btn btn-warning numI">IMPRIMIR<BR>PEDIDO</a>-->

                        <a id="impedidoww" href="#" class="btn btn-warning numI">IMPRIMIR<BR>PEDIDO</a>
                            <%   } else {

                                if (idpuesto == 12 || idpuesto == 8 || idpuesto == 22|| idpuesto == 24||idpuesto == 23 || idpuesto == 2 || idpuesto == 3) {%>
                        <input type="submit" value="CERRAR E IMPRIMIR" class="btn btn-primary numH">
                        <a href="CancelaProducto.jsp" class="btn btn-warning" style="height:40px">Cancelar Producto</a>
                        <!--<a href="#" id="reimprmir" name="idMesaCuenta=<% out.println(idMesa);%>&op=imprimir&idComanda=VER" class="btn btn-warning numI">VISTA PREVIA</a>-->
                        <%                            }
                            }%>

                    </form>


                    <!---#####################cANCELAR COMANDA--------->
                    <script type="text/javascript">
                        $(document).ready(function() {
                            $('#mostraridComanda').change(function() {
                                var user = $(this).val();
                                var dataString = 'mostraridComanda=' + user;
                                //alert(user);
                                if (user != "") {
                                    $('#veridCom').html('<img src="img/ajax-loader.gif" alt=""/>');
                                    $.ajax({
                                        type: "POST",
                                        url: "BucarComandasController",
                                        data: dataString,
                                        success: function(data) {
                                            //alert(data)

                                            $('#veridCom').fadeIn(500).html(data);

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
                            $('#mostrartrasls').change(function() {
                                var user = $(this).val();
                                var dataString = 'mostraridComanda=' + user;

                                if (user != "") {
                                    $('#veridTras').html('<img src="img/ajax-loader.gif" alt=""/>');
                                    $.ajax({
                                        type: "POST",
                                        url: "BucarComandasController",
                                        data: dataString,
                                        success: function(data) {
                                            //alert(data)

                                            $('#veridTras').fadeIn(500).html(data);
                                            //$('#idComanditaa').html(user);



                                            //	 response.sendRedirect("index.jsp");	
                                            //alert(data);
                                        }
                                    });
                                    //}
                                }
                            }


                            );
                        });
                        //Mostrar mesasa
                        $(document).ready(function() {
                            $('#mostrarMesas').change(function() {
                                var user = $(this).val();

                                var dataString = 'idEmpleado=' + user + '';
                                //  var dataString ='idEmpleado='+user+'&idComada='+idComanda+'';
                                //alert(dataString);                             

                                $.ajax({
                                    type: "POST",
                                    url: "SeleccionMesasController",
                                    data: dataString,
                                    success: function(data) {
                                        //  alert(data)

                                        $('#resulselec').html(data);

                                        //	 response.sendRedirect("index.jsp");	
                                        //alert(data);
                                    }
                                });
                                //}
                            }


                            );
                        });

                        $(function() {
                            $('#fromcancelacion').submit(function() {
                                var data = $(this).serialize();

                                jPrompt("Observación", "", "Insertar Observación", function(r) {
                                    if (r) {

                                        var enviadatos = data + "&Observa=" + r;
                                        jConfirm("¿Seguro que desea cancelar la comanda?", "Cancelar Comanda", function(r) {
                                            if (r) {

                                                $('#cargar').html('<img src="img/ajax-loader.gif" alt=""/>').fadeOut(1000);
                                                // alert(enviadatos)
                                                $.post('CancelacionComandaControll', enviadatos, function(respuesta) {


                                                    //$('#fromcancelacion')[0].reset();
                                                    // alert(respuesta);
                                                    var r = respuesta.length;
                                                    //  alert(r);
                                                    if (r == 0) {

                                                        jAlert("No tiene Autorización", "Autorización");
                                                    } else {
                                                        $('#fromcancelacion')[0].reset();
                                                        var urli = $('#uerlimpresion').val();
                                                        var encodedUrl = encodeURIComponent(respuesta);
                                                        $("#formImprimioCorrecto").load(urli + encodedUrl);
                                                        jAlert("Se realizo la cancelación correctamente", "Confirmación", function(r) {
                                                            if (r) {


                                                                $(location).attr('href', "Comanda_venta.jsp");
                                                            }
                                                        });
                                                        // $(location).attr('href', "tiket/TiketCancelacion.jsp");
                                                    }








                                                });
                                            } else {
                                                return false;
                                            }
                                        });


                                    }
                                    return false;
                                });


                                return false;
                            });
                        });
                        //Funcion transladar
                        $(function() {
                            $('#fromtrasladoComan').submit(function() {
                                var data = $(this).serialize();
                                jPrompt("Observación", "", "Insertar Observación", function(r) {
                                    if (r) {

                                        var enviadatos = data + "&Observa=" + r;
                                        jConfirm("¿Seguro que desea TRANSLADAR la comanda?", "Trasladar Comanda", function(r) {
                                            if (r) {

                                                $('#cargar').html('<img src="img/ajax-loader.gif" alt=""/>').fadeOut(1000);
                                                // alert(enviadatos)
                                                $.post('TransladarComandaController', enviadatos, function(respuesta) {


                                                    //$('#fromcancelacion')[0].reset();                       
                                                    var r = respuesta.length;
                                                    // alert(r)
                                                    if (r != 0) {

                                                        jAlert(respuesta, "Autorización");
                                                    } else {
                                                        $('#fromtrasladoComan')[0].reset();
                                                        jAlert("Se realizo el translado correctamente", "Confirmación", function(r) {
                                                            if (r) {
                                                                //  jAlert("Imprime tiket", "UU");
                                                                $(location).attr('href', "Comanda_venta.jsp");
                                                            }
                                                        });
                                                        // $(location).attr('href', "tiket/TiketCancelacion.jsp");
                                                    }







                                                });
                                            } else {
                                                return false;
                                            }
                                        });


                                    }
                                    return false;
                                });


                                return false;
                            });
                        });

                    </script>
                    <!--############Cancelacion comanda#####-->
                    <div id="cancelardiv" class="reveal-modal" style="text-align:center">                       
                        <form id="fromcancelacion">                            
                            <label class="label-warning"><H3>Cancelación -->#ID COMANDA</H3></label>    
                            <select name="idComanda" id="mostraridComanda" required="">
                                <option value="">Seleccione</option>
                                <%                                    rescan = daocan.getBuscar(idMesa);
                                    itrcan = rescan.iterator();

                                    while (itrcan.hasNext()) {
                                        Comanda comcan = (Comanda) itrcan.next();
                                        out.println("<option value='" + comcan.getIdComanda() + "'>" + comcan.getIdComanda() + "</option>");

                                    }
                                %>
                            </select><br>
                            <input type="password" name="atorizar" required="" placeholder="PASSWORD" ><br>
                            <div id="veridCom" style="OVERFLOW: auto;HEIGHT:390px;padding-top:0%">


                            </div>                            

                            <input type="submit" value="CANCELAR" class="btn btn-primary btn-large" >

                            <div id="cargar"></div>
                        </form>

                        <a class="close-reveal-modal">&#215;</a>

                    </div>
                    <!--############Ttrasladar Comanda#####-->
                    <div id="trasladoCom" class="reveal-modal" style="text-align:center">


                        <form id="fromtrasladoComan">                         
                            <label class="label-warning"><H3>Transladar Comanda</H3></label>    
                            <input type="hidden" name="nombres" value="<% out.println(nomMesero);%>">

                            <select name="idComanda" id="mostrartrasls" required="">
                                <option value="">Seleccione</option>
                                <%                                    rescan = daocan.getBuscar(idMesa);
                                    itrcan = rescan.iterator();

                                    while (itrcan.hasNext()) {
                                        Comanda comcan = (Comanda) itrcan.next();

                                        out.println("<option value='" + comcan.getIdComanda() + "'>" + comcan.getIdComanda() + "</option>");

                                    }
                                %>
                            </select>
                            <br>
                            <select name="idMesero" id="mostrarMesas" required="">
                                <option value="">Mesero</option>
                                <%                                    EmpleadoDaoImpl daoe = new EmpleadoDaoImpl();
                                    Barra b = new Barra();
                                    List rese = daoe.getFiltro();
                                    Iterator itre = rese.iterator();

                                    while (itre.hasNext()) {
                                        Empleado em = (Empleado) itre.next();

                                        b = em.getBarra();

                                        if (b != null) {
                                            if (!b.getIdBarra().equals("Desactivar")) {
                                                out.print(" <option  value ='" + em.getIdEmpleado() + "'>" + em.getEmpleadocol() + "</option>");

                                            }

                                        }

                                        //out.print("<li class='ui-state-default'><a href='SessionMesero?idMesero=" + em.getIdEmpleado() + "'><h3>" + puesto + "</h3><br>" + em.getNombre() + " " + em.getApellidos() + "</a></li>");
                                    }

                                %>
                            </select> a 

                            <select name="idMesa"  id="resulselec" required="" >

                                <option value="">idCuentaMesa</option>

                            </select>
                            <input type="password" name="atorizar" required="" placeholder="PASSWORD" ><br>
                            <div id="veridTras" style="OVERFLOW: auto;HEIGHT:290px;padding-top:0%">


                            </div>                            

                            <input type="submit" value="Transladar" class="btn btn-primary btn-large" >

                            <div id="cargar"></div>
                        </form>

                        <a class="close-reveal-modal">&#215;</a>

                    </div>













                    <a href="#" id="Activar" data-reveal-id="Activardiv" data-animation="fadeAndPop" data-animationspeed="300" data-closeonbackgroundclick="true" data-dismissmodalclass="close-reveal-modal" title="" ></a>



                </td> 
                <td style="position:absolute; top:10; left:50;" width="64%">
                    <table width="100%">
                        <tr><td width="85%" valign="top" style="padding-right:1%">
                                <script type="text/javascript">

                                    $(document).ready(function() {
                                        $(".btnEnviarenviar").click(function(event) {

                                            var idCargoria = $(this).attr("title");
                                            //alert(idCargoria)
                                            $("#div_mostrar").load(idCargoria);
                                        });
                                    });

                                    $(document).ready(function() {
                                        $(".addCategoria").click(function(event) {

                                            var idCargoria = $(this).attr("name");

                                            $("#verResultadoBuscados").load(idCargoria);
                                        });
                                    });


                                </script>
                                <style>
                                    #sortable { list-style-type: none; margin: 0; padding: 0; width: 100%; }
                                    #sortable li { margin: 3px 3px 3px 0; padding: 1px; float: left; /*background-image:url('img/producto.jpg');*/
                                    }

                                    .addCategoria{

                                        margin: 3px 3px 3px 0; padding: 1px; float: left; width: 96px; height: 50px; font-size:10px; text-align: center;
                                    }
                                    div.bordesolido{ 
                                        border: 1px solid #aaaaaa; 
                                    }
                                    .addProducto{

                                        margin: 3px 3px 3px 0; padding: 1px; float: left; width: 120px; height: 120px; font-size: 1em; text-align: center;
                                    }
                                    .addCategoria:hover {

                                        text-decoration: none;
                                        color: #FA5C00;
                                        cursor: pointer;
                                    }
                                    .addProducto:hover {

                                        text-decoration: none;
                                        color: #FA5C00;
                                        cursor: pointer;
                                    }


                                </style>
                                <div class="well" style="padding-top:0%;text-align:center">

                                    <!--##############################################Productos#################################################################-->
                                    <div id="adicionalemenu">

                                    </div>
                                    <div id="menuproductos">
                                        <div id="menuCategoriascss" style="OVERFLOW: auto; WIDTH:100%;padding-top:0%;">
                                            <ul id="sortable" >
                                                <%                                           //     if (idpuesto == 8 || idpuesto == 1 || idpuesto == 22) {
                                                    ProductoBeanDaoImpl dao = new ProductoBeanDaoImpl();
                                                    List res = dao.getFiltro();
                                                    Iterator itr = res.iterator();

                                                    while (itr.hasNext()) {
                                                        Categoria p = (Categoria) itr.next();

                                                        out.print("<li class='ui-state-default'><a class='addCategoria' name='BuscarProductoCategoriaController?idCategoria=" + p.getIdCategoria() + "' ><h5>" + p.getIdCategoria() + "</h5></a></li>");

                                                    }

                                                    //  }
                                                %>


                                            </ul>

                                        </div>

                                        <div id="div_mostrar" style="padding-top:0%">
                                            <script type="text/javascript">


                                                $(document).ready(function() {
                                                    $('#NombreProducto').keyup(function() {

                                                        var user = $(this).val();
                                                        // alert(user);



                                                        var dataString = 'NombreProducto=' + user;

                                                        var inres = user.length;
                                                        //  alert(inres);
                                                        // $('#verResultadoBuscados').html('<img src="img/ajax-loader.gif" alt=""/>').fadeOut(200);
                                                        if (inres > 3) {
                                                            $('#verResultadoBuscados').html('<img src="img/ajax-loader.gif" alt=""/>').fadeOut(100);


                                                            $.ajax({
                                                                type: "POST",
                                                                url: "BuscarProductoController",
                                                                data: dataString,
                                                                success: function(data) {
                                                                    //alert(data)

                                                                    $('#verResultadoBuscados').fadeIn(100).html(data);

                                                                    //	 response.sendRedirect("index.jsp");	
                                                                    //alert(data);
                                                                }
                                                            });
                                                            //}
                                                        }


                                                    }


                                                    );
                                                });


                                                //regresar de nuvo............
                                                $(document).ready(function() {
                                                    $("#Regresar_comandaVenta").click(function(event) {

                                                        var idCargoria = $(this).attr("title");
                                                        //alert(idCargoria)
                                                        $("#div_mostrar").load(idCargoria);
                                                    });
                                                });

                                                //Agregar producto a comanda
                                                $(document).ready(function() {
                                                    $(".addProducto").click(function(event) {
                                                        var idDescuento = $('#porcentaje').val();

                                                        var tipro = $('#porcentaje').val();
                                                        var nombre = "";
                                                        var idCargoria = $(this).attr("title");

                                                        $('#passAutorizaciondes').val("");
                                                        $("#ComandaVirtual").load(idCargoria + idDescuento);

                                                    });
                                                });




                                                $(document).ready(function() {
                                                    $(".addProductoBotellas").click(function(event) {
                                                        var idDescuento = $('#porcentaje').val();

                                                        if (idDescuento != "Ninguno") {
                                                            var idCargoria = $(this).attr("title");

                                                            $("#ComandaVirtual").load(idCargoria + idDescuento);
                                                        } else {
                                                            $("#Activar").click();
                                                            //var idBotella = $(this).attr("name");

                                                            //alert(idDescuento + idBotella);


                                                        }
                                                        //
                                                    });
                                                });
                                            </script>

                                            <div align="center" >
                                                <table style="width:100%;text-align:center">
                                                    <tr><td>

                                                        </td><td style="background-color:orange">

                                                            <h4>DESCUENTO
                                                                <input type="hidden" id="porcentaje" value="<% out.println(idDescuento);%>">

                                                                <% out.println(idDescuento);%></h4>                       




                                                        </td><td style="background-color:orange">


                                                            <% if (!idComanda.equals("VER")) {%>
                                                            <input type="text"  id="NombreProducto"  class="input-medium search-query"   placeholder="Búscar...'todo'">
                                                            <%}
                                                            %>



                                                </table>



                                            </div>
                                            <div align="center" id="verResultadoBuscados" style="OVERFLOW: auto; WIDTH:100%;padding-top:0%">

                                                <ul id="sortable" >




                                                </ul>



                                            </div>

                                        </div>
                                    </div>
                                    <!--###############################################################################################################-->
                                </div>


                            </td>
                            <td valign="top">
                                <a href="closeSessionMeseroCuenta" class="btn btn-primary num">SALIR</a>
                                <br><br>
                                <a href="Mesas.jsp" class="btn btn-primary num">MESAS</a>
                                <hr>


                                <!--###################-->
                                <div id="btnnew">
                                    <!--<a href="#" data-reveal-id="newProductoBotellasDiv" data-animation="fadeAndPop" data-animationspeed="300" data-closeonbackgroundclick="true" data-dismissmodalclass="close-reveal-modal" title="AGREGAR MESA" class="btn btn-primary num"> <h3>NUEVO PRODUCTO</h3></a><hr>-->
                                    <%if (idComanda.equals(
                                                "VER")) {%>

                                    <%
                                        if ((idpuesto == 5 && idp != 8) || (idpuesto == 2 && idp != 8) || (idpuesto == 22 && idp != 8)) {
                                    %>
                                    <a href="SessionIdMesaComanda?idMesaVenta=<% out.println(idMesa);%>&idComanda=crear&tipo=venta&observa=-&autorizacion=-"  class="btn btn-primary btn-danger numg"><H4><br> CREAR COMANDA</h4></a><BR><BR>
                                            <%
                                                }

                                            %>

                                    <a href="#" data-reveal-id="cancelardiv" data-animation="fadeAndPop" data-animationspeed="300" data-closeonbackgroundclick="true" data-dismissmodalclass="close-reveal-modal" title="CANCELAR COMANDA" class="btn btn-primary btn-warning num"><H4> CANCELAR COMANDA</h4></a><BR><BR>
                                    <a href="#" data-reveal-id="trasladoCom" data-animation="fadeAndPop" data-animationspeed="300" data-closeonbackgroundclick="true" data-dismissmodalclass="close-reveal-modal" title="CANCELAR COMANDA" class="btn btn-primary btn-warning num"><H4> TRASLADAR COMANDA</h4></a><BR><BR>


                                    <a href='Autorizar.jsp?idMesaVenta=<% out.println(idMesa);%>&idComanda=crear&tipo=cortesia' class="btn btn-primary btn-inverse num"><H4> CORTESIA</h4></a><BR><BR>
                                    <!-- <a href='AutorizarDescuento.jsp?idMesaVenta=<% out.println(idMesa);%>&idComanda=crear&tipo=descuento'  class="btn btn-primary btn-inverse num"><H4> DESCUENTO</h4></a><BR><BR> -->
                                    <!--<a href="#" data-reveal-id="#" data-animation="fadeAndPop" data-animationspeed="300" data-closeonbackgroundclick="true" data-dismissmodalclass="close-reveal-modal" title="CANCELAR COMANDA" class="btn btn-primary btn-danger num"><H4> TRASLADAR PRODUCTO</h4></a>
                                    -->
                                    <%    } else {
                                        }%>


                                </div>
                                <hr>

                            </td></tr>
                    </table>
                </td>
            </tr>

        </table>
    </div>

</body>
