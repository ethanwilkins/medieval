class User {
  Warrior warrior;
  PVector location, speed;
  PImage userImg;
  
  User () {
    warrior = new Warrior();
    userImg = warrior.warriorRight;
    location = new PVector(width/2, 475);
    speed = new PVector(3.5, 0);
  }
  
  void display() {
    imageMode(CENTER);
    image(userImg, location.x, location.y);
    walk();
  }
  
  void walk() {
    if (dist(mouseX, 0, location.x, 0) > 5) {
      if (mouseX > location.x) {
        userImg = warrior.warriorRight;
        location.add(speed);
      } else if (mouseX < location.x) {
        userImg = warrior.warriorLeft;
        location.sub(speed);
      }
    }
  }
}
