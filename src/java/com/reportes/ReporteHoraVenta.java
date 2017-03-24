/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.reportes;

import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Chunk;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.FontFactory;
import com.itextpdf.text.Image;
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
public class ReporteHoraVenta extends HttpServlet {

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
    int text = 12;
    String ruta = "";
    int idDia = 0;
    consultasMysq con = new consultasMysq();
    String direccion = "";
    Dibujar g = new Dibujar();
    

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       // response.setContentType("text/html;charset=UTF-8");
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
        ResultSet rscc = null;
        PreparedStatement stcc = null;
        HttpSession sesion = request.getSession();
        Altadia d = new Altadia();
        d = (Altadia) sesion.getAttribute("idDia");

        idDia = d.getIdaltadia();
        // idDia = 2;
        try {
            // step 1
            Document document = new Document();
            // step 2
            PdfWriter.getInstance(document, response.getOutputStream());
            // step 3
            document.open();
            Paragraph paragraph = new Paragraph("Estadística\nB1ONE",
                    FontFactory.getFont("arial",
                    22, Font.BOLD));
            paragraph.setAlignment(Element.ALIGN_CENTER);
            document.add(paragraph);
            Paragraph paragraphs = new Paragraph(" D. F. TEL.  41 69 18 20\nREPORTE DEL DIA : "+d.getFecha(),
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

            Paragraph sc = new Paragraph("Venta ByLatino",
                    FontFactory.getFont("arial",
                    16, Font.BOLD));
            paragraph.setAlignment(Element.ALIGN_LEFT);
            document.add(sc);
            document.add(new Paragraph("\n\n"));
            //Tabla salidaas###################################


            PdfPTable tablasc = new PdfPTable(2);

            PdfPCell cellsc = new PdfPCell(new Paragraph("Venta",
                    FontFactory.getFont("arial",
                    text, Font.BOLD)));
            // fuente

            cellsc.setBackgroundColor(BaseColor.GRAY);
            cellsc.setHorizontalAlignment(tablasc.ALIGN_CENTER);

            PdfPCell cell1sc = new PdfPCell(new Paragraph("Hora",
                    FontFactory.getFont("arial",
                    text, Font.BOLD)));
            // fuente
            cell1sc.setBackgroundColor(BaseColor.GRAY);
            cell1sc.setHorizontalAlignment(tablasc.ALIGN_CENTER);


            tablasc.addCell(cellsc);
            tablasc.addCell(cell1sc);





            String horav = "";
            int sum = 0;

            float total = con.reporte(idDia, "v");
            String sSQl = "select ROUND(sum(vc.costo)) as total,vc.registro as hora from mesa_venta mv,comanda c, venta_comanda vc ,empleado e where mv.idMesa_venta=c.idMesa_venta  and e.idEmpleado=mv.idEmpleado and c.idComanda=vc.idComanda and mv.idaltadia=" + idDia + " and mv.estado!='Cancelado' and c.estado!='Cancelado' and e.idpuesto!=1  and e.idpuesto!=8 group by hour(vc.registro) order by vc.registro asc";

            stc = cn.prepareStatement(sSQl);
            rsc = stc.executeQuery();
            float to = 0;
            DefaultPieDataset hM = new DefaultPieDataset();
            while (rsc.next()) {
                System.out.println(rsc.getString("total") + " a " + rsc.getString("hora"));
                to = rsc.getFloat("total");
                // sum=Integer.parseInt(rsc.getString("hora").substring(11,13))-1;
                horav = rsc.getString("hora").substring(10, 13) + ":00:00 hrs.";
                PdfPCell cell6p = new PdfPCell(new Paragraph("            $ " + to,
                        FontFactory.getFont("arial",
                        12, Font.NORMAL)));
                cell6p.setHorizontalAlignment(tablasc.ALIGN_LEFT);
                tablasc.addCell(cell6p);
                PdfPCell celv = new PdfPCell(new Paragraph(horav,
                        FontFactory.getFont("arial",
                        12, Font.NORMAL)));
                celv.setHorizontalAlignment(tablasc.ALIGN_CENTER);
                tablasc.addCell(celv);
                hM.setValue(horav + (to * 100) / total + "%", to);

            }

            PdfPCell cell7 = new PdfPCell(new Paragraph("             $ " + total,
                    FontFactory.getFont("arial",
                    12, Font.NORMAL)));
            cell7.setHorizontalAlignment(tablasc.ALIGN_LEFT);
            cell7.setBackgroundColor(BaseColor.GRAY);
            tablasc.addCell(cell7);
            PdfPCell celv8 = new PdfPCell(new Paragraph("",
                    FontFactory.getFont("arial",
                    12, Font.NORMAL)));
            celv8.setBackgroundColor(BaseColor.GRAY);
            celv8.setHorizontalAlignment(tablasc.ALIGN_CENTER);

            tablasc.addCell(celv8);



            document.add(tablasc);






            direccion = ruta + "img/";
            String GHMt = g.Graficar(hM, direccion, "estadistica.jpg", "Estadística", 600, 400);
            String imagent = ruta + "img/" + GHMt;

            Image fotot = Image.getInstance(imagent);
            fotot.scaleToFit(500, 300);
            //foto.scaleToFit(200, 200);
            fotot.setAlignment(Chunk.ALIGN_CENTER);



            document.add(fotot);/////teeeeeeeeeeeeeeee

            document.newPage();
            Paragraph scc = new Paragraph("Cortesía ByLatino",
                    FontFactory.getFont("arial",
                    16, Font.BOLD));
            paragraph.setAlignment(Element.ALIGN_LEFT);
            document.add(scc);
            document.add(new Paragraph("\n\n"));
            //#####################################
            PdfPTable tablascc = new PdfPTable(2);

            PdfPCell cellscc = new PdfPCell(new Paragraph("Venta",
                    FontFactory.getFont("arial",
                    text, Font.BOLD)));
            // fuente

            cellscc.setBackgroundColor(BaseColor.GRAY);
            cellscc.setHorizontalAlignment(tablascc.ALIGN_CENTER);

            PdfPCell cell1scc = new PdfPCell(new Paragraph("Hora",
                    FontFactory.getFont("arial",
                    text, Font.BOLD)));
            // fuente
            cell1scc.setBackgroundColor(BaseColor.GRAY);
            cell1scc.setHorizontalAlignment(tablasc.ALIGN_CENTER);


            tablascc.addCell(cellscc);
            tablascc.addCell(cell1scc);





            String horavc = "";
            int sumc = 0;
            float totalc = con.reporte(idDia, "c");
            String sSQlc = "select ROUND(sum(vc.costo)) as total,vc.registro as hora from mesa_venta mv,comanda c, venta_comanda vc ,empleado e where mv.idMesa_venta=c.idMesa_venta  and e.idEmpleado=mv.idEmpleado and c.idComanda=vc.idComanda and mv.idaltadia=" + idDia + " and mv.estado!='Cancelado' and c.estado!='Cancelado' and (e.idpuesto=1  or e.idpuesto=8) group by hour(vc.registro) order by vc.registro asc";

            stcc = cn.prepareStatement(sSQlc);
            rscc = stcc.executeQuery();
            float toc = 0;
            DefaultPieDataset hMc = new DefaultPieDataset();
            while (rscc.next()) {

                toc = rscc.getFloat("total");
                // sum=Integer.parseInt(rsc.getString("hora").substring(11,13))-1;
                horavc = rscc.getString("hora").substring(10, 13) + ":00:00 hrs.";
                PdfPCell cell6pc = new PdfPCell(new Paragraph("             $ " + toc,
                        FontFactory.getFont("arial",
                        12, Font.NORMAL)));
                cell6pc.setHorizontalAlignment(tablascc.ALIGN_LEFT);
                tablascc.addCell(cell6pc);
                PdfPCell celvc = new PdfPCell(new Paragraph(horavc,
                        FontFactory.getFont("arial",
                        12, Font.NORMAL)));
                celvc.setHorizontalAlignment(tablascc.ALIGN_CENTER);
                tablascc.addCell(celvc);

                hMc.setValue(horavc + (toc * 100) / totalc + "%", toc);
            }

            PdfPCell cell7c = new PdfPCell(new Paragraph("             $ " + totalc,
                    FontFactory.getFont("arial",
                    12, Font.NORMAL)));
            cell7c.setHorizontalAlignment(tablascc.ALIGN_LEFT);
            cell7c.setBackgroundColor(BaseColor.GRAY);
            tablascc.addCell(cell7c);
            PdfPCell celv8c = new PdfPCell(new Paragraph("",
                    FontFactory.getFont("arial",
                    12, Font.NORMAL)));
            celv8c.setBackgroundColor(BaseColor.GRAY);
            celv8c.setHorizontalAlignment(tablascc.ALIGN_CENTER);

            tablascc.addCell(celv8c);



            document.add(tablascc);


            direccion = ruta + "img/";
            String GHMtc = g.Graficar(hMc, direccion, "estadisticacorte.jpg", "Estadística", 600, 400);
            String imagentc = ruta + "img/" + GHMtc;

            Image fototc = Image.getInstance(imagentc);
            fototc.scaleToFit(500, 300);
            //foto.scaleToFit(200, 200);
            fototc.setAlignment(Chunk.ALIGN_CENTER);



            document.add(fototc);/////teeeeeeeeeeeeeeee






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
                rscc.close();
                stcc.close();
             
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
