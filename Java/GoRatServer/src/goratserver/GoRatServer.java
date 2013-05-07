package goratserver;

import com.illposed.osc.*;
import java.util.Date;
import java.awt.Robot;
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
        } catch (Exception e) {}
        
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
    }

}
