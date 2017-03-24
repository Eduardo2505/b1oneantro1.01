/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.dao.impl;

import com.dao.AltadiaDao;
import com.mapping.Altadia;
import com.util.HibernateUtil;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author Eduardopc
 */
public class AltadiaDaoImpl implements AltadiaDao {

    @Override
    public List getDias() {
        List<Altadia> dia = null;
        Session session = HibernateUtil.getSessionFactory().openSession();

        try {

            Query q = session.createQuery("From Altadia order by fecha Desc ");
            dia = (List<Altadia>) q.list();


        } catch (Exception e) {
            return null;

        } finally {

            session.close();
        }
        return dia;
    }

    @Override
    public Altadia bucar() {
        Session session = HibernateUtil.getSessionFactory().openSession();

        Altadia altadia = null;
        try {
            String sql = "From Altadia as altadia where estado='Activo'";
            Query query = session.createQuery(sql);

            altadia = (Altadia) query.uniqueResult();


        } catch (Exception e) {
            return null;

        } finally {

            session.close();

        }
        return altadia;
    }

    @Override
    public void insertar(Altadia altadia) {
        Session session = HibernateUtil.getSessionFactory().openSession();

        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.save(altadia);
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
    public void actulizar(int id, String estado) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Altadia altadia = null;
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            altadia = (Altadia) session.get(Altadia.class, id);
            altadia.setEstado(estado);
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
    public Altadia bucar(int id) {
       Session session = HibernateUtil.getSessionFactory().openSession();

        Altadia a = null;
        try {

            a = (Altadia) session.get(Altadia.class, id);


        } catch (Exception e) {
            return null;

        } finally {
            session.close();
        }
        return a;
    }

    public static void main(String[] args) {
        Date ahora = new Date();
        SimpleDateFormat dateFormat = new SimpleDateFormat("HH:mm:ss");

        SimpleDateFormat dateFormatf = new SimpleDateFormat("yyyy-MM-dd");
        String fechaAc = dateFormatf.format(ahora);
        String horaActu = dateFormat.format(ahora);

        AltadiaDaoImpl dao = new AltadiaDaoImpl();
        Altadia dia = new Altadia();
        dia.setFecha(fechaAc);
        dia.setHora(fechaAc + " " + horaActu);
        dia.setEstado("Activo");
        dia.setTipoEvento("Nocturno");

        dao.insertar(dia);

         
         

    }
}
