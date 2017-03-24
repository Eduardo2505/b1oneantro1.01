<%-- 
    Document   : Actualizar
    Created on : 24/04/2013, 03:27:46 PM
    Author     : Eduardopc
--%>

<%@page import="com.dao.impl.BarraDaoImpl"%>
<%@page import="com.mapping.Barra"%>
<%@page import="com.dao.impl.MesasDaoImpl"%>
<%@page import="com.mapping.Mesas"%>
<%@page import="com.mapping.Zona"%>
<%@page import="com.dao.impl.ZonaDaoImpl"%>
<%@page import="com.mapping.Puesto"%>
<%@page import="com.dao.impl.PuestoDaoImpl"%>
<%@page import="com.mapping.Empleado"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="com.dao.impl.EmpleadoDaoImpl"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>

        <%
            EmpleadoDaoImpl dao = new EmpleadoDaoImpl();
            PuestoDaoImpl daop = new PuestoDaoImpl();
            List res = null, resp = null;
            ZonaDaoImpl daoz = new ZonaDaoImpl();
            MesasDaoImpl daom = new MesasDaoImpl();

            Iterator itr = null, itrp = null;
            List resm = null, resz = null;

            Iterator itrm = null, itrz = null;

            Puesto pu = new Puesto();
            Barra vb = new Barra();
            BarraDaoImpl daob = new BarraDaoImpl();
            HttpSession sesion = request.getSession();
            String puesto =(String)sesion.getAttribute("puesto");
            int idpuesto = (Integer) sesion.getAttribute("idpuesto");
             if (puesto == null) {
                response.sendRedirect("../index2.jsp");
            } else {
            
             }
        %>
        <script src="../assets/js/jquery.js"></script>
        <script src="../assets/js/bootstrap-transition.js"></script>
        <script src="../assets/js/bootstrap-alert.js"></script>
        <script src="../assets/js/bootstrap-modal.js"></script>
        <script src="../assets/js/bootstrap-dropdown.js"></script>
        <script src="../assets/js/bootstrap-scrollspy.js"></script>
        <script src="../assets/js/bootstrap-tab.js"></script>
        <script src="../assets/js/bootstrap-tooltip.js"></script>
        <script src="../assets/js/bootstrap-popover.js"></script>
        <script src="../assets/js/bootstrap-button.js"></script>
        <script src="../assets/js/bootstrap-collapse.js"></script>
        <script src="../assets/js/bootstrap-carousel.js"></script>
        <script src="../assets/js/bootstrap-typeahead.js"></script>
        <script src="../js/jquery-1.7.2.min.js"></script>
        <script src="../js/jquery-ui-1.8.21.custom.min.js"></script>
        <script src="../js/jquery.alerts.js"></script>
        <link rel="stylesheet" type="text/css" href="../js/jquery.alerts.css">

        <script type="text/javascript" src="../js/jquery.reveal.js"></script>
        <link rel="stylesheet" href="../css/reveal.css">
        <!-- ================================Los styles =============================== -->
        <link href="../assets/css/bootstrap.css" rel="stylesheet">
        <link rel='stylesheet' type='text/css' href='../css/jquery.autocomplete.css' />
        <script src='../js/jquery.autocomplete.js'></script>
        <style type="text/css">
            body {
                padding-top: 4%;
                padding-bottom: 40px;
            }
            .sidebar-nav {
                padding: 9px 0;
            }
            .login{
                width:290px;

            }	
        </style>
        <link href="../assets/css/bootstrap-responsive.css" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="../css/jquery-ui-1.8.21.custom.css">
        <link rel="stylesheet" type="text/css" href="../css/styles.css" />
    </head>


    <body style="text-align: center">
         <div class="navbar navbar-inverse navbar-fixed-top">
      <div class="navbar-inner">
        <div class="container">
          <button type="button" class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="brand" href="#">Administración</a>
          <div class="nav-collapse collapse">
              <div class="navbar-form pull-right">
                  <a href="Menu.jsp" class="btn btn-large btn-warning"><--Regresar</a>
                  <a href="../close" class="btn btn-large btn-danger">Salir</a>
              </div>
          </div><!--/.nav-collapse -->
        </div>
      </div>
    </div>

        <script type="text/javascript">
            $(function() {
                $('#Activarform').submit(function() {
                    var data = $(this).serialize();
                    // alert(data);
                    var verir = "<div class='ui-widget'><div class='ui-state-error ui-corner-all' style='padding: 0 .7em;'><p><span class='ui-icon ui-icon-alert' style='float: left; margin-right: .3em;'></span> <strong>Error:</strong> <br> No coincide el password</p></div>";
                    $.post('../ControllerEmpleado', data, function(respuesta) {

                        var inres = respuesta.length;
                        // alert(inres);
                        if (inres > 0) {
                            $('.pass').focus();
                            $('#Info').html(respuesta);
                        } else {
                            $('#Activarform')[0].reset();
                            jAlert("Se Actualizo correctamente", "Confirmación", function(r) {
                                if (r) {
                                    $(location).attr('href', "Actualizar.jsp");
                                }
                            });
                        }

                    });
                    return false;
                });
            });




            $(function() {
                $('#reform').submit(function() {
                    var data = $(this).serialize();
                    // alert(data);

                    $.post('../ControllerEmpleado', data, function(respuesta) {
                        var verir = "<div class='ui-widget'><div class='ui-state-error ui-corner-all' style='padding: 0 .7em;'><p><span class='ui-icon ui-icon-alert' style='float: left; margin-right: .3em;'></span> <strong>Error:</strong> <br> No coincide el password</p></div>";
                        var inres = respuesta.length;
                        //alert(inres);
                        if (inres > 0) {
                            $('.passr').focus();
                            $('#Infor').html(respuesta);
                        } else {
                            $('#reform')[0].reset();
                            jAlert("Se inserto correctamente", "Confirmación", function(r) {
                                if (r) {
                                    $(location).attr('href', "Actualizar.jsp");
                                }
                            });
                            // $(location).attr('href', "Actualizar.jsp");
                        }

                    });
                    return false;
                });
            });

            $(function() {
                $('#AsignarMesa').submit(function() {
                    var data = $(this).serialize();
                    //     alert(data);

                    $.post('../AsignarMesaControlleri', data, function(respuesta) {

                       // alert(respuesta);

                        jAlert("Se asignaron tus mesas correctamente", "Confirmación", function(r) {
                            if (r) {
                              //  $(location).attr('href', "Actualizar.jsp");
                            }
                        });


                    });
                    return false;
                });
            });


            $(function() {
                $('#Activarformme').submit(function() {
                    var data = $(this).serialize();
                    // alert(data);
                    $('#Info').html('<img src="img/ajax-loader.gif" alt=""/>').fadeOut(1000);
                    $.post('../EmpleadoController', data, function(respuesta) {

                        var inres = respuesta.length;

                        if (inres <= 0) {

                        } else {
                            $('#Activarformme')[0].reset();


                            jAlert("Se agrego correctamente", "Confirmación", function(r) {
                                if (r) {
                                    $(location).attr('href', "Actualizar.jsp");
                                }
                            });


                        }



                    });
                    return false;
                });
            });

            $(document).ready(function() {
                $('#idBarrab').change(function() {
                    var user = $(this).val();
                    var dataString = 'idBarra=' + user;
                    //alert(user);
                    if (user != "") {
                        $('#mostraMeseros').html('<img src="img/ajax-loader.gif" alt=""/>');
                        $.ajax({
                            type: "POST",
                            url: "../ChengeActivarBarra",
                            data: dataString,
                            success: function(data) {
                                //alert(data)

                                $('#mostraMeseros').fadeIn(500).html(data);

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
        
        
        <table style="width: 100%">
            <tr><td VALIGN="top">
                    <form id="Activarform">
                        <input type="hidden" name="op" value="ac">
                        <label>Empleado</label>
                        <select name="idEmpleado" required>
                            <option value="" >Seleccione</option>
                            <%
             
           
                                res = dao.getFiltro();
                                itr = res.iterator();

                                while (itr.hasNext()) {
                                    Empleado em = (Empleado) itr.next();






                                    out.print(" <option  value ='" + em.getIdEmpleado() + "'>" + em.getNombre() + " " + em.getApellidos() + " ("+em.getEmpleadocol()+")</option>");
                                }


             





                            %>
                        </select><br><a href="Actualizar.jsp" class="btn">Actualizar</a><br>
                        <br>

                        <label>Password</label>
                        <input type="password" name="pass" pattern="|^([0-9]+\s*)+$|" class="pass" required="" placeholder="****" maxlength="4"><br>
                        <label>Confirmación</label>
                        <input type="password" name="passr" pattern="|^([0-9]+\s*)+$|" class="pass" required="" placeholder="****" maxlength="4">
                        <br>


                        <label>Clave</label>
                        <input type="text" name="Clave" required="" placeholder=""><br>


                        <br>
                        <select name="idBarra" required="">
                                <option value="">IdBarra</option>
                                <%
                                   
                                    List resb = daob.getver();
                                    Iterator itrb = resb.iterator();
                                    while (itrb.hasNext()) {
                                        Barra c = (Barra) itrb.next();

                                        out.println("<option value='" + c.getIdBarra() + "' >" + c.getIdBarra() + "</option>");

                                    }

                                %>  
                            </select>
                        <br>
                        <select name="idPuesto" required="">
                                <option value="">Puesto</option>
                                <%
                                   PuestoDaoImpl ps=new PuestoDaoImpl();
                                    List resrr = ps.getPuesto();
                                    Iterator itp = resrr.iterator();
                                    while (itp.hasNext()) {
                                        Puesto c = (Puesto) itp.next();

                                        out.println("<option value='" + c.getIdpuesto() + "' >" + c.getTipo() + "</option>");

                                    }

                                %>  
                            </select><br>
                        <input type="radio" name="group1" value="pass"> Password
                         <input type="radio" name="group1" value="puesto"> Puesto
                        <input type="radio" name="group1" value="passClave" checked>Todo <br><br>
                        <input type="submit" value="Actualizar">
                        <div id="Info" >



                        </div>
                    </form>

                  
                    <a href="Zonas.jsp" class="btn btn-inverse">Zonas</a>
                                     
                
                    <!--<a href="Barra.jsp" class="btn btn-inverse">Activar Mesero</a><br>-->

                </td><td VALIGN="top">
                    <label><h1>Registrar</h1></label>
                    <form id="reform">
                        <input type="hidden" name="op" value="regis">
                        <label>Nombre</label>
                        <input type="text" name="nom"  required="" >
                        <label>Apellido</label>
                        <input type="text" name="ape"  required="" >
                        <label>Email</label>
                        <input type="email" name="txtemail"   placeholder="email@ser.com" >
                        <label>Password</label>
                        <input type="password" name="pass" pattern="|^([0-9]+\s*)+$|" required="" placeholder="****" maxlength="4"><br>
                        <label>Confirmación</label>
                        <input type="password" name="passr" pattern="|^([0-9]+\s*)+$|" required="" placeholder="****" maxlength="4">
                        <br>


                        <label>Clave</label>
                        <input type="text" name="Clave" required="" placeholder=""><br>

                        <btr>
                            <label>Puesto</label>
                            <select name="pu" required>
                                <option value="" >Seleccione</option>
                                <%
                                    resp = daop.getPuesto();
                                    itrp = resp.iterator();

                                    while (itrp.hasNext()) {
                                        Puesto em = (Puesto) itrp.next();






                                        out.print(" <option  value ='" + em.getIdpuesto() + "'>" + em.getTipo() + "</option>");
                                    }








                                %>
                            </select><br>

                            <input type="submit" value="Registrar">
                            <div id="Infor"></div>
                    </form>
                </td>
                <td VALIGN="top">
                    <form id="AsignarMesa">
                        <label><h2>Asignar Mesa</h2></label>

                        <label>Empleado</label>
                        <select name="idEmpleado" required>
                            <option value="" >Seleccione</option>
                            <%
                                res = dao.getFiltro();
                                itr = res.iterator();

                                while (itr.hasNext()) {
                                    Empleado em = (Empleado) itr.next();
                                    if (em.getEmpleadocol() != null) {

                                        out.print(" <option  value ='" + em.getIdEmpleado() + "'>" + em.getNombre() + " " + em.getApellidos() + " ("+em.getEmpleadocol()+")</option>");
                                    }







                                }








                            %>
                        </select><br>
                        <br>                        
                        <br>
                        <label>Final</label>

                        <input type="number" name="finalv"  class="pass" required="" placeholder="final" style="width:70px">

                        <br><br>
                        <label>Zona</label>
                        <select name="idZona" required>
                           
                            <%
                                resz = daoz.getZona();
                                itrz = resz.iterator();

                                while (itrz.hasNext()) {
                                    Zona em = (Zona) itrz.next();






                                    out.print(" <option  value ='" + em.getIdzona() + "'>" + em.getIdzona() + "</option>");
                                }








                            %>
                        </select><br>
                        <br>


                        <input type="submit" value="Crear">
                        
                    </form>


                </td>
            </tr></table>
    </body>
</html>
