class Player {

  // Position of player center in level coordinates
  float playerX, playerY;
  // Velocity of player
  float playerVX, playerVY;
  // Speed at which the player moves
  float playerSpeed = 150;
  // The player is a circle and this is its radius
  float playerR = 20;
  // The score of the player
  int score;
  PImage bird_right;

  // Konstruktor
  Player(float x, float y) {
    this.playerX = x;
    this.playerY = y;
    this.playerVX = 0;
    this.playerVY = 0;
    this.score = 0;
    bird_right = loadImage("images/bird_right.png");
  }

  void keyPressed() {
    if ( keyCode == UP ) {
      playerVY = -playerSpeed;
      playerVX = 0;
    } else if ( keyCode == DOWN ) {
      playerVY = playerSpeed;
      playerVX = 0;
    } else if ( keyCode == LEFT ) {
      playerVX = -playerSpeed;
      playerVY = 0;
    } else if ( keyCode == RIGHT ) {
      playerVX = playerSpeed;
      playerVY = 0;
    }
  }

  void update() {
    // update player
    float nextX = playerX + playerVX/frameRate, 
      nextY = playerY + playerVY/frameRate;
    if ( map.testTileInRect( nextX-playerR, nextY-playerR, 2*playerR, 2*playerR, "W" ) ) {
      playerVX = 0;
      playerVY = 0;
      nextX = playerX;
      nextY = playerY;
    }

    if (map.testTileInRect(nextX-playerR, nextY-playerR, 2*playerR, 2*playerR, "H_")) {
      score++;
      int x = map.xOfTileAtPixel(playerX);
      int y = map.yOfTileAtPixel(playerY);
      map.set(x, y, 'F');
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
    imageMode(CENTER);
    image (bird_right, playerX - screenLeftX, playerY - screenTopY, 2*playerR, 2*playerR);
  }
}