<%-- 
    Document   : Productos
    Created on : 30/01/2013, 02:18:43 AM
    Author     : Eduardopc
--%>


<%@page import="com.mapping.Descuento"%>
<%@page import="com.dao.impl.DescuentoDaoImpl"%>
<%@page import="com.mapping.Altadia"%>
<%@page import="com.mapping.Empleado"%>
<%@page import="com.mapping.Producto"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="com.dao.impl.ProductoDaoImpl"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

    </head>
    <body>
        <%
            String idCategoria = request.getParameter("idCategoria");
            String tipo = request.getParameter("tipo");
            ProductoDaoImpl dao = new ProductoDaoImpl();
            List res = null;
            HttpSession sesion = request.getSession();
            Empleado e = new Empleado();
            Altadia d = new Altadia();
            String nombre = "", nomMesero = "", tipoEvento = "";
            e = (Empleado) sesion.getAttribute("id");
            String idMesero = "", idMesa = "", idComanda = "";
            int idDia = 0;


            if (e == null) {
                response.sendRedirect("index.jsp");
            } else {
                nombre = e.getNombre() + " " + e.getApellidos();
                Empleado em = new Empleado();
                idComanda = (String) sesion.getAttribute("idComanda");
                idMesa = (String) sesion.getAttribute("idMesa");
                em = (Empleado) sesion.getAttribute("idMesero");
                nomMesero = em.getNombre() + " " + em.getApellidos();
                d = (Altadia) sesion.getAttribute("idDia");
                idMesero = em.getIdEmpleado();
                idDia = d.getIdaltadia();
                tipoEvento = d.getTipoEvento();
                //out.println(idMesa);
                if (idCategoria.equals("") && tipo.equals("")) {

                    res = dao.getBuscar("", tipoEvento);



                } else {

                    res = dao.getFiltro(idCategoria, tipo, tipoEvento, "");
                }

            }
           
        %>
        <style>
            #sortable { list-style-type: none; margin: 0; padding: 0; width: 100%; }
            #sortable li { margin: 3px 3px 3px 0; padding: 1px; float: left; width: 140px; height: 120px; font-size: 1em; text-align: center; }

            div.bordesolido{ 
                border: 1px solid #aaaaaa; 
            }
        </style>
        <script type="text/javascript">           
            
   
            $(document).ready(function() {	
                $('#NombreProducto').keyup(function(){
                   
                    var user = $(this).val();
                    //  alert(user);
                    var idCategoria = $('#idCategoria').val();
                    var tipo = $('#tipo').val();
                    var dataString ='NombreProducto='+user+'&tipo='+tipo+'&idCategoria='+idCategoria;
                    //var dataString ='NombreProducto='+user;
                    //alert(user);
                    
                    if(user!=""){
                        $('#verResultadoBuscados').html('<img src="img/ajax-loader.gif" alt=""/>');
                        $.ajax({
                            type: "POST",
                            url: "BuscarProductoController",
                            data: dataString,
                            success: function(data) {
                                //alert(data)
              
                                $('#verResultadoBuscados').fadeIn(500).html(data);
                
                                //	 response.sendRedirect("index.jsp");	
                                //alert(data);
                            }
                        });
                        //}
                    }}
        
    
            );              
            });
            
            
            //regresar de nuvo............
            $(document).ready(function() {
                $("#Regresar_comandaVenta").click(function(event) {
                                            
                    var idCargoria = $(this).attr("title");
                    //alert(idCargoria)
                    $("#div_mostrar").load(idCargoria);
                });
            });
            
            //Agregar producto a comanda
            $(document).ready(function() {
                $(".addProducto").click(function(event) {
                    var idDescuento=$('#porcentaje').val(); 
                    // alert(idDescuento);
                    var idCargoria = $(this).attr("title");
                    //alert(idCargoria)
                    $("#ComandaVirtual").load(idCargoria+idDescuento);
                });
            });
        </script>
        <div align="center" >
            <table style="width:100%;text-align:center">
                <tr><td>

                    </td><td>
                        <label class="label-warning">
                            <h2>Descuento</h2> <select id="porcentaje" style="width:150px">
                                <option value="Ninguno">Ninguno</option>
                                <%
                                    DescuentoDaoImpl daod = new DescuentoDaoImpl();
                                    List resd = daod.getVer();
                                    Iterator itrd = resd.iterator();
                                    while (itrd.hasNext()) {
                                        Descuento des = (Descuento) itrd.next();

                                        if (des.getPorcentaje() != 100) {
                                            out.println(" <option value='" + des.getIdDescuento() + "'>" + des.getPorcentaje() + "%</option>");
                                            //System.out.println(des.getPorcentaje());
                                        }



                                    }

                                %>
                            </select>

                        </label>


                    </td><td>
                        <label class="label-warning">  
                            <h2>Buscador</h2> 
                            <input type="hidden" value="<% out.println(idCategoria);%>" id="idCategoria">
                            <input type="hidden" value="<% out.println(tipo);%>" id="tipo">
                            <input type="text" id="NombreProducto"  class="input-medium search-query"   placeholder="Búscar...'todo'"></td>

                            </table>
                            </td></tr>
                            </table>






                            </div>
                            <div align="center" id="verResultadoBuscados">

                                <ul id="sortable" >
                                    <%

                                        if (idComanda.equals("VER")) {
                                            
                                           out.println("<div class=\"alert alert-block\">\n" +
"            \n" +
"            <h4>MODO \"VER\"</h4>\n" +
"            Esta en modo <b>VER</b> así que sólo podra ver la cuenta y consultar los precios de los productos.\n" +
"        </div>");
                                             Iterator itr = res.iterator();
                                            while (itr.hasNext()) {
                                                Producto p = (Producto) itr.next();
                                                // System.out.println(p.getIdProducto() + p.getNombre());
                                                p.setIdProducto(p.getIdProducto());

                                                //System.out.println(pre.getCosto());

                                                out.print("<li class='ui-state-default'><a class='addProducto'>" + p.getIdProducto() + "<br><h3>" + p.getNombre() + "</h3><br>$" + p.getPrecio() + "</a></li>");

                                            }
                                        } else {

                                            Iterator itr = res.iterator();
                                            while (itr.hasNext()) {
                                                Producto p = (Producto) itr.next();
                                                // System.out.println(p.getIdProducto() + p.getNombre());
                                                p.setIdProducto(p.getIdProducto());

                                                //System.out.println(pre.getCosto());

                                                out.print("<li class='ui-state-default'><a class='addProducto' href='#' title='addVirtual?idProducto=" + p.getIdProducto() + "&idDescuento='>" + p.getIdProducto() + "<br><h3>" + p.getNombre() + "</h3><br>$" + p.getPrecio() + "</a></li>");

                                            }

                                        }


                                    %>



                                </ul>



                            </div>
                            </body>
                            </html>
