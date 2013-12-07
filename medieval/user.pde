// pausing game lets you change spells and weapons

class User {
  Warrior warrior;
  Wizard wizard;
  Ranger ranger;
  Npc target;
  PImage userImg;
  PVector location, destination, speed;
  String actionState, chosenClass;
  float distTraveled, health;
  int xp;
  
  User () {
    warrior = new Warrior();
    wizard = new Wizard();
    ranger = new Ranger();
    location = new PVector(width/2, 475);
    destination = new PVector();
    actionState = "idle";
    distTraveled = 0;
    health = 1000;
  }
  
  void update() {
    walk();
    target();
    attack();
    imageMode(CENTER);
    image(userImg, location.x, location.y);
  }
  
  void attack() {
    if (actionState == "attacking") {
      if (chosenClass == "warrior") {
        warrior.attackDisplay();
        warrior.attack();
      } else if (chosenClass == "wizard") {
        
      } else if (chosenClass == "wizard") {
        
      }
    }
  }
  
  void walk() {
    // walk animation for class
    if (actionState == "walking" || actionState == "targeting") {
      if (chosenClass == "warrior") {
        warrior.walk();
      } else if (chosenClass == "wizard") {
        wizard.walk();
      } else if (chosenClass == "ranger") {
        ranger.walk();
      }
      // moves user based on mouse/touch
      if (location.dist(destination) > 5) {
        if (destination.x > location.x) {
          location.add(speed);
        } else if (destination.x < location.x) {
          location.sub(speed);
        } // dist for walk animation
        distTraveled += speed.x;
      } else actionState = "idle";
    }
  }
  
  void target() {
    if (chosenClass == "warrior") {
      warrior.target();
    } else if (chosenClass == "wizard") {
      
    } else if (chosenClass == "wizard") {
      
    }
  }
  
  void detectTap() {
    selection();
  }
  
  void detectSwipe() {
    
  }
  
  void detectLongPress() {
    
  }
  
  void selection() {
    for (int x=0; x < env.characters.size(); x++) {
      Npc npc = env.characters.get(x);
      if (npc.overNpc() && npc.alive) {
        target = npc;
        if (chosenClass == "warrior") {
          warrior.selection();
        } else if (chosenClass == "wizard") {
          
        } else if (chosenClass == "ranger") {
          
        }
      }
    }
  }
  
  void getDestination() {
    actionState = "walking";
    destination.x = mouseX;
    destination.y = location.y;
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
