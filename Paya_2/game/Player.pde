class Player {

  // Position of player center in level coordinates
  float playerX, playerY;
  // Velocity of player
  float playerVX, playerVY;
  // Speed at which the player moves
  float playerSpeed = 150;
  // The player is a circle and this is its radius
  float playerR = 10;

  // Konstruktor
  Player(float x, float y) {
    this.playerX = x;
    this.playerY = y;
    this.playerVX = 0;
    this.playerVY = 0;
  }

  void keyPressed() {
    if ( keyCode == UP && playerVY == 0 ) {
      playerVY = -playerSpeed;
      playerVX = 0;
    } else if ( keyCode == DOWN && playerVY == 0 ) {
      playerVY = playerSpeed;
      playerVX = 0;
    } else if ( keyCode == LEFT && playerVX == 0 ) {
      playerVX = -playerSpeed;
      playerVY = 0;
    } else if ( keyCode == RIGHT && playerVX == 0 ) {
      playerVX = playerSpeed;
      playerVY = 0;
    }
  }

  void update() {
    // update player
    float nextX = playerX + playerVX/frameRate, 
      nextY = playerY + playerVY/frameRate;
    if ( map.testTileInRect( nextX-playerR, nextY-playerR, 2*playerR, 2*playerR, "W" ) ) {
      playerVX = -playerVX;
      playerVY = -playerVY;
      nextX = playerX;
      nextY = playerY;
    }
    if ( map.testTileFullyInsideRect (nextX-playerR, nextY-playerR, 2*playerR, 2*playerR, "H_" ) ) {
      gameState=GAMEOVER;
    }
    if ( map.testTileFullyInsideRect (nextX-playerR, nextY-playerR, 2*playerR, 2*playerR, "E" ) ) {
      gameState=GAMEWON;
    }

    playerX = nextX;
    playerY = nextY;
  }

  void draw() {
    // draw player
    noStroke();
    fill(0, 255, 255);
    ellipseMode(CENTER);
    ellipse( playerX - screenLeftX, playerY - screenTopY, 2*playerR, 2*playerR );
  }
}