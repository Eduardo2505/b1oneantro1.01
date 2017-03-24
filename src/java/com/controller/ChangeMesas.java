/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.controller;

import com.dao.impl.MesasDaoImpl;
import com.mapping.Empleado;
import com.mapping.Mesas;
import com.mapping.Zona;
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
public class ChangeMesas extends HttpServlet {

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
        String idEpleado = request.getParameter("idEmpleado");
        //out.println(idEpleado);
        try {
            /* TODO output your page here. You may use following sample code. */
            out.println("<script language=\"javascript\">\n"
                    + "	 $(document).ready(function(){\n"
                    + "	   $(\".check_todos\").click(function(event){\n"
                    + "	     if($(this).is(\":checked\")) {\n"
                    + "		 	$(\".ck:checkbox:not(:checked)\").attr(\"checked\", \"checked\");\n"
                    + "		 }else{\n"
                    + "			 $(\".ck:checkbox:checked\").removeAttr(\"checked\");\n"
                    + "		 }\n"
                    + "	   });\n"
                    + "	 });\n"
                    + ""
                    + ""
                    + " $(document).ready(function() {\n"
                    + "                $('.pp').click(function() {\n"
                    + "\n"
                    + "                    var idmesa = $(this).val();\n"
                    + "                    var idEmpleado = $('#idempleado').val();\n"
                    + "                    var idZona = $('#idZona').val();\n"
                    + "                    \n"
                    + "                    var dataString = 'idMesa=' + idmesa + '&idempleado=' + idEmpleado + '&idZona=' + idZona + '&op=pp';\n"
                    + "\n"
                    + "\n"
                    + "                    //  alert(dataString);\n"
                    + "\n"
                    + "\n"
                    + "                    $.ajax({\n"
                    + "                        type: \"POST\",\n"
                    + "                        url: \"../AsigarMesaController\",\n"
                    + "                        data: dataString,\n"
                    + "                        success: function(data) {\n"
                    + "                            //  alert(data);\n"
                    + "                            $('#actualimesa').html(data);\n"
                    + "                            //  $('#verresultador').html(data);\n"
                    + "                        }\n"
                    + "                    });\n"
                    + "                    //}\n"
                    + "\n"
                    + "                }\n"
                    + "\n"
                    + "\n"
                    + "                );\n"
                    + "            });</script>");

            out.println("<div id='actualimesa'><form><table class=\"table table-striped\"><thead>\n"
                    + "                                <tr>\n"
                    + "                                    <th>idMesa</th>\n"
                    + "                                    <th>Tipo</th>\n"
                    + "                                    <th>Zona</th>\n"
                    + "                                    <th>Empleado</th>\n"
                    + "                                    <th>Activar<br>Seleccionar todos<br><input name=\"Todos\" type=\"checkbox\" value=\"1\" class=\"check_todos\"/></th>\n"
                    + "                                    <th>Abre y Cierra</th>\n"
                    + "\n"
                    + "                                </tr>\n"
                    + "                            </thead>\n"
                    + "                            <tbody>");
            MesasDaoImpl daom = new MesasDaoImpl();
            System.out.println(idEpleado);
            List resm = daom.getMesas("Activo",idEpleado);
            Iterator itrm = resm.iterator();
            Empleado e = new Empleado();
            Zona z = new Zona();

            while (itrm.hasNext()) {
                Mesas em = (Mesas) itrm.next();
                e = em.getEmpleado();
                z = em.getZona();
                System.out.println(em.getIdMesa()+" "+em.getTipo());
                String t = em.getTipo();
                if (t.equals("PP")) {
                    out.println("<tr><td>" + em.getIdMesa() + "</td><td>" + em.getTipo() + "</td><td>" + z.getIdzona() + "</td><td>" + e.getEmpleadocol() + "</td><td> <input name=\"elemento1\" type=\"checkbox\" name='categoria[]' value='" + em.getIdMesa() + "' class=\"ck\"/></td><td><input type='radio'  name='tipo' value='" + em.getIdMesa() + "' class='pp' checked></td></tr>");

                } else {
                    out.println("<tr><td>" + em.getIdMesa() + "</td><td>" + em.getTipo() + "</td><td>" + z.getIdzona() + "</td><td>" + e.getEmpleadocol() + "</td><td> <input name=\"elemento1\" type=\"checkbox\" name='categoria[]' value='" + em.getIdMesa() + "' class=\"ck\"/></td><td><input type='radio'  name='tipo' value='" + em.getIdMesa() + "' class='pp'></td></tr>");
                }


                //  System.out.println(em.getIdMesa());




            }



            out.println(" </tbody>\n"
                    + "                        </table></form></div>");
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
