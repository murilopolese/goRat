import oscP5.*;
import netP5.*;

OscP5 osc;
NetAddress server;
PVector serverSize = new PVector(800, 600);
PVector clientSize = new PVector (480, 320);
float[] ratio = {
  serverSize.x/clientSize.x, serverSize.y/clientSize.y
};
String[] lines;

void setup()
{
  // Load configuration:
  // lines[0]: server width
  // lines[1]: server height
  // lines[2]: server ip
  // lines[3]: server port
  lines = loadStrings("config");
  serverSize = new PVector(int(lines[0]), int(lines[1]));
  ratio[0] = serverSize.x/clientSize.x;
  ratio[1] = serverSize.y/clientSize.y;
  
  size(int(clientSize.x), int(clientSize.y));
  frameRate(20);
  background(100);
  osc = new OscP5(this, int(lines[3]));
  server = new NetAddress(lines[2], int(lines[3]));
}

void draw() {}

// This one just send mouse position
void sendMessage(String pattern)
{
  OscMessage msg = new OscMessage(pattern);
  msg.add(int(mouseX*ratio[0]));
  msg.add(int(mouseY*ratio[1]));
  osc.send(msg, server);
}
// This other send the mouse position with a value
// that can be the mouse button or the keyboard event
void sendMessage(String pattern, int value)
{
  OscMessage msg = new OscMessage(pattern);
  msg.add(int(mouseX*ratio[0]));
  msg.add(int(mouseY*ratio[1]));
  msg.add(value);
  osc.send(msg, server);
  println(value);
}

void mouseMoved()
{
  sendMessage("/mouseMove");
}
void mouseDragged()
{
  sendMessage("/mouseMove");
}
void mousePressed()
{
  sendMessage("/mousePress", mouseButton);
}
void mouseReleased()
{
  sendMessage("/mouseRelease", mouseButton);
}
void keyPressed()
{
  sendMessage("/keyPress", keyCode);
}
void keyReleased()
{
  sendMessage("/keyRelease", keyCode);
}
