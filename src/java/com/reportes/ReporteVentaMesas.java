/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.reportes;

import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.FontFactory;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import com.mapping.Altadia;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.jfree.data.general.DefaultPieDataset;
import otrosNOsirve.conexion;
import otrosNOsirve.consultasMysq;

/**
 *
 * @author Eduardo
 */
public class ReporteVentaMesas extends HttpServlet {

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
    int text = 10;
    String ruta = "";
    int idDia = 0;
    consultasMysq con = new consultasMysq();
    String direccion = "";
    Dibujar g = new Dibujar();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/pdf");
        ruta = getServletContext().getRealPath("/");
        Date ahora = new Date();
        SimpleDateFormat dateFormat = new SimpleDateFormat("HH:mm:ss");
        SimpleDateFormat dateFormatf = new SimpleDateFormat("yyyy-MM-dd");
        String fechaAc = dateFormatf.format(ahora);
        String horaAc = dateFormat.format(ahora);
        String hora = fechaAc + " " + horaAc;
        conexion mysql = new conexion();
        Connection cn = mysql.Conectar();
        ResultSet rsc = null;
        PreparedStatement stc = null;
        // ResultSet rscc = null;
        //PreparedStatement stcc = null;
        HttpSession sesion = request.getSession();
        Altadia d = new Altadia();
        d = (Altadia) sesion.getAttribute("idDia");

        idDia = d.getIdaltadia();
        // idDia = 2;
        try {
            // step 1
            Document document = new Document(PageSize.LETTER.rotate());
            document.setPageSize(PageSize.A4);
            document.setMargins(50, 50, 30, 50);
            // step 2
            PdfWriter.getInstance(document, response.getOutputStream());
            // step 3
            document.open();

            Paragraph paragraph = new Paragraph("Estadística\nB1ONE",
                    FontFactory.getFont("arial",
                    22, Font.BOLD));
            paragraph.setAlignment(Element.ALIGN_CENTER);
            document.add(paragraph);
            Paragraph paragraphs = new Paragraph(" D. F. TEL.  41 69 18 20\nREPORTE DEL DIA : " + d.getFecha(),
                    FontFactory.getFont("arial",
                    11, Font.NORMAL));
            paragraphs.setAlignment(Element.ALIGN_CENTER);
            document.add(paragraphs);
            Paragraph paragraphf = new Paragraph(hora,
                    FontFactory.getFont("arial",
                    10, Font.ITALIC));
            paragraphf.setAlignment(Element.ALIGN_RIGHT);
            document.add(paragraphf);
            document.add(new Paragraph("\n"));

            Paragraph sc = new Paragraph("Venta Cuentas",
                    FontFactory.getFont("arial",
                    16, Font.BOLD));
            paragraph.setAlignment(Element.ALIGN_LEFT);
            document.add(sc);
            document.add(new Paragraph("\n\n"));
            //Tabla salidaas###################################


            PdfPTable tablasc = new PdfPTable(7);
            tablasc.setWidthPercentage(100f);
            PdfPCell cellsc = new PdfPCell(new Paragraph("Nombre",
                    FontFactory.getFont("arial",
                    text, Font.BOLD)));
            // fuente

            cellsc.setBackgroundColor(BaseColor.GRAY);
            cellsc.setHorizontalAlignment(tablasc.ALIGN_CENTER);


            PdfPCell cell1scc = new PdfPCell(new Paragraph("Cuenta",
                    FontFactory.getFont("arial",
                    text, Font.BOLD)));
            // fuente
            cell1scc.setBackgroundColor(BaseColor.GRAY);
            cell1scc.setHorizontalAlignment(tablasc.ALIGN_CENTER);
            PdfPCell cell1sci = new PdfPCell(new Paragraph("Inicio",
                    FontFactory.getFont("arial",
                    text, Font.BOLD)));
            // fuente
            cell1sci.setBackgroundColor(BaseColor.GRAY);
            cell1sci.setHorizontalAlignment(tablasc.ALIGN_CENTER);
            PdfPCell cell1scf = new PdfPCell(new Paragraph("Final",
                    FontFactory.getFont("arial",
                    text, Font.BOLD)));
            // fuente
            cell1scf.setBackgroundColor(BaseColor.GRAY);
            cell1scf.setHorizontalAlignment(tablasc.ALIGN_CENTER);
            PdfPCell cell1sct = new PdfPCell(new Paragraph("TOTAL",
                    FontFactory.getFont("arial",
                    text, Font.BOLD)));
            // fuente
            cell1sct.setBackgroundColor(BaseColor.GRAY);
            cell1sct.setHorizontalAlignment(tablasc.ALIGN_CENTER);

            PdfPCell cell1sc = new PdfPCell(new Paragraph("Autzo Cierre",
                    FontFactory.getFont("arial",
                    text, Font.BOLD)));
            // fuente
            cell1sc.setBackgroundColor(BaseColor.GRAY);
            cell1sc.setHorizontalAlignment(tablasc.ALIGN_CENTER);
            PdfPCell cell1scm = new PdfPCell(new Paragraph("Observación",
                    FontFactory.getFont("arial",
                    text, Font.BOLD)));
            // fuente
            cell1scm.setBackgroundColor(BaseColor.GRAY);
            cell1scm.setHorizontalAlignment(tablasc.ALIGN_CENTER);


            tablasc.addCell(cellsc);

            tablasc.addCell(cell1scc);
            tablasc.addCell(cell1sci);
            tablasc.addCell(cell1scf);
            tablasc.addCell(cell1sct);
            tablasc.addCell(cell1sc);
            tablasc.addCell(cell1scm);




            String horav = "";
            int sum = 0;

            // float total = con.reporte(idDia, "v");
            String sSQl = "select e.Nombre,e.apellidos,e.Empleadocol,ROUND(sum(vc.costo)) as total ,mv.idMesa_venta,mv.idMesa,mv.HoraAbierta,mv.HoraCerrada,mv.Atorizacion,mv.Observaciones from venta_comanda vc,comanda c,mesa_venta mv,empleado e where e.idEmpleado=mv.idEmpleado and mv.idMesa_venta=c.idMesa_venta and c.idComanda=vc.idComanda and c.idaltadia=" + idDia + " and mv.estado!='Cancelado' and c.estado!='Cancelado'  group by mv.idEmpleado,mv.idMesa_venta order by e.Nombre";

            stc = cn.prepareStatement(sSQl);
            rsc = stc.executeQuery();
            float to = 0;
            double totalli = 0;
            DefaultPieDataset hM = new DefaultPieDataset();
            while (rsc.next()) {
                //System.out.println(rsc.getString("total") + " a " + rsc.getString("hora"));
                to = rsc.getFloat("total");
                totalli += to;
                // sum=Integer.parseInt(rsc.getString("hora").substring(11,13))-1;
                //  horav = rsc.getString("hora").substring(10, 13) + ":00:00 hrs.";
                PdfPCell cell6p = new PdfPCell(new Paragraph(rsc.getString("e.Nombre") + " " + rsc.getString("e.apellidos"),
                        FontFactory.getFont("arial",
                       text, Font.NORMAL)));
                cell6p.setHorizontalAlignment(tablasc.ALIGN_LEFT);
                tablasc.addCell(cell6p);

                PdfPCell celvtv = new PdfPCell(new Paragraph(rsc.getString("mv.idMesa_venta"),
                        FontFactory.getFont("arial",
                        text, Font.NORMAL)));
                celvtv.setHorizontalAlignment(tablasc.ALIGN_CENTER);
                tablasc.addCell(celvtv);
                PdfPCell celvti = new PdfPCell(new Paragraph("" + rsc.getString("mv.HoraAbierta") + " Hrs.",
                        FontFactory.getFont("arial",
                       text, Font.NORMAL)));
                celvti.setHorizontalAlignment(tablasc.ALIGN_LEFT);
                tablasc.addCell(celvti);
                PdfPCell celvtf = new PdfPCell(new Paragraph("" + rsc.getString("mv.HoraCerrada") + " Hrs.",
                        FontFactory.getFont("arial",
                       text, Font.NORMAL)));
                celvtf.setHorizontalAlignment(tablasc.ALIGN_LEFT);
                tablasc.addCell(celvtf);
                PdfPCell celvtx = new PdfPCell(new Paragraph("      $ " + rsc.getString("total"),
                        FontFactory.getFont("arial",
                        text, Font.NORMAL)));
                celvtx.setHorizontalAlignment(tablasc.ALIGN_LEFT);
                tablasc.addCell(celvtx);

                PdfPCell celvaut = new PdfPCell(new Paragraph(rsc.getString("mv.Atorizacion"),
                        FontFactory.getFont("arial",
                        text, Font.NORMAL)));
                celvaut.setHorizontalAlignment(tablasc.ALIGN_LEFT);
                tablasc.addCell(celvaut);
                //#################
                PdfPCell celosbsr = new PdfPCell(new Paragraph(rsc.getString("mv.Observaciones"),
                        FontFactory.getFont("arial",
                        text, Font.NORMAL)));
                celosbsr.setHorizontalAlignment(tablasc.ALIGN_LEFT);
                tablasc.addCell(celosbsr);
                // hM.setValue(horav + (to * 100) / total + "%", to);

            }

            PdfPCell cell7 = new PdfPCell(new Paragraph("",
                    FontFactory.getFont("arial",
                    text, Font.NORMAL)));
            cell7.setHorizontalAlignment(tablasc.ALIGN_LEFT);
            cell7.setBackgroundColor(BaseColor.GRAY);
            tablasc.addCell(cell7);
            PdfPCell celv8 = new PdfPCell(new Paragraph("",
                    FontFactory.getFont("arial",
                    text, Font.NORMAL)));
            celv8.setBackgroundColor(BaseColor.GRAY);
            celv8.setHorizontalAlignment(tablasc.ALIGN_CENTER);

            tablasc.addCell(celv8);
            PdfPCell celv9 = new PdfPCell(new Paragraph("",
                    FontFactory.getFont("arial",
                    text, Font.NORMAL)));
            celv9.setBackgroundColor(BaseColor.GRAY);
            celv9.setHorizontalAlignment(tablasc.ALIGN_CENTER);

            tablasc.addCell(celv9);
            PdfPCell celv13 = new PdfPCell(new Paragraph("",
                    FontFactory.getFont("arial",
                   text, Font.NORMAL)));
            celv13.setBackgroundColor(BaseColor.GRAY);
            celv13.setHorizontalAlignment(tablasc.ALIGN_CENTER);

            tablasc.addCell(celv13);
            PdfPCell celv14 = new PdfPCell(new Paragraph("",
                    FontFactory.getFont("arial",
                    text, Font.NORMAL)));
            celv14.setBackgroundColor(BaseColor.GRAY);
            celv14.setHorizontalAlignment(tablasc.ALIGN_CENTER);

            tablasc.addCell(celv14);

            PdfPCell celv10 = new PdfPCell(new Paragraph(" TOTAL: ",
                    FontFactory.getFont("arial",
                    text, Font.NORMAL)));
            celv10.setBackgroundColor(BaseColor.GRAY);
            celv10.setHorizontalAlignment(tablasc.ALIGN_CENTER);

            tablasc.addCell(celv10);
            PdfPCell celv11 = new PdfPCell(new Paragraph("    $ " + totalli,
                    FontFactory.getFont("arial",
                    text, Font.NORMAL)));
            celv11.setBackgroundColor(BaseColor.GRAY);
            celv11.setHorizontalAlignment(tablasc.ALIGN_CENTER);

            tablasc.addCell(celv11);

            document.add(tablasc);



//################################
            document.close();
        } catch (SQLException ex) {
            Logger.getLogger(ReporteHoraVenta.class.getName()).log(Level.SEVERE, null, ex);

        } catch (DocumentException ex) {
            Logger.getLogger(ReporteHoraVenta.class.getName()).log(Level.SEVERE, null, ex);

        } finally {
            try {
                cn.close();
                rsc.close();
                stc.close();
                //rscc.close();
                //   stcc.close();

                //  out.close();
            } catch (SQLException ex) {
                Logger.getLogger(ReporteHoraVenta.class.getName()).log(Level.SEVERE, null, ex);
            }
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
