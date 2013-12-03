class User {
  Warrior warrior;
  Wizard wizard;
  Ranger ranger;
  PVector location, speed;
  PImage userImg;
  float destination, distTraveled, health;
  String actionState, chosenClass;
  
  User () {
    warrior = new Warrior();
    wizard = new Wizard();
    ranger = new Ranger();
    location = new PVector(width/2, 475);
    actionState = "idle";
    distTraveled = 0;
  }
  
  void update() {
    walk();
    attack();
    imageMode(CENTER);
    image(userImg, location.x, location.y);
  }
  
  void attack() {
    if (actionState == "attacking") {
      if (chosenClass == "warrior") {
        warrior.attack();
      } else if (chosenClass == "wizard") {
        
      } else if (chosenClass == "wizard") {
        
      }
    }
  }
  
  void walk() {
    // walk animation for class
    if (actionState == "walking") {
      if (chosenClass == "warrior") {
        warrior.walk();
      } else if (chosenClass == "wizard") {
        wizard.walk();
      } else if (chosenClass == "ranger") {
        ranger.walk();
      }
      // moves user based on mouse/touch
      if (dist(destination, 0, location.x, 0) > 5) {
        if (destination > location.x) {
          location.add(speed);
        } else if (destination < location.x) {
          location.sub(speed);
        } // dist for walk animation
        distTraveled += speed.x;
      }
    }
  }
  
  void selection() {
    for (int x=0; x < env.characters.size(); x++) {
      Npc npc = env.characters.get(x);
      if (npc.overNpc()) {
        actionState = "attacking";
      }
    }
  }
  
  void getDestination() {
    actionState = "walking";
    destination = mouseX;
  }
  
  void setUserClass(String classChoice) {
    // will set the users class and corresponding variables
    if (classChoice == "warrior") {
      chosenClass = "warrior";
      userImg = warrior.idleRight;
      speed = warrior.speed;
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
