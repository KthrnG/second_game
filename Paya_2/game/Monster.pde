class Monster {

  float x, y;
  float vX, vY;
  // float speed;
  float radius;

  //Konstruktor Monster
  Monster(float x, float y) {
    this.x = x;
    this.y = y;
    this.vY = 0;
    this.vX = 30;
    // this.speed = 1;
    this.radius = 10;
  }

  void draw() {
    // TODO Monster zeichnen
    noStroke();
    fill(0, 0, 0);
    ellipseMode(CENTER);
    ellipse(x - screenLeftX, y - screenTopY, 2*radius, 2*radius);
  }

  void update() {
    float nextX = x + vX/frameRate;
    float nextY = y + vY/frameRate;
    if ( map.testTileInRect( nextX-radius, nextY-radius, 2*radius, 2*radius, "W" ) ) {
      vX = -vX;
      vY = -vY;
      nextX = x;
      nextY = y;
    }
    x = nextX;
    y = nextY;
  }

  boolean collidesWith(Player player) {
    // TODO Steht das Monster auf dem gleichen Tile wie der Player?
    return false;
  }
}