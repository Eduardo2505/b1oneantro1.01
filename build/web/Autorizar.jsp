<%-- 
    Document   : Autorizar
    Created on : 2/05/2013, 12:08:50 AM
    Author     : Eduardo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Autorizar</title>
        <%

            String idMesaVenta = request.getParameter("idMesaVenta");
            String idComanda = request.getParameter("idComanda");

            String tipo = request.getParameter("tipo");
            //&observa=\"\"&autorizacion=\"\"
%>

        <script src="js/jquery-1.7.2.min.js"></script>

        <!-- ================================Los styles =============================== -->
        <link href="assets/css/bootstrap.css" rel="stylesheet">

        <style type="text/css">
            body {
                padding-top: 40px;
                padding-bottom: 40px;
                background-color: #f5f5f5;
            }

            .form-signin {
                max-width: 300px;
                padding: 19px 29px 29px;
                margin: 0 auto 20px;
                background-color: #fff;
                border: 1px solid #e5e5e5;
                -webkit-border-radius: 5px;
                -moz-border-radius: 5px;
                border-radius: 5px;
                -webkit-box-shadow: 0 1px 2px rgba(0,0,0,.05);
                -moz-box-shadow: 0 1px 2px rgba(0,0,0,.05);
                box-shadow: 0 1px 2px rgba(0,0,0,.05);
            }
            .form-signin .form-signin-heading,
            .form-signin .checkbox {
                margin-bottom: 10px;
            }
            .form-signin input[type="text"],
            .form-signin input[type="password"] {
                font-size: 16px;
                height: auto;
                margin-bottom: 15px;
                padding: 7px 9px;
            }

        </style>




        <link rel="stylesheet" type="text/css" href="css/jquery-ui-1.8.21.custom.css">
    </head>
    <body>
        <script type="text/javascript">
            $(function() {
                $('#from').submit(function() {
                    var data = $(this).serialize();
                    $('#cargar').html('<img src="img/ajax-loader.gif" alt=""/>').fadeOut(1000);
                    $.post('VerificarCortesia', data, function(respuesta) {
                        var verir = "<div class='ui-widget'><div class='ui-state-error ui-corner-all' style='padding: 0 .7em;'><p><span class='ui-icon ui-icon-alert' style='float: left; margin-right: .3em;'></span> <strong>Error:</strong> <br>NO TIENES AUTORIZACION</p></div>";

                        var inres = respuesta.length;
                        //alert(inres);
                        if (inres == 23) {

                            $('#pass').focus();
                            $('#cargar').fadeIn(1000).html(verir);
                        } else {
                            //var encodedUrl = encodeURIComponent(respuesta);
                          //  alert("SessionIdMesaComanda?idMesaVenta="+encodedUrl);
                            $(location).attr('href',"SessionIdMesaComanda?idMesaVenta="+respuesta);

                        }



                    });
                    return false;
                });
            });
        </script>

        <div class="container">

            <form class="form-signin" id="from">

                <input type="hidden" name="idMesaVenta" value="<% out.println(idMesaVenta);%>">
                <input type="hidden" name="idComanda" value="<% out.println(idComanda);%>">
                <input type="hidden" name="tipo" value="<% out.println(tipo);%>">
                <h2 class="form-signin-heading">AUTORIZACIÓN</h2>
                <input type="password" class="input-block-level"  required="" name="pass" id="pass" placeholder="Password">

                <textarea name="observa" style="width:290px" required ></textarea>
                <br>
                <button class="btn btn-large btn-primary" type="submit">Enviar</button>
                <a href="Comanda_venta.jsp" class="btn btn-large btn-danger">Regresar</a>
                <div id="cargar">


                </div>
            </form>


    </body>
    <script Language="JavaScript">

        $(document).ready(function() {
            if (history.forward(1)) {
                history.replace(history.forward(1));
                // alert("entro");
            }
        });
    </script>
</html>
