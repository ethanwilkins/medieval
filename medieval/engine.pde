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
  
  void bootStrap() {
    // starts the game, can be called for restart
    loadGame();
    gameState = "classChoice";
    env = new Environment();
    // QuestGiver Display
    que = new Quest();
    user = new User();
    gui = new Gui();
  }
  
  void loadGame() {
    // get xml from data, createOutput, check for saved game
    try {
      inventory = loadXML("/storage/sdcard0/Medieval/gameData/inventory.xml");
      stats = loadXML("/storage/sdcard0/Medieval/gameData/stats.xml");
      text = loadXML("gameData/text.xml");
      XML test = inventory.getChild("gold");
      } catch (Exception e) {
      inventory = loadXML("gameData/inventory.xml");
      stats = loadXML("gameData/stats.xml");
      text = loadXML("gameData/text.xml");
      println("load game error caught");
    }
  }
  
  void saveGame() {
    XML gold = inventory.getChild("gold");
    inventory.removeChild(gold);
    gold.setInt("quantity", user.gold.quantity);
    inventory.addChild(gold);
    try {
      saveXML(inventory, "/storage/sdcard0/Medieval/gameData/inventory.xml");
      saveXML(stats, "/storage/sdcard0/Medieval/gameData/stats.xml");
    } catch (Exception e) {
      createOutput("/storage/sdcard0/Medieval/gameData/inventory.xml");
      createOutput("/storage/sdcard0/Medieval/gameData/stats.xml");
      saveXML(inventory, "/storage/sdcard0/Medieval/gameData/inventory.xml");
      saveXML(stats, "/storage/sdcard0/Medieval/gameData/stats.xml");
      println("save game error caught");
    }
  }
}
