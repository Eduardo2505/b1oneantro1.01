/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.controller;

import com.dao.impl.CategoriaDaoImpl;
import com.dao.impl.ProductoDaoImpl;
import com.mapping.Categoria;
import com.mapping.Producto;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Eduardo
 */
public class ProductoController extends HttpServlet {

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
        String idpro = request.getParameter("idpro");
        ProductoDaoImpl daop = new ProductoDaoImpl();
        Producto p = new Producto();

        p = daop.getBuscar(idpro);

        String checbotella = "", checopa = "", checotro = "";
        if (p.getTipo().equals("Botella")) {
            checbotella = "selected";
        } else if (p.getTipo().equals("Copa")) {
            checopa = "selected";
        } else {
            checotro = "selected";
        }
        Categoria pb = new Categoria();
        pb = p.getCategoria();

        try {
            out.println("<script type=\"text/javascript\">\n"
                    + "                                            $(function() {\n"
                    + "                                                $('#Actualizar').submit(function() {\n"
                    + "                                                    var data = $(this).serialize();"
                    + "\n"
                    + "\n"
                    + "                                                    $.post('../ActualizarProducto', data, function(respuesta) {\n"
                    + "                                                        // alert(respuesta);\n"
                    + "\n"
                    + "                                                        jAlert(\"Se Actializo correctamente\", \"Confirmación\", function(r) {\n"
                    + "                                                            if (r) {\n"
                    + "                                                                 $(location).attr('href','NuevProducto.jsp');\n"
                    + "                                                              \n"
                    + "                                                                \n"
                    + "                                                            }\n"
                    + "                                                        });\n"
                    + "\n"
                    + "\n"
                    + "\n"
                    + "\n"
                    + "                                                    });\n"
                    + "                                                    return false;\n"
                    + "                                                });\n"
                    + "                                            });\n"
                    + "\n"
                    + "\n"
                    + "                                        </script>");
            /* TODO output your page here. You may use following sample code. */
            out.println(" <form id=\"Actualizar\">"
                    + "<input type=\"hidden\" name=\"idProducto\" value=\"" + p.getIdProducto() + "\">\n"
                    + "                                Nombre:<input type=\"text\" id=\"nomr\" value='" + p.getNombre() + "' name=\"nompro\" required=\"\"> <br>\n"
                    + "                                Tipo<select name=\"tipo\" required=\"\">\n"
                    + "                                    <option value=\"\">Seleccionar</option>\n"
                    + "                                    <option value=\"Botella\" " + checbotella + ">Botella</option>\n"
                    + "                                    <option value=\"Copa\" " + checopa + ">Copa</option>\n"
                    + "                                    <option value=\"Otro\" " + checotro + ">Otro</option>\n"
                    + "                                </select><br>\n"
                    + "                                Tamaño<input type=\"text\" value='" + p.getTamano() + "' name=\"tamano\" onkeypress=\"return isNumberKey(event)\" required> <br>");
            String o1 = "", o2 = "", o3 = "", o4 = "", o5 = "";
            if (p.getMedida().equals("lt")) {
                o1 = "selected";
            } else if (p.getMedida().equals("ml")) {
                o2 = "selected";
            } else if (p.getMedida().equals("kg")) {
                o3 = "selected";
            } else if (p.getMedida().equals("pz")) {
                o4 = "selected";
            } else {
                o5 = "selected";
            }
            out.println(" <select name=\"medida\" required=\"\">\n"
                    + "                                        <option value=\"\">Medida</option>\n"
                    + "                                        <option value=\"lt\" " + o1 + ">lt</option>\n"
                    + "                                        <option value=\"ml\" " + o2 + ">ml</option>\n"
                    + "                                        <option value=\"kg\" " + o3 + ">kg</option>\n"
                    + "                                        <option value=\"pz\" " + o4 + ">pz</option>\n"
                    + "                                        <option value=\"g\" " + o5 + ">g</option>\n"
                    + "                                    </select><br>");
            out.println("   Precio<input type=\"text\" name=\"precio\" value='" + p.getPrecio() + "' onkeypress=\"return isNumberKey(event)\" required> <br>\n"
                    + "                                <select name=\"categoria\" required=\"\">\n"
                    + "                                    <option value=\"\">Seleccionar</option>");
            CategoriaDaoImpl dao = new CategoriaDaoImpl();
            List res = dao.getFiltro();
            Iterator itr = res.iterator();
            while (itr.hasNext()) {
                Categoria c = (Categoria) itr.next();
                if (c.getIdCategoria().equals(pb.getIdCategoria())) {
                    out.println("<option selected value='" + c.getIdCategoria() + "'>" + c.getIdCategoria() + "</option>");
                } else {
                    out.println("<option value='" + c.getIdCategoria() + "'>" + c.getIdCategoria() + "</option>");
                }

            }

            out.println("</select><br>");
            String evenn = "", event = "";
            if (p.getTipoEvento().equals("Nocturno")) {
                evenn = "selected";
            } else {
                event = "selected";
            }

            out.println("                                <select name=\"opEvento\" required=\"\">\n"
                    + "                                    <option value=\"Nocturno\" " + evenn + ">Nocturno</option>\n"
                    + "                                    <option value=\"Tardeada\" " + event + ">Tardeada</option>\n"
                    + "                                </select><br>\n");

            String valor = p.getImportacion() == null ? "" : p.getImportacion();
            out.println("<select name=\"Importado\" >");
            if (valor.equals("Importados")) {
                out.println("imporatdddoooo");
                out.println(" <option value=\"\">---Seleccionar---</option>"
                        + "  <option  selected value=\"Importados\">Importados</option>\n"
                        + "                          <option value=\"Nacionales\">Nacionales</option>");
            } else if (valor.equals("Nacionales")) {
                out.println("Nacionales");
                out.println(" <option value=\"\">---Seleccionar---</option>"
                        + "  <option   value=\"Importados\">Importados</option>\n"
                        + "                          <option selected value=\"Nacionales\">Nacionales</option>");
            } else {
                out.println("Nacionales");
                out.println(" <option value=\"\">---Seleccionar---</option>"
                        + "  <option   value=\"Importados\">Importados</option>\n"
                        + " <option  value=\"Nacionales\">Nacionales</option>");

                
            }
            out.println("    </select><br>");
            String op1 = "", op2 = "";
            if (p.getOpcion().equals("np")) {
                op1 = "selected";
            } else {
                op2 = "selected";
            }
            out.println("***OPCION <br><select name=\"opcion\" required=\"\">\n" +
"                                        <option value=\"np\" "+op1+">NP</option>     \n" +
"                                        <option value=\"Adicional\" "+op2+">Adicional</option>\n" +
"                                    </select><br>");
            String es1 = "", es2 = "";
            if (p.getUrl().equals("1")) {
                es1 = "checked";
            } else {
                es2 = "checked";
            }
            out.println(" Estado <br>Activo <input type=\"radio\" name=\"estado\" value=\"1\" " + es1 + "> Inactivo <input type=\"radio\" name=\"estado\" " + es2 + " value=\"0\"><br>");
            out.println("                            <input type=\"submit\" value=\"Actualizar\"  class=\"btn btn-primary\"> <a href=\"NuevProducto.jsp\" class=\"btn btn-warning\">Cancelar</a>\n"
                    + "                            </form>");

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
