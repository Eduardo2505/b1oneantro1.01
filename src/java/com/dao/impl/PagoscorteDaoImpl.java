/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.dao.impl;

import com.dao.PagoscorteDao;
import com.mapping.Pagoscorte;
import com.util.HibernateUtil;
import java.util.Iterator;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author Eduardo
 */
public class PagoscorteDaoImpl implements PagoscorteDao {

    @Override
    public Pagoscorte insertar(Pagoscorte pagoscorte) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Pagoscorte pc = null;
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.save(pagoscorte);
            pc = (Pagoscorte) session.get(Pagoscorte.class, pagoscorte.getIdPagosCorte());
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                tx.rollback();
            }

        } finally {

            session.close();

        }
        return pc;
    }

    @Override
    public void actualizar(int id, float total) {
        Session session = HibernateUtil.getSessionFactory().openSession();

        Pagoscorte pc = null;
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            pc = (Pagoscorte) session.get(Pagoscorte.class, id);
            pc.setTotal(total);
            session.save(pc);
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
    public void actualizar(int id, float efectivo, float tarjetas) {
        Session session = HibernateUtil.getSessionFactory().openSession();

        Pagoscorte pc = null;
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            pc = (Pagoscorte) session.get(Pagoscorte.class, id);

            pc.setEfectivo(efectivo);
            pc.setTarjetas(tarjetas);
            session.save(pc);
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
    public void eliminar(int id) {
        Session session = HibernateUtil.getSessionFactory().openSession();

        Transaction tx = null;
        Pagoscorte pc = null;

        try {
            tx = session.beginTransaction();

            pc = (Pagoscorte) session.get(Pagoscorte.class, id);
            session.delete(pc);
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
    public Pagoscorte buscar(String idEmpleado, int iddida) {
        Session session = HibernateUtil.getSessionFactory().openSession();

        Pagoscorte pc = null;
        try {

            String sql = "select u from Pagoscorte u where idEmpleado=:idEmpleado and idaltadia=:idaltadia ";
            Query query = session.createQuery(sql);

            query.setString("idEmpleado", idEmpleado);
            query.setInteger("idaltadia", iddida);
            pc = (Pagoscorte) query.uniqueResult();

        } catch (Exception e) {
            return null;

        } finally {
            //session.close();
        }
        return pc;
    }

    @Override
    public List getFiltro(String idEmpleado) {
        List<Pagoscorte> pg = null;
        Session session = HibernateUtil.getSessionFactory().openSession();


        try {

            Query q = session.createQuery("From Pagoscorte where idEmpleado like '" + idEmpleado + "' ");
            pg = (List<Pagoscorte>) q.list();


        } catch (Exception e) {
            return null;
        } finally {
            session.close();
        }
        return pg;
    }

    @Override
    public Pagoscorte buscar(int idpagocorte) {
        Session session = HibernateUtil.getSessionFactory().openSession();

        Pagoscorte pc = null;
        try {

            pc = (Pagoscorte)session.get(Pagoscorte.class, idpagocorte);


        } catch (Exception e) {
            return null;

        } finally {
           // session.close();
        }
        return pc;
    }

    public static void main(String[] args) {
        PagoscorteDaoImpl daoEm = new PagoscorteDaoImpl();
        List res = daoEm.getFiltro("20135BR201");
        Iterator itr = res.iterator();
        int verMesesa = 0;
        while (itr.hasNext()) {
            Pagoscorte vc = (Pagoscorte) itr.next();
            System.out.println(vc.getEfectivo());

        }
    }
}
