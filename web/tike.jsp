<%-- 
    Document   : tike
    Created on : 9/03/2013, 02:13:35 PM
    Author     : Eduardopc
--%>

<%@page import="com.mapping.Mesas"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.mapping.Adicionales"%>
<%@page import="com.mapping.VentaComanda"%>
<%@page import="com.dao.impl.VentaComandaDaoImpl"%>
<%@page import="com.mapping.Descuento"%>
<%@page import="com.mapping.Comanda"%>
<%@page import="java.text.NumberFormat"%>
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
          //  Empleado e = new Empleado();
            Altadia d = new Altadia();
            String nombre = "", nomMesero = "", tipoEvento = "";
           // e = (Empleado) sesion.getAttribute("id");
             String idBarra =(String)sesion.getAttribute("idBarra");
            String idMesero = "", idMesa = "", idComanda = "", idComandaTras = "", op = "";
            int idDia = 0;
            // ComandaDaoImpl daocan = new ComandaDaoImpl();
            //AdicionalesDaoImpl daol = new AdicionalesDaoImpl();
            double total = 0, sub = 0, iva = 0;
            //Producto p = new Producto();
            // List rescan = null;
            //Iterator itrcan = null;
            Date ahora = new Date();
            String espacio = " ";
            SimpleDateFormat dateFormat = new SimpleDateFormat("HH:mm:ss");
            SimpleDateFormat dateFormatf = new SimpleDateFormat("yyyy-MM-dd");
            String fechaAc = dateFormatf.format(ahora);
            String horaAc = dateFormat.format(ahora);
            Mesa_ventaDaoImpl mv = new Mesa_ventaDaoImpl();
            MesaVenta mvv = new MesaVenta();
            String clave = "";
            Mesas msa=new Mesas();
            float sumatotal = 0;
            if (idBarra == null) {
                response.sendRedirect("index.jsp");
            } else {
                nombre = " B1One";
                Empleado em = new Empleado();
                idComanda = (String) sesion.getAttribute("idComanda");
                op = (String) sesion.getAttribute("op");
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
                    msa=mvv.getMesas();
                    
                    clave = em.getEmpleadocol();

                }


            }


            conexion mysql = new conexion();
            Connection cn = mysql.Conectar();
            ResultSet rs = null;
            PreparedStatement st = null;

        %>
        <script type="text/javascript">
            function imprSelec(muestra)
            {
                var ficha = document.getElementById(muestra);
                var ventimp = window.open(' ', 'popimpr');
                ventimp.document.write(ficha.innerHTML);
                ventimp.document.close();
                ventimp.print();
                ventimp.close();
            }
        </script> 

    </head>
    <body onload="javascript:imprSelec('muestra')">

        <div id="muestra" >
            <table >
                <tr><td colspan="4" style=" text-align:center"><b>B1ONE<BR>Niza 19 Col.Juárez Delg. Cuauhtémoc  <BR>C.P. 06600 MÉXICO, D. F. <BR>TEL.  41 69 18 20<br>RFC: OPR1403115F3</b><hr></td></tr>

                <tr><td colspan="4">
                        <table>

                            <tr><td>Mesero:</td><td><td></tr>
                            <tr><td colspan="2"><h5><% out.println(nomMesero.toUpperCase());%></h5><td></tr>
                            <tr><td>Clave: </td><td><h3><% out.println(clave);%></h3><td></tr>
                            <tr><td>Mesa: </td><td><h3><% out.println(mvv.getIdMesaCapturada());%></h3><td></tr>
                            <tr><td>Cuenta: </td><td><% out.println(idMesa);%><td></tr>                                        
                            <tr><td>Personas Aprox: </td><td><% out.println(mvv.getPersonasAprox());%><td></tr>
                            <tr><td>FECHA: </td><td><% out.println(fechaAc);%><td></tr>
                            <tr><td>HORA: </td><td><% out.println(horaAc);%><td></tr>
                        </table>



                    </td></tr>
                <tr><td colspan="4"> <HR><td></tr>

                <%

                    try {

                        AdicionalesDaoImpl daoa = new AdicionalesDaoImpl();
                        Producto pa = new Producto();
                        float costo = 0;
                        int sumita = 0;
                        double totalsumuta = 0;
                        NumberFormat nf = NumberFormat.getInstance();
                        nf.setMaximumFractionDigits(2);
                        int idc = 0;
                        int sumadcio = 0;
                        String nombrePro = "", obseComanda = "", Autorza = "", Observavc = "", tipo = "", iddes = "", idProducto = "";
                        int cantidad = 0, cantidada = 0, idvc = 0;
                        String sSQla = "SELECT CONCAT(p.nombre,'// ',p.tamano) as nombre,count(vc.idProducto) as cantidad,vc.costo as costo,c.observa,c.Autorizacion,vc.Observaciones,vc.idVenta_Comandacol as idventa,c.tipo as tipo,vc.idDescuento,p.idProducto as idProducto,p.idCategoria as cat FROM mesa_venta mv,comanda c,venta_comanda vc,producto p where mv.idMesa_venta=c.idMesa_venta and c.idComanda=vc.idComanda and vc.idProducto=p.idProducto and c.estado='activo' and mv.idMesa_venta='" + idMesa + "' and c.idComanda like '%%' group by vc.idProducto,vc.idDescuento,c.observa order by vc.registro DESC";

                        st = cn.prepareStatement(sSQla);
                        rs = st.executeQuery();

                        while (rs.next()) {
                            String cat=rs.getString("cat");
                                        String atr="";
                                        if(cat.equals("COCINA")){
                                        atr="Ord";
                                        }else{
                                        atr="ml";
                                        }
                            nombrePro = rs.getString("nombre")+" "+atr;
                            obseComanda = rs.getString("c.observa");
                            cantidad = rs.getInt("cantidad");
                            costo = rs.getFloat("costo");
                            idvc = rs.getInt("idventa");
                            Autorza = rs.getString("c.Autorizacion");
                            Observavc = rs.getString("vc.Observaciones");
                            iddes = rs.getString("vc.idDescuento");
                            tipo = rs.getString("tipo");
                            totalsumuta = cantidad * costo;
                            sumatotal += totalsumuta;

                            if (tipo.equals("venta") && iddes.equals("Ninguno")) {
                                out.println("<tr><td colspan='2'>" + nombrePro + "</td><td>" + cantidad + "</td><td>$ " +  nf.format(totalsumuta) + "</td><td></td></tr>");
                            } else if (tipo.equals("venta") && (iddes.equals("ProIn3-4") || iddes.equals("ProIn2-3") || iddes.equals("ProIn4-5"))) {
                                out.println("<tr><td colspan='2'>" + nombrePro + " .<h5>" + tipo + " " + Observavc + "</td><td>" + cantidad + "</td><td>$ " +  nf.format(totalsumuta) + "</td></tr>");
                            } else {
                                if (iddes.equals("Ninguno")) {
                                    iddes = "";
                                }
                                out.println("<tr><td colspan='2'>" + nombrePro + " <h5>" + tipo + " " + Observavc + "<br>" + obseComanda + "</h5><h5>Autoriza: " + Autorza + "</h5></td><td>" + cantidad + "</td><td>$ " +  nf.format(totalsumuta) + "</td><td></td></tr>");
                            }
//Adicionales #######################
                           /* List resa = daoa.getMostrar(idvc);
                            Iterator itra = resa.iterator();

                            while (itra.hasNext()) {
                                Adicionales aa = (Adicionales) itra.next();
                                pa = aa.getProducto();
                                sumadcio = daoa.contar(pa.getIdProducto(), idvc) * cantidad;
                                out.println("<tr><td width='70px'></td><td style='background-color:yellow'>" + pa.getNombre() + "</td><td style='background-color:yellow'>" + sumadcio + "</td><td style='background-color:yellow'>$ 0</td><td></td></tr>");
                                // System.out.println(pa.getNombre() + " " + sumadcio);

                            }*/



                            //######################

                        }

                       // Mesa_ventaDaoImpl mvt = new Mesa_ventaDaoImpl();
                        //mvt.actualiza(idMesa, sumatotal);

                        // Mesa_ventaDaoImpl mvt = new Mesa_ventaDaoImpl();
                        //mvt.actualiza(idMesa, sumatotal);
                       
                        total = sumatotal * (.16);
                        sub = sumatotal /1.16;
                        iva = sub * (.16);
                        String ste = nf.format(iva);
                        String subto = nf.format(sub);



                %> 

                <tr><td ></td><td colspan="3" style="text-align:right">_________________</td></tr>
                <tr><td colspan="3">Subtotal:</td><td style="text-align:right">$<%out.println(subto);%> </td></tr>
                <tr><td colspan="3">IVA 16%:</td><td style="text-align:right">$<%out.println(ste);%>  </td></tr>
                <tr><td></td><td colspan="3" style="text-align:right">___________________</td></tr>
                <tr><td colspan="3">TOTAL:</td><td style="text-align:right"><b>$<%out.println(sumatotal);%></b></td></tr>
              
                <tr><td colspan="4" style="text-align:center">RESERVACIONES</td></tr>
                <tr><td colspan="4" style="text-align:center">www.b1restobar.mx<br>Tel. 41 69 18 20</td></tr>               
                <tr><td colspan="4" style="text-align:center">WHATSAPP 5521060721</td></tr>
                <tr><td colspan="4" style="text-align:center">Si solicita factura<br>favor indique a nuestro personal<br></td></tr>
                 <tr><td colspan="4" style="text-align:center">SiPoliticas de privacidad<br>disponibles en pagina Web<br></td></tr>
               


            </table>
        </div>

        <%
            } catch (SQLException ex) {
                ex.printStackTrace();
                if (cn != null) {
                                        try {
                                            System.err.print("Transaction is being rolled back");
                                            cn.rollback();
                                        } catch (SQLException excep) {
                                           
                                        }
                                    }
            } finally {
                cn.close();
                rs.close();
                st.close();
            }
            String mensaje = "Se imprimio correctamente el tiket";


            out.println(" <script src=\"js/jquery-1.7.2.min.js\"></script>");
            out.println("<script src=\"js/jquery-ui-1.8.21.custom.min.js\"></script>");
            out.println(" <link rel='stylesheet' type='text/css' href='css/jquery-ui-1.8.21.custom.css'>");
            out.println("  <style type=\"text/css\">");
            out.println("  body {");
            out.println("    padding-top: 210px;");
            out.println("    </style>");
            out.println(" </head>");
            out.println("<body>");
            out.println("<script>");

            out.println("$(function() {");
            // a workaround for a flaw in the demo system (http://dev.jqueryui.com/ticket/4375), ignore!
            out.println("$( \"#dialog:ui-dialog\" ).dialog( \"disable\" );");

            out.println("$( \"#dialog-message\" ).dialog({");

            out.println("modal: true,");
            out.println("buttons: {");
            out.println("	Ok: function() {");
            out.println("  $( this ).dialog( \"close\" );");
            if (op.equals("close")) {
                out.println("	$(location).attr('href','CuentasCerradas.jsp');");
            } else {
                out.println("	$(location).attr('href','Comanda_venta.jsp');");
            }
            // out.println("	$(location).attr('href','CajaCover.jsp?dia="+diaS+"');");
            out.println("	}");
            out.println("}");
            out.println("});");
            out.println("});");
            out.println("</script>");

            out.println("   <div id='dialog-message' title='Comprobación'>");
            out.println("<p>");
            out.println(" <br><span class='ui-icon ui-icon-circle-check' style='float:left; margin:0 7px 50px 0;'></span>");
            out.println("         " + mensaje + "");
            out.println("     </p>");

            out.println("</div>");

            out.println("<div align=\"center\">");
            if (op.equals("close")) {
                out.println("<a href=\"CuentasCerradas.jsp\"/><button style=\"height:100px; color:#03F\">SE GENERO TIKET CORRECATEMENTE<BR>ACPETAR<HR>REGRESAR <-- </button></a>");
            } else {
                out.println("<a href=\"Comanda_venta.jsp\"/><button style=\"height:100px; color:#03F\">SE GENERO TIKET CORRECATEMENTE<BR>ACPETAR<HR>REGRESAR <-- </button></a>");
            }
            // out.println("<a href=\"CajaCover.jsp?dia="+diaS+"\"><button style=\"height:100px; color:#03F\">SE GENERO TIKET CORRECATEMENTE<BR>ACPETAR<HR>REGRESAR <-- </button></a>");
            out.println(" </div>");

        %>
    </body>
     <script Language="JavaScript">

           
                if (history.forward(1)) {
                    history.replace(history.forward(1));
                    
                }
          
        </script>
</html>
