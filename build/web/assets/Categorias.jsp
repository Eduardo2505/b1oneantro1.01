<%-- 
    Document   : Categorias
    Created on : 29/01/2013, 08:26:48 PM
    Author     : Eduardopc
--%>

<%@page import="com.mapping.Categoria"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="com.dao.impl.CategoriaDaoImpl"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%

            String tipo = request.getParameter("tipo");

           // out.println(tipo);
        %>
        <script src="js/jquery-1.7.2.min.js"></script>
        <script src="js/jquery-ui-1.8.21.custom.min.js"></script>
        <script type="text/javascript">

            $(document).ready(function() {
                $(".idCate").click(function(event) {
                    var idCargoria = $(this).attr("title");                  
                    //alert(idCargoria)
                    $("#div_mostrar").load(idCargoria);
                });
            });
                                   
                      
        </script>
        <style>
            #sortable { list-style-type: none; margin: 0; padding: 0; width: 100%; }
            #sortable li { margin: 3px 3px 3px 0; padding: 1px; float: left; width: 160px; height: 130px; font-size: 1em; text-align: center; }


        </style>
        <div align="center" id="mostrarBuscador">
            <ul id="sortable">
                <%

                    CategoriaDaoImpl dao = new CategoriaDaoImpl();

                    List res = dao.getFiltro();
                    Iterator itr = res.iterator();
                    while (itr.hasNext()) {
                        Categoria c = (Categoria) itr.next();

                        //   System.out.println(c.getIdCategoria() + "\n" + c.getDescripcion());
                        out.print("<li class='ui-state-default'><a href='#' class='idCate' title='Productos.jsp?idCategoria=" + c.getIdCategoria() + "&tipo=" + tipo + "'><h3>" + c.getIdCategoria() + "</h3><br>" + c.getDescripcion() + "</a></li>");

                    }




                %>



            </ul>



        </div>
    </body>
</html>
