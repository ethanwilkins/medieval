// Engine class ties the game together, interfacing all the classes to the main file, medieval
// read xml in bootstrap to setup game based on last save
// may need more xml files instead of nested elements

class Engine {
  XML inventory, stats, text;
  String gameState;
  
  void display() {
    displayGame();
    displayGui();
  }
  
  void displayGame() {
    // displays all parts of game
    if (gameState == "game") {
      env.update();
      user.update();
    }
  }
  
  void displayGui() {
    if (gameState == "classChoice") {
      gui.displayClassChoice();
    } else if (gameState == "game") {
      gui.pause.display();
    } else if (gameState == "paused") {
      gui.displayPauseScreen();
    }
  }
  
  void updateUserPress() {
    if (gameState == "game") {
      user.getDestination();
      user.loot();
      // selection aftwerwards to override
      detectTap();
    }
  }
  
  void detectTap() {
    user.selection();
  }
  
  void detectSwipe() {
    
  }
  
  void detectLongPress() {
    
  }
  
  void checkButtons() {
    if (gameState == "classChoice") {
      gui.checkClassChoice();
    } else if (gameState == "game") {
      gui.checkPauseButton();
    } else if (gameState == "paused") {
      gui.checkPauseScreen();
    }
  }
  
  void saveGame() {
    XML gold = inventory.getChild("gold");
    inventory.removeChild(gold);
    gold.setInt("quantity", user.gold.quantity);
    inventory.addChild(gold);
    if (displayWidth == 1280 && displayHeight == 720) {
      createOutput("/storage/sdcard0/Medieval/gameData/inventory.xml");
      saveXML(inventory, "/storage/sdcard0/Medieval/gameData/inventory.xml");
    } else saveXML(inventory, "data/gameData/inventory.xml");
  }
  
  void bootStrap() {
    // starts the game, can be called for restart
    // get xml from data, createOutput, check for saved game
    inventory = loadXML("/storage/sdcard0/Medieval/gameData/inventory.xml");
    stats = loadXML("gameData/stats.xml");
    text = loadXML("gameData/text.xml");
    gameState = "classChoice";
    env = new Environment();
    // QuestGiver Display
    que = new Quest();
    user = new User();
    gui = new Gui();
  }
}
