class Monster {

  float x, y;
  float vX, vY;
  // float speed;
  float radius;
  int speed = (int) random (50, 100);
  PImage geier;


  //Konstruktor Monster
  Monster(float x, float y) {
    this.x = x;
    this.y = y;
    //this.vY = 50;
    //this.vX = 30;
    if (random(1)> 0.5) {
      vX = speed;
    } else vY = speed;
    // this.speed = 1;
    this.radius = 20;
    geier = loadImage("images/Geier.png");
  }

  void draw() {
    // Monster zeichnen
    noStroke();
    fill(0, 0, 0);
    //ellipseMode(CENTER);
    //ellipse(x - screenLeftX, y - screenTopY, 2*radius, 2*radius);
    imageMode(CENTER);
    image(geier, x - screenLeftX, y - screenTopY, 2*radius, 2*radius);
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

  // Steht das Monster auf dem gleichen Tile wie der Player?
  boolean collidesWith(Player player) {
    int playerTileX = map.xOfTileAtPixel(player.playerX);
    int playerTileY = map.yOfTileAtPixel(player.playerY);
    int monsterTileX = map.xOfTileAtPixel(x);
    int monsterTileY = map.yOfTileAtPixel(y);

    return playerTileX == monsterTileX && playerTileY == monsterTileY;
  }
}