/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.dao.impl;

import com.dao.CancelacionComandaDao;
import com.mapping.CancelacionComanda;
import com.mapping.Comanda;
import com.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author Eduardopc
 */
public class CancelacionComandaDaoImpl implements CancelacionComandaDao {

    @Override
    public CancelacionComanda insertar(CancelacionComanda cancelacionComanda) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        CancelacionComanda c = null;
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.save(cancelacionComanda);
            c = (CancelacionComanda) session.get(CancelacionComanda.class, cancelacionComanda.getIdCancelacionComanda());
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
}
