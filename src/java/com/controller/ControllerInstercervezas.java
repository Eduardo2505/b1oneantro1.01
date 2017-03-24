/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.controller;

import com.dao.impl.ComandaDaoImpl;
import com.dao.impl.VentaComandaDaoImpl;
import com.mapping.Altadia;
import com.mapping.Categoria;
import com.mapping.Comanda;
import com.mapping.Producto;
import com.mapping.VentaComanda;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import otrosNOsirve.consultasMysq;

/**
 *
 * @author Eduardo
 */
public class ControllerInstercervezas extends HttpServlet {

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
    VentaComandaDaoImpl daol = new VentaComandaDaoImpl();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        HttpSession sesion = request.getSession();
        String idComanda = (String) sesion.getAttribute("idComanda");
        consultasMysq m = new consultasMysq();
        ComandaDaoImpl co = new ComandaDaoImpl();
        Comanda man = new Comanda();
        String op = request.getParameter("op");

        Altadia d = new Altadia();
        d = (Altadia) sesion.getAttribute("idDia");
        String evento = d.getTipoEvento();

        VentaComandaDaoImpl daovc = new VentaComandaDaoImpl();

        try {
            man = co.bucarPorId(idComanda);
            String vf = man.getTipo();
            // out.println(vf+"fff");
            if (vf.equals("venta")) {
                int veri = daovc.verificarComanda(idComanda);
                //out.println(veri);
                // if (evento.equals("Nocturno")) {
                if (veri != 0) {
                    List res = daol.getVerDistribucion(idComanda);
                    Iterator itr = res.iterator();
                    while (itr.hasNext()) {
                        VentaComanda vc = (VentaComanda) itr.next();
                        Producto p = new Producto();
                        p = vc.getProducto();
                        Categoria cate = new Categoria();
                        cate = p.getCategoria();
                        int id = vc.getIdVentaComandacol();
                        if (p.getTipo().equals("Botella") && !cate.getIdCategoria().equals("PROMOCIONES")) {

                            int coj = m.verificarAdicionales(id, "JUGOS");
                            int cor = m.verificarAdicionales(id, "REFRESCO");
                            int sum = coj + cor;
                            // out.println(sum);

                            if (coj != 2 && cor == 0) {
                                out.println("Falta Servicio");
                                break;
                            } else if (cor != 5 && coj == 0) {
                                out.println("Falta Servicio");
                                break;
                            } else if ((cor == 2 && coj == 1) || (cor == 1 && coj == 1)) {
                                out.println("Falta Servicio");
                                break;

                            } else if ((cor == 2 && coj == 2)) {
                                out.println("No esta autorizado este servicio");
                                break;

                            }


                        } else if (p.getTipo().equals("Copa")) {
                            int coj = m.verificarAdicionales(id, "JUGOS");
                            int cor = m.verificarAdicionales(id, "REFRESCO");
                            int sum = coj + cor;
                            if (sum <= 0) {

                                out.println("Coloque el servicio de la copa");
                                break;
                            }



                        }




                        //}
                    }

                } else {
                    out.println("NO TIENE PRODUCTO LA COMANDA");
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
