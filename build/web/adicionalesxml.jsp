<%-- 
    Document   : adicionalesxml
    Created on : 4/04/2015, 03:34:36 AM
    Author     : Eduardo
--%>

<%@page import="beans.Adicionalesbean"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.dao.impl.AdicionalesComprobarDaoImpl"%>
<%@page import="org.jdom.Element"%>
<%@page import="java.util.List"%>
<%@page import="jdom.jdom"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String ruta = getServletContext().getRealPath("/");
    jdom jdomdao = new jdom();
    String idProducto = request.getParameter("idProducto");

    String rutita = ruta + "/config/" + idProducto + ".xml";
    // jdomdao.crear(rutita);
    String estadob = jdomdao.Buscar(rutita, "estado", "promo_botellas");
    String stdocerveza = jdomdao.Buscar(rutita, "estado", "cervezas");
    String stdocomida = jdomdao.Buscar(rutita, "estado", "comida_config");
    String estadorefres = jdomdao.Buscar(rutita, "estado", "promo_refrescos");
    String estadojugo = jdomdao.Buscar(rutita, "estado", "promo_jugo");

    String estadojarra = jdomdao.Buscar(rutita, "estado", "promo_jarra");
    String promo_refrsp2 = jdomdao.Buscar(rutita, "estado", "promo_refrsp2");
    String promo_hene = jdomdao.Buscar(rutita, "estado", "promo_hene");






    HttpSession sesion = request.getSession();

//Integer.parseInt(request.getParameter("idventa"));

    int idventa = (Integer) sesion.getAttribute("idventaVer");
%>
<script src="js/jquery-1.7.2.min.js"></script>
<script type="text/javascript">

    $(document).ready(function() {
        $('.enviarfrom').submit(function() {
            var data = $(this).serialize();
            // alert(data);
            $("#resultado").html("<h1>VERIFICANDO ....</h2>");
            $.post('adicionalesControlerxml', data, function(respuesta) {
                var inres = respuesta.length;
                if (inres != 0) {
                    $("#resultado").html("");
                    $("#ComandaVirtual").html(respuesta);

                } else {
                    $("#resultado").html("<h1>NO SE PUEDE REALIZAR ESTA OPERACION</h2>");

                }

            });
            return false;
        });
    });



    $(document).ready(function() {
        $('#regresar').click(function() {
            $("#menuproductos").show();
            $("#adicionalemenu").html("");

            return false;
        });
    });

</script>
<!--
<script type="text/javascript">

    $(document).ready(function() {
        $('.addAdicionales').click(function() {
            var idproducto = $(this).attr("name");
            var idventa = $(this).val();
            var dataString = 'idProducto=' + idproducto + '&idventa=' + idventa;
            $.ajax({
                type: "POST",
                url: "comprobarcomandaadicional",
                data: dataString,
                success: function(data) {
                    var inres = data.length;
                    //alert(inres)
                    if (inres != 0) {
                        $("#menuproductos").hide();

                        var urla = "adicionalesxml.jsp?idProducto=" + idproducto;

                        $("#adicionalemenu").fadeIn(800).load(urla);

                    }
                    return false;
                }

            });

            return false;
        });

    });
</script>
<!--

<script type="text/javascript">

    $(document).ready(function() {
        $('.addProducto').click(function() {
            var idDescuento = $('#porcentaje').val();
            var tipro = $('#porcentaje').val();
            var idCargoria = $(this).attr("title");
            var idproducto = $(this).attr("name");
            var dataString = 'idProducto=' + idproducto + '&idventa=';
            //$("#ComandaVirtual").load();
            $('#adicionalemenu').html("<img src=\"img/ajax-loader.gif\" />").fadeOut(800);
            var dataStringx = idCargoria + idDescuento;
           
            $.ajax({
                type: "POST",
                url: "addVirtual",
                data: dataStringx,
                success: function(data) {
                    $("#ComandaVirtual").html(data);
                    $.ajax({
                        type: "POST",
                        url: "comprobarArchivo",
                        data: dataString,
                        success: function(data) {
                            var inres = data.length;
                            //alert(inres)
                            if (inres != 0) {
                                $("#menuproductos").hide();

                                var urla = "adicionalesxml.jsp?idProducto=" + idproducto;

                                $("#adicionalemenu").fadeIn(800).load(urla);

                            }
                            return false;
                        }

                    });
                    return false;
                }

            });

            return false;
        });

    });
</script>


-->
<table class="table table-striped">
    <tr>
        <% if (estadob.equals("Activo")) {
                String limiteb = jdomdao.Buscar(rutita, "limite", "promo_botellas");
                String clasebote = jdomdao.Buscar(rutita, "clase", "promo_botellas");
                String id = jdomdao.Buscar(rutita, "id", "promo_botellas");
                StringBuffer pro = new StringBuffer();
                pro.append("IN (");
        %>
        <td>
            <h4>Botellas</h4>
            <h5><%=limiteb%></h5>
            <form class="enviarfrom">
                <input type="hidden" name="limite" value="<%=limiteb%>">
                <input type="hidden" name="clase" value="<%=clasebote%>">
                <input type="hidden" name="idclase" value="<%=id%>">
                <input type="hidden" name="idventa" value="<%=idventa%>">
                <select name="productos" required="" class="form-control">
                    <option value="">Seleccione</option>
                    <%
                        List list = jdomdao.mostrarPro(rutita, "botella");
                        for (int i = 0; i < list.size(); i++) {

                            Element node = (Element) list.get(i);
                            out.println(" <option value=\"" + node.getChildText("id") + "\">" + node.getChildText("nombre") + "</option>");

                            pro.append("'" + node.getChildText("id") + "',");





                        }
                    %>
                </select><br><br>
                <%
                    pro.append("'')");
                %>


                <input type="hidden" name="productoin" value="<%=pro.toString()%>">
                <input type="submit" class="btn btn-info" value="Agregar">
            </form>
        </td>
        <% }%>




        <% if (stdocerveza.equals("Activo")) {
                String limitecevrza = jdomdao.Buscar(rutita, "limite", "cervezas");
                String classcevrza = jdomdao.Buscar(rutita, "clase", "cervezas");
                String id = jdomdao.Buscar(rutita, "id", "cervezas");
                StringBuffer proc = new StringBuffer();
                proc.append("IN (");
        %>
        <td>
            <h4>Cervezas</h4>
            <h5><%=limitecevrza%></h5>
            <form class="enviarfrom">
                <input type="hidden" name="limite" value="<%=limitecevrza%>">
                <input type="hidden" name="clase" value="<%=classcevrza%>">
                <input type="hidden" name="idclase" value="<%=id%>">
                <input type="hidden" name="idventa" value="<%=idventa%>">
                <select name="productos" required="" class="form-control">
                    <option value="">Seleccione</option>
                    <%
                        List list = jdomdao.mostrarPro(rutita, "cerveza");
                        for (int i = 0; i < list.size(); i++) {

                            Element node = (Element) list.get(i);
                            out.println(" <option value=\"" + node.getChildText("id") + "\">" + node.getChildText("nombre") + "</option>");



                            proc.append("'" + node.getChildText("id") + "',");
                        }
                    %>
                </select><br><br>
                <%
                    proc.append("'')");
                %>
                <input type="hidden" name="productoin" value="<%=proc.toString()%>">
                <input type="submit" class="btn btn-info" value="Agregar">
            </form>
        </td>
        <% }%>


        
            <% if (estadojarra.equals("Activo")) {
                    String limiteb = jdomdao.Buscar(rutita, "limite", "promo_jarra");
                    String clasebote = jdomdao.Buscar(rutita, "clase", "promo_jarra");
                    String id = jdomdao.Buscar(rutita, "id", "promo_jarra");
                    StringBuffer pro = new StringBuffer();
                    pro.append("IN (");
            %>
            <td>
            <h4>Jarras</h4>
            <h5><%=limiteb%></h5>
            <form class="enviarfrom">
                <input type="hidden" name="limite" value="<%=limiteb%>">
                <input type="hidden" name="clase" value="<%=clasebote%>">
                <input type="hidden" name="idclase" value="<%=id%>">
                <input type="hidden" name="idventa" value="<%=idventa%>">
                <select name="productos" required="" class="form-control">
                    <option value="">Seleccione</option>
                    <%
                        List list = jdomdao.mostrarPro(rutita, "jarra");
                        for (int i = 0; i < list.size(); i++) {

                            Element node = (Element) list.get(i);
                            out.println(" <option value=\"" + node.getChildText("id") + "\">" + node.getChildText("nombre") + "</option>");

                            pro.append("'" + node.getChildText("id") + "',");





                        }
                    %>
                </select><br><br>
                <%
                    pro.append("'')");
                %>


                <input type="hidden" name="productoin" value="<%=pro.toString()%>">
                <input type="submit" class="btn btn-info" value="Agregar">
            </form>
                </td>
            <% }%>
        
        
            <% if (promo_refrsp2.equals("Activo")) {
                    String limiteb = jdomdao.Buscar(rutita, "limite", "promo_refrsp2");
                    String clasebote = jdomdao.Buscar(rutita, "clase", "promo_refrsp2");
                    String id = jdomdao.Buscar(rutita, "id", "promo_refrsp2");
                    StringBuffer pro = new StringBuffer();
                    pro.append("IN (");
            %>
            <td>
            <h4>RefrescoPromo</h4>
            <h5><%=limiteb%></h5>
            <form class="enviarfrom">
                <input type="hidden" name="limite" value="<%=limiteb%>">
                <input type="hidden" name="clase" value="<%=clasebote%>">
                <input type="hidden" name="idclase" value="<%=id%>">
                <input type="hidden" name="idventa" value="<%=idventa%>">
                <select name="productos" required="" class="form-control">
                    <option value="">Seleccione</option>
                    <%
                        List list = jdomdao.mostrarPro(rutita, "refresco");
                        for (int i = 0; i < list.size(); i++) {

                            Element node = (Element) list.get(i);
                            out.println(" <option value=\"" + node.getChildText("id") + "\">" + node.getChildText("nombre") + "</option>");


                            pro.append("'" + node.getChildText("id") + "',");


                        }
                    %>
                </select><br><br>
                <%
                    pro.append("'')");
                %>


                <input type="hidden" name="productoin" value="<%=pro.toString()%>">
                <input type="submit" class="btn btn-info" value="Agregar">
            </form>
                </td>
            <% }%>
            
             <% if (promo_hene.equals("Activo")) {
                    String limiteb = jdomdao.Buscar(rutita, "limite", "promo_hene");
                    String clasebote = jdomdao.Buscar(rutita, "clase", "promo_hene");
                    String id = jdomdao.Buscar(rutita, "id", "promo_hene");
                    StringBuffer pro = new StringBuffer();
                    pro.append("IN (");
            %>
            <td>
            <h4>Heninekken</h4>
            <h5><%=limiteb%></h5>
            <form class="enviarfrom">
                <input type="hidden" name="limite" value="<%=limiteb%>">
                <input type="hidden" name="clase" value="<%=clasebote%>">
                <input type="hidden" name="idclase" value="<%=id%>">
                <input type="hidden" name="idventa" value="<%=idventa%>">
                <select name="productos" required="" class="form-control">
                    <option value="CER-ON401"> Heineken</option>
                   
                </select><br><br>
                <%
                    pro.append("'')");
                %>


                <input type="hidden" name="productoin" value="<%=pro.toString()%>">
                <input type="submit" class="btn btn-info" value="Agregar">
            </form>
                </td>
            <% }%>
        
    </tr>
    <tr>
        <td>
            <% if (estadorefres.equals("Activo")) {
                    String limite = jdomdao.Buscar(rutita, "limite", "promo_refrescos");
                    String clase = jdomdao.Buscar(rutita, "clase", "promo_refrescos");
                    String id = jdomdao.Buscar(rutita, "id", "promo_refrescos");
                    String combinar = jdomdao.Buscar(rutita, "limite_jugos", "promo_refrescos");
                    StringBuffer procc = new StringBuffer();
                    procc.append("IN (");



            %>
            <h4>REFRESCOS</h4>
            <h5><%=limite%></h5>
            <form class="enviarfrom">
                <input type="hidden" name="clase" value="<%=clase%>">
                <input type="hidden" name="limite" value="<%=limite%>">
                <input type="hidden" name="idclase" value="<%=id%>">
                <input type="hidden" name="idventa" value="<%=idventa%>">
                <input type="hidden" name="combinar" value="<%=combinar%>">
                <select name="productos" required="" class="form-control">
                    <option value="">Seleccione</option>
                    <%
                        List list = jdomdao.mostrarPro(rutita, "refresco");
                        for (int i = 0; i < list.size(); i++) {

                            Element node = (Element) list.get(i);
                            out.println(" <option value=\"" + node.getChildText("id") + "\">" + node.getChildText("nombre") + "</option>");


                            procc.append("'" + node.getChildText("id") + "',");


                        }
                    %>
                </select><br><br>
                <%
                    procc.append("'')");
                %>
                <input type="hidden" name="productoin" value="<%=procc.toString()%>">
                <input type="submit" class="btn btn-info" value="Agregar">
            </form>
            <% }%>
        </td><td>
            <% if (estadojugo.equals("Activo")) {
                    String limite = jdomdao.Buscar(rutita, "limite", "promo_jugo");
                    String clase = jdomdao.Buscar(rutita, "clase", "promo_jugo");
                    String idx = jdomdao.Buscar(rutita, "id", "promo_jugo");

                    String combinar = jdomdao.Buscar(rutita, "limite_refre", "promo_jugo");
                    StringBuffer procc = new StringBuffer();
                    procc.append("IN (");



            %>
            <h4>JUGOS</h4>
            <h5><%=limite%></h5>

            <form class="enviarfrom">

                <input type="hidden" name="clase" value="<%=clase%>">
                <input type="hidden" name="limite" value="<%=limite%>">
                <input type="hidden" name="idclase" value="<%=idx%>">
                <input type="hidden" name="idventa" value="<%=idventa%>">
                <input type="hidden" name="combinar" value="<%=combinar%>">
                <select name="productos" required="" class="form-control">
                    <option value="">Seleccione</option>
                    <%
                        List list = jdomdao.mostrarPro(rutita, "jugo");
                        for (int i = 0; i < list.size(); i++) {

                            Element node = (Element) list.get(i);
                            out.println(" <option value=\"" + node.getChildText("id") + "\">" + node.getChildText("nombre") + "</option>");


                            procc.append("'" + node.getChildText("id") + "',");


                        }
                    %>
                </select><br><br>
                <%
                    procc.append("'')");
                %>
                <input type="hidden" name="productoin" value="<%=procc.toString()%>">
                <input type="submit" class="btn btn-info" value="Agregar">
            </form>
            <% }%>
        </td><td></td></tr>
    <tr><td>

            <% if (stdocomida.equals("Activo")) {
                    String limitecomida = jdomdao.Buscar(rutita, "limite", "comida_config");
                    String classcomida = jdomdao.Buscar(rutita, "clase", "comida_config");
                    String id = jdomdao.Buscar(rutita, "id", "comida_config");
                    StringBuffer procc = new StringBuffer();
                    procc.append("IN (");
            %>
            <h4>Comida</h4>
            <h5><%=limitecomida%></h5>
            <form class="enviarfrom">
                <input type="hidden" name="clase" value="<%=classcomida%>">

                <input type="hidden" name="limite" value="<%=limitecomida%>">
                <input type="hidden" name="idclase" value="<%=id%>">
                <input type="hidden" name="idventa" value="<%=idventa%>">
                <select name="productos" required="" class="form-control">
                    <option value="">Seleccione</option>
                    <%
                        List list = jdomdao.mostrarPro(rutita, "comida");
                        for (int i = 0; i < list.size(); i++) {

                            Element node = (Element) list.get(i);
                            out.println(" <option value=\"" + node.getChildText("id") + "\">" + node.getChildText("nombre") + "</option>");

                            procc.append("'" + node.getChildText("id") + "',");


                        }
                    %>
                </select><br><br>
                <%
                    procc.append("'')");
                %>
                <input type="hidden" name="productoin" value="<%=procc.toString()%>">
                <input type="submit" class="btn btn-info" value="Agregar">
            </form>
            <% }%>

        </td><td>



        </td></tr>

</table>


<div id="resultado">


</div>
<br>
<button id="regresar" class="btn btn-danger btn-large btn-lg"><h2>REGRESAR</h2></button>