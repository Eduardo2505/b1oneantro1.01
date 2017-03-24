/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.dao.impl;

import com.dao.ProductoBeanDao;
import com.mapping.Categoria;
import com.mapping.Producto;
import com.util.HibernateUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import otrosNOsirve.conexion;

/**
 *
 * @author Eduardo
 */
public class ProductoBeanDaoImpl implements ProductoBeanDao {

    @Override
    public List getFiltro(String tipoEvento, String producto,String idCategoria) {
        List<Producto> pg = new ArrayList<Producto>();
        conexion mysql = new conexion();
        Connection cn = mysql.Conectar();
        ResultSet rs = null;
        PreparedStatement st = null;
        try {
            String sSQl = "SELECT "
                    + "    p.idProducto, p.nombre, p.precio,p.tamano,p.horarioinicial,p.horariofinal,p.medida"
                    + " FROM "
                    + "    producto p,"
                    + "    categoria c"
                    + " WHERE "
                    + "        p.idCategoria = c.idCategoria "
                    + "        AND p.url = '1' and c.url='1' "
                    + "        AND p.tipoEvento='" + tipoEvento + "' AND p.nombre like '%" + producto + "%' and p.idCategoria like '%" + idCategoria + "%'"
                    + "ORDER BY p.nombre ASC;";
            
            st = cn.prepareStatement(sSQl);
            rs = st.executeQuery();
            //System.out.println(sSQl);
            while (rs.next()) {
                Producto ne = new Producto();

                ne.setIdProducto(rs.getString(1));
                ne.setNombre(rs.getString(2));
                ne.setPrecio(rs.getFloat(3));
                ne.setTamano(rs.getInt(4));
                ne.setHorarioinicial(rs.getString(5));
                ne.setHorariofinal(rs.getString(6));
                ne.setMedida(rs.getString(7));


                pg.add(ne); //agregas ese objeto a la lista

            }
            st.close();
            rs.close();
            cn.close();

        } catch (Exception e) {
            return null;
        }
        return pg;
    }

    public List getFiltro() {
        List<Categoria> categoria = null;
        Session session = HibernateUtil.getSessionFactory().openSession();


        try {

            Query q = session.createQuery("From Categoria as categoria where url='1' order by idCategoria ASC ");
            categoria = (List<Categoria>) q.list();


        } catch (Exception e) {
            return null;
        } finally {
            session.close();
        }
        return categoria;
    }

    public static void main(String[] args) {
        ProductoBeanDaoImpl dao = new ProductoBeanDaoImpl();

        List res = dao.getFiltro("Nocturno", "","");

        Iterator itr = res.iterator();
        while (itr.hasNext()) {
            Producto p = (Producto) itr.next();
            System.out.println(p.getNombre()+" "+p.getTamano()+" "+p.getMedida());
        }
    }
}
