/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.dao.impl;

import com.dao.ZonaDao;
import com.mapping.Zona;
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
public class ZonaDaoImpl implements ZonaDao {

    @Override
    public List getZona() {
        List<Zona> zonas = null;
        Session session = HibernateUtil.getSessionFactory().openSession();
        try {

            Query q = session.createQuery("From Zona as zona");
            zonas = (List<Zona>) q.list();


        } catch (Exception e) {
            return null;

        } finally {

            session.close();

        }
        return zonas;
    }

    @Override
    public void insertar(Zona zona) {
        Session session = HibernateUtil.getSessionFactory().openSession();

        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.save(zona);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                tx.rollback();
            }

        } finally {

            session.close();

        }
    }

    public static void main(String[] args) {
        ZonaDaoImpl dao = new ZonaDaoImpl();

        List res = dao.getZona();
        Iterator itr = res.iterator();
        while (itr.hasNext()) {
            Zona z = (Zona) itr.next();
            System.out.println(z.getIdzona());
        }


    }
}
