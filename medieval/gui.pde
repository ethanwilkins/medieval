class Gui {
  Button warrior, wizard, ranger;
  
  Gui () {
    warrior = new Button(width/2, height*0.48, user.warrior.warriorRight);
  }
  
  void display() {
    classChoice();
  }
  
  void classChoice() {
    if (ei.gameState == "classChoice") {
      textSize(50);
      textAlign(CENTER);
      text("Choose a class.", width/2, height*0.2);
      text("Warrior", width/2, height*0.8);
      warrior.display();
    }
  }
  
  void checkClassChoice() {
    if (ei.gameState == "classChoice") {
      if (warrior.overButton()) {
        user.setUserClass("warrior");
        ei.gameState = "game";
      }
    }
  }
}
