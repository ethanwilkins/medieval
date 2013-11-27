class Environment {
  PImage background;
  
  Environment () {
    background = loadImage("background.png");
    if (width != 1280 && height != 720) {
      background.resize(0, height);
    }
  }
  
  void display() {
    imageMode(CORNER);
    image(background, 0, 0);
  }
}
