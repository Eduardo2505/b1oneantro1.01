<%-- 
    Document   : ActivarCuentas
    Created on : 19/07/2013, 04:25:14 PM
    Author     : Eduardo
--%>

<%@page import="com.mapping.Empleado"%>
<%@page import="com.mapping.MesaVenta"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="com.dao.impl.Mesa_ventaDaoImpl"%>
<%@page import="com.mapping.Altadia"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Administrador</title>
        <%
            HttpSession sesion = request.getSession();
            // Empleado e = new Empleado();
            Altadia d = new Altadia();
            d = (Altadia) sesion.getAttribute("idDia");
//out.println(d);

            String dia = d.getFecha();
            Empleado em = new Empleado();
            int idDia = d.getIdaltadia();

        %>
      
     <!--   <script src="../js/jquery-1.7.2.min.js"></script>
        <script src="../js/jquery-ui-1.8.21.custom.min.js"></script>
    
        <link href="../assets/css/bootstrap.css" rel="stylesheet">
        
        <link rel="stylesheet" type="text/css" href="../css/jquery-ui-1.8.21.custom.css">-->
        
    </head>
    <body>
    
        <div class="well">
            <script type="text/javascript">
                $(document).ready(function() {
                    $('.ver').click(function() {


                        var user = $(this).attr("name");
                      

                        var dataString = 'idCuentas=' + user;
                        //  alert(dataString);
                        if (user != "") {
                            // $('#verResultadoBuscados').html('<img src="img/ajax-loader.gif" alt=""/>');
                            $.ajax({
                                type: "POST",
                                url: "AbrirCuenta",
                                data: dataString,
                                success: function(data) {
                                    $('#resultados').html(data);
                                }
                            });
                            //}
                        }
                    }


                    );
                });
            </script>
            <div id="resultados">
                <table class="table table-striped">
                    <tr><td colspan="3"><h4>########Cuentas Cerradas#######</h4></td></tr>
                    <tr><th>Cuenta</th><th>Estado</th><th>Opciones</th></tr>
                            <%
                                Mesa_ventaDaoImpl dao = new Mesa_ventaDaoImpl();
                                List res = dao.getCuentasAbiertas("", idDia, "");
                                Iterator itr = res.iterator();

                                String color = "", nom = "";
                                while (itr.hasNext()) {
                                    MesaVenta ee = (MesaVenta) itr.next();
                                    if (ee.getEstado().equals("Cerrado")) {
                                        color = "btn-primary";
                                        nom = "Abrir";

                                    } else {
                                        color = "btn-danger";
                                        nom = "Cerrar";
                                    }


                                    out.println("<tr><td>" + ee.getIdMesaVenta() + "</td><td>" + ee.getEstado() + "</td><td><a href='#' name='" + ee.getIdMesaVenta() + "'  class='btn btn-large " + color + " ver' >" + nom + "</a></td></tr>");
                                }



                                //  out.println("<tr><td>" + e.getNombre() + " " + e.getApellidos() + "</td><td>" + e.getRegistro() + "</td><td><a class=\"btn btn-small\" TARGET='_new' href='ImprimirTarjeta?idUsuario=" + e.getIdCliente() + "&nombre=" + e.getNombre() + " " + e.getApellidos() + "'><i class='icon-print'></i>Imprimir</a></td></tr>");


                            %>
                </table>
            </div>
        </div>

    </body>
</html>
