class Npc {
  PImage npcImg;
  PVector location;
  boolean alive, enemy;
  float w, h, health;
  
  Npc (float x_, float y_, PImage img) {
    npcImg = img;
    location = new PVector(x_, y_);
    w = npcImg.width;
    h = npcImg.height;
  }
  
  void update() {
    imageMode(CENTER);
    image(npcImg, location.x, location.y);
  }
  
  boolean overNpc() {
    float disX = location.x - mouseX;
    float disY = location.y - mouseY;
    if(sqrt(sq(disX) + sq(disY)) < w/2) {
      return true;
    } else return false;
  }
}
