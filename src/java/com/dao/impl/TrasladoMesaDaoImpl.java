/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.dao.impl;

import com.dao.TrasladoMesaDao;
import com.mapping.TrasladoMesa;
import com.util.HibernateUtil;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Transaction;
import org.hibernate.classic.Session;

/**
 *
 * @author Eduardo
 */
public class TrasladoMesaDaoImpl implements TrasladoMesaDao {

    @Override
    public TrasladoMesa insertar(TrasladoMesa tras) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        TrasladoMesa c = null;
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.save(tras);
            c = (TrasladoMesa) session.get(TrasladoMesa.class,tras.getIdTrasladoMesa());
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
        List<TrasladoMesa> v = null;
        Session session = HibernateUtil.getSessionFactory().openSession();
        try {

            Query q = session.createQuery("From TrasladoMesa");
            v = (List<TrasladoMesa>) q.list();


        } catch (Exception e) {
            return null;

        } finally {

            session.close();

        }
        return v;
    }
}
