<%-- 
    Document   : Barra
    Created on : 25/02/2013, 07:22:41 PM
    Author     : Eduardopc
--%>

<%@page import="com.mapping.Empleado"%>
<%@page import="com.mapping.Barra"%>
<%@page import="com.dao.impl.BarraDaoImpl"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Barra</title>
        <script src="js/jquery-1.7.2.min.js"></script> 
         <script src="js/jquery.popupWindow.js"></script> 
        <link href="assets/css/bootstrap.css" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="css/jquery-ui-1.8.21.custom.css">
        <style type="text/css">
            body {
                padding-top: 8%;
                padding-bottom: 40px;
            }
            .sidebar-nav {
                padding: 9px 0;
            }
            .login{
                width:290px;

            }	
        </style>
        
        <script type="text/javascript">
            $(function() {
                $('#entrar').submit(function() {
                    var data = $(this).serialize();
                    $('#contenido').html("<img src=\"img/ajax-loader.gif\" />").fadeOut(1000);

                    $.post('SessionBarra', data, function(respuesta) {
                        // alert(respuesta);
                        var inres = respuesta.length;
                        //   alert(inres);
                        if (inres == 275) {
                            $('#contenido').fadeIn(1000).html(respuesta);


                        } else {



                            $('#ver').click();
                               $('#close').click();

                        }

                    });
                    return false;
                });
            });

        </script>

    </head>
    <body>
        <div style="display:none">
        <a href="Menu.jsp" class="example1demo" id="ver">open popup</a>
        <a href="#" onClick="window.close();" id="close" >Closeee</a> 
        </div>
        <script type="text/javascript">
            
            $('.example1demo').popupWindow({
                height: 700,
                width: 1250


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
                    <a class="brand">Barra</a>
                </div>
            </div>
        </div>


        <div align="center">
            <div class="well login">
                <h1>********* B1 ONE ANTRO **********</h1><BR>
                <label><h4>BARRA </h4></label>                

                <table>
                    <form class="well form-inline" id="entrar">

                        <tr><td><select name="idbarra" required="">
                                    <option value="">Seleccione</option>
                                    <%
                                        BarraDaoImpl dao = new BarraDaoImpl();
                                        List res = dao.getver();
                                        Iterator itr = res.iterator();
                                        while (itr.hasNext()) {
                                            Barra c = (Barra) itr.next();
                                            if (!c.getIdBarra().equals("Desactivar")) {
                                                out.println("<option value='" + c.getIdBarra() + "'>" + c.getIdBarra() + "</option>");
                                            }
                                            // System.out.println(c.getIdBarra());

                                        }


                                    %>
                                </select></td></tr>
                        <tr><td align="center">
                                <input type="submit" class="btn" value="Entrar"></td></tr>
                        <tr><td align="center">
                                <a href="index2.jsp">Administrar</a></tr>
                        <tr><td align="center">
                                <a href="Administrador/Barra.jsp?op=Barra" class="btn btn-inverse">Activar Mesero</a></tr>


                    </form>
                </table>
                <div id="contenido" style="text-align: left">
                </div>




            </div>

        </div> 
    </body>
    <script Language="JavaScript">

            $(document).ready(function() {
                if (history.forward(1)) {
                    history.replace(history.forward(1));
                    alert("entro");
                }
            });
        </script>
</html>
