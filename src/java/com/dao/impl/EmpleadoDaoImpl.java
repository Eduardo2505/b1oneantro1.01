/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.dao.impl;

import com.dao.EmpleadoDao;
import com.mapping.Barra;
import com.mapping.Empleado;
import com.mapping.Mesas;
import com.mapping.Puesto;
import com.mapping.Zona;
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
public class EmpleadoDaoImpl implements EmpleadoDao {

    Empleado empleado = null;

    @Override
    public Empleado Login(Empleado empleado) {
        Session session = HibernateUtil.getSessionFactory().openSession();


        try {

            String sql = "select u from Empleado u where mail=:email and passEmail=:pass and idpuesto in(2,3,8,12,22,23,24)";
            Query query = session.createQuery(sql);
            query.setString("email", empleado.getMail());
            query.setString("pass", empleado.getPassEmail());
            empleado = (Empleado) query.uniqueResult();

        } catch (Exception e) {
            return null;

        } finally {
            //session.close();
        }
        return empleado;

    }

    @Override
    public Empleado buscarEmail(Empleado empleado) {
        Session session = HibernateUtil.getSessionFactory().openSession();

        try {

            String sql = "select u from Empleado u where mail=:email";
            Query query = session.createQuery(sql);
            query.setString("email", empleado.getMail());
            empleado = (Empleado) query.uniqueResult();

        } catch (Exception e) {
            return null;

        } finally {
            //session.close();
        }
        return empleado;
    }

    @Override
    public Empleado bucarPorId(String id) {
        Session session = HibernateUtil.getSessionFactory().openSession();


        try {

            empleado = (Empleado) session.get(Empleado.class, id);


        } catch (Exception e) {

            return null;

        } finally {
            //session.close();
        }
        return empleado;
    }

    @Override
    public Empleado verificarCantras(String id) {
        Session session = HibernateUtil.getSessionFactory().openSession();

        int total = 0;
        try {

            String sql = "select u from Empleado u where idpuesto in(2,3,8,12,22) and CONCAT(Empleadocol,'',pass)=:pass";

            //String sql = "SELECT count(*)  FROM Empleado  where  CONCAT(Empleadocol,'',pass) like '%EL1LALO%'";
            Query query = session.createQuery(sql);
            query.setString("pass", id);
            empleado = (Empleado) query.uniqueResult();

        } catch (Exception e) {

            return null;

        } finally {
            session.close();
        }
        return empleado;
    }

    @Override
    public Empleado verificarTrasn(String clave) {
        Session session = HibernateUtil.getSessionFactory().openSession();

        int total = 0;
        try {


            String sql = "select u from Empleado u where Empleadocol=:clave";
            Query query = session.createQuery(sql);
            query.setString("clave", clave);
            empleado = (Empleado) query.uniqueResult();

        } catch (Exception e) {
            return null;

        } finally {
            session.close();
        }
        return empleado;
    }

 

    @Override
    public Empleado supervisar(String id) {
        Session session = HibernateUtil.getSessionFactory().openSession();

        int total = 0;
        try {

            String sql = "select u from Empleado u where CONCAT(Empleadocol,'',pass)=:pass and (idpuesto=22 or idpuesto=8 or idpuesto=2 or idpuesto=3 or idpuesto=8 or idpuesto=23 or idpuesto=12)";

            //String sql = "SELECT count(*)  FROM Empleado  where  CONCAT(Empleadocol,'',pass) like '%EL1LALO%'";
            Query query = session.createQuery(sql);
            query.setString("pass", id);
            empleado = (Empleado) query.uniqueResult();

        } catch (Exception e) {

            return null;

        } finally {
            session.close();
        }
        return empleado;
    }

    @Override
    public void insertar(Empleado empleado) {
        Session session = HibernateUtil.getSessionFactory().openSession();

        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.save(empleado);
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
    public void actulizar(String idEmpleado, Barra barra) {
        Session session = HibernateUtil.getSessionFactory().openSession();

        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            empleado = (Empleado) session.get(Empleado.class, idEmpleado);
            empleado.setBarra(barra);
            session.update(empleado);
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
    public List getEmpleado(String estado) {
        List<Empleado> empleados = null;
        Session session = HibernateUtil.getSessionFactory().openSession();
        try {

            Query q = session.createQuery("From Empleado as empleado where estado='" + estado + "'");
            empleados = (List<Empleado>) q.list();


        } catch (Exception e) {
            return null;

        } finally {

            session.close();

        }
        return empleados;
    }

    @Override
    public List getFiltro() {
        List<Empleado> empleados = null;
        Session session = HibernateUtil.getSessionFactory().openSession();


        try {

            Query q = session.createQuery("From Empleado as empleado where idpuesto in(12,5,1,8,22,2,3,23) order by Nombre ");
            empleados = (List<Empleado>) q.list();


        } catch (Exception e) {
            return null;
        } finally {
            //session.close();
        }
        return empleados;
    }

    @Override
    public int contar() {
        Session session = HibernateUtil.getSessionFactory().openSession();

        int total = 0;
        try {

            String sql = "select count(*) from Empleado";
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
    public List getBuscar(String NombreCompleto) {
        List<Empleado> empleados = null;
        Session session = HibernateUtil.getSessionFactory().openSession();
        try {

            Query q = session.createQuery("From Empleado as empleado where Empleadocol like '" + NombreCompleto + "%'");
            empleados = (List<Empleado>) q.list();


        } catch (Exception e) {
            return null;

        } finally {
            //  session.close();
        }
        return empleados;
    }

    @Override
    public void actulizarDato(String idEmpleado, String pass, String clave, String idbarra, int idPuesto) {
        Session session = HibernateUtil.getSessionFactory().openSession();

        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            empleado = (Empleado) session.get(Empleado.class, idEmpleado);
            empleado.setPass(pass);
            empleado.setEmpleadocol(clave);
            Barra b = new Barra();
            b.setIdBarra(idbarra);
            empleado.setBarra(b);
            Puesto p = new Puesto();
            p.setIdpuesto(idPuesto);
            empleado.setPuesto(p);
            session.update(empleado);
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
    public Empleado clave(String id, String pass) {
        Session session = HibernateUtil.getSessionFactory().openSession();

        try {

            String sql = "select u from Empleado u where idEmpleado='" + id + "' and pass='" + pass + "'";
            Query query = session.createQuery(sql);

            empleado = (Empleado) query.uniqueResult();

        } catch (Exception e) {
            return null;

        } finally {
            //session.close();
        }
        return empleado;
    }

    @Override
    public int verificarClave(String clave) {
        Session session = HibernateUtil.getSessionFactory().openSession();

        int total = 0;
        try {

            String sql = "select count(*) from Empleado where Empleadocol='" + clave + "'";
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
    public void actulizarpass(String idEmpleado, String pass) {
        Session session = HibernateUtil.getSessionFactory().openSession();

        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            empleado = (Empleado) session.get(Empleado.class, idEmpleado);
            empleado.setPass(pass);
            session.update(empleado);
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
    public List buscarEmpleado(String buscar) {
        List<Empleado> empleados = null;
        Session session = HibernateUtil.getSessionFactory().openSession();
        try {

            String sql = "select u from Empleado u where CONCAT(Nombre,' ',apellidos,'',Empleadocol) like '%" + buscar + "%'";
            Query query = session.createQuery(sql);
            empleados = (List<Empleado>) query.list();


        } catch (Exception e) {
            return null;

        } finally {
            //  session.close();
        }
        return empleados;
    }

    @Override
    public void actulizarpue(String idEmpleado, int idpuesto) {
        Session session = HibernateUtil.getSessionFactory().openSession();

        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            empleado = (Empleado) session.get(Empleado.class, idEmpleado);
            Puesto p = new Puesto();
            p.setIdpuesto(idpuesto);
            empleado.setPuesto(p);
            session.update(empleado);
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
    public List getFiltro(String idbarra) {
        List<Empleado> empleados = null;
        Session session = HibernateUtil.getSessionFactory().openSession();
        Query q = null;

        try {
            if (idbarra.equals("Desactivar")) {
                System.out.println("Entriiiiis");
                q = session.createQuery("From Empleado as empleado where idBarra='Desactivar' order by Empleadocol ");
            } else {
                q = session.createQuery("From Empleado as empleado where idBarra!='Desactivar' order by Empleadocol ");
            }
            empleados = (List<Empleado>) q.list();


        } catch (Exception e) {
            return null;
        } finally {
            //session.close();
        }
        return empleados;
    }

    @Override
    public Empleado verificarCantrasDes(String id) {
        Session session = HibernateUtil.getSessionFactory().openSession();

        int total = 0;
        try {

            String sql = "select u from Empleado u where idpuesto!=5 and idpuesto!=1 and idpuesto!=23 and CONCAT(Empleadocol,'',pass)=:pass";

            //String sql = "SELECT count(*)  FROM Empleado  where  CONCAT(Empleadocol,'',pass) like '%EL1LALO%'";
            Query query = session.createQuery(sql);
            query.setString("pass", id);
            empleado = (Empleado) query.uniqueResult();

        } catch (Exception e) {

            return null;

        } finally {
            session.close();
        }
        return empleado;
    }
}
