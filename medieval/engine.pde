// Engine class ties the game together, interfacing all the classes to the main file, medieval
// read xml in bootstrap to setup game based on last save

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
