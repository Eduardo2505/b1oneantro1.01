/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.dao;

import com.mapping.Empleado;
import com.mapping.Mesas;
import com.mapping.Zona;
import java.util.List;

/**
 *
 * @author Eduardopc
 */
public interface MesasDao {

    public List getMesas(String estado, String idEmpleado, String idMesa);
    // public List getBuscar(String estado, String idEmpleado,String idMesa);

    public List getMesas(String estado);

    public List getMesas(String estado, String idEmpleado);

    public void insertar(Mesas mesas);

    public Mesas bucarPorId(String id);

    public void actulizar(String idMesa, String estado);

    public void actulizar(String idMesa, Zona z, String estado);

    public void actulizartipo(String idMesa, String pp);

    public Mesas bucarPormpleado(Empleado Empleado);
    // public List<Object[]> joinMesas();
    
    public int mesasMaximas(String idEmpleado);
}
