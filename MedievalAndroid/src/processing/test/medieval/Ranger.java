package processing.test.medieval;

import processing.core.PApplet;

/**
 * Created by ethanwilkins on 1/21/14.
 */

// double tap and more taps for rapid, successive shots

public class Ranger {
    PApplet parent;
    String title, description;

    Ranger (PApplet p) {
        parent = p;
        title = "Ranger";
        description = "Defeat your enemies from afar with bow and arrow.";
    }

    public void walk() {

    }
}
