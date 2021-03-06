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
  // In welche RIchtung guckt der Vogel?
  int direction;
  PImage bird_right;
  PImage bird_left;
  PImage bird_front;
  PImage bird_back;

  // Konstruktor
  Player(float x, float y) {
    this.playerX = x;
    this.playerY = y;
    this.playerVX = 0;
    this.playerVY = 0;
    this.score = 0;
    bird_right = loadImage("images/bird_right.png");
    bird_left = loadImage("images/bird_left.png");
    bird_front = loadImage("images/bird_front.png");
    bird_back = loadImage("images/bird_back.png");
    direction = RIGHT;
  }

  void keyPressed() {
    if ( keyCode == UP ) {
      playerVY = -playerSpeed;
      playerVX = 0;
      direction = UP;
    } else if ( keyCode == DOWN ) {
      playerVY = playerSpeed;
      playerVX = 0;
      direction = DOWN;
    } else if ( keyCode == LEFT ) {
      playerVX = -playerSpeed;
      playerVY = 0;
      direction = LEFT;
    } else if ( keyCode == RIGHT ) {
      playerVX = playerSpeed;
      playerVY = 0;
      direction = RIGHT;
    }
  }

  void update() {
    // update player
    float nextX = playerX + playerVX/frameRate;
    float nextY = playerY + playerVY/frameRate;
    if ( map.testTileInRect( nextX-playerR, nextY-playerR, 2*playerR, 2*playerR, "W" ) ) {
      playerVX = 0;
      playerVY = 0;
      nextX = playerX;
      nextY = playerY;
    }

    // Wir fragen Map auf welcher Tile unser Player steht, wenn "H" zutrifft, dann wird der Diamant eingesammelt und in den Score gezaehlt
    Map.TileReference tile = map.findTileInRect(nextX-playerR, nextY-playerR, 2*playerR, 2*playerR, "H_");
    if (tile != null) {
      bird.rewind();
      bird.play();
      score++;
      map.set(tile.x, tile.y, 'F');
      if (score == totalNumberOfGreenCards) {
        gameState=GAMEWON;
      }
    }

    playerX = nextX;
    playerY = nextY;
  }

  void draw() {
    // draw player
    noStroke();
    fill(0, 255, 255);
    imageMode(CENTER);
    if (direction == RIGHT) {
      image (bird_right, playerX - screenLeftX, playerY - screenTopY, 2*playerR, 2*playerR);
    } else if (direction == LEFT) {
      image (bird_left, playerX - screenLeftX, playerY - screenTopY, 2*playerR, 2*playerR);
    } else if (direction == DOWN) {
      image (bird_front, playerX - screenLeftX, playerY - screenTopY, 2*playerR, 2*playerR);
    } else if (direction == UP) {
      image (bird_back, playerX - screenLeftX, playerY - screenTopY, 2*playerR, 2*playerR);
    }
  }
  
}