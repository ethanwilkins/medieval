package processing.test.medieval;

import java.util.ArrayList;

import processing.core.PApplet;
import processing.core.PImage;
import processing.core.PVector;

/**
 * Created by ethanwilkins on 1/21/14.
 */
public class Npc {
    PApplet parent;
    PImage npcImg, blood;
    PVector loc;
    ArrayList<Item> bag; Item gold;
    float w, h, health,
            timeOfDeath, lastBled;
    String actionState;
    boolean bleeding;
    int level;

    Npc (float x, float y, PImage img, PApplet p) {
        parent = p;
        npcImg = img;
        blood = parent.loadImage("blood.png");
        loc = new PVector(x, y);
        bag = new ArrayList<Item>();
        actionState = "idle";
        w = npcImg.width;
        h = npcImg.height;
        health = 500;
        level = 1;
        loadBag();
    }

    public void update() {
        if (actionState != "dead") {
            parent.imageMode(parent.CENTER);
            parent.image(npcImg, loc.x, loc.y);
            regulate();
            bleed();
            death();
        }
    }

    public void loadBag() {
        gold = new Item(loc.x, loc.y+150, parent.loadImage("goldCoins.png"), "loot/gold", parent);
        bag.add(gold);
    }

    public void bleed() {
        if (bleeding) {
            parent.image(blood, loc.x, loc.y-75);
        }
    }

    public void death() {
        if (health < 1) {
            actionState = "dead";
            timeOfDeath = parent.millis();
            medieval.env.loot.add(gold);
            bag.remove(gold);
            medieval.user.xp += 50;
            medieval.user.kills++;
        }
    }

    public void decay() {
        if (timeOfDeath < parent.millis()-10000) {
            // change image to blood
        } else if (timeOfDeath < parent.millis()-15000) {
//        env.enemies.remove(this);
//        env.characters.remove(this);
        }
    }

    public void regulate() {
        if (lastBled < parent.millis()-400) {
            bleeding = false;
        }
    }

    public boolean overNpc() {
        float disX = loc.x - parent.mouseX;
        float disY = loc.y - parent.mouseY;
        if(parent.sqrt(parent.sq(disX) + parent.sq(disY)) < w) {
            return true;
        } else return false;
    }
}
