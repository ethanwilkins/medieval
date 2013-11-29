class User {
  Warrior warrior;
  Wizard wizard;
  Ranger ranger;
  PVector location, speed;
  PImage userImg;
  float distTraveled;
  
  User () {
    warrior = new Warrior();
    wizard = new Wizard();
    ranger = new Ranger();
    location = new PVector(width/2, 475);
    speed = new PVector(3.5, 0);
    distTraveled = 0;
  }
  
  void display() {
    imageMode(CENTER);
    image(userImg, location.x, location.y);
    walk();
  }
  
  void walk() {
    warrior.warriorWalk();
    if (dist(mouseX, 0, location.x, 0) > 5) {
      if (mouseX > location.x) {
        location.add(speed);
      } else if (mouseX < location.x) {
        location.sub(speed);
      } distTraveled += speed.x;
    }
  }
  
  void setUserClass(String classChoice) {
    if (classChoice == "warrior") {
       userImg = warrior.idleRight;
    } else if (classChoice == "wizard") {
       userImg = warrior.idleRight;
    } else if (classChoice == "ranger") {
       userImg = warrior.idleRight;
    }
    ei.gameState = "game";
  }
}
