class Engine {
  String gameState;
  
  void display() {
    gui.display();
    displayGame();
  }
  
  void displayGame() {
    if (gameState == "game") {
      env.display();
      user.display();
      //If User in Game Display QuestGiver Also QuestGiver drawn b4 user? No Idea What The Issue is.
      que.display();
    }
  }
  
  void checkButtons() {
    gui.checkClassChoice();
  }
  
  void bootStrap() {
    gameState = "classChoice";
    env = new Environment();
    user = new User();
    gui = new Gui();
    //QuestGiver Display
      que = new Questgiver();
  }
}
