/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.controller;

import com.dao.Mesa_ventaDao;
import com.dao.impl.CancelacionmesaDaoImpl;
import com.dao.impl.EmpleadoDaoImpl;
import com.dao.impl.Mesa_ventaDaoImpl;
import com.dao.impl.MesasDaoImpl;
import com.dao.impl.TrasladoMesaDaoImpl;
import com.mapping.CancelacionMesa;
import com.mapping.Empleado;
import com.mapping.MesaVenta;
import com.mapping.Mesas;
import com.mapping.TrasladoMesa;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Eduardo
 */
public class Cancelacion_MesaController extends HttpServlet {

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
        EmpleadoDaoImpl dao = new EmpleadoDaoImpl();
        String op = request.getParameter("op");
        String idCuenta = request.getParameter("idCuenta");
        String pass = request.getParameter("pass");
        String obs = request.getParameter("obser");
        Mesa_ventaDaoImpl dam = new Mesa_ventaDaoImpl();
        CancelacionmesaDaoImpl daoc = new CancelacionmesaDaoImpl();
        CancelacionMesa c = new CancelacionMesa();
        Date ahora = new Date();
        SimpleDateFormat dateFormat = new SimpleDateFormat("HH:mm:ss");
        SimpleDateFormat dateFormatf = new SimpleDateFormat("yyyy-MM-dd");
        String fechaAc = dateFormatf.format(ahora);
        String horaAc = dateFormat.format(ahora);
        String hora = fechaAc + " " + horaAc;

        MesaVenta mv = new MesaVenta();
        HttpSession sesion = request.getSession();
        String Supervisor = (String) sesion.getAttribute("Supervisor");
        try {
            /* TODO output your page here. You may use following sample code. *
             * da
             */
            Empleado em = new Empleado();

            if (op.equals("cancelar")) {

                // out.println(em);
                em = dao.verificarCantras(pass);
                if (em != null) {

                    dam.cerrar(idCuenta, "Cancelado", hora, Supervisor);
                    c.setObservaciones(obs);
                    c.setRegistro(hora);
                    mv.setIdMesaVenta(idCuenta);
                    c.setMesaVenta(mv);
                    c.setAutorizacion(em.getNombre() + " " + em.getApellidos());
                    c = daoc.insertar(c);

                    mv = dam.bucarPorId(idCuenta);
                    Mesas me = new Mesas();
                    me = mv.getMesas();
                    String idMesa = me.getIdMesa();
                    MesasDaoImpl damm = new MesasDaoImpl();
                    damm.actulizar(idMesa, "Activo");

                    sesion.setAttribute("idMesa", idCuenta);
                    sesion.setAttribute("Cancelacion", c);
                    //  response.sendRedirect("tiket/TiketCancelacion.jsp");

                } else {


                    out.println("No tiene Autorización");

                }
            } else {
                   String idClave = request.getParameter("idClave");
                  //  System.out.println("xxxxxxxxxxxxxxxxxxx"+idClave);   
                    em = dao.verificarCantras(pass);
             //   
                if (em != null) {
                    TrasladoMesaDaoImpl daot = new TrasladoMesaDaoImpl();
                    TrasladoMesa t = new TrasladoMesa();
                    mv.setIdMesaVenta(idCuenta);
                    t.setMesaVenta(mv);
                    t.setDescripcion(obs);
                    t.setRegistro(hora);
                    t.setAutorizacion(em.getNombre() + " " + em.getApellidos());
                    daot.insertar(t);
                    //actualizar mesaVenta
                    Empleado emM = new Empleado();
                    emM  = dao.verificarTrasn(idClave);
                    emM .getIdEmpleado();
                    dam.trasladar(idCuenta, emM);


                } else {


                    out.println("No tiene Autorización");
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
