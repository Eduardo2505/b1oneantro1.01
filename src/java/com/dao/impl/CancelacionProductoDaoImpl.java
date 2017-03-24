/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.dao.impl;

import com.dao.CancelacionProductoDao;
import com.mapping.Cancelacionproducto;
import com.util.HibernateUtil;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author Eduardopc
 */
public class CancelacionProductoDaoImpl implements CancelacionProductoDao {

    @Override
    public void insertar(Cancelacionproducto cancelacionproducto) {
        Session session = HibernateUtil.getSessionFactory().openSession();

        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.save(cancelacionproducto);
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
    public List getver(String fecha) {
        List<Cancelacionproducto> cancelacionproducto = null;
        Session session = HibernateUtil.getSessionFactory().openSession();


        try {

            Query q = session.createQuery("From Cancelacionproducto where Registro like '%"+fecha+"%' order by Registro DESC ");
            cancelacionproducto = (List<Cancelacionproducto>) q.list();


        } catch (Exception e) {
            return null;
        } finally {
            session.close();
        }
        return cancelacionproducto;
    }

    @Override
    public List getver(String fechaInicial, String fechaFinal) {
       List<Cancelacionproducto> cancelacionproducto = null;
        Session session = HibernateUtil.getSessionFactory().openSession();


        try {

            Query q = session.createQuery("From Cancelacionproducto where Registro BETWEEN '"+fechaInicial+"' AND '"+fechaFinal+"' order by Registro DESC ");
            cancelacionproducto = (List<Cancelacionproducto>) q.list();


        } catch (Exception e) {
            return null;
        } finally {
            session.close();
        }
        return cancelacionproducto;
    }
}
