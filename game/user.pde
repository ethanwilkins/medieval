class User {
  PImage userImg;
  PVector user;
  float speed;
  
  User () {
    userImg = loadImage("userRight.png");
    user = new PVector(width/2, 450);
    speed = 0.015;
  }
  
  void display() {
    walk();
    imageMode(CENTER);
    image(userImg, user.x, user.y);
  }
  
  void walk() {
    direction();
    user.x += (mouseX - user.x) * speed;
  }
  
  void direction() {
    if (mouseX > user.x) {
      userImg = loadImage("userRight.png");
    } else if (mouseX < user.x) {
      userImg = loadImage("userLeft.png");
    }
  }
}
