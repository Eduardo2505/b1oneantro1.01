/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import otrosNOsirve.conexion;
import otrosNOsirve.consultasMysq;

/**
 *
 * @author Eduardo
 */
public class ChageCuentas extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String idCuenta = request.getParameter("idCuenta").trim();
        conexion mysql = new conexion();
        Connection cn = mysql.Conectar();
        PreparedStatement st = null;
        ResultSet rs = null;
        PreparedStatement sta = null;
        ResultSet rsa = null;
        // out.println(idCuenta);
        try {
            /* TODO output your page here. You may use following sample code. */
            consultasMysq co = new consultasMysq();
            int v = co.verificar(idCuenta);
            System.out.println(v);
            if (v != 0) {

                float sumatotal = 0;
                String sSQl = "", sSQla = "";


                out.println("<input type=\"submit\" value=\"Aceptar\" class=\"btn btn-primary btn-large\">"
                        + "<table class=\"table\">");
                try {

                    out.println("<tr><th colspan='2'>Producto</th><th style='text-align:center'>Cantidad</th><th>Precio</th></tr>");

                    sSQl = "select CONCAT(p.nombre,'// ',p.tamano,' ml') ,v.costo,count(v.idProducto),d.porcentaje,d.Observaciones,v.idcomanda,v.idVenta_Comandacol,v.Observaciones,c.observa,c.Autorizacion from producto p,venta_comanda v,comanda c,descuento d where  p.idProducto=v.idProducto and c.idComanda=v.idComanda and v.idDescuento=d.idDescuento and c.idMesa_venta='" + idCuenta + "' and c.estado='activo'  group by v.idProducto,v.idDescuento,v.estado order by v.registro DESC";
                    st = cn.prepareStatement(sSQl);
                    rs = st.executeQuery();
                    String obsercort = "", autoriza = "";
                    while (rs.next()) {
                        obsercort = rs.getString("c.observa");
                        autoriza = rs.getString("c.Autorizacion");
                        double res = 0;

                        //double res = Float.parseFloat(rs.getString(2));

                        if (rs.getString(5).equals("")) {//$" + rs.getString(2) + "</td><td>" + rs.getString(3) + "

                            //SE Agrega el codigo de cortesía
                            if (!obsercort.equals("-") && !autoriza.equals("-")) {
                                out.println("<tr><td colspan='2'>" + rs.getString(1) + "</td><td class='precio'> " + rs.getString(3) + "</td><td> $ 0</td></tr>");
                                out.println("<tr><td colspan='3' style='padding-left:15%'>Cortesía: " + rs.getString("c.observa") + "<BR>Autorización: " + rs.getString("c.Autorizacion") + "</td></tr>");
                                res = 0;
                            } else {
                                res = Float.parseFloat(rs.getString(2));
                                out.println("<tr><td colspan='2'>" + rs.getString(1) + "</td><td class='precio'> " + rs.getString(3) + "</td><td> $ " + rs.getString(2) + "</td></tr>");
                            }
                            //############################

                            int id = Integer.parseInt(rs.getString(7));
                            sSQla = "select CONCAT(p.nombre,'// ',p.tamano,' ml') as producto ,count(a.idProducto) as cantidad,(count(a.idProducto)*a.precio) as total,a.idAdicionales from producto p,adicionales a where p.idProducto=a.idProducto and idVenta_Comandacol=" + id + "  group by a.idProducto,a.precio";
                            sta = cn.prepareStatement(sSQla);
                            rsa = sta.executeQuery();
                            while (rsa.next()) {
                                out.println("<tr><td width='70px'></td><td style='background-color:yellow'>" + rsa.getString(1) + "</td><td style='background-color:yellow'> " + rsa.getString(2) + "</td><td style='background-color:yellow'> $ " + rsa.getString(3) + "</td></tr>");
                                double adicio = Float.parseFloat(rsa.getString(3));

                            }


                        } else {
                            out.println("<tr><td colspan='2'>" + rs.getString(1) + "<h5> ||" + rs.getString(5) + " //" + rs.getString(8) + "</h5></td><td class='precio'>" + rs.getString(3) + "</td><td> $ " + rs.getString(2) + "</td></tr>");
                            //SE Agrega el codigo de cortesía
                            if (!obsercort.equals("-") && !autoriza.equals("-")) {
                                out.println("<tr><td colspan='3' style='padding-left:15%'>Cortesía: " + rs.getString("c.observa") + "<BR>Autorización: " + rs.getString("c.Autorizacion") + "</td></tr>");
                                res = 0;
                            } else {
                                res = Float.parseFloat(rs.getString(2));
                            }

                            //############################
                            int id = Integer.parseInt(rs.getString(7));
                            sSQla = "select CONCAT(p.nombre,'// ',p.tamano,' ml') as producto ,count(a.idProducto) as cantidad,(count(a.idProducto)*a.precio) as total,a.idAdicionales from producto p,adicionales a where p.idProducto=a.idProducto and idVenta_Comandacol=" + id + "  group by a.idProducto,a.precio";
                            sta = cn.prepareStatement(sSQla);
                            rsa = sta.executeQuery();
                            while (rsa.next()) {
                                out.println("<tr><td width='70px'></td><td style='background-color:yellow'>" + rsa.getString(1) + "</td><td style='background-color:yellow'>" + rsa.getString(2) + "</td><td style='background-color:yellow'> $ " + rsa.getString(3) + "</td></tr>");
                                double adicio = Float.parseFloat(rsa.getString(3));

                            }
                        }

                    };













                    out.println(
                            "                <tr><td colspan=\"2\">TOTAL:</td><td><b>$" + sumatotal + "</b></td></tr>\n"
                            + "              \n"
                            + "\n"
                            + "            </table>");

                } catch (SQLException ex) {
                    Logger.getLogger(ChageCuentas.class.getName()).log(Level.SEVERE, null, ex);
                }
                try {
                    System.out.println("Cerrro conexionChangeCuentas");
                    cn.close();
                    st.close();
                    rs.close();
                    sta.close();
                    rsa.close();
                } catch (SQLException ex) {
                    Logger.getLogger(ChageCuentas.class.getName()).log(Level.SEVERE, null, ex);
                }
            } else {
                out.println("<input type=\"submit\" value=\"Aceptar\" class=\"btn btn-primary btn-large\"><BR>");
                out.println("No hay ninguna producto");
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
