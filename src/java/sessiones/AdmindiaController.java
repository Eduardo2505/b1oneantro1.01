/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package sessiones;

import com.dao.impl.AltadiaDaoImpl;
import com.dao.impl.Mesa_ventaDaoImpl;
import com.mapping.Altadia;
import com.mapping.Empleado;
import com.mapping.MesaVenta;
import com.mapping.Mesas;
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

/**
 *
 * @author Eduardo
 */
public class AdmindiaController extends HttpServlet {

    AltadiaDaoImpl dao = new AltadiaDaoImpl();
    Altadia dia = new Altadia();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String op = request.getParameter("op").trim();
        Date ahora = new Date();
        SimpleDateFormat dateFormat = new SimpleDateFormat("HH:mm:ss");
        SimpleDateFormat dateFormatf = new SimpleDateFormat("yyyy-MM-dd");
        String fechaAc = dateFormatf.format(ahora);
        String horaActu = dateFormat.format(ahora);
        try {


            int idDia = Integer.parseInt(request.getParameter("iddia"));

            Mesa_ventaDaoImpl daox = new Mesa_ventaDaoImpl();
            List resx = daox.getCuentasAbiertas("Activo", idDia, "");
            int sum = resx.size();
            System.out.println(sum);
            if (sum == 0) {
                String estado = request.getParameter("estado");
                String aux = "";
                if (estado.equals("Activo")) {
                    aux = "Desactivado";
                } else {
                    aux = "Activo";
                }
                dao.actulizar(idDia, aux);

                out.println(" <script type=\"text/javascript\">"
                        + "$(document).ready(function() {\n"
                        + "                $('.desactivar').click(function() {\n"
                        + "\n"
                        + "                    var user = $(this).val();\n"
                        + "\n"
                        + "                    //alert(user);\n"
                        + "\n"
                        + "                    var dataString = 'iddia=' + user + '&op=actualizar';\n"
                        + "                  //  alert(dataString);\n"
                        + "                    if (user != \"\") {\n"
                        + "                        // $('#verResultadoBuscados').html('<img src=\"img/ajax-loader.gif\" alt=\"\"/>');\n"
                        + "                        $.ajax({\n"
                        + "                            type: \"POST\",\n"
                        + "                            url: \"../AdmindiaController\",\n"
                        + "                            data: dataString,\n"
                        + "                            success: function(data) {\n"
                        + "                                $('#resultados').fadeIn(1000).html(data);\n"
                        + "                            }\n"
                        + "                        });\n"
                        + "                        //}\n"
                        + "                    }\n"
                        + "                }\n"
                        + "\n"
                        + "\n"
                        + "                );\n"
                        + "            });\n"
                        + "        </script>");
                out.println("<table class=\"table table-hover\">\n"
                        + "\n"
                        + "                            <thead>\n"
                        + "                                <tr>\n"
                        + "                                    <th>Dia</th> <th>Tipo</th>\n"
                        + "                                    <th>Resgistro</th>\n"
                        + "                                    <th>Estado</th>\n"
                        + "                                </tr>\n"
                        + "                            </thead>\n"
                        + "                            <tbody>");
                //  AltadiaDaoImpl dao = new AltadiaDaoImpl();
                List res = dao.getDias();
                Iterator itr = res.iterator();
                String color = "";
                while (itr.hasNext()) {
                    Altadia des = (Altadia) itr.next();
                    if (des.getEstado().equals("Activo")) {
                        color = "success";
                    } else {
                        color = "danger";
                    }
                    out.println("<tr><td>" + des.getFecha() + "</td><td>" + des.getTipoEvento() + "</td><td>" + des.getHora() + "</td><td><button class='btn btn-" + color + " desactivar' value='" + des.getIdaltadia() + "&estado=" + des.getEstado() + "' type='button'>" + des.getEstado() + "</button> <a href='../AltadiaController?iddia=" + des.getIdaltadia() + "&op=imp'  class='btn btn-primary ver' >VER</a> <a href='../AltadiaController?iddia=" + des.getIdaltadia() + "&op=actcuentas'  class='btn btn-primary ver' >Cuentas</a></td>");






                }


                out.println(" </tbody>\n"
                        + "                        </table>");
            } else {
                out.println("<script type=\"text/javascript\">\n"
                        + "            \n"
                        + "              $(document).ready(function() {\n"
                        + "                $('.cerrarctacero').click(function() {\n"
                        + "\n"
                        + "                    var user = $(this).attr(\"name\");\n"
                        + "                    var remov = $(this).attr(\"title\");\n"
                        + "\n"
                        + "                    var dataString = 'idMesa=' + user;\n"
                        + "                   \n"
                        + "                        $.ajax({\n"
                        + "                            type: \"POST\",\n"
                        + "                            url: \"../CerrarCuentasCero\",\n"
                        + "                            data: dataString,\n"
                        + "                            success: function(data) {\n"
                        + "\n"
                        + "\n"
                        + "                                $('#'+remov).remove();\n"
                        + "                            }\n"
                        + "                        });\n"
                        + "                    \n"
                        + "                    \n"
                        + "                }\n"
                        + "\n"
                        + "\n"
                        + "                );\n"
                        + "            });\n"
                        + "        </script>");
                out.println(" <div style='text-align:center'><h2>¡Tiene cuentas abiertas!<br>Debes de cerrar las cuentas abiertas existentes</h2>");
                out.println("<table class=\"table table-striped\"><tr><th>Nombre</th><th>Clave</th><th>Cuenta</th><th>Total</th><th>Opción</th><tr>");
                Empleado em = new Empleado();
                Iterator itrx = resx.iterator();
                Mesas m = new Mesas();
                while (itrx.hasNext()) {
                    MesaVenta ee = (MesaVenta) itrx.next();
                    em = ee.getEmpleado();
                    m = ee.getMesas();
                    if (ee.getTotalcuenta() == 0) {
                        out.println("<tr id='" + ee.getIdMesaVenta() + "'><td>" + em.getNombre() + " " + em.getApellidos() + "</td><td>" + em.getEmpleadocol() + "</td><td>" + ee.getIdMesaCapturada() + "</td><td> $ " + ee.getTotalcuenta() + "</td><td><a href=\"#\" class='cerrarctacero' name=\"" + ee.getIdMesaVenta() + "&mesa=" + m.getIdMesa() + "\" title='" + ee.getIdMesaVenta() + "'>Cerrar</a></td></tr>");
                    } else {
                        out.println("<tr id='" + ee.getIdMesaVenta() + "'><td>" + em.getNombre() + " " + em.getApellidos() + "</td><td>" + em.getEmpleadocol() + "</td><td>" + ee.getIdMesaCapturada() + "</td><td> $ " + ee.getTotalcuenta() + "</td><td>Sistema</td></tr>");
                    }
                }
            }
            out.println("</table>");
            out.println("</div>");

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
