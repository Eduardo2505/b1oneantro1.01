/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.dao.impl;

import com.dao.CancelacionmesaDao;
import com.mapping.CancelacionMesa;
import com.mapping.MesaVenta;
import com.util.HibernateUtil;
import java.util.Iterator;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author Eduardoim
 */
public class CancelacionmesaDaoImpl implements CancelacionmesaDao {

    @Override
    public CancelacionMesa insertar(CancelacionMesa cancelacionmesa) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        CancelacionMesa c = null;
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.save(cancelacionmesa);
            c = (CancelacionMesa) session.get(CancelacionMesa.class, cancelacionmesa.getIdCancelacionMesa());
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                tx.rollback();
            }

        } finally {

            session.close();

        }
        return c;
    }

    @Override
    public List getMostrar(int idDia) {
        List<CancelacionMesa> v = null;
        Session session = HibernateUtil.getSessionFactory().openSession();
        try {

            Query q = session.createQuery("From CancelacionMesa");
            v = (List<CancelacionMesa>) q.list();


        } catch (Exception e) {
            return null;

        } finally {

            session.close();

        }
        return v;
    }

    public static void main(String[] args) {
        CancelacionmesaDaoImpl dao = new CancelacionmesaDaoImpl();
        MesaVenta c = new MesaVenta();
        CancelacionMesa m = new CancelacionMesa();
         CancelacionMesa mc = new CancelacionMesa();
        c.setIdMesaVenta("RA-4-9");
        m.setMesaVenta(c);        
        m.setAutorizacion("Lalo");
        
        mc=dao.insertar(m);
        
        System.out.println(mc);


    }

    @Override
    public CancelacionMesa getBuscar(String idMesa) {
      Session session = HibernateUtil.getSessionFactory().openSession();

        CancelacionMesa empleado = null;
        try {

            String sql = "select u from CancelacionMesa u where idMesa_Venta=:idMesa";
            Query query = session.createQuery(sql);
            query.setString("idMesa", idMesa);

            empleado = (CancelacionMesa) query.uniqueResult();

        } catch (Exception e) {
            return null;

        } finally {
            //session.close();
        }
        return empleado;
    }
}
