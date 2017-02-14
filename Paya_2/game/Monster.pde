class Monster {

  float x, y;
  float vX, vY;
  float speed;
  float radius;

  //Konstruktor Monster
  Monster(float x, float y) {
    this.x = x;
    this.y = y;
    this.vY = 1;
    this.vX = 1;
    this.speed = 1;
    this.radius = 10;
  }

  void draw() {
    // TODO Monster zeichnen
    noStroke();
    fill(0, 0, 0);
    ellipseMode(CENTER);
    ellipse(x - screenLeftX, y - screenTopY, 2*radius, 2*radius);
  }

  boolean collidesWith(Player player) {
    // TODO Steht das Monster auf dem gleichen Tile wie der Player?
    return false;
  }
}