package processing.test.medieval;

import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException;

public class medieval extends PApplet {

public static Environment env;
public static Engine ei;
public static Quest que;
public static User user;
public static Gui gui;

public void setup() {
 
  orientation(LANDSCAPE);
  ei = new Engine(this);
  ei.bootStrap(this);
}

public void draw() {
  background(0);
  ei.display();
}

public void mousePressed() {
  ei.updateUserPress();
}

public void mouseReleased() {
  ei.checkButtons();
}
  public int sketchWidth() { return 1280; }
  public int sketchHeight() { return 720; }
}
