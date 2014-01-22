package processing.test.medieval;

import java.util.ArrayList;

import processing.core.PApplet;
import processing.core.PImage;

/**
 * Created by ethanwilkins on 1/21/14.
 */
public class Environment {
    PApplet parent;
    PImage background;
    ArrayList<Npc> characters;
    ArrayList<Npc> enemies;
    ArrayList<Item> loot;
    Npc questGiver, goblin;

    Environment (PApplet p) {
        parent = p;
        background = p.loadImage("background.png");
        characters = new ArrayList<Npc>();
        enemies = new ArrayList<Npc>();
        loot = new ArrayList<Item>();
        questGiver = new Npc(p.width*0.8f, 475, p.loadImage("questGiverLeft.png"), p);
        goblin = new Npc(p.width*0.8f, 475, p.loadImage("goblinLeft.png"), p);
        characters.add(questGiver);
        enemies.add(goblin);
    }

    public void update() {
        parent.imageMode(parent.CORNER);
        parent.image(background, 0, 0);
        for (int x=0; x < enemies.size(); x++) {
            Npc npc = enemies.get(x);
            npc.update();
        }
        displayItems();
        respawn();
    }

    public void displayItems() {
        for (int x=0; x < loot.size(); x++) {
            loot.get(x).display();
        }
    }

    public void spawn() {
        // beginning of each level
        // loads xml items and images
    }

    public void respawn() {
        // temporary test respawn
        for (int x=0; x < enemies.size(); x++) {
            Npc npc = enemies.get(x);
            if (npc.actionState == "dead" && npc.timeOfDeath < parent.millis()-5000) {
                npc.actionState = "idle";
                npc.health = 1000;
            }
        }
    }
}
