class Npc {
  PImage npcImg;
  boolean alive;
  float x, y, w, h;
  
  Npc (float x_, float y_, PImage img) {
    npcImg = img;
    w = npcImg.width;
    h = npcImg.height;
    x = x_;
    y = y_;
  }
  
  void update() {
    imageMode(CENTER);
    image(npcImg, x, y);
  }
  
  boolean overNpc() {
    float disX = x - mouseX;
    float disY = y - mouseY;
    if(sqrt(sq(disX) + sq(disY)) < w/2) {
      return true;
    } else return false;
  }
}
