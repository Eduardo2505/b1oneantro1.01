<%-- 
    Document   : Actualizar
    Created on : 24/04/2013, 03:27:46 PM
    Author     : Eduardopc
--%>

<%@page import="com.mapping.Altadia"%>
<%@page import="com.dao.impl.AltadiaDaoImpl"%>
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
            
            String op = request.getParameter("op").trim()==null?"Barra":request.getParameter("op").trim();
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
            .desactivar{
                width:150px;

            }
            .ver{
                width:70px;

            }

        </style>
        <link href="../assets/css/bootstrap-responsive.css" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="../css/jquery-ui-1.8.21.custom.css">
        <link rel="stylesheet" type="text/css" href="../css/styles.css" />

        <script type="text/javascript">
            $(function() {
                $('#enviar').click(function() {

                    var idBarra = $('#idBarra').val();

                    //var f = $('.ck').val();

                    if (idBarra != "") {
                        $("input[@name='categoria[]']:checked").each(function() {
                            var idempleado = $(this).val();

                            var dataString = 'idBarra=' + idBarra + '&idempleado=' + idempleado;

                            $.ajax({
                                type: "POST",
                                url: "../ActivarBarraEmpleadoController",
                                data: dataString,
                                success: function(data) {
                                    jAlert("Se actualizaron correctamente", "¡Bien hecho!", function(r) {
                                        if (r) {
                                            $(location).attr('href', "Barra.jsp?op=Barra");
                                        }
                                    });
                                }
                            });

                        });


                    } else {
                        jAlert("Seleccione Barra", "Error", function(r) {
                            if (r) {
                                $('#idBarra').focus();
                            }
                        });

                    }
                });
            });

        </script>
    </head>

    <body>
        <div class="navbar navbar-inverse navbar-fixed-top">
            <div class="navbar-inner">
                <div class="container">
                    <button type="button" class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="brand" href="#">Administrador</a>
                    <a class="brand" href="../index.jsp"><h1>Regresar</h1></a>
                    
                </div>
            </div>
        </div>

        <div class="container-fluid">
            <div class="row-fluid">
                <div class="span3">
                    <div class="sidebar-nav">
                        <div class="well" style="text-align: center">
                            <select id="idBarra" required="">
                                <option value="">Seleccionar</option>
                                <%
                                    BarraDaoImpl daob = new BarraDaoImpl();
                                    List resb = daob.getver();
                                    Iterator itrb = resb.iterator();
                                    while (itrb.hasNext()) {
                                        Barra c = (Barra) itrb.next();

                                        out.println("<option value='" + c.getIdBarra() + "' >" + c.getIdBarra() + "</option>");

                                    }

                                %>  
                            </select>
                            <br>
                            <input type="button" id="enviar" class="btn btn-large"  value="enviar" /><br>
                            <br>
                            <a href="Barra.jsp?op=Desactivar" style="width:120px" class="btn btn-inverse">Mostrar<br>Meseros<br>Desactivados</a>
                            <br><br>
                            <a href="Barra.jsp?op=Barra" style="width:120px" class="btn btn-primary">Mostrar<br>Meseros<br>Activos</a>
                            <hr>
                        <!--    <a href="../Resetear" style="width:120px"  class="btn btn-danger btn-large">Resetear barra</a>-->
                        </div>
                    </div><!--/.well -->
                </div><!--/span-->
                <div class="span9" >
                    <div id="actualiBarra">
                        <table class="table table-striped" style="width:70%">
                            <tr>
                                <th>Nombre</th>
                                <th>Clave</th>
                                <th>Barra</th>
                                <th>Activar</th>
                            </tr>
                            <%
                               EmpleadoDaoImpl dao = new EmpleadoDaoImpl();
                                List res = dao.getFiltro(op);
                                Iterator itr = res.iterator();
                                Barra b = new Barra();
                                while (itr.hasNext()) {
                                    Empleado em = (Empleado) itr.next();
                                    if (em.getEmpleadocol() != null) {
                                             b = em.getBarra();                                       
                                              out.println("<tr><td>" + em.getNombre() + " " + em.getApellidos() + "</td><td>" + em.getEmpleadocol() + "</td><td>" + b.getIdBarra() + "</td><td> <input name=\"elemento1\" type=\"checkbox\" name='categoria[]' value='" + em.getIdEmpleado() + "' class=\"ck\"/></td></tr>");
                                        
                                         
                                    }
                                }
                            %>
                        </table>
                    </div><!--/.well -->
                </div><!--/span-->

            </div><!--/row-->

            <hr>

            <footer>
                <p>&copy; Company 2013</p>
            </footer>

        </div><!--/.fluid-container-->
    </body>
</html>
