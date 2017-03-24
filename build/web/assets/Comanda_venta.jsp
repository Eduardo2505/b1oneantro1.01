<%-- 
    Document   : Comanda_venta
    Created on : 17/01/2013, 12:56:34 AM
    Author     : Eduardopc
--%>

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
            Empleado e = new Empleado();
            Altadia d = new Altadia();
            String nombre = "", nomMesero = "", tipoEvento = "";
            e = (Empleado) sesion.getAttribute("id");
            String idMesero = "", idMesa = "", idComanda = "";
            int idDia = 0;

            if (e == null) {
                response.sendRedirect("index.jsp");
            } else {
                nombre = e.getNombre() + " " + e.getApellidos();
                Empleado em = new Empleado();
                idComanda = (String) sesion.getAttribute("idComanda");
                idMesa = (String) sesion.getAttribute("idMesa");
                em = (Empleado) sesion.getAttribute("idMesero");
                nomMesero = em.getNombre() + " " + em.getApellidos();
                d = (Altadia) sesion.getAttribute("idDia");
                idMesero = em.getIdEmpleado();
                idDia = d.getIdaltadia();
                tipoEvento = d.getTipoEvento();


            }
            //out.println(idComanda);


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
       
            $(function(){
                $('#cobro').submit(function(){
                    var data=$(this).serialize();
                    $('#verif').html('<img src="img/ajax-loader.gif" alt=""/>').fadeOut(1000);
                    $.post('CoverController',data,function(respuesta){
                        $('#verif').fadeIn(1000).html(respuesta);
			   
                    });
                    return false;
                });
            });
            $(function(){
                $('#RCortesia').submit(function(){
                    var data=$(this).serialize();
                    $('#verif').html('<img src="img/ajax-loader.gif" alt=""/>').fadeOut(1000);
                    $.post('ImprimeCortesia',data,function(respuesta){
                        $('#verif').fadeIn(1000).html(respuesta);
			   
                    });
                    return false;
                });
            });
            
            $(function(){ 
            
                $('#RRerservacion').submit(function(){
                    var data=$(this).serialize();
                   
                    $('#verif').html('<img src="img/ajax-loader.gif" alt=""/>').fadeOut(1000);
                    $.post('ImprimeReservacion',data,function(respuesta){
                        $('#verif').fadeIn(1000).html(respuesta);
			   
                    });
                    return false;
                });
            });
            //############################
        
 
            $(document).ready(function(){
                $('.precio').change(generarSubIva);
            });
	
            function generarSubIva()
            {
                /* var iva=parseFloat($(this).parent().parent().find(".iva").val());
                $(this).parent().parent().find(".final").val(parseFloat($(this).val())*iva/100);*/
		
                var total=0;	
                $(".final").each(function(){
                    total += parseFloat($(this).val());
                });
		
                $("#finalIva").val(total);
            }
        
        </script>
        <script>
            $('input').bind('blur', function() {
                $(this).val(function( i, val ) {
                    return val.toUpperCase();
                });
            });
        </script>
        <style>
            .numH{
                font-size:23px;
                font-weight:bold;
                height:150px;
                width:210px;

            }
            .num{
                font-size:20px;
                font-weight:bold;
                height:70px;
                width:170px;

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
                        <ul class="dropdown-menu">

                            <li><a href="closeSessionMesero">Salir</a></li>
                        </ul>
                    </div>

                </div>
            </div>
        </div>

        <table width="100%" style="text-align:center" >
            <tr><td width="35%" style="padding:20px 20px 20px 20px" valign="top" id="vercancelacion">

                    <div class="well" id="ComandaVirtual" style="OVERFLOW: auto; WIDTH:90%;HEIGHT:490px;padding-top:0%">
                        <script type="text/javascript">
            
                            $(document).ready(function() {
                                $(".eliminarProducto").click(function(event) {
                                            
                                    var idCargoria = $(this).attr("name");
                                    //alert(idCargoria)
                                    $("#ComandaVirtual").load(idCargoria);
                                });
                            });
                        </script>
                        <table class="table table-striped" >
                            <tr><th>Producto</th><th>Precio</th><th>Cantidad</th></tr>
                            <%
                                conexion mysql = new conexion();
                                Connection cn = mysql.Conectar();
                                PreparedStatement st = null;
                                ResultSet rs = null;
                                float sumatotal = 0;
                                String sSQl = "";
                                try {
                                    if (idComanda.equals("VER")) {

                                        sSQl = "select p.nombre,((count(v.idProducto)*p.precio)*(d.porcentaje/100)),count(v.idProducto),d.porcentaje,d.Observaciones from producto p,Venta_Comanda v,Comanda c,Descuento d where p.idProducto=v.idProducto and c.idComanda=v.idComanda and v.idDescuento=d.idDescuento and c.idMesa_venta='" + idMesa + "' and c.estado='activo' group by v.idProducto,v.idDescuento order by v.registro DESC";
                                        st = cn.prepareStatement(sSQl);
                                        rs = st.executeQuery();

                                        while (rs.next()) {

                                            double res = Float.parseFloat(rs.getString(2));
                                            sumatotal += res;
                                            if (rs.getString(5).equals("")) {
                                                out.println("<tr><td>" + rs.getString(1) + "</td><td class='precio'>$" + rs.getString(2) + "</td><td>" + rs.getString(3) + "</td></tr>");
                                            } else {
                                                out.println("<tr><td>" + rs.getString(1) + "<h5>PROMO:" + rs.getString(4) + "% || " + rs.getString(5) + "%</h5></td><td class='precio'>$" + rs.getString(2) + "</td><td>" + rs.getString(3) + "</td></tr>");
                                            }

                                        };
                                    } else {
                                        sSQl = "select p.nombre,((count(v.idProducto)*p.precio)*(d.porcentaje/100)),count(v.idProducto),d.porcentaje,d.Observaciones,v.idcomanda,v.idVenta_Comandacol from producto p,Venta_Comanda v,Comanda c,Descuento d where p.idProducto=v.idProducto and c.idComanda=v.idComanda and v.idDescuento=d.idDescuento and c.idMesa_venta='" + idMesa + "' and c.estado='activo' group by v.idProducto,v.idDescuento,v.idcomanda order by v.registro DESC";

                                        //  sSQl = "select p.nombre,((count(v.idProducto)*p.precio)*(d.porcentaje/100)),count(v.idProducto),d.porcentaje,d.Observaciones from producto p,Venta_Comanda v,Comanda c,Descuento d where p.idProducto=v.idProducto and c.idComanda=v.idComanda and v.idDescuento=d.idDescuento and c.idMesa_venta='" + idMesa + "' and c.estado='activo' group by v.idProducto,v.idDescuento,v.Comanda";
                                        st = cn.prepareStatement(sSQl);
                                        rs = st.executeQuery();
                                        //double sumatotal = 0;
                                        while (rs.next()) {

                                            double res = Float.parseFloat(rs.getString(2));
                                            sumatotal += res;

                                            if (rs.getString(5).equals("")) {
                                                if (rs.getString(6).equals(idComanda)) {
                                                    out.println("<tr><td><a href=\"#\" class=\"eliminarProducto\"  name=\"EliminarProductoController?idIdventComanda=" + rs.getString(7) + "\"> <img src=\"img/iconoE.png\"> </a> " + rs.getString(1) + "</td><td>$" + rs.getString(2) + "</td><td >" + rs.getString(3) + "</td></tr>");
                                                } else {

                                                    out.println("<tr><td>" + rs.getString(1) + "</td><td class='precio'>$" + rs.getString(2) + "</td><td>" + rs.getString(3) + "</td></tr>");
                                                }
                                            } else {
                                                out.println("<tr><td><a href=\"#\" class=\"eliminarProducto\"  name=\"EliminarProductoController?idIdventComanda=" + rs.getString(7) + "\"> <img src=\"img/iconoE.png\"> </a> " + rs.getString(1) + "<h5>PROMO:" + rs.getString(4) + "% || " + rs.getString(5) + "%</h5></td><td class='precio'>$" + rs.getString(2) + "</td><td>" + rs.getString(3) + "</td></tr>");
                                            }

                                        };
                                    }


                                    Mesa_ventaDaoImpl mvt = new Mesa_ventaDaoImpl();
                                    mvt.actualiza(idMesa, sumatotal);
                            %>
                            <tr><td colspan="2">TOTAL:</td><td>$<%out.println(sumatotal);%></td></tr>
                        </table>
                    </div>

                    <button class="btn btn-primary cuenta" type="button">CERARA CUENTA E IMPRIMIR</button>
                    <!---#####################cANCELAR COMANDA--------->
                    <script type="text/javascript">
                        $(document).ready(function() {	
                            $('#mostraridComanda').change(function(){
                                var user = $(this).val();		
                                var dataString ='mostraridComanda='+user;
                                //alert(user);
                                if(user!=""){
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
                                }}
        
    
                        );              
                        });
                        
                        $(function(){
                            $('#fromcancelacion').submit(function(){
                                var data=$(this).serialize();
                                jPrompt("Observación", "", "Insertar Observación", function(r) {
                                    if(r) {
                                        jAlert("Tu nombre es "+r, "Actualidad jQuery");
                                        var enviadatos=data+"&Observa="+r;
                                        jConfirm("¿Seguro que desea cancelar la comanda?", "Cancelar Comanda", function(r) {  
                                            if(r) {
                                           
                                                $('#cargar').html('<img src="img/ajax-loader.gif" alt=""/>').fadeOut(1000);
                                                // alert(enviadatos)
                                                $.post('CancelacionComandaControll',enviadatos,function(respuesta){
                       
                                                    
                                                    //$('#fromcancelacion')[0].reset();                       
                              
                                                    $('#vercancelacion').html(respuesta);
                                                     
                                                 
                          
											
                                                   
       
                      
			   
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
                    <div id="cancelardiv" class="reveal-modal" style="text-align:center">                       
                        <form id="fromcancelacion">                            
                            <label class="label-warning"><H3>Cancelación -->#ID COMANDA</H3></label>    
                            <select name="idComanda" id="mostraridComanda" required="">
                                <option value="">Seleccione</option>
                                <%
                                    ComandaDaoImpl daocan = new ComandaDaoImpl();
                                    List rescan = daocan.getBuscar(idMesa);
                                    Iterator itrcan = rescan.iterator();
                                    while (itrcan.hasNext()) {
                                        Comanda comcan = (Comanda) itrcan.next();
                                        out.println("<option value='" + comcan.getIdComanda() + "'>" + comcan.getIdComanda() + "</option>");


                                    }
                                %>
                            </select>
                            <div id="veridCom" style="OVERFLOW: auto;HEIGHT:390px;padding-top:0%">


                            </div>                            

                            <input type="submit" value="CANCELAR" class="btn btn-primary btn-large" >

                            <div id="cargar"></div>
                        </form>

                        <a class="close-reveal-modal">&#215;</a>

                    </div>

                    <%if (idComanda.equals("VER")) {%>
                    <a href="#" data-reveal-id="cancelardiv" data-animation="fadeAndPop" data-animationspeed="300" data-closeonbackgroundclick="true" data-dismissmodalclass="close-reveal-modal" title="TRASLADAR" class="btn btn btn-danger numHE"> CANCELAR COMANDA</a>

                    <%    }%>

                    <!--#############################-->

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
                                   
                                   
                      
                                </script>

                                <div class="well" style="OVERFLOW: auto; WIDTH:93%;HEIGHT:540px;padding-top:0%" >



                                    <div id="div_mostrar">
                                        <label class="label-warning" style="text-align:left"><H3>BOTELLAS</H3></label>
                                        <HR>
                                        <button title="Categorias.jsp?tipo=Botella" class="btn btn-primary numH btnEnviarenviar" >CATEGORIAS</button>
                                        <hr>
                                        <button title='Productos.jsp?idCategoria=<% out.println(
                                                    "");%>&tipo=<% out.println(
                                                                "");%>'class="btn btn-primary numH btnEnviarenviar" >PRODUCTO</button>

                                    </div>

                                </div>


                            </td>
                            <td valign="top">
                                <a href="Menu.jsp" class="btn btn-primary num">SALIR</a>
                                <br><br>
                                <a href="Mesas.jsp" class="btn btn-primary num">MESAS</a>
                                <hr>
                                <div id="newProductoBotellasDiv" class="reveal-modal" style="text-align:center">
                                    <form id="newProducto">

                                        <!-- <form action="MesasController">-->
                                        <input type="hidden" value="<% out.println(tipoEvento);%>" name="tipoEvento">
                                        <input type="hidden" value="botellas" name="tipo">
                                        <label ><H3>Nombre<i class=" icon-circle-arrow-down"></i></H3></label>
                                        <input type="text" name="Nombre"  required>
                                        <label ><H3>Tamaño Mililitros<i class=" icon-circle-arrow-down"></i></H3></label>
                                        <input type="number" name="tamano"  required>
                                        <label ><H3>Categoría <i class=" icon-circle-arrow-down"></i></H3></label>
                                        <select name="idCategoria" required>
                                            <option value="">Seleccione</option>
                                            <%                                                CategoriaDaoImpl daob = new CategoriaDaoImpl();
                                                List resb = daob.getFiltro();
                                                Iterator itrb = resb.iterator();

                                                while (itrb.hasNext()) {
                                                    Categoria cb = (Categoria) itrb.next();
                                                    out.println(" <option value='" + cb.getIdCategoria() + "'>" + cb.getIdCategoria() + "</option>");
                                                    //  System.out.println(c.getIdCategoria());

                                                }

                                            %>

                                        </select>
                                        <label ><H3>Costo <i class=" icon-circle-arrow-down"></i></H3></label>
                                        <input type="number" name="costo"  step="0.01" required><br>
                                        <label ><H3>Tipo de Evento <i class=" icon-circle-arrow-down"></i></H3></label>
                                        <h4><%    out.println(tipoEvento);%></h4>
                                        <input type="submit" value="Agregar" class="btn btn-primary btn-large" >

                                        <div id="Info">
                                        </div>
                                    </form>
                                    <a class="close-reveal-modal">&#215;</a>

                                </div>
                                <!--###################-->
                                <div id="newProductoCopeoDiv" class="reveal-modal" style="text-align:center">
                                    <form id="newProducto">

                                        <!-- <form action="MesasController">-->
                                        <input type="hidden" value="<% out.println(tipoEvento);%>" name="tipoEvento">
                                        <input type="hidden" value="copeo" name="tipo">
                                        <label ><H3>Nombre<i class=" icon-circle-arrow-down"></i></H3></label>
                                        <input type="text" name="Nombre"  required>

                                        <label ><H3>Categoría <i class=" icon-circle-arrow-down"></i></H3></label>
                                        <select name="idCategoria" required>
                                            <option value="">Seleccione</option>
                                            <%                                                CategoriaDaoImpl dao = new CategoriaDaoImpl();
                                                    List res = dao.getFiltro();
                                                    Iterator itr = res.iterator();

                                                    while (itr.hasNext()) {
                                                        Categoria c = (Categoria) itr.next();
                                                        out.println(" <option value='" + c.getIdCategoria() + "'>" + c.getIdCategoria() + "</option>");
                                                        //  System.out.println(c.getIdCategoria());

                                                    }
                                                } finally {

                                                    System.out.println("se cerro conexión.!!!");
                                                    cn.close();
                                                    st.close();
                                                    rs.close();
                                                }





                                            %>

                                        </select>
                                        <label ><H3>Costo <i class=" icon-circle-arrow-down"></i></H3></label>
                                        <input type="number" name="Nombre"  step="0.01" required><br>
                                        <label ><H3>Tipo de Evento <i class=" icon-circle-arrow-down"></i></H3></label>
                                        <h4><%    out.println(tipoEvento);%></h4>
                                        <input type="submit" value="Agregar" class="btn btn-primary btn-large" >

                                        <div id="Info">
                                        </div>
                                    </form>
                                    <a class="close-reveal-modal">&#215;</a>

                                </div>

                                <!--###################-->
                                <div id="btnnew">
                                    <a href="#" data-reveal-id="newProductoBotellasDiv" data-animation="fadeAndPop" data-animationspeed="300" data-closeonbackgroundclick="true" data-dismissmodalclass="close-reveal-modal" title="AGREGAR MESA" class="btn btn-primary numHE"> <h2>NUEVO</h2><h2>PRODUCTO</h2></a>
                                </div>
                                <hr>
                                <!--
                                <input type="radio" id="radio-2-1" name="radio-2-set" class="regular-radio big-radio" checked=""
                                       onclick="
                                           var  mensa='<a href= \'#\' data-reveal-id=\'newProductoBotellasDiv\' data-animation=\'fadeAndPop\' data-animationspeed=\'300\' data-closeonbackgroundclick=\'true\' data-dismissmodalclass=\'close-reveal-modal\' class=\'btn btn-primary numHE\'> <h2>NUEVO</h2><h2>PRODUCTO</h2></a>';
                                           $('#div_mostrar').fadeOut('slow', function() {$('#div_mostrar').html('all this text'); $('#div_mostrar').fadeIn('slow'); });
                                           $('#btnnew').fadeOut('slow', function() {$('#btnnew').html(mensa); $('#btnnew').fadeIn('slow'); });
                                       
                                       " /><label for="radio-2-1"></label>
                                <samp style="font-weight:bold;font-size:25px">BOTELLA</samp><br>
                                <input type="radio" id="radio-2-2" name="radio-2-set" class="regular-radio big-radio"
                                       onclick="
                                           var  mensa='<a href= \'#\' data-reveal-id=\'newProductoCopeoDiv\' data-animation=\'fadeAndPop\' data-animationspeed=\'300\' data-closeonbackgroundclick=\'true\' data-dismissmodalclass=\'close-reveal-modal\' class=\'btn btn-primary numHE\'> <h2>NUEVO</h2><h2>PRODUCTO</h2></a>';
                                           $('#div_mostrar').fadeOut('slow', function() {$('#div_mostrar').html('all this text'); $('#div_mostrar').fadeIn('slow'); });
                                           $('#btnnew').fadeOut('slow', function() {$('#btnnew').html(mensa); $('#btnnew').fadeIn('slow'); });"

                                       /><label for="radio-2-2"></label><samp style="font-weight:bold;font-size:25px">COPEO</samp>-->
                            </td></tr>
                    </table>
                </td>
            </tr>
        </table>
    </body>
