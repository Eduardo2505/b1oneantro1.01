/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.controller;

import com.dao.impl.ProductoBeanDaoImpl;
import com.dao.impl.ProductoDaoImpl;
import com.mapping.Altadia;

import com.mapping.Producto;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Eduardopc
 */
public class BuscarProductoController extends HttpServlet {

    /**
     * Processes requests for both HTTP
     * <code>GET</code> and
     * <code>POST</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();


        String nomproducto = request.getParameter("NombreProducto").toLowerCase().trim();
        Altadia d = new Altadia();
        HttpSession sesion = request.getSession();
        d = (Altadia) sesion.getAttribute("idDia");
        String idComanda = (String) sesion.getAttribute("idComanda");
        String tipoEvento = d.getTipoEvento();
        int idpuesto = Integer.parseInt((String) sesion.getAttribute("idpuesto"));


        try {


            //     System.out.println("Buscos..."+nomproducto);
          /*  if (idCategoria.length() == 1) {
             idCategoria = "";
             }
             if (tipo.length() == 1) {
             tipo = "";
             }
             if (nomproducto.equals("todo")) {
             nomproducto = "";
             }*/
            //String idCategoria, String tipo, String tipoEvento, String nomproducto
            out.println("<script type=\"text/javascript\">\n" +
"\n" +
"    $(document).ready(function() {\n" +
"        $('.addProducto').click(function() {\n" +
"            var idDescuento = $('#porcentaje').val();\n" +
"            var tipro = $('#porcentaje').val();\n" +
"            var idCargoria = $(this).attr(\"title\");\n" +
"            var idproducto = $(this).attr(\"name\");\n" +
"            var dataString = 'idProducto=' + idproducto + '&idventa=';\n" +
"            //$(\"#ComandaVirtual\").load();\n" +
"            $('#adicionalemenu').html(\"<img src=\\\"img/ajax-loader.gif\\\" />\").fadeOut(100);\n" +
"            var dataStringx = idCargoria + idDescuento;\n" +
"           \n" +
"            $.ajax({\n" +
"                type: \"POST\",\n" +
"                url: \"addVirtual\",\n" +
"                data: dataStringx,\n" +
"                success: function(data) {\n" +
"                    $(\"#ComandaVirtual\").html(data);\n" +
"                    $.ajax({\n" +
"                        type: \"POST\",\n" +
"                        url: \"comprobarArchivo\",\n" +
"                        data: dataString,\n" +
"                        success: function(data) {\n" +
"                            var inres = data.length;\n" +
"                            //alert(inres)\n" +
"                            if (inres != 0) {\n" +
"                                $(\"#menuproductos\").hide();\n" +
"\n" +
"                                var urla = \"adicionalesxml.jsp?idProducto=\" + idproducto;\n" +
"\n" +
"                                $(\"#adicionalemenu\").fadeIn(100).load(urla);\n" +
"\n" +
"                            }\n" +
"                            return false;\n" +
"                        }\n" +
"\n" +
"                    });\n" +
"                    return false;\n" +
"                }\n" +
"\n" +
"            });\n" +
"\n" +
"            return false;\n" +
"        });\n" +
"\n" +
"    });\n" +
"</script>");
            out.println(" <ul id=\"sortable\" >");

            ProductoBeanDaoImpl dao = new ProductoBeanDaoImpl();
            //out.println(op);
            List res = null;
            //System.out.println(tipoEvento+"--->"+ nomproducto);
            res = dao.getFiltro(tipoEvento, nomproducto, "");
            //  out.println("entro");


            // List res = dao.getFiltro(idCategoria, tipo, tipoEvento, nomproducto);




            Iterator itr = res.iterator();

            while (itr.hasNext()) {
                Producto p = (Producto) itr.next();
                String validador = (String) p.getHorarioinicial();
                if (validador == null || validador.equals("")) {
                    out.print("<li class='ui-state-default'><a class='addProducto' name='" + p.getIdProducto() + "' href='#' title='idProducto=" + p.getIdProducto() + "&precio="+p.getPrecio()+"&idDescuento='>" + p.getIdProducto() + "<br><h4>" + p.getNombre() + "</h4>" + p.getTamano() + " "+p.getMedida()+"<br>$" + p.getPrecio() + "</a></li>");
                } else {
                    Date ahora = new Date();
                    SimpleDateFormat dateFormat = new SimpleDateFormat("HH:mm:ss");
                    String horaNueva = dateFormat.format(ahora);
                    String hora1 = p.getHorarioinicial();
                    String hora2 = p.getHorariofinal();
                    Date date1, date2, dateNueva;
                    date1 = dateFormat.parse(hora1);
                    date2 = dateFormat.parse(hora2);
                    dateNueva = dateFormat.parse(horaNueva);

                    if ((date1.compareTo(dateNueva) <= 0) && (date2.compareTo(dateNueva) >= 0)) {

                        out.print("<li class='ui-state-default'><a class='addProducto' name='" + p.getIdProducto() + "'  href='#' title='idProducto=" + p.getIdProducto() + "&precio="+p.getPrecio()+"&idDescuento='>" + p.getIdProducto() + "<br><h4>" + p.getNombre() + "</h4>" + p.getTamano() + " "+p.getMedida()+"<br>$" + p.getPrecio() + "</a></li>");
                    }


                }


                //out.print("<li class='ui-state-default'><a class='addProducto' href='#' title='addVirtual?idProducto=" + p.getIdProducto() + "&idDescuento='>" + p.getIdProducto() + "<br><h3>" + p.getNombre() + "</h3><br>$" 1+ p.getPrecio() + "</a></li>");

            }


            out.println("</ul>");
//pre.getCosto()

        } catch (ParseException ex) {
            Logger.getLogger(BuscarProductoController.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            out.close();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP
     * <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP
     * <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
