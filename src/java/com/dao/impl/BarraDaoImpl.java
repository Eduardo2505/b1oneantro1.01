/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.dao.impl;

import com.dao.BarraDao;
import com.mapping.Barra;
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
public class BarraDaoImpl implements BarraDao{

    @Override
    public void insetar(Barra barra) {
       Session session = HibernateUtil.getSessionFactory().openSession();

        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.save(barra);
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
    public List getver() {
         List<Barra> barra = null;
        Session session = HibernateUtil.getSessionFactory().openSession();

        try {

            Query q = session.createQuery("From Barra");
            barra = (List<Barra>) q.list();


        } catch (Exception e) {
            return null;

        } finally {

            session.close();
        }
        return barra;
    }
    public static void main(String[] args) {
        BarraDaoImpl dao=new BarraDaoImpl();
        
         List res = dao.getver();
         Iterator itr = res.iterator();
         while (itr.hasNext()) {
         Barra  c = (Barra ) itr.next();

         System.out.println(c.getIdBarra());

         }
    }
    
}
