/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package sessiones;

import com.dao.impl.EmpleadoDaoImpl;
import com.mapping.Empleado;
import com.mapping.Puesto;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Eduardopc
 */
public class SessionMesero extends HttpServlet {

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
        String idMesero = request.getParameter("idMesero");
        String pass = request.getParameter("clave");
        HttpSession sesion = request.getSession();
        try {
            EmpleadoDaoImpl dao = new EmpleadoDaoImpl();
            Empleado empleado = new Empleado();            
            empleado = dao.clave(idMesero, pass);
            Puesto pu = new Puesto();           
            if (empleado != null) {

                sesion.setAttribute("idMesero", empleado);
                out.println(empleado.getIdEmpleado());
                pu = empleado.getPuesto();
                String idpue = String.valueOf(pu.getIdpuesto());
                sesion.setAttribute("idpuesto", idpue);                
                sesion.setAttribute("Supervisor", "-");
            } else {
               
                empleado = dao.supervisar(pass);
                if (empleado != null) {                    
                    sesion.setAttribute("Supervisor", empleado.getNombre() + " " + empleado.getApellidos());
                    pu = empleado.getPuesto();
                   // if(pu.getIdpuesto()==13&&)
                    int idpussuperviso=pu.getIdpuesto();
                    String idpue = String.valueOf(idpussuperviso);
                    sesion.setAttribute("idpuesto", idpue);                    
                    empleado = dao.bucarPorId(idMesero); 
                    Puesto pus = new Puesto(); 
                    pus = empleado.getPuesto();
                    int idicahjor=pus.getIdpuesto();
                    sesion.setAttribute("idMesero", empleado);
                    if(idpussuperviso==12&&idicahjor==8){
                     
                    }else{
                    out.println(empleado.getIdEmpleado());
                    
                    }
                   
                   
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
