/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.reportes;

import java.io.File;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartUtilities;
import org.jfree.chart.JFreeChart;
import org.jfree.data.general.DefaultPieDataset;

/**
 *
 * @author Eduardo
 */
public class Dibujar {
    
    public void Dibujar() {
    }

    public String Graficar(DefaultPieDataset data, String direc, String nomA, String titulo, int w, int h) {
        try {
            JFreeChart chart = ChartFactory.createPieChart3D(titulo, data, true, false, false);

            ChartUtilities.saveChartAsJPEG(new File(direc + nomA), chart, w, h);
        } catch (IOException ex) {
            Logger.getLogger(Dibujar.class.getName()).log(Level.SEVERE, null, ex);
        }

        return nomA;
    }
}
