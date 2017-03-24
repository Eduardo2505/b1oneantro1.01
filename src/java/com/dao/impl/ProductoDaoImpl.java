/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.dao.impl;

import com.dao.ProductoDao;
import com.mapping.Categoria;
import com.mapping.Producto;
import com.util.HibernateUtil;
import java.util.Iterator;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Transaction;
import org.hibernate.classic.Session;

/**
 *
 * @author Eduardopc
 */
public class ProductoDaoImpl implements ProductoDao {

    @Override
    public List getFiltro(String idCategoria, String tipo, String tipoEvento, String nomproducto) {
        List<Producto> producto = null;
        Session session = HibernateUtil.getSessionFactory().openSession();

        try {
            String SSQL = "From Producto as producto where idCategoria like '%" + idCategoria + "%' AND tipo like '%" + tipo + "%' AND tipoEvento like '%" + tipoEvento + "%' AND nombre like '%" + nomproducto + "%' AND url!='0' order by nombre ASC";
            Query q = session.createQuery(SSQL);
            producto = (List<Producto>) q.list();


        } catch (Exception e) {
            return null;
        } finally {
            session.close();
        }
        return producto;

    }

    @Override
    public void insertar(Producto producto) {
        Session session = HibernateUtil.getSessionFactory().openSession();

        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.save(producto);
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
    public void actulizar(String idPro, String tipo, String evento) {
        Session session = HibernateUtil.getSessionFactory().openSession();

        Transaction tx = null;
        Producto producto = null;
        try {
            tx = session.beginTransaction();
            producto = (Producto) session.get(Producto.class, idPro);
            producto.setTipo(tipo);
            producto.setTipoEvento(evento);
            session.update(producto);
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
    public List getOtro() {
        List<Producto> producto = null;
        Session session = HibernateUtil.getSessionFactory().openSession();

        try {
            String SSQL = "from Producto where tipo is null";
            Query q = session.createQuery(SSQL);
            producto = (List<Producto>) q.list();


        } catch (Exception e) {
            return null;
        } finally {
            session.close();
        }
        return producto;
    }

    @Override
    public List getBuscar(String nombre, String tipoEvento) {
        List<Producto> producto = null;
        Session session = HibernateUtil.getSessionFactory().openSession();

        try {

            Query q = session.createQuery("From Producto as producto where nombre like '%" + nombre + "%' and tipoEvento like '%" + tipoEvento + "%' order by nombre ASC ");
            producto = (List<Producto>) q.list();


        } catch (Exception e) {
            return null;
        } finally {
            session.close();
        }
        return producto;
    }

    @Override
    public Producto getBuscar(String id) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Producto producto = null;

        try {


            producto = (Producto) session.get(Producto.class, id);
        } catch (Exception e) {
            return null;

        } finally {
            session.close();
        }
        return producto;
    }

    @Override
    public List getFiltro(String categori,String evento) {
        List<Producto> producto = null;
        Session session = HibernateUtil.getSessionFactory().openSession();

        try {
            String SSQL = "from Producto where idCategoria='" + categori + "' and tipoEvento='"+evento+"'";
            Query q = session.createQuery(SSQL);
            producto = (List<Producto>) q.list();


        } catch (Exception e) {
            return null;
        } finally {
            session.close();
        }
        return producto;
    }

    @Override
    public List getVEr() {
        List<Producto> producto = null;
        Session session = HibernateUtil.getSessionFactory().openSession();

        try {
            String SSQL = "from Producto order by nombre desc";
            Query q = session.createQuery(SSQL);
            producto = (List<Producto>) q.list();


        } catch (Exception e) {
            return null;
        } finally {
            session.close();
        }
        return producto;
    }

    @Override
    public int contar() {
        Session session = HibernateUtil.getSessionFactory().openSession();


        int total = 0;
        try {

            String sql = "select count(*) from Producto";
            Query query = session.createQuery(sql);
            total = ((Number) query.uniqueResult()).intValue();

        } catch (Exception e) {
            System.out.println("#########Error CONTAR PRODUCTOS#################" + e.getMessage());
            return 0;

        } finally {

            session.close();

        }
        return total;
    }

    public static void main(String[] args) {

        ProductoDaoImpl dao = new ProductoDaoImpl();
        String tipoEveneto = "Nocturno";
        String Categoria = "REFRESCO";
        String tipo = "Otro";
        int contar = dao.contar() + 1;
        String nombre = "Coca cola";
        int tamano = 335;
        float costo = 325;
        String idProducto = Categoria.substring(0, 3) + nombre.substring(0, 3) + "-" + tipo.substring(0, 1) + tipoEveneto.substring(0, 1) + contar;
        Producto p = new Producto();
        Categoria c = new Categoria();
        p.setIdProducto(idProducto.toUpperCase());
        p.setNombre(nombre);
        p.setTamano(tamano);
        c.setIdCategoria(Categoria);
        p.setCategoria(c);
        p.setTipo(tipo);
        p.setTipoEvento(tipoEveneto);
        p.setPrecio(costo);
        dao.insertar(p);


        /*ProductoDaoImpl dao = new ProductoDaoImpl();
         List res = dao.getOtro();
         Iterator itr = res.iterator();
         while (itr.hasNext()) {
         Producto p = (Producto) itr.next();
         dao.actulizar(p.getIdProducto(), "Otros", "Nocturno");
         System.out.println(p.getIdProducto());

         }*/
    }

    @Override
    public List getFiltro(String tipo, String tipoEvento, String nomproducto) {
        List<Producto> producto = null;
        Session session = HibernateUtil.getSessionFactory().openSession();

        try {
            String SSQL = "From Producto as producto where tipo like '%" + tipo + "%' AND tipoEvento like '%" + tipoEvento + "%' AND nombre like '%" + nomproducto + "%' AND url!='0' order by nombre ASC";
            Query q = session.createQuery(SSQL);
            producto = (List<Producto>) q.list();


        } catch (Exception e) {
            return null;
        } finally {
            session.close();
        }
        return producto;
       
    }

    @Override
    public void actualizar(Producto producto) {
         Session session = HibernateUtil.getSessionFactory().openSession();

        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.update(producto);
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
    public List getVErSucategorias() {
List<Producto> producto = null;
        Session session = HibernateUtil.getSessionFactory().openSession();

        try {
            String SSQL = "From Producto group by importacion";
            Query q = session.createQuery(SSQL);
            producto = (List<Producto>) q.list();


        } catch (Exception e) {
            return null;
        } finally {
            session.close();
        }
        return producto;
    }

    @Override
    public List getProPromo(String tipo) {
        List<Producto> producto = null;
        Session session = HibernateUtil.getSessionFactory().openSession();

        try {
            String SSQL = "From Producto as producto importacion='" + tipo + "' and url='0'";
            Query q = session.createQuery(SSQL);
            producto = (List<Producto>) q.list();


        } catch (Exception e) {
            return null;
        } finally {
            session.close();
        }
        return producto;
    }

    @Override
    public void actulizarPromo(String idPro, String act) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public List getAdicionales() {
        List<Producto> producto = null;
        Session session = HibernateUtil.getSessionFactory().openSession();

        try {
            String SSQL = "from Producto group by nombre";
            Query q = session.createQuery(SSQL);
            producto = (List<Producto>) q.list();


        } catch (Exception e) {
            return null;
        } finally {
            session.close();
        }
        return producto;
    }
}
