// pausing game lets you change spells and weapons
// you cant really transfer items between bags, you'll have to copy them
// get properties from item to give to constructor of new copy item

class User {
  Warrior warrior;
  Wizard wizard;
  Ranger ranger;
  Npc target;
  PImage userImg;
  ArrayList<Item> bag; Item gold;
  PVector loc, destination, speed;
  String actionState, chosenClass;
  int xp, kills, level, walkFrames, lastPress;
  float health;
  
  User () {
    warrior = new Warrior();
    wizard = new Wizard();
    ranger = new Ranger();
    bag = new ArrayList<Item>();
    loc = new PVector(200, 475);
    destination = new PVector();
    actionState = "idle";
    health = 1000;
    loadStats();
    loadBag();
  }
  
  void update() {
    walk();
    target();
    attack();
    regulate();
    imageMode(CENTER);
    image(userImg, loc.x, loc.y);
  }
  
  void attack() {
    if (actionState == "attacking") {
      if (chosenClass == "warrior") {
        warrior.displayQuickAttack();
        warrior.quickAttack();
      } else if (chosenClass == "wizard") {
        
      } else if (chosenClass == "wizard") {
        
      }
    }
  }
  
  void walk() {
    // walk animation for class
    walkFrames++;
    if (actionState == "walking" || actionState == "targeting") {
      if (chosenClass == "warrior") {
        warrior.displayWalk();
      } else if (chosenClass == "wizard") {
        wizard.walk();
      } else if (chosenClass == "ranger") {
        ranger.walk();
      }
      // moves user based on mouse/touch
      if (loc.dist(destination) > 5) {
        if (destination.x > loc.x) {
          loc.add(speed);
        } else if (destination.x < loc.x) {
          loc.sub(speed);
        }
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
  
  void selection() {
    for (int x=0; x < env.characters.size(); x++) {
      Npc npc = env.characters.get(x);
      if (npc.overNpc() && npc.actionState != "dead") {
        target = npc;
        if (chosenClass == "warrior") {
          warrior.selection();
        } else if (chosenClass == "wizard") {
          
        } else if (chosenClass == "ranger") {
          
        }
      }
    }
  }
  
  void loot() {
    for (int x=0; x < env.loot.size(); x++) {
      Item item = env.loot.get(x);
      if (item.overItem()) {
        if (item.name.equals(gold.name)) {
          gold.quantity += item.quantity;
        } else {
          // unable to transfer, make copy instead
          bag.add(new Item(loc.x, loc.y,
          item.itemImg, item.path));
          println(item.name + " != " + gold.name);
        }
        env.loot.remove(item);
      }
    }
  }
  
  void getDestination() {
    // if pause/resume not pressed
    if (mouseY > 200) {
      actionState = "walking";
      destination.x = mouseX;
      destination.y = loc.y;
      // assures regular stride
      if (lastPress < millis()-300) {
        walkFrames = 10;
      }
    }
  }
  
  void loadBag() {
    gold = new Item(loc.x, loc.y,
      loadImage("goldCoins.png"), "gold");
    bag.add(gold);
  }
  
  void loadStats() {
    XML[] kids = ei.stats.getChildren("stat");
    for (int x=0; x < kids.length; x++) {
      XML kid = kids[x];
      if (kid.getContent().equals("Kills")) {
        kills = kid.getInt("quantity");
      } else if (kid.getContent().equals("XP")) {
        xp = kid.getInt("quantity");
      } else if (kid.getContent().equals("Level")) {
        level = kid.getInt("level");
      }
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
  
  void regulate() {
    if (xp > 2000) {
      level = 3;
    } else if (xp > 1000) {
      level = 2;
    }
    // class specific regulation
    if (chosenClass == "warrior") {
      warrior.regulate();
    } else if (chosenClass == "wizard") {
      
    } else if (chosenClass == "ranger") {
      
    }
  }
}
