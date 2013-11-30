// Environment holds all backgrounds and environmental objects i.e. loot

class Environment {
  PImage background;
  
  Environment () {
    background = loadImage("background.png");
  }
  
  void display() {
    imageMode(CORNER);
    image(background, 0, 0);
  }
}
