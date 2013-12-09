class Item {
  PVector loc;
  PImage itemImg;
  XML element;
  String name;
  int quantity;
  float w, h;
  
  Item (float x, float y, PImage img, String itemPath) {
    loc = new PVector(x, y);
    itemImg = img;
    loadItem(itemPath);
    w = itemImg.width;
    h = itemImg.height;
  }
  
  void update() {
    imageMode(CENTER);
    image(itemImg, loc.x, loc.y);
  }
  
  void loadItem(String itemPath) {
    element = ei.inventory.getChild(itemPath);
    quantity = element.getInt("quantity");
    name = element.getContent();
  }
  
  boolean overItem() {
    float disX = loc.x - mouseX;
    float disY = loc.y - mouseY;
    if(sqrt(sq(disX) + sq(disY)) < w) {
      return true;
    } else return false;
  }
}
