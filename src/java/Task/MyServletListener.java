/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Task;

import java.util.Timer;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

/**
 *
 * @author hp g4
 */
public class MyServletListener implements ServletContextListener {

    public static final int DELAY = 1000;
    Timer timer;
    SimpleTimer simpleTimer;

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        timer = new Timer();
        simpleTimer = new SimpleTimer();

        timer.schedule(simpleTimer, DELAY, DELAY * 60);
        //timer.schedule(horarioTipo,DELAY,DELAY*60);
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        //  simpleTimer.cancel();
        timer.cancel();
    }
}
