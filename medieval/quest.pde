// Quest class for quest lines, characters, objectives, and rewards

class Quest {
  
  //NOI = NO IMAGE
  PImage questGiver;
  
  //NOI = LoadImage Logic 
  //Path /Data Name NoImage.PNG
  Quest () {
    // using this image for now
    questGiver = loadImage("questGiver.png");
  }
  
  void display() {
    questGiver();
  }
  
  //Display Image (NOI, X, Y, W%, H%) 
  void questGiver() {
  //image(NOI, 0, 0);
  imageMode(CENTER);
  image(questGiver, width/10, 475);
  }
}

