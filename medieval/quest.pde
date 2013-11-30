class Quest {
  
  //NOI = NO IMAGE
    PImage NOI;
  
  //NOI = LoadImage Logic 
  //Path /Data Name NoImage.PNG
  Quest () {
    NOI = loadImage("NoImage.png");
  }
  
 //Display Image (NOI, X, Y, W%, H%) 
  void display() {
  //image(NOI, 0, 0);
  image(NOI, 60, 520, width/10, height/10);
  }
}

