package processing.test.medieval;

import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class medieval extends PApplet {

Engine ei;
Environment env;
Quest que;
User user;
Gui gui;

public void setup() {
 
  orientation(LANDSCAPE);
  ei = new Engine();
  ei.bootStrap();
}

public void draw() {
  background(0);
  ei.display();
}

public void mousePressed() {
  ei.checkButtons();
}
class Button {
  PImage graphic;
  float x, y, w, h;
  
  Button (float xLoc, float yLoc, PImage buttonGraphic) {
    graphic = buttonGraphic;
    w = graphic.width;
    h = graphic.height;
    x = xLoc;
    y = yLoc;
  }
  
  public void display() {
    imageMode(CENTER);
    image(graphic, x, y);
  }
  
  public boolean overButton() {
    float disX = x - mouseX;
    float disY = y - mouseY;
    if(sqrt(sq(disX) + sq(disY)) < w/2) {
      return true;
    } else return false;
  }
}
// Engine class ties the game together, interfacing all the classes to the main file, medieval

class Engine {
  String gameState;
  
  public void display() {
    gui.display();
    displayGame();
  }
  
  public void displayGame() {
    // displays all parts of game
    if (gameState == "game") {
      env.display();
      que.display();
      user.display();
    }
  }
  
  public void checkButtons() {
    gui.checkClassChoice();
  }
  
  public void bootStrap() {
    // starts the game, can be called for restart
    gameState = "classChoice";
    env = new Environment();
    // QuestGiver Display
    que = new Quest();
    user = new User();
    gui = new Gui();
  }
}
// Environment holds all backgrounds and environmental objects i.e. loot

class Environment {
  PImage background;
  
  Environment () {
    background = loadImage("background.png");
  }
  
  public void display() {
    imageMode(CORNER);
    image(background, 0, 0);
  }
}
class Gui {
  Button warrior, wizard, ranger, forward, backward;
  // keeps the state of the class choice and possibly later choices
  int choiceState;
  
  Gui () {
    warrior = new Button(width*0.3f, height*0.48f, user.warrior.idleRight);
    wizard = new Button(width*0.3f, height*0.48f, user.warrior.idleRight);
    ranger = new Button(width*0.3f, height*0.48f, user.warrior.idleRight);
    forward = new Button(width*0.9f, height/2, loadImage("forward.png"));
    backward = new Button(width*0.1f, height/2, loadImage("backward.png"));
    choiceState = 0;
  }
  
  public void display() {
    classChoice();
  }
  
  public void classChoice() {
    String title = " ", description = " ";
    if (ei.gameState == "classChoice") {
      forward.display();
      backward.display();
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
      text(title, width*0.55f, height*0.3f);
      textSize(30);
      text(description, width*0.42f, height*0.45f, 400, 400);
    }
  }
  
  public void checkClassChoice() {
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
class Quest {
  
  //NOI = NO IMAGE
    PImage NOI;
  
  //NOI = LoadImage Logic 
  //Path /Data Name NoImage.PNG
  Quest () {
    NOI = loadImage("NoImage.png");
  }
  
 //Display Image (NOI, X, Y, W%, H%) 
  public void display() {
  //image(NOI, 0, 0);
  image(NOI, 60, 520, width/10, height/10);
  }
}

class Ranger {
  String title, description;
  
  Ranger () {
    title = "Ranger";
    description = "Defeat your enemies from afar with bow and arrow.";
  }
  
  public void walk() {
    
  }
}
class User {
  Warrior warrior;
  Wizard wizard;
  Ranger ranger;
  PVector location, speed;
  PImage userImg;
  float distTraveled;
  String chosenClass;
  
  User () {
    warrior = new Warrior();
    wizard = new Wizard();
    ranger = new Ranger();
    location = new PVector(width/2, 475);
    speed = new PVector(3.5f, 0);
    distTraveled = 0;
  }
  
  public void display() {
    imageMode(CENTER);
    image(userImg, location.x, location.y);
    walk();
  }
  
  public void walk() {
    // walk animation for class
    if (chosenClass == "warrior") {
      warrior.walk();
    } else if (chosenClass == "wizard") {
      wizard.walk();
    } else if (chosenClass == "ranger") {
      ranger.walk();
    }
    // moves user based on mouse/touch
    if (dist(mouseX, 0, location.x, 0) > 5) {
      if (mouseX > location.x) {
        location.add(speed);
      } else if (mouseX < location.x) {
        location.sub(speed);
      } // dist for walk animation
      distTraveled += speed.x;
    }
  }
  
  public void setUserClass(String classChoice) {
    // will set the users class and corresponding variables
    if (classChoice == "warrior") {
      chosenClass = "warrior";
      userImg = warrior.idleRight;
    } else if (classChoice == "wizard") {
        chosenClass = "wizard";
        userImg = warrior.idleRight;
    } else if (classChoice == "ranger") {
        chosenClass = "ranger";
        userImg = warrior.idleRight;
    }
    ei.gameState = "game";
  }
}
class Warrior {
  PImage idleRight, idleLeft,
    walkingRight3, walkingLeft3,
    walkingRight6, walkingLeft6,
    idleWarrior;
  String title, description;
  int step;
  
  Warrior () {
    idleRight = loadImage("warriorRight.png");
    idleLeft = loadImage("warriorLeft.png");
    walkingRight3 = loadImage("warriorWalkingRight3.png");
    walkingLeft3 = loadImage("warriorWalkingLeft3.png");
    walkingRight6 = loadImage("warriorWalkingRight6.png");
    walkingLeft6 = loadImage("warriorWalkingLeft6.png");
    description = "Slay your enemies with sword and shield.";
    title = "Warrior";
  }
  
  public void walk() {
    // change step image if distTraveled % 20 == 0
    if (user.distTraveled % 20 == 0) {
      if (step < 1) {
        step++;
      } else step = 0;
    }
    if (dist(mouseX, 0, user.location.x, 0) > 5) {
      // warrior walks right
      if (mouseX > user.location.x) {
        idleWarrior = idleRight;
        switch (step) {
          case 0:
            user.userImg = walkingRight3;
            break;
          case 1:
            user.userImg = walkingRight6;
            break;
        }
      } // warrior walks left
      else if (mouseX < user.location.x) {
        idleWarrior = idleLeft;
        switch (step) {
          case 0:
            user.userImg = walkingLeft3;
            break;
          case 1:
            user.userImg = walkingLeft6;
            break;
        }
      }
    } else user.userImg = idleWarrior;
  }
}
class Wizard {
  String title, description;
  
  Wizard () {
    title = "Wizard";
    description = "Destroy your foes with powerful magic.";
  }
  
  public void walk() {
    
  }
}

  public int sketchWidth() { return displayWidth; }
  public int sketchHeight() { return displayHeight; }
}
