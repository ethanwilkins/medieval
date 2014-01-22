package processing.test.medieval;

import processing.core.PApplet;
import processing.data.XML;

/**
 * Created by ethanwilkins on 1/21/14.
 */

// Engine class ties the game together, interfacing all the classes to the main file, medieval
// read xml in bootstrap to setup game based on last save
// may need more xml files instead of nested elements

public class Engine {
    XML inventory, stats, text;
    String gameState;
    PApplet parent;

    Engine (PApplet p) {
        parent = p;
    }

    public void display() {
        displayGame();
        displayGui();
    }

    public void displayGame() {
        // displays all parts of game
        if (gameState == "game") {
            medieval.env.update();
            medieval.user.update();
        }
    }

    public void displayGui() {
        if (gameState == "classChoice") {
            medieval.gui.displayClassChoice();
        } else if (gameState == "game") {
            medieval.gui.pause.display();
        } else if (gameState == "paused") {
            medieval.gui.displayPauseScreen();
        }
    }

    public void updateUserPress() {
        if (gameState == "game") {
            medieval.user.lastPress = parent.millis();
            medieval.user.getDestination();
            medieval.user.loot();
            // selection aftwerwards to override
            detectTap();
        }
    }

    public void detectTap() {
        medieval.user.selection();
    }

    public void detectSwipe() {

    }

    public void detectLongPress() {

    }

    public void checkButtons() {
        if (gameState == "classChoice") {
            medieval.gui.checkClassChoice();
        } else if (gameState == "game") {
            medieval.gui.checkPauseButton();
        } else if (gameState == "paused") {
            medieval.gui.checkPauseScreen();
        }
    }

    public void bootStrap(PApplet p) {
        // starts the game, can be called for restart
        loadGame();
        p = parent;
        gameState = "classChoice";
        medieval.env = new Environment(p);
        // QuestGiver Display
        medieval.que = new Quest(p);
        medieval.user = new User(p);
        medieval.gui = new Gui(p);
    }

    public void loadGame() {
        // get xml from data, createOutput, check for saved game
        try {
            inventory = parent.loadXML("/storage/sdcard0/Medieval/gameData/inventory.xml");
            stats = parent.loadXML("/storage/sdcard0/Medieval/gameData/stats.xml");
            text = parent.loadXML("gameData/text.xml");
            XML test = inventory.getChild("gold");
            parent.println("load successful");
        } catch (Exception e) {
            inventory = parent.loadXML("gameData/inventory.xml");
            stats = parent.loadXML("gameData/stats.xml");
            text = parent.loadXML("gameData/text.xml");
            parent.println("load game error caught");
        }
    }

    public void saveGame() {
        saveItems();
        saveStats();
        try {
            try {
                parent.saveXML(inventory, "/storage/sdcard0/Medieval/gameData/inventory.xml");
                parent.saveXML(stats, "/storage/sdcard0/Medieval/gameData/stats.xml");
            } catch (Exception e) {
                parent.createOutput("/storage/sdcard0/Medieval/gameData/inventory.xml");
                parent.createOutput("/storage/sdcard0/Medieval/gameData/stats.xml");
                parent.saveXML(inventory, "/storage/sdcard0/Medieval/gameData/inventory.xml");
                parent.saveXML(stats, "/storage/sdcard0/Medieval/gameData/stats.xml");
                parent.println("save game error caught");
            }
        } catch (Exception e) {
            parent.println("save game failed");
        }
    }

    public void saveItems() {
        XML gold = inventory.getChild("gold");
        inventory.removeChild(gold);
        gold.setInt("quantity", medieval.user.gold.quantity);
        inventory.addChild(gold);
    }

    public void saveStats() {
        XML[] kids = stats.getChildren("stat");
        for (int x=0; x < kids.length; x++) {
            XML kid = kids[x];
            stats.removeChild(kid);
            if (kid.getContent().equals("Kills")) {
                kid.setInt("quantity", medieval.user.kills);
            } else if (kid.getContent().equals("XP")) {
                kid.setInt("quantity", medieval.user.xp);
            } else if (kid.getContent().equals("Level")) {
                kid.setInt("level", medieval.user.level);
            }
            stats.addChild(kid);
        }
    }

}
