class Npc {
  PImage npcImg;
  PVector location;
  boolean alive, enemy;
  float w, h, health;
  String actionState;
  
  Npc (float x, float y, PImage img) {
    location = new PVector(x, y);
    npcImg = img;
    alive = true;
    w = npcImg.width;
    h = npcImg.height;
    health = 1000;
  }
  
  void update() {
    if (alive) {
      imageMode(CENTER);
      image(npcImg, location.x, location.y);
      death();
    }
  }
  
  void death() {
    if (health < 1) {
      alive = false;
      env.enemies.remove(this);
      env.characters.remove(this);
    }
  }
  
  boolean overNpc() {
    float disX = location.x - mouseX;
    float disY = location.y - mouseY;
    if(sqrt(sq(disX) + sq(disY)) < w/2) {
      return true;
    } else return false;
  }
}
