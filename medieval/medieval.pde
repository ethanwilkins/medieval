Environment env;
Engine ei;
Quest que;
User user;
Gui gui;

void setup() {
  size(1280, 720);
  orientation(LANDSCAPE);
  ei = new Engine();
  ei.bootStrap();
}

void draw() {
  background(0);
  ei.display();
}

void mousePressed() {
  ei.updateUserPress();
}

void mouseReleased() {
  ei.checkButtons();
}
