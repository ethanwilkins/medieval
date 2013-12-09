// Engine class ties the game together, interfacing all the classes to the main file, medieval

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
      gui.classChoice();
    } else if (gameState == "game") {
      gui.pauseButton();
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
    }
  }
  
  void bootStrap() {
    // starts the game, can be called for restart
    inventory = loadXML("gameData/inventory.xml");
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
