package processing.test.medieval;

import processing.core.PApplet;
import processing.core.PImage;
import processing.core.PVector;

/**
 * Created by ethanwilkins on 1/21/14.
 */

// long press and release for attacks, multiple target spells
// use images and programmatic spells: ellipses, rects

public class Wizard {
    PApplet parent;
    PVector speed;
    PImage idleRight, idleLeft;
    String title, description;

    Wizard (PApplet p) {
        parent = p;
        loadWizard();
        speed = new PVector(2.5f, 0);
        title = "Wizard";
        description = "Destroy your foes with powerful magic.";
    }

    public void displayWalk() {
        if (medieval.user.loc.dist(medieval.user.destination) > 5) {
            // wizard walks right
            if (medieval.user.destination.x > medieval.user.loc.x) {
            	medieval.user.userImg = idleRight;
            } // wizard walks left
            else if (medieval.user.destination.x < medieval.user.loc.x) {
            	medieval.user.userImg = idleLeft;
            }
        }
    }
    
    public void loadWizard() {
    	idleRight = parent.loadImage("wizard/wizardRight.png");
    	idleLeft = parent.loadImage("wizard/wizardLeft.png");
    }
}
