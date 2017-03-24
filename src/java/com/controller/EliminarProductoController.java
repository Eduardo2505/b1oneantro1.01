/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.controller;

import beans.Adicionalesbean;
import beans.Comandaventabean;
import com.dao.impl.AdicionalesComprobarDaoImpl;
import com.dao.impl.ComandaDaoImpl;
import com.dao.impl.ComandaVentaBeansImpl;
import com.dao.impl.VentaComandaDaoImpl;
import com.mapping.Comanda;
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
public class EliminarProductoController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        int idIdventComanda = Integer.parseInt(request.getParameter("idIdventComanda"));
        HttpSession sesion = request.getSession();
        String idComanda = (String) sesion.getAttribute("idComanda");


        try {
            Comanda c = new Comanda();
            ComandaDaoImpl daocan = new ComandaDaoImpl();
            c = daocan.bucarPorId(idComanda);
            if (!c.getImpreso().equals("Impreso")) {
                VentaComandaDaoImpl eli = new VentaComandaDaoImpl();
                eli.eliminar(idIdventComanda);


                out.println("<script type=\"text/javascript\">\n"
                        + "\n"
                        + "            $(document).ready(function() {\n"
                        + "                $(\".eliminarProducto\").click(function(event) {\n"
                        + "\n"
                        + "                    var idCargoria = $(this).attr(\"name\");\n"
                        + "                    //alert(idCargoria)\n"
                        + "                    $(\"#ComandaVirtual\").load(idCargoria);\n"
                        + "                });\n"
                        + "            });\n"
                        + "\n"
                        + "            $(document).ready(function() {\n"
                        + "                $(\".eliminarAdicional\").click(function(event) {\n"
                        + "\n"
                        + "                    var idCargoria = $(this).attr(\"name\");\n"
                        + "                    //alert(idCargoria)\n"
                        + "                    $(\"#ComandaVirtual\").load(idCargoria);\n"
                        + "                });\n"
                        + "            });\n"
                        + "\n"
                        + "\n"
                        + "                            </script>");

                out.println("<script type=\"text/javascript\">\n"
                        + "\n"
                        + "    $(document).ready(function() {\n"
                        + "        $('.addAdicionales').click(function() {\n"
                        + "            var idproducto = $(this).attr(\"name\");\n"
                        + "            var idventa = $(this).val();\n"
                        + "            var dataString = 'idProducto=' + idproducto + '&idventa=' + idventa;\n"
                        + "            $.ajax({\n"
                        + "                type: \"POST\",\n"
                        + "                url: \"comprobarcomandaadicional\",\n"
                        + "                data: dataString,\n"
                        + "                success: function(data) {\n"
                        + "                    var inres = data.length;\n"
                        + "                    //alert(inres)\n"
                        + "                    if (inres != 0) {\n"
                        + "                        $(\"#menuproductos\").hide();\n"
                        + "\n"
                        + "                        var urla = \"adicionalesxml.jsp?idProducto=\" + idproducto;\n"
                        + "\n"
                        + "                        $(\"#adicionalemenu\").fadeIn(800).load(urla);\n"
                        + "\n"
                        + "                    }\n"
                        + "                    return false;\n"
                        + "                }\n"
                        + "\n"
                        + "            });\n"
                        + "\n"
                        + "            return false;\n"
                        + "        });\n"
                        + "\n"
                        + "    });\n"
                        + "</script>");
                out.println("<hr><div style='align-text:center'><h1>COMANDA</h1></div> <table class=\"table table-striped\" >");
                out.println("<tr><th colspan='2'>Producto</th><th>Cantidad</th><th>Precio</th><th>Opc</th></tr>");
                float sumita = 0, sumitax = 0;
                ComandaVentaBeansImpl dac = new ComandaVentaBeansImpl();
                List resa = dac.getBuscar(idComanda, "adicional");
                Iterator itra = resa.iterator();
                while (itra.hasNext()) {
                    Comandaventabean a = (Comandaventabean) itra.next();
                    sumita += a.getTotalcosto();
                    out.println("<tr><td colspan='2'><a href=\"#\" class=\"eliminarProducto\"  name=\"EliminarProductoController?idIdventComanda=" + a.getIdventa() + "\"> <img src=\"img/iconoE.png\"> </a> " + a.getProducto() + "</td><td>" + a.getCantidad() + "</td><td>$ " + a.getTotalcosto() + "</td><td><input type=\"radio\" class='addAdicionales' name=\"" + a.getIdProducto() + "\" value='" + a.getIdventa() + "'></td></tr>");

                    AdicionalesComprobarDaoImpl daoEm = new AdicionalesComprobarDaoImpl();
                    List res = daoEm.getAdicionales(a.getIdventa());
                    Iterator itr = res.iterator();
                    int verMesesa = 0;
                    while (itr.hasNext()) {
                        Adicionalesbean vcx = (Adicionalesbean) itr.next();
                        out.println("<tr><td width='70px'></td><td style='background-color:yellow'><a href=\"#\" class=\"eliminarAdicional\"  name=\"EliminarAdicionController?idAdicion=" + vcx.getIdadicional() + "\"> <img src=\"img/iconoE.png\"> </a> " + vcx.getProducto() + "</td><td style='background-color:yellow'>" + vcx.getCantidad() + "</td><td style='background-color:yellow'>$ 0</td><td></td></tr>");



                    }
                }
                List resax = dac.getBuscar(idComanda, "np");
                Iterator itrax = resax.iterator();
                while (itrax.hasNext()) {
                    Comandaventabean a = (Comandaventabean) itrax.next();
                    sumitax += a.getTotalcosto();
                    out.println("<tr><td colspan='2'><a href=\"#\" class=\"eliminarProducto\"  name=\"EliminarProductoController?idIdventComanda=" + a.getIdventa() + "\"> <img src=\"img/iconoE.png\"> </a> " + a.getProducto() + "</td><td>" + a.getCantidad() + "</td><td>$ " + a.getTotalcosto() + "</td></tr>");


                }
               out.println("<tr><td colspan=\"3\"><H4>TOTAL:</H4></td><td>$ " + (sumita + sumitax) + "</td></tr>");

                out.println("  <tr><td ></td><td><h4>Autorización:</h4></td><td colspan=\"3\" ><h4>" + c.getAutorizacion() + "</h4></td></tr>");
                out.println("  <tr><td ></td><td><h4>Observaciones:</h4></td><td colspan=\"3\"><h4>" + c.getObserva() + "</h4></td></tr>");
                out.println("  <tr><td colspan=\"3\" id=\"cargarCerrar\"></td></tr>");




            } else {
                out.println("YA ESTA IMPRESO");
            }
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
