import oscP5.*;
import netP5.*;
import java.awt.event.KeyEvent;

OscP5 osc;
NetAddress server;
color grey = #F9F9F9;
color blue = #0099CC;
color black = #222222;
float slotX, slotY, s;
int[] k;
PVector up, down, left, right, a, b, x, y;

boolean started = false;

void setup() {
  size(displayWidth, displayHeight);
  background(grey);
  stroke(blue);
  fill(blue);
  ellipseMode(CENTER);
  frameRate(60);

  osc = new OscP5(this, 32000);
  server = new NetAddress("192.168.1.101", 32000);

  slotX = width / 9;
  slotY = height / 5;
  up = new PVector(2*slotX, slotY);
  down = new PVector(2*slotX, 3*slotY);
  left = new PVector(slotX, 2*slotY);
  right = new PVector(3*slotX, 2*slotY);
  b = new PVector(6*slotX, 3*slotY); 
  a = new PVector(8*slotX, 2.5*slotY);
  x = new PVector(6*slotX, 1.5*slotY);
  y = new PVector(8*slotX, slotY);
}

void draw() {
  background(grey);
  if (started)
    drawButtons();
  else
    drawMenu();
};

int[] setP1Keys() {
  int[] keys = new int[8];
  keys[0] = KeyEvent.VK_Q;
  keys[1] = KeyEvent.VK_W;
  keys[2] = KeyEvent.VK_E;
  keys[3] = KeyEvent.VK_R;
  keys[4] = KeyEvent.VK_T;
  keys[5] = KeyEvent.VK_Y;
  keys[6] = KeyEvent.VK_U;
  keys[7] = KeyEvent.VK_I;
  return keys;
}

int[] setP2Keys() {
  int[] keys = new int[8];
  keys[0] = KeyEvent.VK_A;
  keys[1] = KeyEvent.VK_S;
  keys[2] = KeyEvent.VK_D;
  keys[3] = KeyEvent.VK_F;
  keys[4] = KeyEvent.VK_G;
  keys[5] = KeyEvent.VK_H;
  keys[6] = KeyEvent.VK_J;
  keys[7] = KeyEvent.VK_K;
  return keys;
}

void drawButtons() {
  ellipse(up.x, up.y, slotY, slotY);
  ellipse(down.x, down.y, slotY, slotY);
  ellipse(left.x, left.y, slotY, slotY);
  ellipse(right.x, right.y, slotY, slotY);
  ellipse(b.x, b.y, slotY, slotY);
  ellipse(a.x, a.y, slotY, slotY);
  ellipse(x.x, x.y, slotY, slotY);
  ellipse(y.x, y.y, slotY, slotY);
}

void buttonsAction() {
  if (dist(mouseX, mouseY, up.x, up.y) < (slotY/2))
    sendMessage("/keyPress", k[0]);
  if (dist(mouseX, mouseY, down.x, down.y) < (slotY/2))
    sendMessage("/keyPress", k[1]);
  if (dist(mouseX, mouseY, left.x, left.y) < (slotY/2))
    sendMessage("/keyPress", k[2]);
  if (dist(mouseX, mouseY, right.x, right.y) < (slotY/2))
    sendMessage("/keyPress", k[3]);
  if (dist(mouseX, mouseY, a.x, a.y) < (slotY/2))
    sendMessage("/keyPress", k[4]);
  if (dist(mouseX, mouseY, b.x, b.y) < (slotY/2))
    sendMessage("/keyPress", k[5]);
  if (dist(mouseX, mouseY, x.x, x.y) < (slotY/2))
    sendMessage("/keyPress", k[6]);
  if (dist(mouseX, mouseY, y.x, y.y) < (slotY/2))
    sendMessage("/keyPress", k[7]);
}

void buttonsReleaseAction() {
  if (dist(mouseX, mouseY, up.x, up.y) < (slotY/2))
    sendMessage("/keyRelease", k[0]);
  if (dist(mouseX, mouseY, down.x, down.y) < (slotY/2))
    sendMessage("/keyRelease", k[1]);
  if (dist(mouseX, mouseY, left.x, left.y) < (slotY/2))
    sendMessage("/keyRelease", k[2]);
  if (dist(mouseX, mouseY, right.x, right.y) < (slotY/2))
    sendMessage("/keyRelease", k[3]);
  if (dist(mouseX, mouseY, a.x, a.y) < (slotY/2))
    sendMessage("/keyRelease", k[4]);
  if (dist(mouseX, mouseY, b.x, b.y) < (slotY/2))
    sendMessage("/keyRelease", k[5]);
  if (dist(mouseX, mouseY, x.x, x.y) < (slotY/2))
    sendMessage("/keyRelease", k[6]);
  if (dist(mouseX, mouseY, y.x, y.y) < (slotY/2))
    sendMessage("/keyRelease", k[7]);
}

void drawMenu() {
  rect(
    height/15, 
    height/15, 
    (width/2)-2*(height/15), 
    height-2*(height/15)
  );
  rect(
    (width/2)+(height/15), 
    height/15, 
    (width/2)-2*(height/15), 
    height-2*(height/15)
  );
}

void menuAction() {
  if(mouseX < ((width/2)-2*(height/15))) {
    k = setP1Keys();
    started = true;
  }
  if(mouseX > ((width/2)+(height/15))) {
    k = setP2Keys();
    started = true;
  }
}

void sendMessage(String pattern, int value) {
  OscMessage msg = new OscMessage(pattern);
  msg.add(0);
  msg.add(0);
  msg.add(value);
  osc.send(msg, server);
}

void mousePressed() {
  if (started)
    buttonsAction();
  else
    menuAction();
}

void mouseReleased() {
  if (started)
    buttonsReleaseAction();
}

