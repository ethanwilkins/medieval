class Button {
  PImage graphic;
  float x, y, w, h;
  
  Button (float xLoc, float yLoc, PImage buttonGraphic) {
    graphic = buttonGraphic;
    w = graphic.width;
    h = graphic.height;
    x = xLoc;
    y = yLoc;
  }
  
  void display() {
    imageMode(CENTER);
    image(graphic, x, y);
  }
  
  boolean overButton() {
    float disX = x - mouseX;
    float disY = y - mouseY;
    if(sqrt(sq(disX) + sq(disY)) < w/2) {
      return true;
    } else return false;
  }
}
