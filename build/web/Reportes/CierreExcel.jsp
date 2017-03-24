<%-- 
    Document   : Actualizar
    Created on : 24/04/2013, 03:27:46 PM
    Author     : Eduardopc
--%>

<%@page import="com.mapping.Pagoscorte"%>
<%@page import="com.dao.impl.PagoscorteDaoImpl"%>
<%@page import="com.mapping.MesaVenta"%>
<%@page import="com.dao.impl.Mesa_ventaDaoImpl"%>
<%@page import="com.mapping.Altadia"%>
<%@page import="com.dao.impl.AltadiaDaoImpl"%>
<%@page import="com.dao.impl.BarraDaoImpl"%>
<%@page import="com.mapping.Barra"%>
<%@page import="com.dao.impl.MesasDaoImpl"%>
<%@page import="com.mapping.Mesas"%>
<%@page import="com.mapping.Zona"%>
<%@page import="com.dao.impl.ZonaDaoImpl"%>
<%@page import="com.mapping.Puesto"%>
<%@page import="com.dao.impl.PuestoDaoImpl"%>
<%@page import="com.mapping.Empleado"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="com.dao.impl.EmpleadoDaoImpl"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>

        
        <title>Cierre</title>
        <%
            HttpSession sesion = request.getSession();
            Empleado e = new Empleado();
            Altadia d = new Altadia();
            String nombre = "", nomMesero = "", tipoEvento = "";
            String idBarra = (String) sesion.getAttribute("idBarra");
            String idMesero = "", idMesa = "", idComanda = "";
            int idDia = 0;
            String dia = "";



            if (idBarra == null) {
                response.sendRedirect("../index.jsp");
            } else {

                d = (Altadia) sesion.getAttribute("idDia");

                idDia = d.getIdaltadia();
                dia = d.getFecha();
                response.setContentType("application/vnd.ms-excel"); //Tipo de fichero.

                response.setHeader("Content-Disposition", "attachment;filename=\"Corte" + d.getTipoEvento() + "" + dia + ".xls\"");



            }
        %>



    </head>

    <body>
        
                    
                        <div style="text-align:center">
                            <label><h2>Corte B1One <br> <% out.print(dia);%></h2></label>
                        </div>
                        <table class="table table-striped">
                            <tr>                        
                                <th>Nombre</th>
                                <th>Clave</th>
                                <th>Total</th>
                                <th>Efectivo</th>
                                <th>Tarjetas</th>
                                <th>Editar</th>
                            </tr>
                            <%
                                Mesa_ventaDaoImpl dao = new Mesa_ventaDaoImpl();
                                List res = dao.getCorte(idDia);
                                Iterator itr = res.iterator();
                                PagoscorteDaoImpl daop = new PagoscorteDaoImpl();
                                Pagoscorte pc = new Pagoscorte();
                                Pagoscorte pci = new Pagoscorte();
                                float total = 0;
                                float tt = 0, te = 0, tta = 0;
                                float inicioy = 0;
                                int verMesesa = 0;
                                //    Empleado e=new Empleado();

                                while (itr.hasNext()) {
                                    MesaVenta em = (MesaVenta) itr.next();
                                    e = em.getEmpleado();
                                    Puesto pu = new Puesto();
                                    pu = e.getPuesto();
                                    total = dao.Sumtotal(idDia, e.getIdEmpleado());
                                    verMesesa = dao.MesaAbiertas(e.getIdEmpleado());
                                    if (verMesesa > 0) {
                                        out.println("<tr><td style='background-color:red' >" + e.getNombre() + " " + e.getApellidos() + "</td><td style='background-color:red' >" + e.getEmpleadocol() + "</td><td style='background-color:red' >" + total + "</td><td style='background-color:red' >" + em.getEfectivo() + "</td><td style='background-color:red' >" + em.getTarjeta() + "</td><td style='background-color:red' ></td></tr>");
                                    } else {
                                        pc = daop.buscar(e.getIdEmpleado(), idDia);
                                        if (pc != null) {

                                            daop.actualizar(pc.getIdPagosCorte(), total);

                                            if (pc.getEfectivo() == 0 && pc.getTarjetas() == 0) {
                                                out.println("<tr><td style='background-color:yellow' >" + e.getNombre() + " " + e.getApellidos() + "</td><td style='background-color:yellow' >" + e.getEmpleadocol() + "</td><td style='background-color:yellow' >" + pc.getTotal() + "</td><td style='background-color:yellow' >" + pc.getEfectivo() + "</td><td style='background-color:yellow' >" + pc.getTarjetas() + "</td><td style='background-color:yellow'><button class='btn btn-large btn-primary btncuenta' name='" + pc.getIdPagosCorte() + "' type='button'>PAGAR</button></td></tr>");
                                            } else {
                                                if (pu.getIdpuesto() == 12 || pu.getIdpuesto() == 5) {
                                                    out.println("<tr><td>" + e.getNombre() + " " + e.getApellidos() + "</td><td>" + e.getEmpleadocol() + "</td><td>" + pc.getTotal() + "</td><td>" + pc.getEfectivo() + "</td><td>" + pc.getTarjetas() + "</td><td><button class='btn btn-large btn-primary btncuenta' name='" + pc.getIdPagosCorte() + "' type='button'>Editar</button></td></tr>");
                                                    float a = pc.getTotal();
                                                    float b = pc.getEfectivo();
                                                    float c = pc.getTarjetas();
                                                    tt += a;
                                                    te += b;
                                                    tta += c;
                                                }
                                            }
                                        } else {

                                            e.setIdEmpleado(e.getIdEmpleado());
                                            pci.setEmpleado(e);
                                            d.setIdaltadia(idDia);
                                            pci.setAltadia(d);
                                            pci.setTotal(total);
                                            pci.setEfectivo(inicioy);
                                            pci.setTarjetas(inicioy);
                                            pci = daop.insertar(pci);


                                            if (pci.getEfectivo() == 0 && pci.getTarjetas() == 0) {
                                                out.println("<tr><td style='background-color:yellow' >" + e.getNombre() + " " + e.getApellidos() + "</td><td style='background-color:yellow' >" + e.getEmpleadocol() + "</td><td style='background-color:yellow' >" + pci.getTotal() + "</td><td style='background-color:yellow' >" + pci.getEfectivo() + "</td><td style='background-color:yellow' >" + pci.getTarjetas() + "</td><td style='background-color:yellow'><button class='btn btn-large btn-primary btncuenta' name='" + pci.getIdPagosCorte() + "' type='button'>PAGAR</button></td></tr>");
                                            } else {
                                                out.println("<tr><td>" + e.getNombre() + " " + e.getApellidos() + "</td><td>" + e.getEmpleadocol() + "</td><td>" + pc.getTotal() + "</td><td>" + pc.getEfectivo() + "</td><td>" + pci.getTarjetas() + "</td><td><button class='btn btn-large btn-primary btncuenta' name='" + pci.getIdPagosCorte() + "' type='button'>Editar</button></td></tr>");


                                            }

                                        }
                                    }


                                }
                            %>
                            <tr>                        
                                <th></th>

                                <th>TOTAL:</th>
                                <th><%  out.println(tt);%></th>
                                <th><%  out.println(te);%></th>
                                <th><%  out.println(tta);%></th>
                                <th></th>
                            </tr>
                        </table>
                   
               
            


    </body>
</html>
