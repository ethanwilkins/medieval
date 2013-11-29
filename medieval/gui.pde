class Gui {
  Button warrior, wizard, ranger, forward, backward;
  int choiceState;
  
  Gui () {
    warrior = new Button(width*0.3, height*0.48, user.warrior.warriorRight);
    wizard = new Button(width*0.3, height*0.48, user.warrior.warriorRight);
    ranger = new Button(width*0.3, height*0.48, user.warrior.warriorRight);
    forward = new Button(width*0.9, height/2, loadImage("forward.png"));
    backward = new Button(width*0.1, height/2, loadImage("backward.png"));
    choiceState = 0;
  }
  
  void display() {
    classChoice();
  }
  
  void classChoice() {
    if (ei.gameState == "classChoice") {
      forward.display();
      backward.display();
      textSize(50);
      textAlign(CENTER);
      switch (choiceState) {
        case 0:
          // title
          text("Warrior", width*0.55, height*0.3);
          // description
          textSize(30);
          text("Slay your enemies with sword and shield.",
            width*0.42, height*0.45, 400, 400);
          // the actual button
          warrior.display();
          break;
        case 1:
          // title
          text("Wizard", width*0.55, height*0.3);
          // description
          textSize(30);
          text("Destroy your foes with powerful magic.",
            width*0.42, height*0.45, 400, 400);
          // the actual button
          wizard.display();
          break;
        case 2:
          // title
          text("Ranger", width*0.55, height*0.3);
          // description
          textSize(30);
          text("Take down your enemies from afar with bow and arrow.",
            width*0.42, height*0.45, 400, 400);
          // the actual button
          ranger.display();
          break;
      }
    }
  }
  
  void checkClassChoice() {
    if (ei.gameState == "classChoice") {
      if (warrior.overButton() && choiceState == 0) {
        user.setUserClass("warrior");
      } else if (wizard.overButton() && choiceState == 1) {
        user.setUserClass("wizard");
      } else if (ranger.overButton() && choiceState == 2) {
        user.setUserClass("ranger");
      } else if (forward.overButton()) {
        if (choiceState < 2) {
          choiceState++;
        } else choiceState = 0;
      } else if (backward.overButton()) {
        if (choiceState > 0) {
          choiceState--;
        } else choiceState = 2;
      }
    }
  }
}
