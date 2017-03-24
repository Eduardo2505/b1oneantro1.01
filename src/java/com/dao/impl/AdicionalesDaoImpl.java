/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.dao.impl;

import com.dao.AdicionalesDao;
import com.mapping.Adicionales;
import com.mapping.Producto;
import com.util.HibernateUtil;
import java.util.Iterator;
import java.util.List;
import mail.EmailEnv;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author Eduardopc
 */
public class AdicionalesDaoImpl implements AdicionalesDao {

    @Override
    public void insertar(Adicionales adicionales) {
        Session session = HibernateUtil.getSessionFactory().openSession();

        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.save(adicionales);
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
        Adicionales adicionales = null;

        try {
            tx = session.beginTransaction();

            adicionales = (Adicionales) session.get(Adicionales.class, id);
            session.delete(adicionales);
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
    public List getMostrar(int idventa) {
        List<Adicionales> adicionales = null;
        Session session = HibernateUtil.getSessionFactory().openSession();

        try {

            Query q = session.createQuery("From Adicionales where idVenta_Comandacol=" + idventa + " group by idProducto");
            adicionales = (List<Adicionales>) q.list();


        } catch (Exception e) {

            return null;

        } finally {
            // session.close();
        }
        return adicionales;
    }

    @Override
    public int contar(String idProducto, int id) {
        Session session = HibernateUtil.getSessionFactory().openSession();

        int total = 0;
        try {

            String sql = "select count(*) from Adicionales where idProducto='" + idProducto + "' and idVenta_Comandacol=" + id + "";
            Query query = session.createQuery(sql);
            total = ((Number) query.uniqueResult()).intValue();

        } catch (Exception e) {
            return 0;
        } finally {

            session.close();

        }
        return total;
    }

    @Override
    public Adicionales bucar(int idVenta_Comandacol) {
        Session session = HibernateUtil.getSessionFactory().openSession();

        Adicionales a = null;
        try {

            String sql = "select u from Adicionales u where idVenta_Comandacol=:ac";
            Query query = session.createQuery(sql);
            query.setInteger("ac", idVenta_Comandacol);

            a = (Adicionales) query.uniqueResult();

        } catch (Exception e) {
            return null;

        } finally {
            //session.close();
        }
        return a;
    }

    public static void main(String[] args) {
        AdicionalesDaoImpl daoa = new AdicionalesDaoImpl();
        Adicionales a = new Adicionales(); 
        int id=6891;
        a=daoa.bucar(id);
        System.out.println(a.getDescripcion());
        
    }
}
