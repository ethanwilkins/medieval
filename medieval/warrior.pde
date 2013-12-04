// different swipes and swipe combos for attacks
// maxHit 

class Warrior {
  PVector speed;
  PImage idleWarrior, idleRight, idleLeft,
    walkRight1, walkLeft1,
    walkRight2, walkLeft2,
    walkRight3, walkLeft3,
    walkRight5, walkLeft5,
    walkRight6, walkLeft6,
    attRight1, attRight2, attRight3;
  String title, description;
  int step, attPose, attFrames;
  float maxHit, maxHealth;
  
  Warrior () {
    loadWarrior();
    speed = new PVector(2.5, 0);
    description = "Slay your enemies with sword and shield.";
    title = "Warrior";
    maxHit = 200;
  }
  
  void selection(Npc npc) {
    if (user.location.dist(npc.location) < 200) {
      // if npc is enemy, attack, else "talking"
      user.actionState = "attacking";
    } //else user.actionState = "targeting";
  }
  
  void target() {
    // walk towards the selected target and attack if enemy
  }
  
  void attack() {
    if (attFrames % 7 == 0 && attPose == 0) {
      user.target.health -= random(1, maxHit);
    }
  }
  
  void attackDisplay() {
    // start at raising sword at new fight
    attFrames++;
    if (attFrames % 7 == 0) {
      if (attPose < 2) {
        attPose++;
      } else attPose = 0;
    }
    switch (attPose) {
      case 0:
        user.userImg = attRight1;
        break;
      case 1:
        user.userImg = attRight2;
        break;
      case 2:
        user.userImg = attRight3;
        break;
    }
  }
  
  void walk() {
    // change step image if distTraveled
    if (user.distTraveled % 7 == 0) {
      if (step < 5) {
        step++;
      } else step = 0;
    }
    if (dist(user.destination, 0, user.location.x, 0) > 5) {
      // warrior walks right
      if (user.destination > user.location.x) {
        idleWarrior = idleRight;
        // only using two steps for now
        switch (step) {
          case 0:
            user.userImg = walkRight1;
            break;
          case 1:
            user.userImg = walkRight2;
            break;
          case 2:
            user.userImg = walkRight3;
            break;
          case 3:
            user.userImg = walkRight1;
            break;
          case 4:
            user.userImg = walkRight5;
            break;
          case 5:
            user.userImg = walkRight6;
            break;
        }
      } // warrior walks left
      else if (user.destination < user.location.x) {
        idleWarrior = idleLeft;
        switch (step) {
          case 0:
            user.userImg = walkLeft1;
            break;
          case 1:
            user.userImg = walkLeft2;
            break;
          case 2:
            user.userImg = walkLeft3;
            break;
          case 3:
            user.userImg = walkLeft1;
            break;
          case 4:
            user.userImg = walkLeft5;
            break;
          case 5:
            user.userImg = walkLeft6;
            break;
        }
      }
    } else user.userImg = idleWarrior;
  }
  
  void loadWarrior() {
    idleRight = loadImage("warrior/idleRight.png");
    idleLeft = loadImage("warrior/idleLeft.png");
    walkRight1 = loadImage("warrior/walkRight1.png");
    walkLeft1 = loadImage("warrior/walkLeft1.png");
    walkRight2 = loadImage("warrior/walkRight2.png");
    walkLeft2 = loadImage("warrior/walkLeft2.png");
    walkRight3 = loadImage("warrior/walkRight3.png");
    walkLeft3 = loadImage("warrior/walkLeft3.png");
    walkRight5 = loadImage("warrior/walkRight5.png");
    walkLeft5 = loadImage("warrior/walkLeft5.png");
    walkRight6 = loadImage("warrior/walkRight6.png");
    walkLeft6 = loadImage("warrior/walkLeft6.png");
    attRight1 = loadImage("warrior/attRight1.png");
    attRight2 = loadImage("warrior/attRight2.png");
    attRight3 = loadImage("warrior/attRight3.png");
  }
}
