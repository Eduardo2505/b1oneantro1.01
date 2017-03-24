/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.controller;

import com.dao.impl.AltadiaDaoImpl;
import com.mapping.Altadia;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Eduardo
 */
public class AltadiaController extends HttpServlet {

    AltadiaDaoImpl dao = new AltadiaDaoImpl();
    Altadia dia = new Altadia();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String op = request.getParameter("op").trim();
        Date ahora = new Date();
        SimpleDateFormat dateFormat = new SimpleDateFormat("HH:mm:ss");
        SimpleDateFormat dateFormatf = new SimpleDateFormat("yyyy-MM-dd");
        String fechaAc = dateFormatf.format(ahora);
        String horaActu = dateFormat.format(ahora);
        
        try {
            /* TODO output your page here. You may use following sample code. */
            if (op.equals("insertar")) {
                String diai = request.getParameter("dia");
                String tipo = request.getParameter("opEvento");

                dia.setFecha(diai);
                dia.setHora(fechaAc + " " + horaActu);
                dia.setEstado("Activo");
                dia.setTipoEvento(tipo);
                dao.insertar(dia);


            } else if (op.equals("actualizar")) {
                int idDia = Integer.parseInt(request.getParameter("iddia"));
                String estado = request.getParameter("estado");
                String aux = "";
                if (estado.equals("Activo")) {
                    aux = "Desactivado";
                } else {
                    aux = "Activo";
                }
                dao.actulizar(idDia, aux);
            } else if (op.equals("actcuentas")) {
             
                int iddia = Integer.parseInt(request.getParameter("iddia"));
               
                dia = dao.bucar(iddia);
                HttpSession sesion = request.getSession();
                sesion.setAttribute("idDia", dia);
                response.sendRedirect("Administrador/ActivarCuentas.jsp");
              //  sesion.setAttribute("idBarra", "Barrita");

            } else if (op.equals("impAdmin")) {
                int iddia = Integer.parseInt(request.getParameter("iddia"));
                dia = dao.bucar(iddia);
                HttpSession sesion = request.getSession();
                sesion.setAttribute("idDia", dia);
                response.sendRedirect("linkAdmin.jsp");
                sesion.setAttribute("SusperUsuario","Admin");
                sesion.setAttribute("idBarra", "Barrita");

            } else {
                int iddia = Integer.parseInt(request.getParameter("iddia"));
                dia = dao.bucar(iddia);
                HttpSession sesion = request.getSession();
                sesion.setAttribute("idDia", dia);
                response.sendRedirect("link.jsp");
                sesion.setAttribute("idBarra", "Barrita");

            }
            out.println(" <script type=\"text/javascript\">"
                    + "$(document).ready(function() {\n"
                    + "                $('.desactivar').click(function() {\n"
                    + "\n"
                    + "                    var user = $(this).val();\n"
                    + "\n"
                    + "                    //alert(user);\n"
                    + "\n"
                    + "                    var dataString = 'iddia=' + user + '&op=actualizar';\n"
                    + "                  //  alert(dataString);\n"
                    + "                    if (user != \"\") {\n"
                    + "                        // $('#verResultadoBuscados').html('<img src=\"img/ajax-loader.gif\" alt=\"\"/>');\n"
                    + "                        $.ajax({\n"
                    + "                            type: \"POST\",\n"
                    + "                            url: \"../AdmindiaController\",\n"
                    + "                            data: dataString,\n"
                    + "                            success: function(data) {\n"
                    + "                                $('#resultados').fadeIn(1000).html(data);\n"
                    + "                            }\n"
                    + "                        });\n"
                    + "                        //}\n"
                    + "                    }\n"
                    + "                }\n"
                    + "\n"
                    + "\n"
                    + "                );\n"
                    + "            });\n"
                    + "        </script>");
            out.println("<table class=\"table table-hover\">\n"
                    + "\n"
                    + "                            <thead>\n"
                    + "                                <tr>\n"
                    + "                                    <th>Dia</th> <th>Tipo</th>\n"
                    + "                                    <th>Resgistro</th>\n"
                    + "                                    <th>Estado</th>\n"
                    + "                                </tr>\n"
                    + "                            </thead>\n"
                    + "                            <tbody>");
            //  AltadiaDaoImpl dao = new AltadiaDaoImpl();
            List res = dao.getDias();
            Iterator itr = res.iterator();
            String color = "";
            while (itr.hasNext()) {
                Altadia des = (Altadia) itr.next();
                if (des.getEstado().equals("Activo")) {
                    color = "success";
                } else {
                    color = "danger";
                }
                out.println("<tr><td>" + des.getFecha() + "</td><td>" + des.getTipoEvento() + "</td><td>" + des.getHora() + "</td><td><button class='btn btn-" + color + " desactivar' value='" + des.getIdaltadia() + "&estado=" + des.getEstado() + "' type='button'>" + des.getEstado() + "</button> <a href='../AltadiaController?iddia=" + des.getIdaltadia() + "&op=imp'  class='btn btn-primary ver' >VER</a> <a href='../AltadiaController?iddia=" + des.getIdaltadia() + "&op=actcuentas'  class='btn btn-primary ver' >Cuentas</a></td>");






            }


            out.println(" </tbody>\n"
                    + "                        </table>");

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
