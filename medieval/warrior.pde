class Warrior {
  PImage idleRight, idleLeft,
    walkingRight1, walkingLeft1,
    walkingRight2, walkingLeft2,
    walkingRight3, walkingLeft3,
    walkingRight6, walkingLeft6,
    idleWarrior;
  String title, description;
  int step;
  
  Warrior () {
    loadWarrior();
    description = "Slay your enemies with sword and shield.";
    title = "Warrior";
  }
  
  void walk() {
    // change step image if distTraveled
    if (user.distTraveled % 8 == 0) {
      if (step < 2) {
        step++;
      } else step = 0;
    }
    if (dist(mouseX, 0, user.location.x, 0) > 5) {
      // warrior walks right
      if (mouseX > user.location.x) {
        idleWarrior = idleRight;
        // only using two steps for now
        switch (step) {
          case 0:
            user.userImg = walkingRight1;
            break;
          case 1:
            user.userImg = walkingRight2;
            break;
          case 2:
            user.userImg = walkingRight3;
            break;
          case 3:
            user.userImg = walkingRight6;
            break;
        }
      } // warrior walks left
      else if (mouseX < user.location.x) {
        idleWarrior = idleLeft;
        switch (step) {
          case 0:
            user.userImg = walkingLeft1;
            break;
          case 1:
            user.userImg = walkingLeft2;
            break;
          case 2:
            user.userImg = walkingLeft3;
            break;
          case 3:
            user.userImg = walkingLeft6;
            break;
        }
      }
    } else user.userImg = idleWarrior;
  }
  
  void loadWarrior() {
    idleRight = loadImage("warriorRight.png");
    idleLeft = loadImage("warriorLeft.png");
    walkingRight1 = loadImage("warriorWalkingRight1.png");
    walkingLeft1 = loadImage("warriorWalkingLeft1.png");
    walkingRight2 = loadImage("warriorWalkingRight2.png");
    walkingLeft2 = loadImage("warriorWalkingLeft2.png");
    walkingRight3 = loadImage("warriorWalkingRight3.png");
    walkingLeft3 = loadImage("warriorWalkingLeft3.png");
    walkingRight6 = loadImage("warriorWalkingRight6.png");
    walkingLeft6 = loadImage("warriorWalkingLeft6.png");
  }
}
