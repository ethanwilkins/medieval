class Npc {
  PImage npcImg;
  PVector loc;
  ArrayList<Item> bag; Item gold;
  float w, h, health,
    timeOfDeath;
  String actionState;
  int level;
  
  Npc (float x, float y, PImage img) {
    npcImg = img;
    loc = new PVector(x, y);
    bag = new ArrayList<Item>();
    actionState = "idle";
    w = npcImg.width;
    h = npcImg.height;
    health = 500;
    level = 1;
    loadBag();
  }
  
  void update() {
    if (actionState != "dead") {
      imageMode(CENTER);
      image(npcImg, loc.x, loc.y);
      death();
    }
  }
  
  void loadBag() {
    gold = new Item(loc.x, loc.y+150,
      loadImage("goldCoins.png"), "loot/gold");
    bag.add(gold);
  }
  
  void death() {
    if (health < 1) {
      actionState = "dead";
      timeOfDeath = millis();
      env.loot.add(gold);
      bag.remove(gold);
    }
  }
  
  void decay() {
    if (timeOfDeath < millis()-10000) {
      // change image to blood
    } else if (timeOfDeath < millis()-15000) {
//        env.enemies.remove(this);
//        env.characters.remove(this);
    }
  }
  
  boolean overNpc() {
    float disX = loc.x - mouseX;
    float disY = loc.y - mouseY;
    if(sqrt(sq(disX) + sq(disY)) < w) {
      return true;
    } else return false;
  }
}
