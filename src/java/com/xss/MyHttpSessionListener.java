/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.xss;

import javax.servlet.http.*;
import java.util.Date;

public class MyHttpSessionListener implements HttpSessionListener {

    @Override
    public void sessionCreated(HttpSessionEvent se) {
        HttpSession session = se.getSession();
        System.out.print(getTime() + " (session) Created:");
        System.out.println("ID=" + session.getId() + " MaxInactiveInterval="
                + session.getMaxInactiveInterval());
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent se) {
        HttpSession session = se.getSession();
        // session has been invalidated and all session data 
//(except Id)is no longer available
        System.out.println(getTime() + " (session) Destroyed:ID="
                + session.getId());
    }

    private String getTime() {
        return new Date(System.currentTimeMillis()).toString();
    }
}