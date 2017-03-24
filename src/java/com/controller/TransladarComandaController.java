/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.controller;

import com.dao.impl.ComandaDaoImpl;
import com.dao.impl.EmpleadoDaoImpl;
import com.dao.impl.Mesa_ventaDaoImpl;
import com.dao.impl.TrasladoComandaDaoImpl;
import com.impresion1.TiketImprimir;
import com.mapping.Comanda;
import com.mapping.Empleado;
import com.mapping.MesaVenta;
import com.mapping.TrasladoComanda;
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
 * @author Eduardopc
 */
public class TransladarComandaController extends HttpServlet {

    MesaVenta mv = new MesaVenta();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String idComanda = request.getParameter("idComanda");
        String idCuentaVenta = request.getParameter("idMesa");//Obtengo el total de
        String Observa = request.getParameter("Observa");
        String nombres = request.getParameter("nombres");
        HttpSession sesion = request.getSession();
        String idMesero = request.getParameter("idMesero");

        // String idMesa = (String) sesion.getAttribute("idMesa");
        float suma = Float.parseFloat(request.getParameter("sumatotal"));
        String pass = request.getParameter("atorizar");

        try {
            Date ahora = new Date();
            SimpleDateFormat dateFormat = new SimpleDateFormat("HH:mm:ss");
            SimpleDateFormat dateFormatf = new SimpleDateFormat("yyyy-MM-dd");
            String fechaAc = dateFormatf.format(ahora);
            String horaAc = dateFormat.format(ahora);
            String hora = fechaAc + " " + horaAc;
            EmpleadoDaoImpl daoe = new EmpleadoDaoImpl();
            Empleado e = new Empleado();
          //  e = daoe.bucarPorId(idMesero);
            
            e = daoe.verificarCantras(pass);
           // System.out.println(e);
            if (e != null) {
                TrasladoComandaDaoImpl dao = new TrasladoComandaDaoImpl();

                TrasladoComanda t = new TrasladoComanda();
                t.setDescripcion(Observa + " Desde: " + nombres + "");
                Comanda c = new Comanda();
                c.setIdComanda(idComanda);
                t.setComanda(c);
                t.setRegistro(hora);
                dao.insertar(t);

                //Optenet total de la comanda a trasferir
                Mesa_ventaDaoImpl daoct = new Mesa_ventaDaoImpl();
                mv = daoct.bucarPorId(idCuentaVenta);
                float totalcuenta = mv.getTotalcuenta() + suma;
                daoct.actualiza(idCuentaVenta, totalcuenta);


                ComandaDaoImpl daoc = new ComandaDaoImpl();


                mv.setIdMesaVenta(idCuentaVenta);
                daoc.actulizarIdMesaventa(idComanda, mv);
                //Optener el total de la cuenta
               /* Mesa_ventaDaoImpl mvi = new Mesa_ventaDaoImpl();
                mv = mvi.bucarPorId(idCuentaVenta);
                float total = mv.getTotalcuenta()¨*/
                //System.out.println(total);
                //TiketImprimir im=new TiketImprimir();
                
              
                
                
                
            } else {

                out.println("No tiene Autorización");
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
