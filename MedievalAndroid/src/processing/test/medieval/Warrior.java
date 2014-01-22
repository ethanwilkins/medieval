package processing.test.medieval;

import processing.core.PApplet;
import processing.core.PImage;
import processing.core.PVector;

/**
 * Created by ethanwilkins on 1/21/14.
 */

// different swipes and swipe combos for attacks, swipe up for sword impale
// tap on enemy, walk up and attack once, one attack per tap
// different speeds for different parts of attack
// maxHit dependent on level

public class Warrior {
    PApplet parent;
    PVector speed;
    PImage idleWarrior, idleRight, idleLeft,
            walkRight1, walkLeft1,
            walkRight2, walkLeft2,
            walkRight3, walkLeft3,
            walkRight5, walkLeft5,
            walkRight6, walkLeft6,
            attRight1, attRight2, attRight3;
    String title, description;
    int attFrames;
    float maxHit, maxHealth, range;

    Warrior (PApplet p) {
        parent = p;
        loadWarrior();
        speed = new PVector(2.5f, 0);
        description = "Slay your enemies with sword and shield.";
        title = "Warrior";
        attFrames = 1;
        maxHit = 500;
        range = 175;
    }

    public void quickAttack() {
        float damageDealt;
        if (attFrames == 0) {
            damageDealt = parent.random(1, maxHit);
            medieval.user.target.health -= damageDealt;
            // so user doesn't walk over enemy
            medieval.user.destination.set(medieval.user.loc);
            // enable to load idle image
            medieval.user.actionState = "walking";
        }
    }

    public void target() {
        if (medieval.user.actionState == "targeting") {
            if (medieval.user.loc.dist(medieval.user.target.loc) > range) {
                medieval.user.destination.set(medieval.user.target.loc);
            } // when user is in range of target
            else medieval.user.actionState = "attacking";
        } // if user kills target, user stops attacking and idles
        if (medieval.user.actionState == "attacking" && medieval.user.target.actionState == "dead") {
            // so user doesn't walk over body
            medieval.user.destination.set(medieval.user.loc);
            // enable to load idle image
            medieval.user.actionState = "walking";
        }
    }

    public void selection() {
        if (medieval.user.loc.dist(medieval.user.target.loc) < range) {
            // if npc is enemy, attack, else "talking"
            medieval.user.actionState = "attacking";
        } else medieval.user.actionState = "targeting";
    }

    public void displayQuickAttack() {
        // start at raising sword at new fight
        // cycles through attack poses as frames pass
        attFrames++;
        switch (PApplet.parseInt(attFrames)) {
            case 5:
                medieval.user.userImg = attRight1;
                break;
            case 20:
                medieval.user.userImg = attRight2;
                break;
            case 25:
                medieval.user.userImg = attRight3;
                break;
            case 30:
                medieval.user.userImg = attRight2;
                break;
            case 35:
                medieval.user.userImg = attRight1;
                medieval.user.target.bleeding = true;
                medieval.user.target.lastBled = parent.millis();
                attFrames = 0;
                break;
        }
    }

    public void displayWalk() {
        if (medieval.user.loc.dist(medieval.user.destination) > 5) {
            // warrior walks right
            if (medieval.user.destination.x > medieval.user.loc.x) {
                idleWarrior = idleRight;
                // only using two steps for now
                switch (medieval.user.walkFrames) {
                    case 10:
                        medieval.user.userImg = walkRight1;
                        break;
                    case 25:
                        medieval.user.userImg = walkRight2;
                        break;
                    case 40:
                        medieval.user.userImg = walkRight3;
                        break;
                    case 55:
                        medieval.user.userImg = walkRight1;
                        break;
                    case 70:
                        medieval.user.userImg = walkRight5;
                        break;
                    case 85:
                        medieval.user.userImg = walkRight6;
                        break;
                }
            } // warrior walks left
            else if (medieval.user.destination.x < medieval.user.loc.x) {
                idleWarrior = idleLeft;
                switch (medieval.user.walkFrames) {
                    case 10:
                        medieval.user.userImg = walkLeft1;
                        break;
                    case 25:
                        medieval.user.userImg = walkLeft2;
                        break;
                    case 40:
                        medieval.user.userImg = walkLeft3;
                        break;
                    case 55:
                        medieval.user.userImg = walkLeft1;
                        break;
                    case 70:
                        medieval.user.userImg = walkLeft5;
                        break;
                    case 85:
                        medieval.user.userImg = walkLeft6;
                        break;
                }
            }
        } else medieval.user.userImg = idleWarrior;
    }

    public void regulate() {
        if (medieval.user.walkFrames > 85) {
            medieval.user.walkFrames = 0;
        }
    }

    public void loadWarrior() {
        idleRight = parent.loadImage("warrior/idleRight.png");
        idleLeft = parent.loadImage("warrior/idleLeft.png");
        walkRight1 = parent.loadImage("warrior/walkRight1.png");
        walkLeft1 = parent.loadImage("warrior/walkLeft1.png");
        walkRight2 = parent.loadImage("warrior/walkRight2.png");
        walkLeft2 = parent.loadImage("warrior/walkLeft2.png");
        walkRight3 = parent.loadImage("warrior/walkRight3.png");
        walkLeft3 = parent.loadImage("warrior/walkLeft3.png");
        walkRight5 = parent.loadImage("warrior/walkRight5.png");
        walkLeft5 = parent.loadImage("warrior/walkLeft5.png");
        walkRight6 = parent.loadImage("warrior/walkRight6.png");
        walkLeft6 = parent.loadImage("warrior/walkLeft6.png");
        attRight1 = parent.loadImage("warrior/attRight1.png");
        attRight2 = parent.loadImage("warrior/attRight2.png");
        attRight3 = parent.loadImage("warrior/attRight3.png");
    }
}
