/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.dao.impl;

import com.dao.ComandaDao;
import com.mapping.Altadia;
import com.mapping.Comanda;
import com.mapping.MesaVenta;
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
public class ComandaDaoImpl implements ComandaDao {

    @Override
    public void insertar(Comanda comanda) {
        Session session = HibernateUtil.getSessionFactory().openSession();

        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.save(comanda);
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
    public Comanda bucarPorId(String id) {
        Session session = HibernateUtil.getSessionFactory().openSession();

        Comanda comanda = null;
        try {

            comanda = (Comanda) session.get(Comanda.class, id);


        } catch (Exception e) {
            return null;

        } finally {
            session.close();
        }
        return comanda;
    }

    @Override
    public List getBuscar(String idMesa) {
        List< Comanda> comanda = null;
        Session session = HibernateUtil.getSessionFactory().openSession();

        try {

            Query q = session.createQuery("From  Comanda as comanda where idMesa_venta='" + idMesa + "' and estado='activo'");
            comanda = (List< Comanda>) q.list();


        } catch (Exception e) {
            return null;
        } finally {
            session.close();
        }
        return comanda;
    }

    @Override
    public void actulizar(String idComanda, String estado) {
        Session session = HibernateUtil.getSessionFactory().openSession();

        Transaction tx = null;
        Comanda comanda = null;
        try {
            tx = session.beginTransaction();
            comanda = (Comanda) session.get(Comanda.class, idComanda);
            comanda.setEstado(estado);
            session.update(comanda);
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
    public void actulizarIdMesaventa(String idComanda, MesaVenta mesaventa) {
        Session session = HibernateUtil.getSessionFactory().openSession();

        Transaction tx = null;
        Comanda comanda = null;
        try {
            tx = session.beginTransaction();
            comanda = (Comanda) session.get(Comanda.class, idComanda);
            comanda.setMesaVenta(mesaventa);
            session.update(comanda);
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
    public int contar(int id, String mesaVenta, String estado) {
        Session session = HibernateUtil.getSessionFactory().openSession();

        int total = 0;
        try {

            String sql = "select count(*) from Comanda where idaltadia=" + id + " and idMesa_venta='" + mesaVenta + "'  and estado like '%" + estado + "%'";
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
    public int contar(int id) {
        Session session = HibernateUtil.getSessionFactory().openSession();

        int total = 0;
        try {

            String sql = "select count(*) from Comanda where idaltadia=" + id + " ";
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
    public int contarComanda(String idComanda) {
        Session session = HibernateUtil.getSessionFactory().openSession();

        int total = 0;
        try {

            String sql = "select count(*) from Comanda where idComanda='" + idComanda + "' ";
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
    public List getMesas(String inicio, String fi, int iddia) {
        List< Comanda> comanda = null;
        Session session = HibernateUtil.getSessionFactory().openSession();

        try {

            Query q = session.createQuery("from Comanda where idaltadia=" + iddia + " and fecha_hora BETWEEN '" + inicio + "' AND '" + fi + "'");
            comanda = (List< Comanda>) q.list();


        } catch (Exception e) {
            return null;
        } finally {
            session.close();
        }
        return comanda;
    }

    @Override
    public void actulizaridDia(String idComanda, int iddia) {
        Session session = HibernateUtil.getSessionFactory().openSession();

        Transaction tx = null;
        Comanda comanda = null;
        try {
            tx = session.beginTransaction();
            comanda = (Comanda) session.get(Comanda.class, idComanda);
            Altadia a=new Altadia();
            a.setIdaltadia(iddia);            
            comanda.setAltadia(a);
            session.update(comanda);
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

        ComandaDaoImpl dao = new ComandaDaoImpl();
        List resm = dao.getMesas("2013-05-31 11:00:00", "2013-05-31 17:00:00", 2);
        Iterator itr = resm.iterator();

        Mesa_ventaDaoImpl daa = new Mesa_ventaDaoImpl();
        while (itr.hasNext()) {
            Comanda em = (Comanda) itr.next();
            //mv=em.getMesaVenta();
            System.out.println(em.getIdComanda());
            dao.actulizaridDia(em.getIdComanda(), 3);
            //daa.actualizaDia(mv.getIdMesaVenta(),3);
        }


    }

    @Override
    public void actulizarImp(String idComanda, String impresion) {
         Session session = HibernateUtil.getSessionFactory().openSession();

        Transaction tx = null;
        Comanda comanda = null;
        try {
            tx = session.beginTransaction();
            comanda = (Comanda) session.get(Comanda.class, idComanda);
            comanda.setImpreso(impresion);
            session.update(comanda);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                tx.rollback();
            }

        } finally {

            session.close();

        }
    }
    
   
    
}
