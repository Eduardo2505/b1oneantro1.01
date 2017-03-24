/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.dao;

import com.mapping.Barra;
import com.mapping.Empleado;
import java.util.List;

/**
 *
 * @author Eduardopc
 */
public interface EmpleadoDao {

    public Empleado Login(Empleado empleado);

    public Empleado clave(String id, String pass);

    public Empleado bucarPorId(String id);

    public Empleado verificarCantras(String id);

    public Empleado verificarCantrasDes(String id);

    public Empleado supervisar(String id);

    public List buscarEmpleado(String buscar);

    public Empleado verificarTrasn(String clave);

    public void insertar(Empleado empleado);

    public void actulizar(String idEmpleado, Barra barra);

    public void actulizarpass(String idEmpleado, String pass);

    public void actulizarpue(String idEmpleado, int idpuesto);

    public void actulizarDato(String idEmpleado, String pass, String clave, String idbarra, int idpue);

    public Empleado buscarEmail(Empleado empleado);

    public List getEmpleado(String estado);

    public List getBuscar(String NombreCompleto);

    public List getFiltro();

    public int contar();

    public int verificarClave(String clave);

    public List getFiltro(String idbarra);
}
