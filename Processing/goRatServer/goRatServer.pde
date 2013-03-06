import oscP5.*;
import netP5.*;
import java.awt.*;

OscP5 osc;
NetAddress server;
Robot robot = null;
PVector pos = new PVector();

void setup()
{
  noLoop();
  try {
    osc = new OscP5(this, 32000);
    robot = new Robot();
  } 
  catch(Exception e) {
    println("deu erro");
  }
}

void draw()
{

}

void oscEvent(OscMessage msg) {
  pos = new PVector(msg.get(0).intValue(), msg.get(1).intValue());
  robot.mouseMove(int(pos.x), int(pos.y));
  if (msg.checkAddrPattern("/mousePress")==true)
  {
    int button = (int) msg.get(2).intValue();
    if (button == 37)
    {
      robot.mousePress(16);
    }
  }
  if (msg.checkAddrPattern("/mouseRelease")==true)
  {
    int button = (int) msg.get(2).intValue();
    if (button == 37)
    {
      robot.mouseRelease(16);
    }
  }
  if (msg.checkAddrPattern("/keyPress")==true)
  {
    int code = (int) msg.get(2).intValue();
    robot.keyPress(code);
    robot.keyRelease(code);
  }
}

