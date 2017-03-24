/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.dao.impl;

import com.dao.MesasDao;
import com.mapping.Empleado;
import com.mapping.Mesas;
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
public class MesasDaoImpl implements MesasDao {

    @Override
    public List getMesas(String estado, String idEmpleado, String idMesa) {
        List<Mesas> mesas = null;
        Session session = HibernateUtil.getSessionFactory().openSession();

        try {
            Query q = session.createQuery("From Mesas where estado='" + estado + "' and idEmpleado like '%" + idEmpleado + "%' and idMesa like '%" + idMesa + "%' ORDER BY posiscion");
            // Query q = session.createQuery("From Mesas where estado='" + estado + "'");
            mesas = (List<Mesas>) q.list();


        } catch (Exception e) {
            return null;

        } finally {

            session.close();
        }
        return mesas;
    }

    @Override
    public void insertar(Mesas mesas) {
        Session session = HibernateUtil.getSessionFactory().openSession();

        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.save(mesas);
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
    public Mesas bucarPorId(String id) {
        Session session = HibernateUtil.getSessionFactory().openSession();

        Mesas mesas = null;
        try {

            mesas = (Mesas) session.get(Mesas.class, id);


        } catch (Exception e) {
            return null;

        } finally {
            session.close();
        }
        return mesas;
    }

    @Override
    public void actulizar(String idMesa, String estado) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Mesas me = null;
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            me = (Mesas) session.get(Mesas.class, idMesa);
            me.setEstado(estado);
            session.update(me);
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
    public List getMesas(String estado) {
        List<Mesas> mesas = null;
        Session session = HibernateUtil.getSessionFactory().openSession();

        try {
            //Query q = session.createQuery("From Mesas where estado='" + estado + "' and idEmpleado like '%" + idEmpleado + "%'");
            Query q = session.createQuery("From Mesas where estado='" + estado + "'");
            mesas = (List<Mesas>) q.list();


        } catch (Exception e) {
            return null;

        } finally {
            session.close();
        }
        return mesas;
    }

    @Override
    public List getMesas(String estado, String idEmpleado) {
        List<Mesas> mesas = null;
        Session session = HibernateUtil.getSessionFactory().openSession();

        try {
            //Query q = session.createQuery("From Mesas where estado='" + estado + "' and idEmpleado like '%" + idEmpleado + "%'");
            Query q = session.createQuery("From Mesas where estado='" + estado + "' and idEmpleado='" + idEmpleado + "' order by posiscion");
            mesas = (List<Mesas>) q.list();


        } catch (Exception e) {
            return null;

        } finally {
            // session.close();
        }
        return mesas;
    }

    @Override
    public void actulizar(String idMesa, Zona z, String estado) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Mesas me = null;
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            me = (Mesas) session.get(Mesas.class, idMesa);
            // me.setTipo(estado);
            me.setZona(z);
            session.update(me);
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
    public void actulizartipo(String idMesa, String pp) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Mesas me = null;
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            me = (Mesas) session.get(Mesas.class, idMesa);
            me.setTipo(pp);
            session.update(me);
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
    public Mesas bucarPormpleado(Empleado empleado) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Mesas me = null;
        Transaction tx = null;
        try {
            String sql = "select u from Mesas u where idEmpleado=:email and tipo='PP'";
            Query query = session.createQuery(sql);
            query.setString("email", empleado.getIdEmpleado());
            me = (Mesas) query.uniqueResult();
        } catch (Exception e) {
            if (tx != null) {
                tx.rollback();
            }

        } finally {

            session.close();

        }
        return me;
    }
 @Override
    public int mesasMaximas(String idEmpleado) {
       Session session = HibernateUtil.getSessionFactory().openSession();

        int total = 0;
        try {

            String sql = "select count(*) from Mesas where idEmpleado='"+idEmpleado+"'";
            Query query = session.createQuery(sql);
            total = ((Number) query.uniqueResult()).intValue();

        } catch (Exception e) {
            return 0;
        } finally {

            session.close();

        }
        return total;
    }
    public static void main(String[] args) {
        MesasDaoImpl daom = new MesasDaoImpl();
        System.out.println(daom.mesasMaximas("20135BNW52"));


    }

   
}
