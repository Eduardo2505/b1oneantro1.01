/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.dao.impl;

import com.dao.DescuentoDao;
import com.mapping.Descuento;
import com.util.HibernateUtil;
import java.util.Iterator;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author Eduardopc
 */
public class DescuentoDaoImpl implements DescuentoDao {

    @Override
    public void insertar(Descuento descuento) {
        Session session = HibernateUtil.getSessionFactory().openSession();

        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.save(descuento);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                tx.rollback();
            }

        } finally {

            session.close();

        }
    }

    @Override
    public List getVer() {
        List<Descuento> descuento = null;
        Session session = HibernateUtil.getSessionFactory().openSession();

        try {

            Query q = session.createQuery("From Descuento");
            descuento = (List<Descuento>) q.list();


        } catch (Exception e) {
            return null;

        } finally {

            session.close();
        }
        return descuento;
    }

    @Override
    public Descuento Buscarid(String idDescuento) {
        Session session = HibernateUtil.getSessionFactory().openSession();

        Descuento descuento = null;
        try {

            descuento = (Descuento) session.get(Descuento.class, idDescuento);


        } catch (Exception e) {
            return null;

        } finally {
            session.close();
        }
        return descuento;
    }

    public static void main(String[] args) {
       

        /*  DescuentoDaoImpl dao = new DescuentoDaoImpl();
         List res = dao.getVer();
         Iterator itr = res.iterator();
         while (itr.hasNext()) {
         Descuento des = (Descuento) itr.next();

         System.out.println(des.getPorcentaje());




         }*/



    }
}
