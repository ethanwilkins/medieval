package processing.test.medieval;

import java.util.ArrayList;

import processing.core.PApplet;
import processing.core.PImage;
import processing.core.PVector;
import processing.data.XML;

/**
 * Created by ethanwilkins on 1/21/14.
 */

// pausing game lets you change spells and weapons
// you cant really transfer items between bags, you'll have to copy them
// get properties from item to give to constructor of new copy item

public class User {
    PApplet parent;
    Warrior warrior;
    Wizard wizard;
    Ranger ranger;
    Npc target;
    PImage userImg;
    ArrayList<Item> bag; Item gold;
    PVector loc, destination, speed;
    String actionState, chosenClass;
    int xp, kills, level, walkFrames, lastPress;
    float health;

    User (PApplet p) {
        parent = p;
        warrior = new Warrior(p);
        wizard = new Wizard(p);
        ranger = new Ranger(p);
        bag = new ArrayList<Item>();
        loc = new PVector(200, 475);
        destination = new PVector();
        actionState = "idle";
        health = 1000;
        loadStats();
        loadBag();
    }

    public void update() {
        walk();
        target();
        attack();
        regulate();
        parent.imageMode(parent.CENTER);
        parent.image(userImg, loc.x, loc.y);
    }

    public void attack() {
        if (actionState == "attacking") {
            if (chosenClass == "warrior") {
                warrior.displayQuickAttack();
                warrior.quickAttack();
            } else if (chosenClass == "wizard") {

            } else if (chosenClass == "wizard") {

            }
        }
    }

    public void walk() {
        // walk animation for class
        walkFrames++;
        if (actionState == "walking" || actionState == "targeting") {
            if (chosenClass == "warrior") {
                warrior.displayWalk();
            } else if (chosenClass == "wizard") {
                wizard.walk();
            } else if (chosenClass == "ranger") {
                ranger.walk();
            }
            // moves user based on mouse/touch
            if (loc.dist(destination) > 5) {
                if (destination.x > loc.x) {
                    loc.add(speed);
                } else if (destination.x < loc.x) {
                    loc.sub(speed);
                }
            } else actionState = "idle";
        }
    }

    public void target() {
        if (chosenClass == "warrior") {
            warrior.target();
        } else if (chosenClass == "wizard") {

        } else if (chosenClass == "wizard") {

        }
    }

    public void selection() {
        for (int x=0; x < medieval.env.enemies.size(); x++) {
            Npc npc = medieval.env.enemies.get(x);
            if (npc.overNpc() && npc.actionState != "dead") {
                target = npc;
                if (chosenClass == "warrior") {
                    warrior.selection();
                } else if (chosenClass == "wizard") {

                } else if (chosenClass == "ranger") {

                }
            }
        }
    }

    public void loot() {
        for (int x=0; x < medieval.env.loot.size(); x++) {
            Item item = medieval.env.loot.get(x);
            if (item.overItem()) {
                if (item.name.equals(gold.name)) {
                    gold.quantity += item.quantity;
                } else {
                    // unable to transfer, make copy instead
                    bag.add(new Item(loc.x, loc.y,
                            item.itemImg, item.path, parent));
                    parent.println(item.name + " != " + gold.name);
                }
                medieval.env.loot.remove(item);
            }
        }
    }

    public void getDestination() {
        // if pause/resume not pressed
        if (parent.mouseY > 200) {
            actionState = "walking";
            destination.x = parent.mouseX;
            destination.y = loc.y;
            // assures regular stride
            if (lastPress < parent.millis()-300) {
                walkFrames = 10;
            }
        }
    }

    public void loadBag() {
        gold = new Item(loc.x, loc.y,
                parent.loadImage("goldCoins.png"), "gold", parent);
        bag.add(gold);
    }

    public void loadStats() {
        XML[] kids = medieval.ei.stats.getChildren("stat");
        for (int x=0; x < kids.length; x++) {
            XML kid = kids[x];
            if (kid.getContent().equals("Kills")) {
                kills = kid.getInt("quantity");
            } else if (kid.getContent().equals("XP")) {
                xp = kid.getInt("quantity");
            } else if (kid.getContent().equals("Level")) {
                level = kid.getInt("level");
            }
        }
    }

    public void setUserClass(String classChoice) {
        // will set the users class and corresponding variables
        if (classChoice == "warrior") {
            chosenClass = "warrior";
            userImg = warrior.idleRight;
            speed = warrior.speed;
        } else if (classChoice == "wizard") {
            chosenClass = "wizard";
            userImg = warrior.idleRight;
        } else if (classChoice == "ranger") {
            chosenClass = "ranger";
            userImg = warrior.idleRight;
        }
        medieval.ei.gameState = "game";
    }

    public void regulate() {
        if (xp > 2000) {
            level = 3;
        } else if (xp > 1000) {
            level = 2;
        }
        // class specific regulation
        if (chosenClass == "warrior") {
            warrior.regulate();
        } else if (chosenClass == "wizard") {

        } else if (chosenClass == "ranger") {

        }
    }
}
