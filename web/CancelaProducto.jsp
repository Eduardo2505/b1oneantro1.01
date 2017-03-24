<%-- 
    Document   : Comanda_venta
    Created on : 17/01/2013, 12:56:34 AM
    Author     : Eduardopc
--%>

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

           
            String idMesero = "", idMesa = "", idComanda = "", idComandaTras = "", idDescuento = "";
            int idDia = 0;           
            conexion mysql = new conexion();
            Connection cn = mysql.Conectar();
            ResultSet rs = null;
            ResultSet rsc = null;
            PreparedStatement st = null;
            PreparedStatement stc = null;

            ComandaDaoImpl daocan = new ComandaDaoImpl();
          
            List rescan = null;
          
            Iterator itrcan = null;

            int idpuesto=0;
            if (idBarra == null) {
                response.sendRedirect("index.jsp");
            } else {
                nombre = "By1ONE";
                Empleado em = new Empleado();
                idComanda = (String) sesion.getAttribute("idComanda");
                idMesa = (String) sesion.getAttribute("idMesa");
                em = (Empleado) sesion.getAttribute("idMesero");
                
                if (nombre.equals(em.getIdEmpleado())) {
                    response.sendRedirect("Menu.jsp");

                } else {
                    idpuesto =Integer.parseInt((String) sesion.getAttribute("idpuesto"));
                   // out.println(idpuesto);
                    nomMesero = em.getNombre() + " " + em.getApellidos();
                    d = (Altadia) sesion.getAttribute("idDia");
                    idMesero = em.getIdEmpleado();
                    idDia = d.getIdaltadia();
                    tipoEvento = d.getTipoEvento();
                    idDescuento = (String) sesion.getAttribute("idDescuento");


                }

            }



        %>

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
                var categoria = 20;
                var productos = ((manuca * 330) / 768)+150;
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
                                $(".copiarentrada").click(function(event) {

                                    var idCargoria = $(this).attr("name");
                                    //alert(idCargoria)
                                    $("#mosrraid").val(idCargoria);
                                });
                            });

                            function isNumberKey(evt)
                            {
                                var charCode = (evt.which) ? evt.which : event.keyCode
                                if (charCode > 31 && (charCode < 48 || charCode > 57))
                                    return false;

                                return true;
                            }
                            $(function() {
                                $('#AgregarMesaCopiar').submit(function() {
                                    var data = $(this).serialize();
                                    //alert(data);

                                    $.post('CopiaVenta_Comanda', data, function(respuesta) {

                                        // $('#AgregarMesaCopiar')[0].reset();
                                        jAlert("Se creo la copia correctamente", "Confirmación", function(r) {
                                            if (r) {
                                                $(location).attr('href', 'Comanda_venta.jsp');

                                            }
                                        });






                                    });
                                    return false;
                                });
                            });
                        </script>

                        <table class="table table-striped" >

                            <%

                                float sumatotal = 0, costo = 0;
                                try {
                                    int sumita = 0;
                                    double totalsumuta = 0;
                        NumberFormat nf = NumberFormat.getInstance();
                        nf.setMaximumFractionDigits(2);
                                    int idc = 0;
                                    int sumadcio = 0;
                                    String nombrePro = "", obseComanda = "", Autorza = "", Observavc = "", tipo = "", iddes = "", idProducto = "";
                                    int cantidad = 0, cantidada = 0, idvc = 0;
                                    Producto pa = new Producto();


                                //    AdicionalesDaoImpl daoa = new AdicionalesDaoImpl();


                                  //  System.out.println(idMesa);
                                    if (!idComanda.equals("VER")) {

                                    


                                    } else {


                                        out.println("<tr><th colspan='5' style='text-align:center'>********* CUENTA TOTAL *********</th></tr>"
                                                + "<tr><th colspan='2'>Producto</th><th>Cantidad</th><th>Precio</th><th>Opc</th></tr>");
//int cantidad = 0, idvc = 0;

out.println(idMesa);
                                        String sSQla = "SELECT CONCAT(p.nombre,'// ',p.tamano,' ml') as nombre,count(vc.idProducto) as cantidad,vc.costo as costo,c.observa,c.Autorizacion,vc.Observaciones,vc.idVenta_Comandacol as idventa,c.tipo as tipo,vc.idDescuento,p.idProducto as idProducto FROM mesa_venta mv,comanda c,venta_comanda vc,producto p where mv.idMesa_venta=c.idMesa_venta and c.idComanda=vc.idComanda and vc.idProducto=p.idProducto and c.estado='activo' and mv.idMesa_venta='" + idMesa + "' and c.idComanda like '%%' group by vc.idProducto,vc.idDescuento,c.observa order by vc.registro DESC";

                                        st = cn.prepareStatement(sSQla);
                                        rs = st.executeQuery();

                                        while (rs.next()) {
                                            nombrePro = rs.getString("nombre");
                                            obseComanda = rs.getString("c.observa");
                                            cantidad = rs.getInt("cantidad");
                                            costo = rs.getFloat("costo");
                                            idvc = rs.getInt("idventa");
                                            Autorza = rs.getString("c.Autorizacion");
                                            Observavc = rs.getString("vc.Observaciones");
                                            iddes = rs.getString("vc.idDescuento");
                                            tipo = rs.getString("tipo");
                                            totalsumuta = cantidad * costo;


                                            if (tipo.equals("venta") && iddes.equals("Ninguno")) {
                                                out.println("<tr><td colspan='2'> <a href='EliminarProducto?id="+idvc+"' >Eliminar</a>" + nombrePro + "</td><td>" + cantidad + "</td><td>$" + totalsumuta + "</td><td></td></tr>");
                                            } else if (tipo.equals("venta") && (iddes.equals("ProIn3-4") || iddes.equals("ProIn2-3") || iddes.equals("ProIn4-5"))) {
                                                out.println("<tr><td colspan='2'>" + nombrePro + " .<h5>" + tipo + " " + Observavc + "</td><td>" + cantidad + "</td><td>$" + nf.format(totalsumuta) + "</td></tr>");
                                            } else {
                                                if (iddes.equals("Ninguno")) {
                                                    iddes = "";
                                                }
                                                out.println("<tr><td colspan='2'><" + nombrePro + " <h5>" + tipo + " " + Observavc + "<br>" + obseComanda + "</h5><h5>Autoriza: " + Autorza + "</h5></td><td>" + cantidad + "</td><td>$" + nf.format(totalsumuta) + "</td><td></td></tr>");
                                            }
                                            sumatotal += totalsumuta;
//Adicionales #######################
                                          /*  List resa = daoa.getMostrar(idvc);
                                            Iterator itra = resa.iterator();

                                            while (itra.hasNext()) {
                                                Adicionales aa = (Adicionales) itra.next();
                                                pa = aa.getProducto();
                                                sumadcio = daoa.contar(pa.getIdProducto(), idvc) * cantidad;

                                                out.println("<tr><td width='70px'></td><td style='background-color:yellow'>" + pa.getNombre() + "</td><td style='background-color:yellow'>" + sumadcio + "</td><td style='background-color:yellow'>$ 0</td><td></td></tr>");
                                                // System.out.println(pa.getNombre() + " " + sumadcio);

                                            }*/



                                            //######################

                                        }
                                        // 
                                       // Mesa_ventaDaoImpl mvt = new Mesa_ventaDaoImpl();
                                       // mvt.actualiza(idMesa, sumatotal);
                                    }

                            %>
                            <tr><td colspan="2">TOTAL:</td><td>$<%out.println(nf.format(sumatotal));%> </td></tr>

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
                                            // alert(inres);
                                            if (inres > 0) {
                                                jAlert("No hay producto", "Error");

                                            } else {
                                                // alert("redireccionar");
                                                $(location).attr('href', "tike.jsp");

                                            }


                                            //$('#verCerrada').html(respuesta);




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

                                $(location).attr('href', "tikeComanda.jsp");
                              /*alert("entro");
                                var user = "op=i";
                                $.ajax({
                                    type: "POST",
                                    url: "ControllerInstercervezas",
                                    data: user,
                                    success: function(data) {
                                        //  alert(data);
                                        var inres = data.length;
                                        // alert(inres);
                                        if (inres > 0) {
                                            jAlert(data, "Error");
                                        } else {
                                            //alert(data);
                                            $(location).attr('href', "tikeComanda.jsp");
                                        }


                                    }
                                });*/


                            }


                            );
                        });
//######################################################

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
                       
                            <%   } else {

                                if (idpuesto == 12 || idpuesto == 8 || idpuesto == 22 || idpuesto == 23 || idpuesto == 2 || idpuesto == 3) {%>
                        <input type="submit" value="IMPRIMIR CANCELACION" class="btn btn-primary numH">  
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
                                                    var r = respuesta.length;
                                                    if (r != 0) {

                                                        jAlert(respuesta, "Autorización");
                                                    } else {
                                                        $('#fromcancelacion')[0].reset();
                                                        jAlert("Se realizo la cancelación correctamente", "Confirmación", function(r) {
                                                            if (r) {
                                                                //  jAlert("Imprime tiket", "UU");
                                                                $(location).attr('href', "tiket/tikeComandaCancelada.jsp");
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



                    <!--#############################-->

                    <script type="text/javascript">
                        $(document).ready(function() {
                            $("#bcate").change(function(event) {

                                var idCargoria = $(this).val();
                                //  alert(idCargoria)

                                var dataString = 'idcategoria=' + idCargoria;
                                $.ajax({
                                    type: "POST",
                                    url: "FiltroProductosController",
                                    data: dataString,
                                    success: function(data) {


                                        $('#viProducto').fadeIn(500).html(data);

                                    }
                                });



                            });
                        });

                        $(function() {

                            $('#enviarAdicionalesi').submit(function() {
                                var data = $(this).serialize();

                                // $('#vfer').html('<img src="img/ajax-loader.gif" alt=""/>').fadeOut(1000);
                                $.post('addProducto', data, function(respuesta) {
                                    //$('#vfer').fadeIn(1000).html(respuesta);
                                    $('#vfer').html(respuesta);

                                });
                                return false;
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

                    <div id="Activardiv" class="reveal-modal" style="text-align:center">
                        <form id="enviarAdicionales">
                            <label class="label-warning"><H3>ADICIONALES</H3></label>
                            <label><H4 id="nomprodiv"></H4></label>
                            <input type="hidden" name="idVentaComanda" id="textIdventa"><br>

                            <select name="idCategoria"  id="bcate" required>
                                <option value="" >Categoria</option>
                                <%                                    CategoriaDaoImpl daoc = new CategoriaDaoImpl();
                                    List resc = daoc.getFiltro();
                                    Iterator itrc = resc.iterator();

                                    while (itrc.hasNext()) {
                                        Categoria cc = (Categoria) itrc.next();
                                        if (cc.getDescripcion().equals("Extra")) {
                                            out.println(" <option value='" + cc.getIdCategoria() + "' >" + cc.getIdCategoria() + "</option>");

                                        }
                                    }

                                %>

                            </select>                              

                            <br>
                            <div id="viProducto">


                            </div><hr>
                            Botellas : <input type="radio" name="tipo" value="botella" checked=""> <!--Adicionales: <input type="radio" name="tipo" value="adicionales">-->
                            <hr>
                            <input type="submit" value="Agregar" class="btn btn-primary " style="width:100px;height:50px" >
                            <a href="Comanda_venta.jsp" class="btn btn-danger" style="width:90px;height:40px"><br>SALIR</a>

                            <div id="vfer">

                            </div>
                        </form>            
                        <!--<a class="close-reveal-modal">&#215;</a>-->
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
                                            //  alert(idCargoria)
                                            $("#div_mostrar").load(idCargoria);
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
                                    <div id="menuCategoriascss" style="OVERFLOW: auto; WIDTH:100%;padding-top:0%;">
                                        <ul id="sortable" >
                                            <%

                                               /* if (idpuesto == 8 || idpuesto == 1 || idpuesto == 22) {
                                                    CategoriaDaoImpl dao = new CategoriaDaoImpl();
                                                    List res = dao.getFiltro();
                                                    Iterator itr = res.iterator();

                                                    while (itr.hasNext()) {
                                                        Categoria p = (Categoria) itr.next();

                                                        out.print("<li class='ui-state-default'><a class='addCategoria' name='BuscarProductoCategoriaController?idCategoria=" + p.getIdCategoria() + "&tipo=" + tipo + "&op=Autorizado'><h5>" + p.getIdCategoria() + "</h5></a></li>");





                                                    }


                                                } else {
                                                    CategoriaDaoImpl dao = new CategoriaDaoImpl();
                                                    List res = dao.getFiltro();
                                                    Iterator itr = res.iterator();

                                                    while (itr.hasNext()) {
                                                        Categoria p = (Categoria) itr.next();
                                                        if (!p.getIdCategoria().equals("PROMOCIONES") && !p.getIdCategoria().equals("BarraLibre")) {
                                                            out.print("<li class='ui-state-default'><a class='addCategoria' name='BuscarProductoCategoriaController?idCategoria=" + p.getIdCategoria() + "&tipo=" + tipo + "&op=restringir'><h5>" + p.getIdCategoria() + "</h5></a></li>");
                                                        }




                                                    }
                                                }*/
                                            %>


                                        </ul>

                                    </div>
                                    <!--
                                    <script type="text/javascript">
 
 
                                         $(document).ready(function() {
                                             $('#NombreProducto').keyup(function() {
 
                                                 var user = $(this).val();
                                                 //  alert(user);
                                                 var idCategoria = $('#idCategoria').val();
                                                 var tipo = $('#tipo').val();
                                                 var dataString = 'NombreProducto=' + user + '&tipo=' + tipo + '&idCategoria=' + idCategoria;
                                                 //var dataString ='NombreProducto='+user;
                                                 //alert(user);
 
                                                 if (user != "") {
                                                     $('#verResultadoBuscados').html('<img src="img/ajax-loader.gif" alt=""/>');
                                                     $.ajax({
                                                         type: "POST",
                                                         url: "BuscarProductoController",
                                                         data: dataString,
                                                         success: function(data) {
                                                             //alert(data)
 
                                                             $('#verResultadoBuscados').fadeIn(500).html(data);
 
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
                                    -->
                                    <div id="div_mostrar" style="padding-top:0%">
                                        <script type="text/javascript">


                                            $(document).ready(function() {
                                                $('#NombreProducto').keyup(function() {

                                                    var user = $(this).val();
                                                    //  alert(user);



                                                    var dataString = 'NombreProducto=' + user;

                                                    var inres = user.length;
                                                    //  alert(inres);
                                                    $('#verResultadoBuscados').html('<img src="img/ajax-loader.gif" alt=""/>').fadeOut(200);
                                                    if (inres > 3) {
                                                        // $('#verif').html('<img src="img/ajax-loader.gif" alt=""/>').fadeOut(1000);


                                                        $.ajax({
                                                            type: "POST",
                                                            url: "BuscarProductoController",
                                                            data: dataString,
                                                            success: function(data) {
                                                                //alert(data)

                                                                $('#verResultadoBuscados').fadeIn(200).html(data);

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
                                                <%/*

                                                     if (idComanda.equals("VER")) {

                                                     out.println("<div class=\"alert alert-block\">\n"
                                                     + "            \n"
                                                     + "            <h4>MODO \"VER\"</h4>\n"
                                                     + "            Esta en modo <b>VER</b> así que sólo podra ver la cuenta y consultar los precios de los productos.\n"
                                                     + "        </div>");


                                                     ProductoDaoImpl daoef = new ProductoDaoImpl();


                                                     List respf = daoef.getFiltro("", "", tipoEvento, "");
                                                     Iterator itrf = respf.iterator();
                                                     while (itrf.hasNext()) {
                                                     Producto p = (Producto) itrf.next();
                                                     // System.out.println(p.getIdProducto() + p.getNombre());
                                                     //p.setIdProducto(p.getIdProducto());

                                                     //System.out.println(pre.getCosto());

                                                     out.print("<li class='ui-state-default'><a class='addProducto'><br>" + p.getIdProducto() + "<br><h4>" + p.getNombre() + "</h4><br>$" + p.getPrecio() + "</a></li>");

                                                     }
                                                     } else {

                                                     ProductoDaoImpl gr = new ProductoDaoImpl();


                                                     List lt = gr.getFiltro("", "", tipoEvento, "");
                                                     Iterator it = lt.iterator();
                                                     Categoria ctg = new Categoria();

                                                     while (it.hasNext()) {
                                                     Producto p = (Producto) it.next();
                                                     ctg = p.getCategoria();
                                                     //System.out.println(p.getIdProducto() + p.getNombre());
                                                     // p.setIdProducto(p.getIdProducto());
                                                     if (!ctg.getIdCategoria().equals("PROMOCIONES")) {
                                                     if (p.getTipo().equals("Botella")) {
                                                     out.print("<li class='ui-state-default'><a class='addProducto' href='#' name='" + p.getIdProducto() + "' title='addVirtual?idProducto=" + p.getIdProducto() + "&idDescuento=' ><br>" + p.getIdProducto() + "<br><h4>" + p.getNombre() + "</h4><br>$" + p.getPrecio() + " " + p.getTipo() + "</a></li>");
                                                     } else {

                                                     out.print("<li class='ui-state-default'><a class='addProducto' href='#' title='addVirtual?idProducto=" + p.getIdProducto() + "&idDescuento=' ><br>" + p.getIdProducto() + "<br><h4>" + p.getNombre() + "</h4><br>$" + p.getPrecio() + "</a></li>");
                                                     }
                                                     }
                                                     }

                                                     }
                                                     */
                                                %>



                                            </ul>



                                        </div>

                                        <!--
                                        
                                                                               
                                                                                                                        <p> &nbsp </p> <p> &nbsp </p> <p> &nbsp </p> <p> &nbsp </p> <p> &nbsp </p> <p> &nbsp </p> 
                                                                                
                                                                                                                                <button title='Productos.jsp?idCategoria=<% out.println(
                                                                                                                                            "");%>&tipo=<% out.println(
                                                                                                                                                        "");%>'class="btn btn-primary  btnEnviarenviar" style="width:300px;height:300px;font-size:x-large " >PRODUCTO</button>
                                                                                
                                                                                
                                                                     
                                        -->
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
                                        if (idpuesto == 5 || idpuesto == 8 || idpuesto == 1 || idpuesto == 22) {
                                    %>
                                   
                                            <%
                                                }

                                            %>

                                    
                                    <%    } else {%>
                                    <a href="Comanda_venta.jsp" class="btn btn-primary btn-danger num"><H4>REFRESCAR</h4></a>

                                    <%    }



                                        } catch (SQLException ex) {
                                            //   ex.printStackTrace();
                                        } finally {
                                        }
                                    %>

                                </div>
                                <hr>

                            </td></tr>
                    </table>
                </td>
            </tr>

        </table>
    </body>
