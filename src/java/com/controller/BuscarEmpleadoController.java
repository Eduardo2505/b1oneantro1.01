/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.controller;

import com.dao.impl.EmpleadoDaoImpl;
import com.mapping.Barra;
import com.mapping.Empleado;
import com.mapping.Puesto;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Eduardopc
 */
public class BuscarEmpleadoController extends HttpServlet {
//BuscarEmpleadoTotal
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String nombre = request.getParameter("NombreUserBuscar");
        Barra vb = new Barra();
        HttpSession sesion = request.getSession();
        String idBarra = (String) sesion.getAttribute("idBarra");

        if (nombre.equals("todo")) {
            nombre = "";
        }
        EmpleadoDaoImpl dao = new EmpleadoDaoImpl();
        Puesto pu = new Puesto();
        List res = null;
        Iterator itr = null;
        String estadov = "";
        Empleado e = new Empleado();
        try {
            out.println(" <div id=\"password\" class=\"reveal-modal\" style=\"text-align:center;width:320px\">\n" +
"                    <script>\n" +
"                        $(function() {\n" +
"                            $(\".val\").click(function(e) {\n" +
"                                e.preventDefault();\n" +
"                                if ($(\".outcome\").val().length < 4) {\n" +
"                                    var a = $(this).attr(\"href\");\n" +
"                                    $(\".screen\").append(a);\n" +
"                                    $(\".outcome\").val($(\".outcome\").val() + a);\n" +
"\n" +
"                                }\n" +
"\n" +
"                            });\n" +
"\n" +
"\n" +
"                            $(\".clear\").click(function() {\n" +
"                                $(\".outcome\").val(\"\");\n" +
"                                $(\".screen\").html(\"\");\n" +
"                            });\n" +
"\n" +
"                            $(\".close\").click(function() {\n" +
"                                $(\".cal\").css(\"display\", \"none\");\n" +
"                            })\n" +
"\n" +
"                            $(\".equal\").click(function() {\n" +
"                                var a = $(\".outcome\").val();\n" +
"                                var idemple = $(\"#idempleadowin\").val();\n" +
"                                var url = \"idMesero=\" + idemple + \"&clave=\" + a;\n" +
"                                //jAlert(url, \"Error\");\n" +
"                                // alert(url);\n" +
"                                var dataString = url;\n" +
"                                $.ajax({\n" +
"                                    type: \"POST\",\n" +
"                                    url: \"SessionMesero\",\n" +
"                                    data: dataString,\n" +
"                                    success: function(data) {\n" +
"\n" +
"                                        //   alert(data)\n" +
"                                        if (data == \"\") {\n" +
"                                            jAlert(\"EL PASSWORD ES INCORRECTO VERIFIQUE?\", \"Error!!\", function(r) {\n" +
"                                                if (r) {\n" +
"                                                    $(\".outcome\").val(\"\");\n" +
"                                                }\n" +
"                                            });\n" +
"\n" +
"                                        } else {\n" +
"\n" +
"                                            $(location).attr('href', \"Mesas.jsp\");\n" +
"\n" +
"                                        }\n" +
"\n" +
"\n" +
"                                    }\n" +
"                                });\n" +
"                                ///################################\n" +
"\n" +
"\n" +
"                            });\n" +
"\n" +
"                            $(\".btnli\").click(function() {\n" +
"                                var a = $(this).attr(\"name\");\n" +
"                                $('#idempleadowin').val(a)\n" +
"\n" +
"\n" +
"\n" +
"                            });\n" +
"                        })\n" +
"\n" +
"//###################\n" +
"                        $(function() {\n" +
"                            $('#entrarlogin').submit(function() {\n" +
"                                var data = $(this).serialize();\n" +
"\n" +
"\n" +
"                                $.post('SessionMesero', data, function(respuesta) {\n" +
"\n" +
"                                    if (respuesta == \"\") {\n" +
"                                        jAlert(\"EL PASSWORD ES INCORRECTO VERIFIQUE?\", \"Error!!\", function(r) {\n" +
"                                            if (r) {\n" +
"                                                $('#entrarlogin')[0].reset();\n" +
"                                            }\n" +
"                                        });\n" +
"\n" +
"                                    } else {\n" +
"                                        //  alert(respuesta);\n" +
"\n" +
"                                        $(location).attr('href', \"Mesas.jsp\");\n" +
"\n" +
"                                    }\n" +
"\n" +
"\n" +
"\n" +
"                                });\n" +
"                                return false;\n" +
"                            });\n" +
"                        });\n" +
"                    </script>\n" +
"\n" +
"\n" +
"                    <div class=\"content\">\n" +
"\n" +
"                        <div class=\"calculator\">\n" +
"                            <form id=\"entrarlogin\">\n" +
"                                <input type=\"hidden\" name=\"idMesero\"  id=\"idempleadowin\" value=\"\">\n" +
"                                <input type=\"password\"  name=\"clave\" class=\"outcome\" style=\"height:60px;font-size:60px;color:white\" value=\"\"   />\n" +
"                                <br>\n" +
"                                <input type=\"submit\" value=\"Entrar\" class=\"btn btn-inverse btn-large\">\n" +
"                            </form>\n" +
"                            <!--\n" +
"                             <ul class=\"buttons\">\n" +
"                                 <table>\n" +
"                                     <tr>\n" +
"                                         <td><li><a class=\"clear\">C</a></li></td>\n" +
"                                     <td><li><a class=\"\" href=\"#\"></a></li></td>\n" +
"                                     <td><li><a class=\"\" href=\"#\"></a></li></td>\n" +
"                                     </tr>\n" +
"                                     <tr>\n" +
"                                         <td><li><a class=\"val\" href=\"7\">7</a></li></td>\n" +
"                                     <td><li><a class=\"val\" href=\"8\">8</a></li></td>\n" +
"                                     <td><li><a class=\"val\" href=\"9\">9</a></li></td>\n" +
"                                     </tr>\n" +
"                                     <tr>\n" +
"                                         <td><li><a class=\"val\" href=\"4\">4</a></li></td>\n" +
"                                     <td><li><a class=\"val\" href=\"5\">5</a></li></td>\n" +
"                                     <td><li><a class=\"val\" href=\"6\">6</a></li></td>\n" +
"                                     </tr>\n" +
"                                     <tr>\n" +
"                                         <td><li><a class=\"val\" href=\"1\">1</a></li></td>\n" +
"                                     <td><li><a class=\"val\" href=\"2\">2</a></li></td>\n" +
"                                     <td><li><a class=\"val\" href=\"3\">3</a></li>></td>\n" +
"                                     </tr>\n" +
"                                     <tr>\n" +
"                                         <td><li><a class=\"val\" href=\"0\">0</a></li></td>\n" +
"                                     <td colspan=\"2\"><li><a class=\"equal wide\" >Entrar</a></li></td>\n" +
" \n" +
"                                     </tr>\n" +
"                                 </table>\n" +
" \n" +
" \n" +
"                             </ul>-->\n" +
"                        </div>\n" +
"                    </div>\n" +
"                    <a class=\"close-reveal-modal clear\">&#215;</a>\n" +
"\n" +
"                </div>");
            out.println("<ul id=\"sortable\">");
            res = dao.getBuscar(nombre);
            itr = res.iterator();
            while (itr.hasNext()) {
                Empleado em = (Empleado) itr.next();
                pu = em.getPuesto();
                String puesto = pu.getTipo();
                vb = em.getBarra();
                if (vb != null) {

                    if (vb.getIdBarra().equals(idBarra)) {

                       out.print("<li class='ui-state-default'><a href=\"#\" name='" + em.getIdEmpleado() + "' data-reveal-id='password' data-animation=\"fadeAndPop\" data-animationspeed=\"300\" data-closeonbackgroundclick=\"true\" data-dismissmodalclass=\"close-reveal-modal\" title=\"Password\" class=\"btnli\" ><h3>" + puesto + "</h3><br><br><h1>" + em.getEmpleadocol().toUpperCase() + "</h1></a></li>");


                    }

                }
            }
            out.println("</ul>");
            out.println("");

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
