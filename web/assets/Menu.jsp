<%-- 
    Document   : Principal
    Created on : 28/01/2013, 01:02:24 AM
    Author     : Eduardopc
--%>

<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="com.mapping.Puesto"%>
<%@page import="com.dao.impl.EmpleadoDaoImpl"%>
<%@page import="com.mapping.Altadia"%>
<%@page import="com.mapping.Empleado"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Menu</title>
        <%
            HttpSession sesion = request.getSession();
            Empleado e = new Empleado();
            Altadia d = new Altadia();
            int idDia = 0;
            String nombre = "";
            e = (Empleado) sesion.getAttribute("id");

            //out.println(e);
            EmpleadoDaoImpl dao = new EmpleadoDaoImpl();
            Puesto pu = new Puesto();
            List res = null;
            String estado = "";
            Iterator itr = null;
            if (e == null) {
                response.sendRedirect("index.jsp");
            } else {
                nombre = e.getNombre() + " " + e.getApellidos();
                d = (Altadia) sesion.getAttribute("idDia");
                idDia = d.getIdaltadia();

                //  out.println(e.getNombre()+" "+ e.getApellidos());

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

        </style>
        <link href="assets/css/bootstrap-responsive.css" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="css/jquery-ui-1.8.21.custom.css">


        <style>
            .numH{
                font-size:25px;
                font-weight:bold;
                /*height:120px;*/
                width:160px;
                padding-top:4%;
                padding-bottom:4%;

            }

        </style>

        <!--####################################siti00#################-->

    </head>
    <body id="contenidoTodo">
        <script>
            $('input').bind('blur', function() {
                $(this).val(function( i, val ) {
                    return val.toUpperCase();
                });
            });
        </script>
        <script type="text/javascript">
            $(function(){
                $('#Activarform').submit(function(){
                    var data=$(this).serialize();
                    // alert(data);
                    $('#Info').html('<img src="img/ajax-loader.gif" alt=""/>').fadeOut(1000);
                    $.post('EmpleadoController',data,function(respuesta){
                       
                        var inres=respuesta.length;
							  
                        if(inres<=0){
                            
                        }else{
                            $('#Activarform')[0].reset();                       
                            
                            
                            jAlert("Se agrego correctamente", "Confirmación", function(r) {  
                                if(r) {  
                                    $('#contenidoTodo').html(respuesta);
                                }  
                            });  
                          
											
                        }
       
                      
			   
                    });
                    return false;
                });
            });
            
            $(function(){
                $('#Desactivarform').submit(function(){
                    var data=$(this).serialize();
                    // alert(data);
                    $('#Infod').html('<img src="img/ajax-loader.gif" alt=""/>').fadeOut(1000);
                    $.post('EmpleadoController',data,function(respuesta){
                       
                        var inres =respuesta.length;
							  
                        if(inres<=0){
                            
                        }else{
                            $('#Desactivarform')[0].reset();                       
                            
                            
                            jAlert("Se agrego correctamente", "Confirmación", function(r) {  
                                if(r) {  
                                    $('#contenidoTodo').html(respuesta);
                                }  
                            });  
                          
											
                        }
       
                      
			   
                    });
                    return false;
                });
            });
            $(document).ready(function() {	
                $('#NombreUserBuscar').keyup(function(){
                    var user = $(this).val();		
                    var dataString ='NombreUserBuscar='+user;
                    //alert(user);
                    if(user!=""){
                        $('#mostrarBuscador').html('<img src="img/ajax-loader.gif" alt=""/>');
                        $.ajax({
                            type: "POST",
                            url: "BuscarEmpleadoController",
                            data: dataString,
                            success: function(data) {
                                //alert(data)
              
                                $('#mostrarBuscador').fadeIn(500).html(data);
                
                                //	 response.sendRedirect("index.jsp");	
                                //alert(data);
                            }
                        });
                        //}
                    }}
        
    
            );              
            });

        </script>
        <div class="navbar navbar-fixed-top">
            <div class="navbar-inner">
                <div class="container-fluid">
                    <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </a>
                    <a class="brand" href="#">Usuario:<samp style="font-size:17px"><% out.println(nombre);%></samp></a>
                    <a class="brand" href="#"><% out.println(idDia);%></a>

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


        <div class="container"  >
            <a href="Reporte.jsp">Ver</a>

            <style>
                #sortable { list-style-type: none; margin: 0; padding: 0; width: 100%; }
                #sortable li { margin: 3px 3px 3px 0; padding: 1px; float: left; width: 160px; height: 130px; font-size: 1em; text-align: center; }
                .numHE{
                    font-size:20px;
                    font-weight:bold;
                    height:30px;
                    width:150px;
                    padding-top:6%;
                }

            </style>
            <!--################################################-->
            <div id="Activardiv" class="reveal-modal" style="text-align:center">
                <form id="Activarform">
                    <label class="label-warning"><H1>MESERO</H1></label>
                    <input type="hidden" name="estado" value="Activo">

                    <select name="idEmpleado" required>
                        <option value="" >Seleccione</option>
                        <%
                            res = dao.getFiltro();
                            itr = res.iterator();
                            while (itr.hasNext()) {
                                Empleado em = (Empleado) itr.next();
                                pu = em.getPuesto();
                                String puesto = pu.getTipo();
                                estado = em.getTarjeta();
                                if (estado != null) {
                                    if (!em.getTarjeta().equals("Activo")) {
                                        out.print(" <option  value ='" + em.getIdEmpleado() + "'>" + em.getNombre() + " " + em.getApellidos() + "</option>");


                                    }
                                }

                            }
                        %>
                    </select>

                    <br>
                    <input type="submit" value="Activar" class="btn btn-primary btn-large" >
                    <div id="Info"></div>
                </form>
                <a class="close-reveal-modal">&#215;</a>

            </div>
            <div id="Desactivardiv" class="reveal-modal" style="text-align:center">
                <form id="Desactivarform">
                    <label class="label-warning"><H1>MESERO</H1></label>
                    <input type="hidden" name="estado" value="Desactivar">
                    <select name="idEmpleado" required>
                        <option value="">Seleccione</option>
                        <%
                            res = dao.getFiltro();
                            itr = res.iterator();
                            while (itr.hasNext()) {
                                Empleado em = (Empleado) itr.next();
                                pu = em.getPuesto();
                                String puesto = pu.getTipo();
                                estado = em.getTarjeta();
                                if (estado != null) {
                                    if (em.getTarjeta().equals("Activo")) {
                                        out.print(" <option  value ='" + em.getIdEmpleado() + "'>" + em.getNombre() + " " + em.getApellidos() + "</option>");


                                    }
                                }

                            }
                        %>
                    </select>
                    <br>
                    <input type="submit" value="Desactivar" class="btn btn-primary btn-large" >
                    <div id="Infod"></div>
                </form>
                <a class="close-reveal-modal">&#215;</a>

            </div>
            <div align="right">
                <table >
                    <tr><td>

                            <a href="#" data-reveal-id="Activardiv" data-animation="fadeAndPop" data-animationspeed="300" data-closeonbackgroundclick="true" data-dismissmodalclass="close-reveal-modal" title="TRASLADAR" class="btn btn-primary numHE">Activar</a>
                        </td>
                        <td>
                            <a href="#" data-reveal-id="Desactivardiv" data-animation="fadeAndPop" data-animationspeed="300" data-closeonbackgroundclick="true" data-dismissmodalclass="close-reveal-modal" title="TRASLADAR" class="btn btn-primary numHE">Desactivar</a>  
                        </td>
                        <td>
                            <form class="form-search">
                                <input type="text" id="NombreUserBuscar" name="NombreUserBuscar" class="input-medium search-query" placeholder="Búscar.....">
                                <a href="Menu.jsp" class="btn">Ver Todo</a>
                            </form>


                        </td></tr>
                </table>
            </div>


            <div align="center" id="mostrarBuscador">
                <ul id="sortable">
                    <%


                        res = dao.getFiltro();
                        itr = res.iterator();
                        while (itr.hasNext()) {
                            Empleado em = (Empleado) itr.next();
                            pu = em.getPuesto();
                            String puesto = pu.getTipo();
                            estado = em.getTarjeta();
                            if (estado != null) {
                                if (em.getTarjeta().equals("Activo")) {

                                    out.print("<li class='ui-state-default'><a href='SessionMesero?idMesero=" + em.getIdEmpleado() + "'><h3>" + puesto + "</h3><br>" + em.getNombre() + " " + em.getApellidos() + "</a></li>");


                                }

                            }
                        }



                    %>



                </ul>



            </div>
        </div>


    </body>
</html>
