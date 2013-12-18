class Npc {
  PImage npcImg, blood;
  PVector loc;
  ArrayList<Item> bag; Item gold;
  float w, h, health,
    timeOfDeath, lastBled;
  String actionState;
  boolean bleeding;
  int level;
  
  Npc (float x, float y, PImage img) {
    npcImg = img;
    blood = loadImage("blood.png");
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
      regulate();
      bleed();
      death();
    }
  }
  
  void loadBag() {
    gold = new Item(loc.x, loc.y+150,
      loadImage("goldCoins.png"), "loot/gold");
    bag.add(gold);
  }
  
  void bleed() {
    if (bleeding) {
      image(blood, loc.x, loc.y-75);
    }
  }
  
  void death() {
    if (health < 1) {
      actionState = "dead";
      timeOfDeath = millis();
      env.loot.add(gold);
      bag.remove(gold);
      user.xp += 50;
      user.kills++;
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
  
  void regulate() {
    if (lastBled < millis()-400) {
      bleeding = false;
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
