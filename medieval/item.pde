class Item {
  PVector loc;
  PImage itemImg;
  XML element;
  String name, path;
  int quantity;
  float w, h;
  
  Item (float x, float y, PImage img, String itemPath) {
    loc = new PVector(x, y);
    itemImg = img;
    path = itemPath;
    loadItem(path);
    w = itemImg.width;
    h = itemImg.height;
  }
  
  void display() {
    imageMode(CENTER);
    image(itemImg, loc.x, loc.y);
    // show quantity of multiples
    if (quantity > 1) {
      fill(255);
      textSize(20);
      textAlign(CENTER);
      text(quantity, loc.x-20, loc.y-20);
    }
  }
  
  void loadItem(String itemPath) {
    element = ei.inventory.getChild(itemPath);
    quantity = element.getInt("quantity");
    name = element.getString("name");
  }
  
  boolean overItem() {
    float disX = loc.x - mouseX;
    float disY = loc.y - mouseY;
    if(sqrt(sq(disX) + sq(disY)) < w) {
      return true;
    } else return false;
  }
}
