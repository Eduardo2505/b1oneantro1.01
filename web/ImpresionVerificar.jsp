<%-- 
    Document   : ImpresionVerificar
    Created on : 18/07/2013, 01:46:13 AM
    Author     : Eduardo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="js/jquery-1.7.2.min.js"></script>
        <script src="js/jquery-ui-1.8.21.custom.min.js"></script>
        <script src="js/jquery.alerts.js"></script>        
        <link rel="stylesheet" type="text/css" href="js/jquery.alerts.css">
        <title>Impresión</title>
         <script type="text/javascript">
            function imprSelec(muestra)
            {

                jAlert("Imprimir", "ImprimeCopia", function(r) {
                    if (r) {
                        $(location).attr('href', "tikeComandaCopia.jsp");
                    }
                });

            }



        </script> 
    </head>
    <body onload="javascript:imprSelec('muestra')">
       
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
