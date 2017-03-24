<%-- 
    Document   : tike
    Created on : 9/03/2013, 02:13:35 PM
    Author     : Eduardopc
--%>

<%@page import="com.mapping.Adicionales"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.mapping.Comanda"%>
<%@page import="otrosNOsirve.consultasMysq"%>
<%@page import="com.mapping.MesaVenta"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="com.dao.impl.Mesa_ventaDaoImpl"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="com.mapping.Producto"%>
<%@page import="com.dao.impl.AdicionalesDaoImpl"%>
<%@page import="com.dao.impl.ComandaDaoImpl"%>
<%@page import="com.mapping.Altadia"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="otrosNOsirve.conexion"%>
<%@page import="com.mapping.Empleado"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <title>Tiket</title>


        <%
            HttpSession sesion = request.getSession();
            //Empleado e = new Empleado();
            Altadia d = new Altadia();
            String nombre = "", nomMesero = "", tipoEvento = "";
            String idBarra = (String) sesion.getAttribute("idBarra");
            //  e = (Empleado) sesion.getAttribute("id");
            String idMesero = "", idMesa = "", idComanda = "", idComandaTras = "";
            int idDia = 0;
            ComandaDaoImpl daocan = new ComandaDaoImpl();
            AdicionalesDaoImpl daol = new AdicionalesDaoImpl();
            double total = 0, sub = 0, iva = 0;
            Producto p = new Producto();
            List rescan = null;
            Iterator itrcan = null;
            Date ahora = new Date();
            String espacio = " ";
            SimpleDateFormat dateFormat = new SimpleDateFormat("HH:mm:ss");
            SimpleDateFormat dateFormatf = new SimpleDateFormat("yyyy-MM-dd");
            String fechaAc = dateFormatf.format(ahora);
            String horaAc = dateFormat.format(ahora);
            Mesa_ventaDaoImpl mv = new Mesa_ventaDaoImpl();
            String mesaCuenta="";
            MesaVenta mvv = new MesaVenta();
            String clave = "";
            ComandaDaoImpl daoc = new ComandaDaoImpl();
            Comanda c = new Comanda();
            if (idBarra == null) {
                response.sendRedirect("index.jsp");
            } else {
                idComanda = (String) sesion.getAttribute("idComanda");

                nombre = " B1One";
                Empleado em = new Empleado();

                idMesa = (String) sesion.getAttribute("idMesa");
                em = (Empleado) sesion.getAttribute("idMesero");
                if (nombre.equals(em.getIdEmpleado())) {
                    response.sendRedirect("Menu.jsp");
                } else {
                    nomMesero = em.getNombre() + " " + em.getApellidos();
                    d = (Altadia) sesion.getAttribute("idDia");
                    idMesero = em.getIdEmpleado();
                    idDia = d.getIdaltadia();
                    tipoEvento = d.getTipoEvento();
                    mvv = mv.bucarPorId(idMesa);
                    clave = em.getEmpleadocol();
mesaCuenta=mvv.getIdMesaCapturada();
                    c = daoc.bucarPorId(idComanda);
                    if (c.getImpreso().equals("Impreso")) {

                        response.sendRedirect("MensajeImpreso.jsp");
                    } else {
                        daoc.actulizarImp(idComanda, "Impreso");
                    }


                }


            }
//style="display:none"
%>
        <script src="js/jquery-1.7.2.min.js"></script>
        <script src="js/jquery-ui-1.8.21.custom.min.js"></script>
        <script src="js/jquery.alerts.js"></script>        
        <link rel="stylesheet" type="text/css" href="js/jquery.alerts.css">
        <script type="text/javascript">
            function imprSelec(muestra)
            {

                var ficha = document.getElementById(muestra);
                var ventimp = window.open(' ', 'popimpr');
                ventimp.document.write(ficha.innerHTML);
                ventimp.document.close();
                ventimp.print();
                ventimp.close();
                //$(location).attr('href', "ImpresionVerificar.jsp");

               jConfirm("Desea 'CONTINUAR' ?", "Impresion Copia", function(r) {
                    if (r) {
                        $(location).attr('href', "tikeComandaCopia.jsp");
                       // $(location).attr('href', href = 'SessionIdMesaComanda?idMesaVenta=' + id + '&idComanda=VER&tipo=venta&observa=-&autorizacion=-');
                    } else {
                        $(location).attr('href', "tikeComandaCopia.jsp");
                    }
                });
            }



        </script> 


    </head>

    <body onload="javascript:imprSelec('muestra')">

        <div id="muestra" style="display:none">
            <table >
                <tr><td colspan="4" style=" text-align:center"><b><BR>PEDIDO<BR><hr></td></tr>

                            <tr><td colspan="4">
                                    <table>

                                        <tr><td colspan="2">Mesero:</td></tr>
                                        <tr><td colspan="2"><h3><% out.println(nomMesero.toUpperCase());%></h3><td></tr>
                                        <tr><td>Clave: </td><td><h3><% out.println(clave);%></h3><td></tr>
                                        <tr><td>Mesa: </td><td><h2><% out.println(mesaCuenta);%></h2><td></tr>
                                        <tr><td>Cuenta: </td><td><% out.println(idMesa);%><td></tr>
                                        <tr><td>Comanda: </td><td><% out.println(idComanda);%><td></tr>
                                        <tr><td>FECHA: </td><td><% out.println(fechaAc);%><td></tr>
                                        <tr><td>HORA: </td><td><% out.println(horaAc);%><td></tr>
                                        <tr><td>TIPO: </td><td><h3><% out.println(c.getTipo().toUpperCase());%></h3><td></tr>
                                        <%
                                            String t = c.getTipo();

                                            if (!t.equals("venta")) {

                                        %>
                                        <tr><td>Autorización: </td><td><td></tr>
                                        <tr><td colspan="2"><% out.println(c.getAutorizacion());%><td></tr>
                                        <tr><td>Descripción: </td><td><td></tr>
                                        <tr><td colspan="2"><% out.println(c.getObserva());%><td></tr>
                                            <%
                                                }
                                            %>

                                    </table>



                                </td></tr>


                            <tr><td colspan="4"> <HR><td></tr>

                            <%
                                int sumita = 0;
                                double totalsumuta = 0;

                                int idc = 0;
                                int sumadcio = 0;
                                String nombrePro = "", obseComanda = "", Autorza = "", Observavc = "", tipo = "", iddes = "", idProducto = "";
                                int cantidad = 0, cantidada = 0, idvc = 0;
                                Producto pa = new Producto();
                                conexion mysql = new conexion();
                                Connection cn = mysql.Conectar();

                                ResultSet rsc = null;

                                PreparedStatement stc = null;
                                float sumatotal = 0, costo = 0;
                                AdicionalesDaoImpl daoa = new AdicionalesDaoImpl();
                                ComandaDaoImpl co = new ComandaDaoImpl();
                                Comanda cv = new Comanda();
                                cv = co.bucarPorId(idComanda);
                                tipo = cv.getTipo();
                                //out.println("Entrooooo");

                                out.println("<tr><th colspan='2'>Producto</th><th>Cantidad</th></tr>");
                                try {

                                    String sSQl = "SELECT CONCAT(p.nombre,'// ',p.tamano) as nombre,count(vc.idProducto) as cantidad,vc.costo as costo,c.observa,c.Autorizacion,vc.Observaciones,vc.idVenta_Comandacol as idventa,c.tipo as tipo,vc.idDescuento,p.idProducto as idProducto,p.idCategoria as cat FROM mesa_venta mv,comanda c,venta_comanda vc,producto p where mv.idMesa_venta=c.idMesa_venta and c.idComanda=vc.idComanda and vc.idProducto=p.idProducto and c.estado='activo' and mv.idMesa_venta='" + idMesa + "' and c.idComanda like '%" + idComanda + "%' group by  vc.idProducto,vc.idDescuento,c.observa order by vc.registro DESC";
                                    //     String sSQl = "SELECT CONCAT(p.nombre,'// ',p.tamano,' ml') as nombre,count(vc.idProducto) as cantidad,vc.costo as costo,c.observa,c.Autorizacion,vc.Observaciones,vc.idVenta_Comandacol as idventa,c.tipo as tipo,vc.idDescuento,p.idProducto as idProducto FROM Mesa_venta mv,Comanda c,Venta_Comanda vc,Producto p where mv.idMesa_venta=c.idMesa_venta and c.idComanda=vc.idComanda and vc.idProducto=p.idProducto and c.estado='activo' and mv.idMesa_venta='" + idMesa + "' and c.idComanda like '%" + idComanda + "%' group by vc.idVenta_Comandacol,vc.idDescuento,c.observa order by vc.registro DESC";

                                    stc = cn.prepareStatement(sSQl);
                                    rsc = stc.executeQuery();
                                    while (rsc.next()) {
                                        String cat=rsc.getString("cat");
                                        String atr="";
                                        if(cat.equals("COCINA")){
                                        atr="Ord";
                                        }else{
                                        atr="ml";
                                        }
                                        nombrePro = rsc.getString("nombre")+" "+atr;

                                        cantidada = rsc.getInt("cantidad");
                                        idvc = rsc.getInt("idventa");
                                        idProducto = rsc.getString("idProducto");

                                        out.println("<tr><td colspan='2'> " + nombrePro + "</td><td>" + cantidada + "</td></tr>");


//Adicionales #######################
                                        List resa = daoa.getMostrar(idvc);
                                        Iterator itra = resa.iterator();

                                        while (itra.hasNext()) {
                                            Adicionales aa = (Adicionales) itra.next();
                                            pa = aa.getProducto();
                                            sumadcio = daoa.contar(pa.getIdProducto(), idvc) * cantidada;

                                            out.println("<tr><td width='70px'></td><td style='background-color:yellow'>" + pa.getNombre() + "</td><td style='background-color:yellow'>" + sumadcio + "</td></tr>");




                                        }



                                        //######################

                                    }






                                } catch (SQLException ex) {

                                    if (cn != null) {
                                        try {
                                            System.err.print("Transaction is being rolled back");
                                            cn.rollback();
                                        } catch (SQLException excep) {
                                        }
                                    }

                                } finally {

                                    System.out.println("se cerro conexión tiketComanda.jsp!");
                                    cn.close();
                                    rsc.close();
                                    stc.close();
                                }

                            %> 


                           


            </table>
        </div>

    </body>
     <script Language="JavaScript">

           
                if (history.forward(1)) {
                    history.replace(history.forward(1));
                    
                }
          
        </script>
</html>
