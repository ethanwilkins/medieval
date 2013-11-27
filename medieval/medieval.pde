Environment env;
User user;

void setup() {
  size(displayWidth, displayHeight);
  orientation(LANDSCAPE);
  env = new Environment();
  user = new User();
}

void draw() {
  env.display();
  user.display();
}
