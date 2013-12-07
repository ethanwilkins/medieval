// Environment holds all backgrounds and environmental objects i.e. loot, npc's
// spawn different enemies at different levels

class Environment {
  PImage background;
  ArrayList<Npc> characters;
  ArrayList<Npc> enemies;
  Npc questGiver;
  
  Environment () {
    background = loadImage("background.png");
    characters = new ArrayList<Npc>();
    enemies = new ArrayList<Npc>();
    questGiver = new Npc(width*0.9, 475, loadImage("questGiverLeft.png"));
    characters.add(questGiver);
  }
  
  void update() {
    imageMode(CORNER);
    image(background, 0, 0);
    for (int x=0; x < characters.size(); x++) {
      Npc npc = characters.get(x);
      npc.update();
    }
    respawn();
  }
  
  void respawn() {
    // temporary test respawn
    if (!questGiver.alive && questGiver.timeOfDeath < millis()-5000) {
      questGiver.health = 1000;
      questGiver.alive = true;
    }
  }
}
