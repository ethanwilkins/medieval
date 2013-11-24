class Environment {
  PImage back;
  
  Environment () {
    back = loadImage("background.png");
  }
  
  void display() {
    imageMode(CORNER);
    image(back, 0, 0);
  }
}
