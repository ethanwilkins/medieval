// Environment holds all backgrounds and environmental objects i.e. loot, npc's
// spawn different enemies at different levels

class Environment {
  PImage background;
  ArrayList<Npc> characters;
  ArrayList<Npc> enemies;
  ArrayList<Item> loot;
  Npc questGiver, goblin;
  
  Environment () {
    background = loadImage("background.png");
    characters = new ArrayList<Npc>();
    enemies = new ArrayList<Npc>();
    loot = new ArrayList<Item>();
    questGiver = new Npc(width*0.8, 475, loadImage("questGiverLeft.png"));
    goblin = new Npc(width*0.8, 475, loadImage("goblinLeft.png"));
    characters.add(questGiver);
    enemies.add(goblin);
  }
  
  void update() {
    imageMode(CORNER);
    image(background, 0, 0);
    for (int x=0; x < enemies.size(); x++) {
      Npc npc = enemies.get(x);
      npc.update();
    }
    displayItems();
    respawn();
  }
  
  void displayItems() {
    for (int x=0; x < loot.size(); x++) {
      loot.get(x).display();
    }
  }
  
  void spawn() {
    // beginning of each level
    // loads xml items and images
  }
  
  void respawn() {
    // temporary test respawn
    for (int x=0; x < enemies.size(); x++) {
      Npc npc = enemies.get(x);
      if (npc.actionState == "dead" && npc.timeOfDeath < millis()-5000) {
        npc.actionState = "idle";
        npc.health = 1000;
      }
    }
  }
}
