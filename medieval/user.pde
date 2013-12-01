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
    distTraveled = 0;
  }
  
  void display() {
    imageMode(CENTER);
    image(userImg, location.x, location.y);
    walk();
  }
  
  void walk() {
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
