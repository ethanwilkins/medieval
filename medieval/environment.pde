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
