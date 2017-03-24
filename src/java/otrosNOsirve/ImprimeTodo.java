/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package otrosNOsirve;

import com.dao.impl.EmpleadoDaoImpl;
import com.dao.impl.Mesa_ventaDaoImpl;
import com.mapping.Altadia;
import com.mapping.Barra;
import com.mapping.Empleado;
import com.mapping.MesaVenta;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.NumberFormat;
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
 * @author Eduardo
 */
public class ImprimeTodo extends HttpServlet {

    String sSQl = "";
    double total = 0, sub = 0, iva = 0;
    Altadia d = new Altadia();
    //idMesero = em.getIdEmpleado();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        HttpSession sesion = request.getSession();
        d = (Altadia) sesion.getAttribute("idDia");
        EmpleadoDaoImpl emp = new EmpleadoDaoImpl();
        Empleado e = new Empleado();

        int idDia = d.getIdaltadia();
        //   out.println(nomMesero);
        try {
            /*TODO output your page here. You may use following sample code. */

            List resm = emp.getFiltro();
            Iterator itr = resm.iterator();
            Barra bv = new Barra();
            while (itr.hasNext()) {
                Empleado em = (Empleado) itr.next();
                bv = em.getBarra();

                if (bv != null) {
                    String idba = bv.getIdBarra();
                    if (idba.equals("Barra 1") || idba.equals("Barra 2")) {

                        //  System.out.println(em.getApellidos());
//
                        e = emp.bucarPorId(em.getIdEmpleado());
                        String nomMesero = e.getNombre() + " " + e.getApellidos();
                        out.println(" <div id=\"muestra\">\n"
                                + "            <table >\n"
                                + "                <tr><td colspan=\"4\" style=\" text-align:center\"><b>PREMIER<BR>GENOVA #44 ESQUINA HAMBURGO <BR>C.P. 06600 MÉXICO, D. F. <BR>TEL.  41 69 18 20</b><hr></td></tr>\n"
                                + "                <tr><td colspan=\"4\">\n"
                                + "                        <table>\n"
                                + "\n"
                                + "                            <tr><td>Mesero:</td><td><h3>" + nomMesero.toUpperCase() + "</h3><td></tr>\n"
                                + "                            <tr><td>Cleve: </td><td><h3>" + e.getEmpleadocol() + "</h3><td></tr>                           \n"
                                + "                        </table>\n"
                                + "\n"
                                + "\n"
                                + "\n"
                                + "                    </td></tr>\n"
                                + "                <tr><td colspan=\"4\"> <HR><td></tr>");

                        conexion mysql = new conexion();
                        Connection cn = mysql.Conectar();
                        PreparedStatement st = null;
                        ResultSet rs = null;
                        PreparedStatement sta = null;
                        ResultSet rsa = null;
                        float sumatotal = 0, totaldTotal = 0;
                        String sSQl = "", sSQla = "";
                        try {
                            Mesa_ventaDaoImpl daomv = new Mesa_ventaDaoImpl();
                            MesaVenta m = new MesaVenta();


                            List resmv = daomv.getMesaVenta("Cerrado", e.getIdEmpleado(), idDia);
                            Iterator itrmv = resmv.iterator();
                            while (itrmv.hasNext()) {
                                MesaVenta mesasv = (MesaVenta) itrmv.next();
                                m = daomv.bucarPorId(mesasv.getIdMesaVenta());
                                String idMesa = mesasv.getIdMesaVenta();
                                //out.println(mesasv.getIdMesaVenta() + "<BR>");
                                out.println("<tr><td colspan='4' style='text-align:center'>######## Cuenta: " + idMesa + " #######<td></tr>"
                                        + "<tr><td>Personas Aprox: </td><td colspan='3'>" + m.getPersonasAprox() + "<td></tr>");
                                out.println("<tr><td colspan=\"4\" style='text-align:center'> ================================ <td></tr>\n"
                                        + "");
                                out.println("<tr><th colspan='2'>Producto</th><th style='text-align:center'>Cantidad</th><th>Precio</th></tr>");

                                sSQl = "select CONCAT(p.nombre,'// ',p.tamano,' ml') ,ROUND((count(v.idProducto)*p.precio)*(d.porcentaje/100)),count(v.idProducto),d.porcentaje,d.Observaciones,v.idcomanda,v.idVenta_Comandacol,v.Observaciones from producto p,venta_comanda v,comanda c,descuento d where  p.idProducto=v.idProducto and c.idComanda=v.idComanda and v.idDescuento=d.idDescuento and c.idMesa_venta='" + idMesa + "' and c.estado='activo'  group by v.idProducto,v.idDescuento,v.estado,v.Observaciones order by v.registro DESC";
                                st = cn.prepareStatement(sSQl);
                                rs = st.executeQuery();

                                while (rs.next()) {

                                    double res = Float.parseFloat(rs.getString(2));

                                    if (rs.getString(5).equals("")) {//$" + rs.getString(2) + "</td><td>" + rs.getString(3) + "
                                        out.println("<tr><td colspan='2'>" + rs.getString(1) + "</td><td style='text-align:center'> " + rs.getString(3) + "</td><td style='text-align:left'> $ " + rs.getString(2) + "</td></tr>");
                                        int id = Integer.parseInt(rs.getString(7));
                                        sSQla = "select CONCAT(p.nombre,'// ',p.tamano,' ml') as producto ,count(a.idProducto) as cantidad,(count(a.idProducto)*a.precio) as total,a.idAdicionales from producto p,adicionales a where p.idProducto=a.idProducto and idVenta_Comandacol=" + id + "  group by a.idProducto,a.precio";
                                        sta = cn.prepareStatement(sSQla);
                                        rsa = sta.executeQuery();
                                        while (rsa.next()) {
                                            out.println("<tr><td width='70px'></td><td style='background-color:yellow'>" + rsa.getString(1) + "</td><td style='background-color:yellow'> " + rsa.getString(2) + "</td><td style='background-color:yellow'> $ " + rsa.getString(3) + "</td></tr>");
                                            double adicio = Float.parseFloat(rsa.getString(3));
                                            //sumatotal += adicio;
                                        }


                                    } else {
                                        out.println("<tr><td colspan='2'>" + rs.getString(1) + "<br>     <b class='obser'> [**" + rs.getString(5) + "**]<br>[" + rs.getString(8) + "]</b></td><td style='text-align:center'>" + rs.getString(3) + "</td><td style='text-align:left'> $ " + rs.getString(2) + "</td></tr>");

                                        int id = Integer.parseInt(rs.getString(7));
                                        sSQla = "select CONCAT(p.nombre,'// ',p.tamano,' ml') as producto ,count(a.idProducto) as cantidad,(count(a.idProducto)*a.precio) as total,a.idAdicionales from producto p,adicionales a where p.idProducto=a.idProducto and idVenta_Comandacol=" + id + "  group by a.idProducto,a.precio";
                                        sta = cn.prepareStatement(sSQla);
                                        rsa = sta.executeQuery();
                                        while (rsa.next()) {
                                            out.println("<tr><td width='70px'></td><td style='background-color:yellow'>" + rsa.getString(1) + "</td><td style='background-color:yellow'>" + rsa.getString(2) + "</td><td style='background-color:yellow'> $ " + rsa.getString(3) + "</td></tr>");
                                            double adicio = Float.parseFloat(rsa.getString(3));
                                            // sumatotal += adicio;
                                        }
                                    }

                                };


                                //   Mesa_ventaDaoImpl mvt = new Mesa_ventaDaoImpl();
                                //  mvt.actualiza(idMesa, sumatotal);
                                totaldTotal += m.getTotalcuenta();

                                out.println("<tr><td colspan=\"4\">.<td></tr>\n"
                                        + "");
                                out.println("<tr><td colspan=\"2\" style='text-align:right'>TOTAL:</td><td><b>$ " + m.getTotalcuenta() + "</b></td></tr>");

                            }
                            out.println("<tr><td colspan=\"4\"> <HR><td></tr>\n"
                                    + "");

                        } finally {

                            System.out.println("se cerro conexión.!!!");
                            cn.close();
                            st.close();
                            rs.close();
                            sta.close();
                            rsa.close();
                        }
                        NumberFormat nf = NumberFormat.getInstance();
                        nf.setMaximumFractionDigits(2);
                        total = totaldTotal * (.16);
                        sub = totaldTotal - total;
                        iva = sub * (.16);
                        String ste = nf.format(iva);
                        String stesub = nf.format(sub);

                        out.println("  <tr><td ></td><td colspan=\"3\" style=\"text-align:center\">***********************************</td></tr>\n"
                                + "\n"
                                + "                <tr><td ></td><td colspan=\"2\" style=\"text-align:right\">Subtotal: $ </td><td>" + stesub + "</td></tr>\n"
                                + "                <tr><td ></td><td colspan=\"2\" style=\"text-align:right\">IVA 16%: $ </td><td>" + ste + "</td></tr>\n"
                                + "                <tr><td ></td><td colspan=\"2\" style=\"text-align:right\"></td><td>_________</td></tr>\n"
                                + "                <tr><td ></td><td colspan=\"2\" style=\"text-align:right\">TOTAL: $ </td><td>" + totaldTotal + "</td></tr>\n"
                                + "\n"
                                + "\n"
                                + "\n"
                                + "               \n"
                                + "\n"
                                + "\n"
                                + "            </table>\n"
                                + "        </div>");
                        
                        

                    }
                }
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(ImprimeTodo.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(ImprimeTodo.class.getName()).log(Level.SEVERE, null, ex);
        }
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
