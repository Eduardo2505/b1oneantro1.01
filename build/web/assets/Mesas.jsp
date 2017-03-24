<%-- 
    Document   : Mesas
    Created on : 16/01/2013, 07:37:33 PM
    Author     : Eduardopc
--%>

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
            Empleado e = new Empleado();
            Altadia d = new Altadia();
            String nombre = "", nomMesero = "";
            e = (Empleado) sesion.getAttribute("id");
            String idMesero = "";
            int idDia = 0;
            //out.println(e);
            if (e == null) {
                response.sendRedirect("index.jsp");
            } else {
                nombre = e.getNombre() + " " + e.getApellidos();
                Empleado em = new Empleado();
                em = (Empleado) sesion.getAttribute("idMesero");
                nomMesero = em.getNombre() + " " + em.getApellidos();
                d = (Altadia) sesion.getAttribute("idDia");
                idMesero = em.getIdEmpleado();
                idDia = d.getIdaltadia();
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
        <script type="text/javascript">
            $(function(){
                $('#formrearMesa').submit(function(){
                    var data=$(this).serialize();
                    $('#Info').html('<img src="img/ajax-loader.gif" alt=""/>').fadeOut(1000);
                    $.post('MesasController',data,function(respuesta){
                        var verir="<div class='ui-widget'><div class='ui-state-error ui-corner-all' style='padding: 0 .7em;'><p><span class='ui-icon ui-icon-alert' style='float: left; margin-right: .3em;'></span> <strong>Error:</strong> <br> YA SE ENCUENTRA EL ID DE LA MESA INTENTE OTRO</p></div>";
                       
                        var inres=respuesta.length;
							  
                        if(inres<=0){
                            $('#idMesain').focus();
                            $('#Info').fadeIn(1000).html(verir);
                        }else{
                            $('#formrearMesa')[0].reset();                       
                            
                            
                            jAlert("Se agrego correctamente", "Confirmación", function(r) {  
                                if(r) {  
                                    $('#contenidoBody').html(respuesta);
                                }  
                            });  
                          
											
                        }
       
                      
			   
                    });
                    return false;
                });
            });
            
            
            $(function(){
                $('#AgregarMesa').submit(function(){
                    var data=$(this).serialize();
                    //alert(data);
                    $('#contenidover').html('<img src="img/ajax-loader.gif" alt=""/>').fadeOut(1000);
                    $.post('Mesa_ventaController',data,function(respuesta){
                        
                        $('#AgregarMesa')[0].reset();      
                        jAlert("Se agrego correctamente", "Confirmación", function(r) {  
                            if(r) {
                                //  $(location).attr('href','Mesas.jsp');
                                $('#contenidoBody').html(respuesta);
                                //  $(location).attr('href','Mesas.jsp');
                            }  
                        });  
                          
											
                        
      
                      
			   
                    });
                    return false;
                });
            });
        </script>

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
            #sortable li { margin: 3px 3px 3px 0; padding: 1px; float: left; width: 200px; height: 170px; font-size: 20px; text-align: center; }
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
        <div id="contenidoBody">
            <script type="text/javascript">
                $(document).ready(function() {	
                    $('#MesasBuscar').keyup(function(){
                        var user = $(this).val();		
                        var dataString ='MesasBuscar='+user;
                        //alert(user);
                        if(user!=""){
                            $('#sortable').html('<img src="img/ajax-loader.gif" alt=""/>');
                            $.ajax({
                                type: "POST",
                                url: "BuscarMesa_ComandaController",
                                data: dataString,
                                success: function(data) {
                                    //alert(data)
              
                                    $('#sortable').fadeIn(500).html(data);
                
                                    //	 response.sendRedirect("index.jsp");	
                                    //alert(data);
                                }
                            });
                            //}
                        }}
        
    
                );              
                });
            </script>
            <!--###########Crear Mesa#################-->
            <div id="crearMesa" class="reveal-modal" style="text-align:center">
                <form id="formrearMesa">

                    <!-- <form action="MesasController">-->
                    <label class="label-warning"><H1># IDMESA</H1></label>
                    <input type="text" name="idMesa" id="idMesain" required>

                    <label class="label-warning"><H1>ZONA</H1></label>
                    <select name="idZona" required>
                        <option value="">Seleccione</option>
                        <%
                            ZonaDaoImpl dao = new ZonaDaoImpl();
                            List res = dao.getZona();
                            Iterator itr = res.iterator();
                            while (itr.hasNext()) {
                                Zona zona = (Zona) itr.next();
                                out.println("<option value='" + zona.getIdzona() + "'>" + zona.getIdzona() + "</option>");
                            }

                        %>
                    </select>
                    <br>
                    <input type="submit" value="Agregar" class="btn btn-primary btn-large" >
                    <div id="Info">
                    </div>
                </form>
                <a class="close-reveal-modal">&#215;</a>

            </div>


            <!--###############Agregar mesa################-->
            <div id="agregarMesaDiv" class="reveal-modal" style="text-align:center">
                <form id="AgregarMesa">
                    <label class="label-warning"><H3>#MESA</H3></label>
                    <select name="idMesa" required>
                        <option value="">Seleccione</option>
                        <%
                            MesasDaoImpl daom = new MesasDaoImpl();
                            List resm = daom.getMesas("Activo");
                            Iterator itrm = resm.iterator();
                            while (itrm.hasNext()) {
                                Mesas mesas = (Mesas) itrm.next();
                                out.println("<option value='" + mesas.getIdMesa() + "'>" + mesas.getIdMesa() + "</option>");
                            }

                        %>
                    </select>

                    <label class="label-warning"><H3>PERSONAS APROX</H3></label>
                    <input type="number" name="persAprox" required="" >    

                    <br>

                    <input type="submit" value="Aceptar" class="btn btn-primary btn-large" >
                    <div id="contenidover"></div>
                </form>
                <a class="close-reveal-modal">&#215;</a>

            </div>

            <div style="padding-right:1%" >
                <table style="text-align:center" WIDTH="100%" >
                    <tr><td style="padding-left:7%;" valign="top">
                            <div style="OVERFLOW: auto; WIDTH:900px;HEIGHT:550px;padding-top:1%" >

                                <ul id="sortable">

                                    <%
                                        Mesa_ventaDaoImpl daomv = new Mesa_ventaDaoImpl();
                                        MesaVenta m = new MesaVenta();
                                        
                                       
                                        List resmv = daomv.getMesaVenta("Activo", idMesero, idDia);
                                        Iterator itrmv = resmv.iterator();
                                        while (itrmv.hasNext()) {
                                            MesaVenta mesasv = (MesaVenta) itrmv.next();
                                            m = daomv.bucarPorId(mesasv.getIdMesaVenta());
                                            out.println("<script type=\"text/javascript\">\n"
                                                    + "            $(function(){\n"
                                                    + "                $('#from" + mesasv.getIdMesaVenta() + "').submit(function(){\n"
                                                    + "                    var data=$(this).serialize();\n"
                                                    + "                    $('#cargar" + mesasv.getIdMesaVenta() + "').html('<img src=\"img/ajax-loader.gif\" alt=\"\"/>').fadeOut(1000);\n"
                                                    + "                    $.post('SessionIdMesa',data,function(respuesta){\n"
                                                    + "                        var verir=\"<div class='ui-widget'><div class='ui-state-error ui-corner-all' style='padding: 0 .7em;'><p><span class='ui-icon ui-icon-alert' style='float: left; margin-right: .3em;'></span> <strong>Error:</strong> <br> YA SE ENCUENTRA EL ID DE LA COMANDA INTENTE OTRO</p></div>\";\n"
                                                    + "                       \n"
                                                    + "                        var inres=respuesta.length;\n"
                                                    + "                       // alert(inres);			  \n"
                                                    + "                        if(inres==0){\n"
                                                    + "                           // alert(\"AQui entro\");\n"
                                                    + "                            $('#from" + mesasv.getIdMesaVenta() + "')[0].reset();               \n"
                                                    + "                            \n"
                                                    + "                            \n"
                                                    + "                           $(location).attr('href',\"Comanda_venta.jsp\"); \n"
                                                    + "                          \n"
                                                    + "                        }else{\n"
                                                    + "                            \n"
                                                    + "                            $('#idComanda" + mesasv.getIdMesaVenta() + "').focus();\n"
                                                    + "                            $('#cargar" + mesasv.getIdMesaVenta() + "').fadeIn(1000).html(verir);\n"
                                                    + "                            \n"
                                                    + "                            \n"
                                                    + "                               \n"
                                                    + "                          \n"
                                                    + "											\n"
                                                    + "                        }\n"
                                                    + "       \n"
                                                    + "                      \n"
                                                    + "			   \n"
                                                    + "                    });\n"
                                                    + "                    return false;\n"
                                                    + "                });\n"
                                                    + "            });\n"
                                                    + "        </script>");

                                            out.println(" <div id=\"" + mesasv.getIdMesaVenta() + "\" class=\"reveal-modal\" style=\"text-align:center\">\n"
                                                    + "            <form id=\"from" + mesasv.getIdMesaVenta() + "\">\n"
                                                    + "                <input type=\"hidden\" value=\"venta\" name=\"tipo\">\n"
                                                    + "                <input type=\"hidden\" value=\"" + mesasv.getIdMesaVenta() + "\" name=\"idMesaVenta\">\n"
                                                    + "                <label class=\"label-warning\"><H3>#ID COMANDA</H3></label>     \n"
                                                    + "\n"
                                                    + "\n"
                                                    + "                <input type=\"text\" name=\"idComanda\" id=\"idComanda" + mesasv.getIdMesaVenta() + "\" required=\"\" >    \n"
                                                    + "\n"
                                                    + "                <br>\n"
                                                    + "\n"
                                                    + "                <input type=\"submit\" value=\"Aceptar\" class=\"btn btn-primary btn-large\" >\n"
                                                    + "                <div id=\"cargar" + mesasv.getIdMesaVenta() + "\"></div>\n"
                                                    + "            </form>\n"
                                                    + "            <a class=\"close-reveal-modal\">&#215;</a>\n"
                                                    + "\n"
                                                    + "        </div>");

                                            out.println(" <li class='ui-state-default'><a href='#' data-reveal-id='" + mesasv.getIdMesaVenta() + "' data-animation='fadeAndPop' data-animationspeed='300' data-closeonbackgroundclick='true' data-dismissmodalclass='close-reveal-modal'>" + mesasv.getIdMesaVenta() + "<br><br><br><h1>$ "+m.getTotalcuenta()+"</h1><br><br><h4>Personas Aprox:" + mesasv.getPersonasAprox() + "</h4></a></li> ");
                                            //out.println("  <li class='ui-state-default'><a href='SessionIdMesa?idMesaVenta=" + mesasv.getIdMesaVenta() + "'></a></li>");

                                        }

                                    %>
                                </ul>
                            </div>
                        </td> 
                        <td valign="top">

                            <table height="100%" >
                                <tr><td>
                                        <input type="text" id="MesasBuscar" name="MesasBuscar" class="input-medium search-query" placeholder="Búscar mesa.....">
                                    </td><td> <a href="Mesas.jsp" class="btn">Ver Todo</a>

                                    </td></tr>
                                <tr><td><a href="Menu.jsp"  data-dismissmodalclass="close-reveal-modal" title="SALIR" class="btn btn-primary numHE"><BR><BR>SALIR</a></td><td>
                                        <a href="Cerradas.jsp"  id="coresiasver"  data-dismissmodalclass="close-reveal-modal" title="MESAS CERRADAS" class="btn btn-primary numHE"><BR><BR>MESAS<br><br>CERRADAS</a>
                                    </td></tr>
                                <tr><td><a href="#" data-reveal-id="agregarMesaDiv" data-animation="fadeAndPop" data-animationspeed="300" data-closeonbackgroundclick="true" data-dismissmodalclass="close-reveal-modal" title="AGREGAR MESA" class="btn btn-primary numHE"> <BR><BR>AGREGAR<br><br>MESA</a></td>
                                    <td><a href="#" data-reveal-id="trasladarv" data-animation="fadeAndPop" data-animationspeed="300" data-closeonbackgroundclick="true" data-dismissmodalclass="close-reveal-modal" title="TRASLADAR" class="btn btn-primary numHE"> <BR><BR>TRASLADAR</a></td></tr>
                                <tr><td>
                                        <a href="Comanda_Cortesia.jsp"  data-dismissmodalclass="close-reveal-modal" title="CORTESIAS" class="btn btn-primary numHE"><BR><BR>CORTESIAS</a>
                                    </td>
                                    <td>


                                    </td></tr>
                                <tr><td><a href="#" data-reveal-id="crearMesa" data-animation="fadeAndPop" data-animationspeed="300" data-closeonbackgroundclick="true" data-dismissmodalclass="close-reveal-modal" title="CREAR MESA" class="btn btn-danger numHE"> <BR><BR>CREAR<br><br>MESA</a></td><td></td></tr>
                            </table>   

                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </body>
</html>
