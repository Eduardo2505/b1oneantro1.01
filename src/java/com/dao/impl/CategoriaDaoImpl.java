/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.dao.impl;

import com.dao.CategoriaDao;
import com.mapping.Categoria;
import com.util.HibernateUtil;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author Eduardopc
 */
public class CategoriaDaoImpl implements CategoriaDao {

    @Override
    public List getFiltro(String sql) {
        List<Categoria> categoria = null;
        Session session = HibernateUtil.getSessionFactory().openSession();

        try {

            Query q = session.createQuery("From Categoria as categoria " + sql + " order by idCategoria ASC ");
            categoria = (List<Categoria>) q.list();

        } catch (Exception e) {
            return null;
        } finally {
            session.close();
        }
        return categoria;
    }

    @Override
    public void insertar(Categoria categoria) {
        Session session = HibernateUtil.getSessionFactory().openSession();

        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.save(categoria);
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
    public void actulizar(Categoria categoria) {
        Session session = HibernateUtil.getSessionFactory().openSession();

        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.update(categoria);
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
    }

    @Override
    public List getFiltro() {
        List<Categoria> categoria = null;
        Session session = HibernateUtil.getSessionFactory().openSession();

        try {

            Query q = session.createQuery("From Categoria as categoria order by idCategoria ASC ");
            categoria = (List<Categoria>) q.list();

        } catch (Exception e) {
            return null;
        } finally {
            session.close();
        }
        return categoria;
    }

    @Override
    public void actulizar(String id, String estado) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Categoria altadia = null;
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            altadia = (Categoria) session.get(Categoria.class, id);
            altadia.setUrl(estado);
            session.update(altadia);

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
    public int buscar(String id) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Categoria altadia = null;
        Transaction tx = null;
        int valor = 0;
        try {
            tx = session.beginTransaction();
           // System.out.println(id);
            altadia = (Categoria) session.get(Categoria.class, id);
            if (!altadia.getUrl().equals("1")) {
                valor = 1;

            }
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                tx.rollback();
            }

        } finally {

            session.close();

        }
        return valor;
    }
}
