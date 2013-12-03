// Environment holds all backgrounds and environmental objects i.e. loot, npc's

class Environment {
  PImage background;
  ArrayList<Npc> characters;
  ArrayList<Npc> enemies;
  Npc questGiver;
  
  Environment () {
    background = loadImage("background.png");
    characters = new ArrayList<Npc>();
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
  }
}
