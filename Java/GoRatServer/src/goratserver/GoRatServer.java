package goratserver;

import com.illposed.osc.*;
import java.util.Date;
import java.awt.Robot;
import java.awt.event.InputEvent;
import java.awt.event.KeyEvent;

class GoRatServer {
    OSCPortIn server;
    Robot robot;
    public static void main(String[] args) {
        GoRatServer grs = new GoRatServer();
        grs.init();
    }
    
    public void init() {
        try {
            robot = new Robot();
            server = new OSCPortIn(32000);
            this.addListeners();
            server.startListening();
        } catch (Exception e) {
            e.printStackTrace();
        }
        
    }
    
    public void addListeners() {
        OSCListener listener = new OSCListener() {
            public void acceptMessage(Date date, OSCMessage oscm) {
                Object[] args = oscm.getArguments();
                robot.keyPress((int) args[2]);
            }
        };
        server.addListener("/keyPress", listener);
        
        OSCListener listener2 = new OSCListener() {
            public void acceptMessage(Date date, OSCMessage oscm) {
                Object[] args = oscm.getArguments();
                robot.keyRelease((int) args[2]);
            }
        };
        server.addListener("/keyRelease", listener2);
        
        OSCListener listener3 = new OSCListener() {
            public void acceptMessage(Date date, OSCMessage oscm) {
                Object[] args = oscm.getArguments();
                robot.mouseMove((int) args[0], (int) args[1]);
            }
        };
        server.addListener("/mouseMove", listener3);
        
        OSCListener listener4 = new OSCListener() {
            public void acceptMessage(Date date, OSCMessage oscm) {
                Object[] args = oscm.getArguments();
                robot.mouseMove((int) args[0], (int) args[1]);
                robot.mousePress(InputEvent.BUTTON1_DOWN_MASK);
            }
        };
        server.addListener("/mousePress", listener4);
        
        OSCListener listener5 = new OSCListener() {
            public void acceptMessage(Date date, OSCMessage oscm) {
                Object[] args = oscm.getArguments();
                robot.mouseMove((int) args[0], (int) args[1]);
                robot.mouseRelease(InputEvent.BUTTON1_DOWN_MASK);
            }
        };
        server.addListener("/mouseRelease", listener5);
    }

}
