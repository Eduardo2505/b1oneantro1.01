/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.controller;

import com.dao.impl.AdicionalesDaoImpl;
import com.dao.impl.ComandaDaoImpl;
import com.dao.impl.ProductoDaoImpl;
import com.dao.impl.VentaComandaDaoImpl;
import com.mapping.Adicionales;
import com.mapping.Altadia;
import com.mapping.Categoria;
import com.mapping.Comanda;
import com.mapping.Producto;
import com.mapping.VentaComanda;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Iterator;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import mail.EmailEnv;
import otrosNOsirve.conexion;
import otrosNOsirve.consultasMysq;

/**
 *
 * @author Eduardopc
 */
public class addProducto extends HttpServlet {

    AdicionalesDaoImpl daoa = new AdicionalesDaoImpl();
    Adicionales a = new Adicionales();
    Producto p = new Producto();
    VentaComanda v = new VentaComanda();
    float costo = 0;
    ProductoDaoImpl dao = new ProductoDaoImpl();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String idVentaComanda = request.getParameter("idVentaComanda");
        String idProductos = request.getParameter("idProductos");
        String tipo = request.getParameter("tipo");
        HttpSession sesion = request.getSession();
        Altadia d = new Altadia();
        d = (Altadia) sesion.getAttribute("idDia");
        String evento = d.getTipoEvento();
        int id = Integer.parseInt(idVentaComanda);
        consultasMysq conc = new consultasMysq();
        try {
            VentaComandaDaoImpl daovc = new VentaComandaDaoImpl();
            String idComanda = (String) sesion.getAttribute("idComanda");
            Comanda c = new Comanda();
            ComandaDaoImpl daocan = new ComandaDaoImpl();
            c = daocan.bucarPorId(idComanda);
            if (!c.getImpreso().equals("Impreso")) {
                daovc.actualizaEstado(id, "Adicional");
                out.println("<table class=\"table\">");
                out.println("<tr><th>Cantidad</th><th>Producto</th></tr>");
                if (tipo.equals("adicionales")) {

                    p = new Producto();
                    p = dao.getBuscar(idProductos);
                    costo = p.getPrecio();

                    a.setDescripcion(tipo);
                    a.setPrecio(costo);
                    p.setIdProducto(idProductos);
                    a.setProducto(p);
                    v.setIdVentaComandacol(Integer.parseInt(idVentaComanda));
                    a.setVentaComanda(v);
                    daoa.insertar(a);

                } else {

                    v = daovc.BuscarComanda(id);
                    p = v.getProducto();
                    String tip = p.getTipo();
                    Producto pb = new Producto();
                    pb = dao.getBuscar(idProductos);
                    Categoria ct = new Categoria();
                    ct = pb.getCategoria();
                    String cate = ct.getIdCategoria();
                    if (evento.equals("Nocturno")) {
                        //buscar
                        VentaComanda vv = new VentaComanda();
                        Producto pp = new Producto();
                        vv = daovc.BuscarComanda(id);
                        pp = vv.getProducto();
                        /*  if (pp.getIdProducto().equals("COC-ON531")) {
                         //EXT-ON339ffr      EXT-ON339yh7
                         int ver = conc.verificarAdicionalesproPaquete(id, "BOTELLAS_P2A", "");
                         // int ver2 = conc.verificarAdicionalesproPaquete(id, "BOTELLAS_P2A", "and p.idProducto=='EXT-ON339ffr' or p.idProducto=='EXT-ON339yh7'");
                         // int verjarra = conc.verificarAdicionalesproPaquete(id, "BOTELLAS_P2A", "and p.importacion=='jarra'");
                         //  int vercerveza = conc.verificarAdicionalesproPaquete(id, "BOTELLAS_P2A", "and p.importacion=='cerveza'");
                         //  int verrefrescos = conc.verificarAdicionalesproPaquete(id, "BOTELLAS_P2A", "and p.importacion=='refrescos'");
                         if (ver == 0) {*/
                        costo = 0;

                        a.setDescripcion(tipo);
                        a.setPrecio(costo);
                        p.setIdProducto(idProductos);
                        a.setProducto(p);
                        v.setIdVentaComandacol(Integer.parseInt(idVentaComanda));
                        a.setVentaComanda(v);
                        daoa.insertar(a);
                        /* } else {
                         out.println("<h2>NO ESTA AUTORIZADO</h2>");
                         }

                         } else if (pp.getIdProducto().equals("COC-ON535")) {
                         int ver = conc.verificarAdicionalesproPaquete(id,"BOTELLAS_P23", "");
                         // int ver2 = conc.verificarAdicionalesproPaquete(id, "BOTELLAS_P2A", "and p.idProducto=='EXT-ON339ffr' or p.idProducto=='EXT-ON339yh7'");
                         // int verjarra = conc.verificarAdicionalesproPaquete(id, "BOTELLAS_P2A", "and p.importacion=='jarra'");
                         //  int vercerveza = conc.verificarAdicionalesproPaquete(id, "BOTELLAS_P2A", "and p.importacion=='cerveza'");
                         //  int verrefrescos = conc.verificarAdicionalesproPaquete(id, "BOTELLAS_P2A", "and p.importacion=='refrescos'");
                         if (ver == 0) {
                         costo = 0;

                         a.setDescripcion(tipo);
                         a.setPrecio(costo);
                         p.setIdProducto(idProductos);
                         a.setProducto(p);
                         v.setIdVentaComandacol(Integer.parseInt(idVentaComanda));
                         a.setVentaComanda(v);
                         daoa.insertar(a);
                         } else {
                         out.println("<h2>NO ESTA AUTORIZADO</h2>");
                         }

                         System.out.println("XXXXXXXXXXXXXXXXXXXXes paquete C");
                         } else if (pp.getIdProducto().equals("COC-ON535PB")) {
                         int ver = conc.verificarAdicionalesproPaquete(id, "BOTELLAS_P2B", "");
                         if (ver == 0) {
                         costo = 0;

                         a.setDescripcion(tipo);
                         a.setPrecio(costo);
                         p.setIdProducto(idProductos);
                         a.setProducto(p);
                         v.setIdVentaComandacol(Integer.parseInt(idVentaComanda));
                         a.setVentaComanda(v);
                         daoa.insertar(a);
                         } else {
                         out.println("<h2>NO ESTA AUTORIZADO</h2>");
                         }
                         }*/

                        // if (tip.equals("Botella") && (cate.equals("JUGOS") || cate.equals("REFRESCO") || cate.equals("TENEDOR"))) {
                        //   }
                    }/* else {

                     //######################################Tardeada#########

                     if (p.getIdProducto().equals("CER-OT303")) {
                     //  out.println("Entrososoosso");
                     // out.println(idProductos);
                     if (idProductos.equals("CER-ON186PROMO") || idProductos.equals("CER-SO186PROMO") || idProductos.equals("CER-OT188")) {

                     int ver = conc.verificarAdicionalespro(id, "CER-ON186PROMO");
                     int verw = conc.verificarAdicionalespro(id, "CER-SO186PROMO");
                     int verr = conc.verificarAdicionalespro(id, "CER-OT188");
                     int sum = ver + verw + verr;
                     if (sum < 20) {
                     costo = 0;

                     a.setDescripcion(tipo);
                     a.setPrecio(costo);
                     p.setIdProducto(idProductos);
                     a.setProducto(p);
                     v.setIdVentaComandacol(Integer.parseInt(idVentaComanda));
                     a.setVentaComanda(v);
                     daoa.insertar(a);
                     } else {
                     out.println("<h2>NO ESTA AUTORIZADO</h2>");
                     }
                     } else {
                     out.println("<h2>NO ESTA AUTORIZADO</h2>");
                     }

                     } else if (tip.equals("Botella") && (cate.equals("JUGOS") || cate.equals("REFRESCO") || cate.equals("EXTRAS"))) {
                     //  consultasMysq conc = new consultasMysq();
                     int coj = conc.verificarAdicionales(id, "JUGOS");
                     int cor = conc.verificarAdicionales(id, "REFRESCO");
                     int sum = coj + cor;
                     if (coj >= 1) {
                     out.println("<h2>NO ESTA AUTORIZADO</h2>");
                     } else if (cor >= 3) {
                     out.println("<h2>NO ESTA AUTORIZADO</h2>");
                     } else if (coj == 1 && cor >= 0) {
                     out.println("<h2>NO ESTA AUTORIZADO</h2>");

                     } else if (cor == 2 && cate.equals("JUGOS")) {
                     out.println("<h2>NO ESTA AUTORIZADO</h2>");
                     } else if (cor == 1 && cate.equals("JUGOS")) {
                     out.println("<h2>NO ESTA AUTORIZADO</h2>");
                     } else {
                     costo = 0;

                     a.setDescripcion(tipo);
                     a.setPrecio(costo);
                     p.setIdProducto(idProductos);
                     a.setProducto(p);
                     v.setIdVentaComandacol(Integer.parseInt(idVentaComanda));
                     a.setVentaComanda(v);
                     daoa.insertar(a);



                     }

                     } else if (!tip.equals("Botella") && (cate.equals("EXTRAS"))) {
                     costo = 0;

                     a.setDescripcion(tipo);
                     a.setPrecio(costo);
                     p.setIdProducto(idProductos);
                     a.setProducto(p);
                     v.setIdVentaComandacol(Integer.parseInt(idVentaComanda));
                     a.setVentaComanda(v);
                     daoa.insertar(a);





                     } else {
                     out.println("<h2>NO ESTA AUTORIZADO</h2>");
                     }


                     }*/

                    //  if()
                }
                //COnsulta#########################3
          /*  AdicionalesDaoImpl daol = new AdicionalesDaoImpl();
                 out.println(id);
                 List res = daol.getMostrar(id);
                 Iterator itr = res.iterator();
                 while (itr.hasNext()) {
                 Adicionales c = (Adicionales) itr.next();
                 p = c.getProducto();
                 int cvec = daol.contar(p.getIdProducto(), id);
                 out.println("<tr><td>" + cvec + "</td><td> " + p.getNombre() + "</td></tr>");

                 System.out.println(c.getPrecio());

                 }*/
                conexion mysql = new conexion();
                Connection cn = mysql.Conectar();
                ResultSet rsc = null;
                // out.println(id);
                rsc = conc.ContarAdicionales(id, cn);
                while (rsc.next()) {

                    out.println("<tr><td>" + rsc.getString("total") + "</td><td> " + rsc.getString("nombre") + "</td></tr>");
                }

                cn.close();
                rsc.close();
                // out.println("Cerro la conx");
                out.println("</table>");
            } else {
                out.println("YA ESTA IMPRESO");
            }
        } catch (Exception ex) {
            Logger.getLogger(addProducto.class.getName()).log(Level.SEVERE, null, ex);
            // EmailEnv email = new EmailEnv();
            // email.enviarErrores("conwereduardopc@hotmail.com", "robbie_petter@hotmail.com", "Servelet addProducto.java/" + ex);
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
