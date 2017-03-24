/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.dao.impl;

import com.dao.VentaComandaDao;
import com.mapping.Barra;
import com.mapping.Comanda;
import com.mapping.Descuento;
import com.mapping.Producto;
import com.mapping.VentaComanda;
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
public class VentaComandaDaoImpl implements VentaComandaDao {

    @Override
    public int insertar(VentaComanda ventaComanda) {
        int id = 0;
        Session session = HibernateUtil.getSessionFactory().openSession();

        Transaction tx = null;
        try {
            tx = session.beginTransaction();

            session.save(ventaComanda);
            ventaComanda = (VentaComanda) session.get(VentaComanda.class, ventaComanda.getIdVentaComandacol());
            tx.commit();

        } catch (Exception e) {
            if (tx != null) {
                tx.rollback();
            }

        } finally {

            session.close();

        }
        return ventaComanda.getIdVentaComandacol();
    }

    @Override
    public void eliminar(int id) {
        Session session = HibernateUtil.getSessionFactory().openSession();

        Transaction tx = null;
        VentaComanda ventaComanda = null;

        try {
            tx = session.beginTransaction();

            ventaComanda = (VentaComanda) session.get(VentaComanda.class, id);
            session.delete(ventaComanda);
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
    public VentaComanda BuscarComanda(int id) {
        Session session = HibernateUtil.getSessionFactory().openSession();

        VentaComanda ventaComanda = null;
        try {

            ventaComanda = (VentaComanda) session.get(VentaComanda.class, id);


        } catch (Exception e) {
            return null;

        } finally {
            //session.close();
        }
        return ventaComanda;
    }

    @Override
    public int contar() {
        Session session = HibernateUtil.getSessionFactory().openSession();


        int total = 0;
        try {

            String sql = "select count(*) from VentaComanda";
            Query query = session.createQuery(sql);
            total = ((Number) query.uniqueResult()).intValue();

        } catch (Exception e) {
            System.out.println("#########Error al consultar  venta comanda #################" + e.getMessage());
            return 0;

        } finally {

            session.close();

        }
        return total;
    }

    @Override
    public void actualiza(int id, String Observaciones) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        VentaComanda ventacomanda = null;
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            ventacomanda = (VentaComanda) session.get(VentaComanda.class, id);
            ventacomanda.setObservaciones(Observaciones);
            session.update(ventacomanda);
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
    public void actualizaEstado(int id, String estado) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        VentaComanda ventacomanda = null;
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            ventacomanda = (VentaComanda) session.get(VentaComanda.class, id);
            ventacomanda.setEstado(estado);
            session.update(ventacomanda);
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
    public List getVerDistribucion(String idProducto, String idComanda) {
        List<VentaComanda> vc = null;
        Session session = HibernateUtil.getSessionFactory().openSession();

        try {

            Query q = session.createQuery("From VentaComanda where idProducto='" + idProducto + "' and idComanda='" + idComanda + "'");
            vc = (List<VentaComanda>) q.list();


        } catch (Exception e) {
            return null;

        } finally {

            session.close();
        }
        return vc;
    }

    @Override
    public List getVerDistribucion(String idComanda) {
        List<VentaComanda> vc = null;
        Session session = HibernateUtil.getSessionFactory().openSession();

        try {

            Query q = session.createQuery("From VentaComanda where idComanda='" + idComanda + "'");
            vc = (List<VentaComanda>) q.list();


        } catch (Exception e) {
            return null;

        } finally {
            //session.close();
        }
        return vc;
    }

    @Override
    public List getVer(String idComanda) {
        List<VentaComanda> vc = null;
        Session session = HibernateUtil.getSessionFactory().openSession();

        try {
            Query q = session.createQuery("From VentaComanda where idComanda like '%" + idComanda + "%' GROUP BY idProducto,idDescuento,estado");

            vc = (List<VentaComanda>) q.list();


        } catch (Exception e) {
            return null;

        } finally {
            //session.close();
        }
        return vc;
    }

    @Override
    public int contar(String idProducto, String idComanda) {
        Session session = HibernateUtil.getSessionFactory().openSession();


        int total = 0;
        try {

            String sql = "select count(*) from VentaComanda where idProducto='" + idProducto + "' and idComanda='" + idComanda + "'";
            Query query = session.createQuery(sql);
            total = ((Number) query.uniqueResult()).intValue();

        } catch (Exception e) {
            //   System.out.println("#########Error al consultar  venta comanda #################" + e.getMessage());
            return 0;

        } finally {

            session.close();

        }
        return total;
    }

    @Override
    public float total(int idDia, String idMesa_venta) {
        Session session = HibernateUtil.getSessionFactory().openSession();


        float total = 0;
        try {

            String sql = "select sum(vc.costo) from VentaComanda vc,Comanda c where c.idMesa_venta='" + idMesa_venta + "' and c.idaltadia=" + idDia + "";
            Query query = session.createQuery(sql);
            total = ((Number) query.uniqueResult()).intValue();

        } catch (Exception e) {
            //   System.out.println("#########Error al consultar  venta comanda #################" + e.getMessage());
            return 0;

        } finally {

            session.close();

        }
        return total;
    }

    @Override
    public void actualizaDes(int id, String idDes, String Obs, float costo) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        VentaComanda ventacomanda = null;
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            ventacomanda = (VentaComanda) session.get(VentaComanda.class, id);
            Descuento d = new Descuento();
            d.setIdDescuento(idDes);
            ventacomanda.setDescuento(d);
            ventacomanda.setObservaciones(Obs);
            ventacomanda.setCosto(costo);

            session.update(ventacomanda);
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
    public int verificarComanda(String idComanda) {

        Session session = HibernateUtil.getSessionFactory().openSession();


        int total = 0;
        try {

            String sql = "select count(*) from VentaComanda where  idComanda='" + idComanda + "'";
            Query query = session.createQuery(sql);
            total = ((Number) query.uniqueResult()).intValue();

        } catch (Exception e) {
            //   System.out.println("#########Error al consultar  venta comanda #################" + e.getMessage());
            return 0;

        } finally {

            session.close();

        }
        return total;
    }

    public static void main(String[] args) {
        VentaComandaDaoImpl dao = new VentaComandaDaoImpl();
        Comanda c = new Comanda();
        VentaComanda vc = new VentaComanda();
        c.setIdComanda("ALEC122");
        vc.setComanda(c);
        Producto p = new Producto();
        p.setIdProducto("COC-ON531");
        vc.setProducto(p);
        // vc.setObservaciones("");
        // vc.setRegistro(hora);
        //vc.setEstado("");
        // vc.setActorizacion("");
        Barra b = new Barra();
        b.setIdBarra("Barra 1");
        vc.setBarra(b);
        // vc.setCosto(costoUnitario);
        //vc.setCostoOriginal(costoUnitario);
        Descuento des = new Descuento();
        des.setIdDescuento("Ninguno");
        vc.setDescuento(des);
        int id = dao.insertar(vc);
        System.out.println(id);





    }
}
