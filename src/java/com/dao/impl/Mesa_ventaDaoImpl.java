/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.dao.impl;

import com.dao.Mesa_ventaDao;
import com.mapping.Altadia;
import com.mapping.Comanda;
import com.mapping.Descuento;
import com.mapping.Empleado;
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
public class Mesa_ventaDaoImpl implements Mesa_ventaDao {

    @Override
    public List getMesaVenta(String estado, String idEmpleado, int idDia) {
        List<MesaVenta> mesaVenta = null;
        Session session = HibernateUtil.getSessionFactory().openSession();

        try {

            Query q = session.createQuery("From MesaVenta where estado != 'Cancelado' and  estado like '%" + estado + "%' and idEmpleado like '%" + idEmpleado + "%' and idaltadia=" + idDia + " ORDER BY posicion");
            mesaVenta = (List<MesaVenta>) q.list();


        } catch (Exception e) {
            return null;

        } finally {

            session.close();
        }
        return mesaVenta;
    }

    @Override
    public List BuscarMesaVenta(String estado, String idEmpleado, int idDia, String idMesa) {
        List<MesaVenta> mesaVenta = null;
        Session session = HibernateUtil.getSessionFactory().openSession();

        try {

            Query q = session.createQuery("From MesaVenta where estado='" + estado + "' and idEmpleado='" + idEmpleado + "' and idaltadia=" + idDia + " and idMesa_venta like '%" + idMesa + "%'");
            mesaVenta = (List<MesaVenta>) q.list();


        } catch (Exception e) {
            return null;

        } finally {

            session.close();
        }
        return mesaVenta;
    }

    @Override
    public void insertar(MesaVenta mesaventa) {
        Session session = HibernateUtil.getSessionFactory().openSession();

        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.save(mesaventa);
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
    public void actualiza(String idMesaventa, float total) {
        Session session = HibernateUtil.getSessionFactory().openSession();

        Transaction tx = null;
        MesaVenta mv = null;
        try {
            tx = session.beginTransaction();
            mv = (MesaVenta) session.get(MesaVenta.class, idMesaventa);
            mv.setTotalcuenta(total);
            session.update(mv);
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
    public MesaVenta bucarPorId(String id) {
        Session session = HibernateUtil.getSessionFactory().openSession();

        MesaVenta mesaVenta = null;
        try {

            mesaVenta = (MesaVenta) session.get(MesaVenta.class, id);


        } catch (Exception e) {
            return null;

        } finally {
            // session.close();
        }
        return mesaVenta;
    }

    @Override
    public void trasladar(String idMesaventa, Empleado empleado) {
        Session session = HibernateUtil.getSessionFactory().openSession();

        Transaction tx = null;
        MesaVenta mv = null;

        try {
            tx = session.beginTransaction();
            mv = (MesaVenta) session.get(MesaVenta.class, idMesaventa);

            mv.setEmpleado(empleado);

            session.update(mv);
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
    public void cerrar(String idMesaventa, String estado, String hora, String autorizacion) {
        Session session = HibernateUtil.getSessionFactory().openSession();

        Transaction tx = null;
        MesaVenta mv = null;
        try {
            tx = session.beginTransaction();
            mv = (MesaVenta) session.get(MesaVenta.class, idMesaventa);
            mv.setHoraCerrada(hora);
            mv.setEstado(estado);
            mv.setAtorizacion(autorizacion);
            mv.setObservaciones("-");
            session.update(mv);
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
    public int contar() {
        Session session = HibernateUtil.getSessionFactory().openSession();

        int total = 0;
        try {

            String sql = "select count(*) from MesaVenta";
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
    public float Sumtotal(int idDia) {
        Session session = HibernateUtil.getSessionFactory().openSession();

        float total = 0;
        try {

            String sql = "select sum(totalcuenta) from MesaVenta where idaltadia=" + idDia + "  and estado!='Cancelado'";
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
    public int MesaAbiertas(String idEmpledo) {
        Session session = HibernateUtil.getSessionFactory().openSession();

        int total = 0;
        try {

            String sql = "select count(*) from MesaVenta where estado='Activo' and idEmpleado='" + idEmpledo + "'";
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
    public List getCuentasAbiertas(String estado, int idDia, String idMesaventa) {
        List<MesaVenta> mesaVenta = null;
        Session session = HibernateUtil.getSessionFactory().openSession();

        try {

            Query q = session.createQuery("From MesaVenta where estado like '%" + estado + "%'  and idaltadia=" + idDia + " and idMesa_venta like '%" + idMesaventa + "%' and estado!='Cancelado' ORDER BY idMesa_venta");
            mesaVenta = (List<MesaVenta>) q.list();


        } catch (Exception e) {
            return null;

        } finally {
            // session.close();
        }
        return mesaVenta;
    }

    @Override
    public void actualizaDia(String idMesaventa, int iddia) {
        Session session = HibernateUtil.getSessionFactory().openSession();

        Transaction tx = null;
        MesaVenta mv = null;
        try {
            tx = session.beginTransaction();
            mv = (MesaVenta) session.get(MesaVenta.class, idMesaventa);
            Altadia a = new Altadia();
            a.setIdaltadia(iddia);
            mv.setAltadia(a);
            session.update(mv);
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
    public void actualiza(String idMesaventa, float efectivo, float tarjeta) {
        Session session = HibernateUtil.getSessionFactory().openSession();

        Transaction tx = null;
        MesaVenta mv = null;
        try {
            tx = session.beginTransaction();
            mv = (MesaVenta) session.get(MesaVenta.class, idMesaventa);
            mv.setEfectivo(efectivo);
            mv.setTarjeta(tarjeta);
            session.update(mv);
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
    public List getCorte(int idDia) {
        List<MesaVenta> mesaVenta = null;
        Session session = HibernateUtil.getSessionFactory().openSession();

        try {

            Query q = session.createQuery("From MesaVenta where idaltadia=" + idDia + " and estado!='Cancelado' GROUP BY idEmpleado ORDER BY idMesa ");
            mesaVenta = (List<MesaVenta>) q.list();


        } catch (Exception e) {
            return null;

        } finally {
            //session.close();
        }
        return mesaVenta;
    }

    @Override
    public float Sumtotal(int idDia, String idEmpleado) {
        Session session = HibernateUtil.getSessionFactory().openSession();

        float total = 0;
        try {

            String sql = "select sum(totalcuenta) from MesaVenta where idaltadia=" + idDia + "  and estado!='Cancelado' and idEmpleado='" + idEmpleado + "'";
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
    public void actualizaDescuento(String idMesaventa, String Autorizacion, String Obs, String iddecuento) {
        Session session = HibernateUtil.getSessionFactory().openSession();

        Transaction tx = null;
        MesaVenta mv = null;
        try {
            tx = session.beginTransaction();
            mv = (MesaVenta) session.get(MesaVenta.class, idMesaventa);
            mv.setAtorizacion(Autorizacion);
            mv.setObservaciones(Obs);
            Descuento d = new Descuento();
            d.setIdDescuento(iddecuento);
            mv.setDescuento(d);
            session.update(mv);
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
    public void AbrirCuenta(String idMesaventa, String estado, String observacion) {
        Session session = HibernateUtil.getSessionFactory().openSession();

        Transaction tx = null;
        MesaVenta mv = null;
        try {
            tx = session.beginTransaction();
            mv = (MesaVenta) session.get(MesaVenta.class, idMesaventa);
            mv.setEstado(estado);
            mv.setObservaciones(observacion);
            session.update(mv);
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
    public List Mostrarmesa(int idDia) {
        List<MesaVenta> mesaVenta = null;
        Session session = HibernateUtil.getSessionFactory().openSession();

        try {

            Query q = session.createQuery("From MesaVenta where estado='Activo'  and idaltadia=" + idDia + " ORDER BY posicion");
            mesaVenta = (List<MesaVenta>) q.list();


        } catch (Exception e) {
            return null;

        } finally {

            session.close();
        }
        return mesaVenta;
    }

    public static void main(String[] args) {
        Mesa_ventaDaoImpl dao = new Mesa_ventaDaoImpl();
        int iddia = 22;
        int iddia2 = 22;
        List res = dao.Mostrarmesa(iddia);
        Iterator itr = res.iterator();
        ComandaDaoImpl dax = new ComandaDaoImpl();
        //Comanda

        ComandaDaoImpl daxc = new ComandaDaoImpl();
        while (itr.hasNext()) {
            MesaVenta e = (MesaVenta) itr.next();

            System.out.println(e.getIdMesaVenta());
            List resc = dax.getBuscar(e.getIdMesaVenta());
            Iterator itrc = resc.iterator();
            while (itr.hasNext()) {

                Comanda c = (Comanda) itr.next();
                ;
                daxc.actulizaridDia(c.getIdComanda(), iddia2);

            }


            //  dax.actulizar(e.getIdMesaVenta(), null);
            //  out.println("<tr><td>" + e.getNombre() + " " + e.getApellidos() + "</td><td>" + e.getRegistro() + "</td><td><a class=\"btn btn-small\" TARGET='_new' href='ImprimirTarjeta?idUsuario=" + e.getIdCliente() + "&nombre=" + e.getNombre() + " " + e.getApellidos() + "'><i class='icon-print'></i>Imprimir</a></td></tr>");


        }
    }

    @Override
    public List getMesaVenta(String estado, int idDia) {
        List<MesaVenta> mesaVenta = null;
        Session session = HibernateUtil.getSessionFactory().openSession();

        try {

            Query q = session.createQuery("From MesaVenta where estado='Cancelado' and idaltadia=" + idDia + " ORDER BY posicion");
            mesaVenta = (List<MesaVenta>) q.list();


        } catch (Exception e) {
            return null;

        } finally {

            session.close();
        }
        return mesaVenta;
    }

    @Override
    public void cerrardescuento(String idMesaventa, String estado, String hora, String autorizacion) {
        Session session = HibernateUtil.getSessionFactory().openSession();

        Transaction tx = null;
        MesaVenta mv = null;
        try {
            tx = session.beginTransaction();
            mv = (MesaVenta) session.get(MesaVenta.class, idMesaventa);
            mv.setHoraCerrada(hora);
            mv.setEstado(estado);
            mv.setAtorizacion(autorizacion);

            session.update(mv);
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
