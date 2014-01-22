package processing.test.medieval;

import processing.core.PApplet;
import processing.core.PImage;
import processing.core.PVector;
import processing.data.XML;

/**
 * Created by ethanwilkins on 1/21/14.
 */
public class Item {
    PApplet parent;
    PVector loc;
    PImage itemImg;
    XML element;
    String name, content, path;
    int quantity;
    float w, h;

    Item (float x, float y, PImage img, String itemPath, PApplet p) {
        parent = p;
        loc = new PVector(x, y);
        itemImg = img;
        path = itemPath;
        loadItem(path);
        w = itemImg.width;
        h = itemImg.height;
    }

    public void display() {
        parent.imageMode(parent.CENTER);
        parent.image(itemImg, loc.x, loc.y);
        // show quantity in bag for stacked items
        if (quantity > 1 && medieval.ei.gameState == "paused") {
            parent.fill(255);
            parent.textSize(20);
            parent.textAlign(parent.CENTER);
            parent.text(quantity, loc.x-20, loc.y-20);
        }
    }

    public void loadItem(String itemPath) {
        element = medieval.ei.inventory.getChild(itemPath);
        quantity = element.getInt("quantity");
        name = element.getString("name");
        content = element.getContent();
    }

    public boolean overItem() {
        float disX = loc.x - parent.mouseX;
        float disY = loc.y - parent.mouseY;
        if(parent.sqrt(parent.sq(disX) + parent.sq(disY)) < w) {
            return true;
        } else return false;
    }
}
