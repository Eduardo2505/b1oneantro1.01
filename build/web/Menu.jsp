<%-- 
    Document   : Principal
    Created on : 28/01/2013, 01:02:24 AM
    Author     : Eduardopc
--%>

<%@page import="com.mapping.Barra"%>
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

            Altadia d = new Altadia();
            int idDia = 0;
            String nombre = "";

            String idBarra = (String) sesion.getAttribute("idBarra");

            EmpleadoDaoImpl dao = new EmpleadoDaoImpl();
            Puesto pu = new Puesto();
            List res = null;
            String estado = "";
            Barra vb = new Barra();
            Iterator itr = null;
            String barraAct = "";
            if (idBarra == null) {
                response.sendRedirect("index.jsp");
            } else {
                nombre = " B1One";
                d = (Altadia) sesion.getAttribute("idDia");
                idDia = d.getIdaltadia();
                if (idBarra.equals("Barra 1")) {
                    barraAct = "Barra 2";
                } else {
                    barraAct = "Barra 1";
                }

                //    out.println(idBarra);
                //  out.println(e.getNombre()+" "+ e.getApellidos());
            }


        %>

        <script src="js/jquery-1.7.2.min.js"></script>      
        <script src="js/jquery.alerts.js"></script>
        <link rel="stylesheet" type="text/css" href="js/jquery.alerts.css">

        <script type="text/javascript" src="js/jquery.reveal.js"></script>
        <link rel="stylesheet" href="css/reveal.css">
        <!-- ================================Los styles =============================== -->
        <link href="assets/css/bootstrap.css" rel="stylesheet">   
        <style type="text/css">
            body {
                padding-top: 5%;
                padding-bottom: 40px;
            }

        </style>
        <link rel="stylesheet" type="text/css" href="css/jquery-ui-1.8.21.custom.css">
        <link href="assets/css/bootstrap-responsive.css" rel="stylesheet">              
        <link rel="stylesheet" type="text/css" href="css/styles.css" />


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
    <body id="contenidoTodo" >
        <script type="text/javascript">
            $(function() {
                $('#Activarform').submit(function() {
                    var data = $(this).serialize();
                    // alert(data);
                    $('#Info').html('<img src="img/ajax-loader.gif" alt=""/>').fadeOut(1000);
                    $.post('EmpleadoController', data, function(respuesta) {

                        var inres = respuesta.length;

                        if (inres <= 0) {

                        } else {
                            $('#Activarform')[0].reset();


                            jAlert("Se agrego correctamente", "Confirmación", function(r) {
                                if (r) {
                                    $('#contenidoTodo').html(respuesta);
                                }
                            });


                        }



                    });
                    return false;
                });
            });

            $(function() {
                $('#Desactivarform').submit(function() {
                    var data = $(this).serialize();
                    // alert(data);
                    $('#Infod').html('<img src="img/ajax-loader.gif" alt=""/>').fadeOut(1000);
                    $.post('EmpleadoController', data, function(respuesta) {

                        var inres = respuesta.length;

                        if (inres <= 0) {

                        } else {
                            $('#Desactivarform')[0].reset();


                            jAlert("Se agrego correctamente", "Confirmación", function(r) {
                                if (r) {
                                    $('#contenidoTodo').html(respuesta);
                                }
                            });


                        }



                    });
                    return false;
                });
            });

            $(document).ready(function() {
                $("#reporteAv").click(function(event) {

                    var idCargoria = "http://dfiestadf.com/CoverBy/ReporteXml";
                    //alert(idCargoria)
                    $("#reportediario").load(idCargoria);
                    $("#enviarD").load("ReporteEmail");
                });
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
                    <a class="brand" href="#"><% out.println(idBarra);%></a>
                    <a class="brand" href="#"><% out.println(d.getFecha() + " " + d.getTipoEvento());%></a>

                    <a class="brand" href="closeSessionMesero">Salir</a>



                    <div class="btn-group pull-right">
                        <a class="brand" href="AutorizarReporte.jsp">*ADMIN*</a>
                        <a class="brand" href="SessionCambioBarra?idbarra=<% out.println(barraAct);%>" title="Ir a <% out.println(barraAct);%>">IR A <% out.println(barraAct);%></a>

                    </div>

                </div>
            </div>
        </div>


        <div class="container"  >


            <style>
                #sortable { list-style-type: none; margin: 0; padding: 0; width: 100%; }
                #sortable li { margin: 3px 3px 3px 0; padding: 1px; float: left;  }

                .btnli{

                    margin: 3px 3px 3px 0; padding: 1px; float: left; width: 160px; height: 130px; font-size: 1em; text-align: center;
                }
                .numHE{
                    font-size:20px;
                    font-weight:bold;
                    height:30px;
                    width:150px;
                    padding-top:6%;
                }

            </style>




            <div align="center" id="mostrarBuscador">
                <div id="password" class="reveal-modal" style="text-align:center;width:320px">
                    <script>
                        $(function() {
                            $(".val").click(function(e) {
                                e.preventDefault();
                                if ($(".outcome").val().length < 4) {
                                    var a = $(this).attr("href");
                                    $(".screen").append(a);
                                    $(".outcome").val($(".outcome").val() + a);

                                }

                            });


                            $(".clear").click(function() {
                                $(".outcome").val("");
                                $(".screen").html("");
                            });

                            $(".close").click(function() {
                                $(".cal").css("display", "none");
                            })

                            $(".equal").click(function() {
                                var a = $(".outcome").val();
                                var idemple = $("#idempleadowin").val();
                                var url = "idMesero=" + idemple + "&clave=" + a;
                                //jAlert(url, "Error");
                                // alert(url);
                                var dataString = url;
                                alert(a);
                                if (a != "") {
                                    $.ajax({
                                        type: "POST",
                                        url: "SessionMesero",
                                        data: dataString,
                                        success: function(data) {

                                            //   alert(data)
                                            if (data == "") {
                                                jAlert("EL PASSWORD ES INCORRECTO VERIFIQUE?", "Error!!", function(r) {
                                                    if (r) {
                                                        $(".outcome").val("");
                                                    }
                                                });

                                            } else {

                                                $(location).attr('href', "Mesas.jsp");

                                            }


                                        }
                                    });
                                } else {
                                    jAlert("Inserte password", "Error!!", function(r) {
                                        if (r) {
                                            $(".outcome").focus();
                                        }
                                    });

                                }

                                ///################################


                            });

                            $(".btnli").click(function() {
                                var a = $(this).attr("name");
                                $('#idempleadowin').val(a)



                            });
                        })

//###################
                        $(function() {
                            $('#entrarlogin').submit(function() {
                                var data = $(this).serialize();


                                $.post('SessionMesero', data, function(respuesta) {

                                    if (respuesta == "") {
                                        jAlert("EL PASSWORD ES INCORRECTO VERIFIQUE?", "Error!!", function(r) {
                                            if (r) {
                                                $('#entrarlogin')[0].reset();
                                            }
                                        });

                                    } else {
                                        //  alert(respuesta);

                                        $(location).attr('href', "Mesas.jsp");

                                    }



                                });
                                return false;


                            });
                        });
                    </script>


                    <div class="content">

                        <div class="calculator">
                            <form id="entrarlogin">
                                <input type="hidden" name="idMesero"  id="idempleadowin" value="">
                                <input type="password"  name="clave" class="outcome" style="height:60px;font-size:60px;color:white" required=""   />
                                <br>
                                <input type="submit" value="Entrar" class="btn btn-inverse btn-large">
                            </form>
                            <!--
                             <ul class="buttons">
                                 <table>
                                     <tr>
                                         <td><li><a class="clear">C</a></li></td>
                                     <td><li><a class="" href="#"></a></li></td>
                                     <td><li><a class="" href="#"></a></li></td>
                                     </tr>
                                     <tr>
                                         <td><li><a class="val" href="7">7</a></li></td>
                                     <td><li><a class="val" href="8">8</a></li></td>
                                     <td><li><a class="val" href="9">9</a></li></td>
                                     </tr>
                                     <tr>
                                         <td><li><a class="val" href="4">4</a></li></td>
                                     <td><li><a class="val" href="5">5</a></li></td>
                                     <td><li><a class="val" href="6">6</a></li></td>
                                     </tr>
                                     <tr>
                                         <td><li><a class="val" href="1">1</a></li></td>
                                     <td><li><a class="val" href="2">2</a></li></td>
                                     <td><li><a class="val" href="3">3</a></li>></td>
                                     </tr>
                                     <tr>
                                         <td><li><a class="val" href="0">0</a></li></td>
                                     <td colspan="2"><li><a class="equal wide" >Entrar</a></li></td>
 
                                     </tr>
                                 </table>
 
 
                             </ul>-->
                        </div>
                    </div>
                    <a class="close-reveal-modal clear">&#215;</a>

                </div>
                <ul id="sortable">
                    <!--  <li class='ui-state-default'>
  
                          <a href="#" data-reveal-id="password" data-animation="fadeAndPop" data-animationspeed="300" data-closeonbackgroundclick="true" data-dismissmodalclass="close-reveal-modal" title="Passwore" class="btnli" >Activar</a>
                      </li>-->
                    <%

                        res = dao.getFiltro();
                        itr = res.iterator();
                        while (itr.hasNext()) {
                            Empleado em = (Empleado) itr.next();
                            pu = em.getPuesto();
                            String puesto = pu.getTipo();
                            vb = em.getBarra();
                            if (vb != null) {
                                if (vb.getIdBarra().equals(idBarra)) {

                                    out.print("<li class='ui-state-default'><a href=\"#\" name='" + em.getIdEmpleado() + "' data-reveal-id='password' data-animation=\"fadeAndPop\" data-animationspeed=\"300\" data-closeonbackgroundclick=\"true\" data-dismissmodalclass=\"close-reveal-modal\" title=\"Password\" class=\"btnli\" ><h3>" + puesto + "</h3><br><br><h1>" + em.getEmpleadocol().toUpperCase() + "</h1></a></li>");

                                }

                            }
                        }


                    %>



                </ul>



            </div>
            <!--<a href="#" id="reporteAv">R</a>
            <div id="reportediario"></div>
            <div id="enviarD"></div>-->
        </div>


    </body>
    <script Language="JavaScript">

           
                if (history.forward(1)) {
                    history.replace(history.forward(1));
                    
                }
          
        </script>
</html>
