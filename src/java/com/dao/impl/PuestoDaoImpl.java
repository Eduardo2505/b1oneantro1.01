/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.dao.impl;

import com.dao.PuestoDao;
import com.mapping.Puesto;
import com.util.HibernateUtil;
import java.util.Iterator;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;

/**
 *
 * @author Eduardopc
 */
public class PuestoDaoImpl implements PuestoDao{

    @Override
    public List getPuesto() {
        List<Puesto> puestos = null;
        Session session = HibernateUtil.getSessionFactory().openSession();
        try {

            Query q = session.createQuery("From Puesto as puesto");
            puestos = (List<Puesto>) q.list();


        } catch (Exception e) {
            return null;

        } finally {

            session.close();

        }
        return puestos;
    }
    public static void main(String[] args) {
        PuestoDaoImpl dao=new PuestoDaoImpl();
        List res = dao.getPuesto();
        Iterator itr = res.iterator();
        while (itr.hasNext()) {
            Puesto e = (Puesto) itr.next();
            System.out.println(e.getIdpuesto());
            //  out.println("<tr><td>" + e.getNombre() + " " + e.getApellidos() + "</td><td>" + e.getRegistro() + "</td><td><a class=\"btn btn-small\" TARGET='_new' href='ImprimirTarjeta?idUsuario=" + e.getIdCliente() + "&nombre=" + e.getNombre() + " " + e.getApellidos() + "'><i class='icon-print'></i>Imprimir</a></td></tr>");


        }
    }
    
}
