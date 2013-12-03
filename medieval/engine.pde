// Engine class ties the game together, interfacing all the classes to the main file, medieval

class Engine {
  String gameState;
  
  void display() {
    gui.display();
    displayGame();
  }
  
  void displayGame() {
    // displays all parts of game
    if (gameState == "game") {
      env.update();
      user.update();
    }
  }
  
  void updateUser() {
    if (gameState == "game") {
      user.getDestination();
      user.selection();
    }
  }
  
  void checkButtons() {
    if (gameState == "classChoice") {
      gui.checkClassChoice();
    }
  }
  
  void bootStrap() {
    // starts the game, can be called for restart
    gameState = "classChoice";
    env = new Environment();
    // QuestGiver Display
    que = new Quest();
    user = new User();
    gui = new Gui();
  }
}
