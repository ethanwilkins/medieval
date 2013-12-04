class Gui {
  Button warrior, wizard, ranger, forward, backward;
  // keeps the state of the class choice and possibly later choices
  int choiceState;
  
  Gui () {
    warrior = new Button(width*0.3, height*0.48, user.warrior.idleRight);
    wizard = new Button(width*0.3, height*0.48, user.warrior.idleRight);
    ranger = new Button(width*0.3, height*0.48, user.warrior.idleRight);
    forward = new Button(width*0.9, height/2, loadImage("forward.png"));
    backward = new Button(width*0.1, height/2, loadImage("backward.png"));
    choiceState = 0;
  }
  
  void display() {
    classChoice();
  }
  
  void classChoice() {
    // class choice screen 
    String title = " ", description = " ";
    if (ei.gameState == "classChoice") {
      // back/forward buttons
      forward.display();
      backward.display();
      // which character to display
      switch (choiceState) {
        case 0:
          title = user.warrior.title;
          description = user.warrior.description;
          warrior.display();
          break;
        case 1:
          title = user.wizard.title;
          description = user.wizard.description;
          wizard.display();
          break;
        case 2:
          title = user.ranger.title;
          description = user.ranger.description;
          ranger.display();
          break;
      }
      textAlign(CENTER);
      textSize(50);
      text(title, width*0.55, height*0.3);
      textSize(30);
      text(description, width*0.42, height*0.45, 400, 400);
    }
  }
  
  void checkClassChoice() {
    // check character buttons
    if (warrior.overButton() && choiceState == 0) {
      user.setUserClass("warrior");
    } else if (wizard.overButton() && choiceState == 1) {
      user.setUserClass("wizard");
    } else if (ranger.overButton() && choiceState == 2) {
      user.setUserClass("ranger");
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
  
  void display() {
    imageMode(CENTER);
    image(graphic, loc.x, loc.y);
  }
  
  boolean overButton() {
    float disX = loc.x - mouseX;
    float disY = loc.y - mouseY;
    if(sqrt(sq(disX) + sq(disY)) < w/2) {
      return true;
    } else return false;
  }
}
