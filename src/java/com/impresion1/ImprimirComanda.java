/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.impresion1;

import beans.Adicionalesbean;
import beans.Comandaventabean;
import com.dao.impl.AdicionalesComprobarDaoImpl;
import com.dao.impl.ComandaDaoImpl;
import com.dao.impl.ComandaVentaBeansImpl;
import com.dao.impl.Mesa_ventaDaoImpl;
import com.dao.impl.VentaComandaDaoImpl;
import com.mapping.Comanda;
import com.mapping.Empleado;
import com.mapping.MesaVenta;
import com.mapping.Producto;
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
public class ImprimirComanda extends HttpServlet {

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
        HttpSession sesion = request.getSession();
        String idComanda = (String) sesion.getAttribute("idComanda");

        ComandaDaoImpl co = new ComandaDaoImpl();
        Comanda man = new Comanda();
        String op = request.getParameter("op");




        VentaComandaDaoImpl daovc = new VentaComandaDaoImpl();
        try {
            man = co.bucarPorId(idComanda);
            String vf = man.getTipo();
            // out.println(vf+"fff");
            if (!man.getImpreso().equals("Impreso")) {

                int veri = daovc.verificarComanda(idComanda);

                if (veri != 0) {
                    co.actulizarImp(idComanda, "Impreso");
                    //#################################Imprimir tiket#########################################

                    String nombre = "", nomMesero = "", tipoEvento = "";

                    String idMesero = "", idMesa = "", idComandaTras = "";
                    int idDia = 0;

                    Date ahora = new Date();
                    String espacio = " ";
                    SimpleDateFormat dateFormat = new SimpleDateFormat("HH:mm:ss");
                    SimpleDateFormat dateFormatf = new SimpleDateFormat("yyyy-MM-dd");
                    String fechaAc = dateFormatf.format(ahora);
                    String horaAc = dateFormat.format(ahora);
                    Mesa_ventaDaoImpl mv = new Mesa_ventaDaoImpl();
                    MesaVenta mvv = new MesaVenta();
                    String clave = "";

                    Empleado em = new Empleado();
                    idMesa = (String) sesion.getAttribute("idMesa");
                    em = (Empleado) sesion.getAttribute("idMesero");
                    nomMesero = em.getNombre() + " " + em.getApellidos();
                    mvv = mv.bucarPorId(idMesa);
                    clave = em.getEmpleadocol();
                    String mesaCuenta = mvv.getIdMesaCapturada();
                    ComandaDaoImpl daoc = new ComandaDaoImpl();

                    int sumita = 0;
                    double totalsumuta = 0;
                    int idc = 0;
                    int sumadcio = 0;
                    String nombrePro = "", obseComanda = "", Autorza = "", Observavc = "", tipo = "", iddes = "", idProducto = "";
                    int cantidad = 0, cantidada = 0, idvc = 0;
                    Producto pa = new Producto();

                    float sumatotal = 0, costo = 0;
// Imprime tiket
                    StringBuilder resultado = new StringBuilder("");
                    String estadoita = "", estadococina = "";
                    ComandaVentaBeansImpl dac = new ComandaVentaBeansImpl();
                    List resa = dac.getBuscar(idComanda, "adicional");
                    Iterator itra = resa.iterator();
                    while (itra.hasNext()) {
                        Comandaventabean a = (Comandaventabean) itra.next();
                        if (a.getTipo().equals("itacate")) {
                            estadoita = "Activo";
                            estadococina = "Activo";
                        }else  if (a.getTipo().equals("cocina")) {
                            estadococina = "Activo";
                        } else {
                            estadoita = "Activo";
                        }


                        resultado.append(a.getProducto() + " " + a.getMedida() + " ----> " + a.getCantidad() + " pz\n");

                        AdicionalesComprobarDaoImpl daoEm = new AdicionalesComprobarDaoImpl();
                        List res = daoEm.getAdicionales(a.getIdventa());
                        Iterator itr = res.iterator();
                        int verMesesa = 0;
                        while (itr.hasNext()) {
                            Adicionalesbean vcx = (Adicionalesbean) itr.next();

                            resultado.append("_____(" + vcx.getProducto() + " " + vcx.getMedida() + "-> " + vcx.getCantidad() + " pz)\n\n");




                        }
                    }
                    List resax = dac.getBuscar(idComanda, "np");
                    Iterator itrax = resax.iterator();
                    while (itrax.hasNext()) {
                        Comandaventabean a = (Comandaventabean) itrax.next();
                        if (a.getTipo().equals("cocina")) {
                            estadococina = "Activo";
                        } else {
                            estadoita = "Activo";
                        }

                        resultado.append(a.getProducto() + " " + a.getMedida() + " ----> " + a.getCantidad() + " pz\n");



                    }

                    TiketImprimir dao = new TiketImprimir();

                    String tiket = dao.ImprimirComanda(nomMesero.toUpperCase(), clave, mesaCuenta + "\n#" + idMesa, idComanda, fechaAc, horaAc, man.getTipo().toUpperCase(), man.getAutorizacion(), man.getObserva(), resultado.toString(), estadoita, estadococina);
                    // Utilidades dg = new Utilidades();
                    // String encriptado = dg.Encriptar(tiket);
                    out.println(tiket);




                    //########################################################################################
                } else {
                    //out.println("NO TIENE PRODUCTO LA COMANDA");
                }
            } else {
                out.println("impreso");
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
