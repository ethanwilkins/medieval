package processing.test.medieval;

import processing.core.PApplet;
import processing.core.PImage;
import processing.core.PVector;

/**
 * Created by ethanwilkins on 1/21/14.
 */

// pause screen with tabs for quest log, inventory, stats, spells/attacks
// buttons from mathgame and ones that grow and shrink away like in circle

public class Gui {
    PApplet parent;
    Button warrior, wizard, ranger, forward, backward,
            pause, resume, items, spells, quests, stats;
    PImage pauseTab, pauseTab1, pauseTab2, pauseTab3;
    String guiState;
    int choiceState;

    Gui (PApplet p) {
        parent = p;
        warrior = new Button(p.width*0.3f, p.height*0.48f, medieval.user.warrior.idleRight);
        wizard = new Button(p.width*0.3f, p.height*0.48f, medieval.user.warrior.idleRight);
        ranger = new Button(p.width*0.3f, p.height*0.48f, medieval.user.warrior.idleRight);
        forward = new Button(p.width*0.9f, p.height/2, p.loadImage("gui/forward.png"));
        backward = new Button(p.width*0.1f, p.height/2, p.loadImage("gui/backward.png"));
        pause = new Button(60, 50, p.loadImage("gui/questLog.png"));
        resume = new Button(70, 65, p.loadImage("gui/backward.png"));
        items = new Button(265, 75, p.loadImage("gui/itemsButton.png"));
        spells = new Button(540, 75, p.loadImage("gui/spellsButton.png"));
        quests = new Button(815, 75, p.loadImage("gui/questsButton.png"));
        stats = new Button(1085, 75, p.loadImage("gui/statsButton.png"));
        pauseTab = p.loadImage("gui/pauseTab.png");
        pauseTab1 = p.loadImage("gui/pauseTab1.png");
        pauseTab2 = p.loadImage("gui/pauseTab2.png");
        pauseTab3 = p.loadImage("gui/pauseTab3.png");
        guiState = "items";
    }

    public void displayPauseScreen() {
        if (guiState == "items") {
            displayItems();
        } else if (guiState == "spells") {
            displaySpells();
        } else if (guiState == "quests") {
            displayQuests();
        } else if (guiState == "stats") {
            displayStats();
        }
        items.display();
        spells.display();
        quests.display();
        stats.display();
        resume.display();
    }

    public void displayItems() {
        parent.imageMode(parent.CORNER);
        parent.image(pauseTab, 0, 0);
        for (int x=0; x < medieval.user.bag.size(); x++) {
            medieval.user.bag.get(x).display();
        }
    }

    public void displaySpells() {
        parent.imageMode(parent.CORNER);
        parent.image(pauseTab1, 0, 0);
    }

    public void displayQuests() {
        parent.imageMode(parent.CORNER);
        parent.image(pauseTab2, 0, 0);
    }

    public void displayStats() {
        parent.imageMode(parent.CORNER);
        parent.image(pauseTab3, 0, 0);
        parent.textSize(25);
        parent.textAlign(parent.CENTER);
        parent.text("Class: " + medieval.user.chosenClass, parent.width/2, parent.height*0.4f);
        parent.text("Gold: " + medieval.user.gold.quantity, parent.width/2, parent.height*0.5f);
        parent.text("Kills: " + medieval.user.kills, parent.width/2, parent.height*0.6f);
        parent.text("XP: " + medieval.user.xp, parent.width/2, parent.height*0.7f);
        parent.text("Level: " + medieval.user.level, parent.width/2, parent.height*0.8f);
    }

    public void displayClassChoice() {
        // class choice screen
        String title = " ", description = " ";
        // back/forward buttons
        forward.display();
        backward.display();
        // which character to display
        switch (choiceState) {
            case 0:
                title = medieval.user.warrior.title;
                description = medieval.user.warrior.description;
                warrior.display();
                break;
            case 1:
                title = medieval.user.wizard.title;
                description = medieval.user.wizard.description;
                wizard.display();
                break;
            case 2:
                title = medieval.user.ranger.title;
                description = medieval.user.ranger.description;
                ranger.display();
                break;
        }
        parent.fill(255);
        parent.textAlign(parent.CENTER);
        parent.rectMode(parent.CORNER);
        parent.textSize(50);
        parent.text(title, parent.width*0.55f, parent.height*0.3f);
        parent.textSize(30);
        parent.text(description, parent.width*0.42f, parent.height*0.45f, 400, 400);
    }

    public void checkPauseScreen() {
        if (resume.overButton()) {
            medieval.ei.gameState = "game";
        } else if (items.overButton()) {
            guiState = "items";
        } else if (spells.overButton()) {
            guiState = "spells";
        } else if (quests.overButton()) {
            guiState = "quests";
        } else if (stats.overButton()) {
            guiState = "stats";
        }
    }

    public void checkPauseButton() {
        if (pause.overButton()) {
            medieval.ei.gameState = "paused";
            loadInventoryScreen();
            medieval.ei.saveGame();
        }
    }

    public void checkClassChoice() {
        // check character buttons
        if (warrior.overButton() && choiceState == 0) {
            medieval.user.setUserClass("warrior");
        } else if (wizard.overButton() && choiceState == 1) {
            medieval.user.setUserClass("wizard");
        } else if (ranger.overButton() && choiceState == 2) {
            medieval.user.setUserClass("ranger");
        } // check back/forward
        else if (forward.overButton()) {
            if (choiceState < 2) {
                choiceState++;
            } else choiceState = 0;
        } else if (backward.overButton()) {
            if (choiceState > 0) {
                choiceState--;
            } else choiceState = 2;
        }
    }

    public void loadInventoryScreen() {
        int z = 0;
        for (int y=250; y < parent.height-10; y += 75) {
            for (int x=125; x < parent.width-10; x += 75) {
                if (z < medieval.user.bag.size()) {
                    Item item = medieval.user.bag.get(z);
                    item.loc.x = x;
                    item.loc.y = y;
                    z++;
                }
            }
        }
    }

    class Button {
        PImage graphic;
        PVector loc;
        float w, h;

        Button (float x, float y, PImage buttonGraphic) {
            loc = new PVector(x, y);
            graphic = buttonGraphic;
            w = graphic.width;
            h = graphic.height;
        }

        public void display() {
            parent.imageMode(parent.CENTER);
            parent.image(graphic, loc.x, loc.y);
        }

        public boolean overButton() {
            float disX = loc.x - parent.mouseX;
            float disY = loc.y - parent.mouseY;
            if(parent.sqrt(parent.sq(disX) + parent.sq(disY)) < w) {
                return true;
            } else return false;
        }
    }
}
