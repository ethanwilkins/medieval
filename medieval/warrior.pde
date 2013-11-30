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
  
  void walk() {
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
