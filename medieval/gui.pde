// pause screen with tabs for quest log, inventory, stats, spells/attacks
// buttons from mathgame and ones that grow and shrink away like in circle

class Gui {
  Button warrior, wizard, ranger, forward, backward,
    pause, resume, items, spells, quests, stats;
  PImage pauseTab, pauseTab1, pauseTab2, pauseTab3;
  String guiState;
  int choiceState;
  
  Gui () {
    warrior = new Button(width*0.3, height*0.48, user.warrior.idleRight);
    wizard = new Button(width*0.3, height*0.48, user.warrior.idleRight);
    ranger = new Button(width*0.3, height*0.48, user.warrior.idleRight);
    forward = new Button(width*0.9, height/2, loadImage("gui/forward.png"));
    backward = new Button(width*0.1, height/2, loadImage("gui/backward.png"));
    pause = new Button(60, 50, loadImage("gui/questLog.png"));
    resume = new Button(70, 65, loadImage("gui/backward.png"));
    items = new Button(265, 75, loadImage("gui/itemsButton.png"));
    spells = new Button(540, 75, loadImage("gui/spellsButton.png"));
    quests = new Button(815, 75, loadImage("gui/questsButton.png"));
    stats = new Button(1085, 75, loadImage("gui/statsButton.png"));
    pauseTab = loadImage("gui/pauseTab.png");
    pauseTab1 = loadImage("gui/pauseTab1.png");
    pauseTab2 = loadImage("gui/pauseTab2.png");
    pauseTab3 = loadImage("gui/pauseTab3.png");
    guiState = "items";
    choiceState = 0;
  }
  
  void displayPauseScreen() {
    if (guiState == "items") {
      displayItems();
    } else if (guiState == "spells") {
      displaySpells();
    } else if (guiState == "quests") {
      displayQuests();
    } else if (guiState == "stats") {
      displayStats();
    }
    items.display();
    spells.display();
    quests.display();
    stats.display();
    resume.display();
  }
  
  void displayItems() {
    imageMode(CORNER);
    image(pauseTab, 0, 0);
    for (int x=0; x < user.bag.size(); x++) {
      user.bag.get(x).display();
    }
  }
  
  void displaySpells() {
    imageMode(CORNER);
    image(pauseTab1, 0, 0);
  }
  
  void displayQuests() {
    imageMode(CORNER);
    image(pauseTab2, 0, 0);
  }
  
  void displayStats() {
    imageMode(CORNER);
    image(pauseTab3, 0, 0);
    textSize(25);
    textAlign(CENTER);
    text("Class: " + user.chosenClass, width/2, height*0.4);
    text("Kills: " + user.kills, width/2, height*0.5);
    text("XP: " + user.xp, width/2, height*0.6);
    text("Gold: " + user.gold.quantity, width/2, height*0.7);
    text("Total Gold: " + user.gold.quantity, width/2, height*0.8);
  }
  
  void displayClassChoice() {
    // class choice screen
    String title = " ", description = " ";
    // back/forward buttons
    forward.display();
    backward.display();
    // which character to display
    switch (choiceState) {
      case 0:
        title = user.warrior.title;
        description = user.warrior.description;
        warrior.display();
        break;
      case 1:
        title = user.wizard.title;
        description = user.wizard.description;
        wizard.display();
        break;
      case 2:
        title = user.ranger.title;
        description = user.ranger.description;
        ranger.display();
        break;
    }
    fill(255);
    textAlign(CENTER);
    rectMode(CORNER);
    textSize(50);
    text(title, width*0.55, height*0.3);
    textSize(30);
    text(description, width*0.42, height*0.45, 400, 400);
  }
  
  void checkPauseScreen() {
    if (resume.overButton()) {
      ei.gameState = "game";
    } else if (items.overButton()) {
      guiState = "items";
    } else if (spells.overButton()) {
      guiState = "spells";
    } else if (quests.overButton()) {
      guiState = "quests";
    } else if (stats.overButton()) {
      guiState = "stats";
    }
  }
  
  void checkPauseButton() {
    if (pause.overButton()) {
      XML gold = ei.inventory.getChild("user/gold");
      gold.setInt("quantity", user.gold.quantity);
      ei.gameState = "paused";
      loadInventoryScreen();
      
    }
  }
  
  void checkClassChoice() {
    // check character buttons
    if (warrior.overButton() && choiceState == 0) {
      user.setUserClass("warrior");
    } else if (wizard.overButton() && choiceState == 1) {
      user.setUserClass("wizard");
    } else if (ranger.overButton() && choiceState == 2) {
      user.setUserClass("ranger");
    } // check back/forward
    else if (forward.overButton()) {
      if (choiceState < 2) {
        choiceState++;
      } else choiceState = 0;
    } else if (backward.overButton()) {
      if (choiceState > 0) {
        choiceState--;
      } else choiceState = 2;
    }
  }
  
  void loadInventoryScreen() {
    int z = 0;
    for (int y=250; y < height-10; y += 75) {
      for (int x=125; x < width-10; x += 75) {
        if (z < user.bag.size()) {
          Item item = user.bag.get(z);
          item.loc.x = x;
          item.loc.y = y;
          z++;
        }
      }
    }
  }

  class Button {
    PImage graphic;
    PVector loc;
    float w, h;
    
    Button (float x, float y, PImage buttonGraphic) {
      loc = new PVector(x, y);
      graphic = buttonGraphic;
      w = graphic.width;
      h = graphic.height;
    }
    
    void display() {
      imageMode(CENTER);
      image(graphic, loc.x, loc.y);
    }
    
    boolean overButton() {
      float disX = loc.x - mouseX;
      float disY = loc.y - mouseY;
      if(sqrt(sq(disX) + sq(disY)) < w) {
        return true;
      } else return false;
    }
  }
}
