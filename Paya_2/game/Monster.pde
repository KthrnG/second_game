class Monster {
  
  float x, y;
  float vX, vY;
  float speed;
  float radius;
  
  Monster() {
    this.x = 100;
    this.y = 200;
    this.vY = 1;
    this.vX = 1;
    this.speed = 1;
    this.radius = 10;
  }
  
  void draw() {
    // TODO Monster zeichnen
  }
  
  boolean collidesWith(Player player) {
    // TODO Steht das Monster auf dem gleichen Tile wie der Player?
    return false;
  }
  
}