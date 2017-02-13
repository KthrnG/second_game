class bird{

}


void keyPressed() {
  if ( keyCode == UP && playerVY == 0 ) {
    playerVY = -playerSpeed;
    playerVX = 0;
  }
  else if ( keyCode == DOWN && playerVY == 0 ) {
    playerVY = playerSpeed;
    playerVX = 0;
  }
  else if ( keyCode == LEFT && playerVX == 0 ) {
    playerVX = -playerSpeed;
    playerVY = 0;
  }
  else if ( keyCode == RIGHT && playerVX == 0 ) {
    playerVX = playerSpeed;
    playerVY = 0;
  }
  else if ( keyCode == 'S' ) showSpecialFunctions = !showSpecialFunctions;
}


void updatePlayer() {
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

void drawPlayer() {
  // draw player
  noStroke();
  fill(0, 255, 255);
  ellipseMode(CENTER);
  ellipse( playerX - screenLeftX, playerY - screenTopY, 2*playerR, 2*playerR );

  // understanding this is optional, skip at first sight
  if (showSpecialFunctions) {
    // draw a line to the next hole   
    Map.TileReference nextHole = map.findClosestTileInRect (playerX-100, playerY-100, 200, 200, "H");
    stroke(255, 0, 255);
    if (nextHole!=null) line (playerX-screenLeftX, playerY-screenTopY, 
    nextHole.centerX-screenLeftX, nextHole.centerY-screenTopY);

    // draw line of sight to goal (until next wall) (understanding this is optional)
    stroke(0, 255, 255);  
    Map.TileReference nextWall = map.findTileOnLine (playerX, playerY, goalX, goalY, "W");
    if (nextWall!=null) 
      line (playerX-screenLeftX, playerY-screenTopY, nextWall.xPixel-screenLeftX, nextWall.yPixel-screenTopY);
    else
      line (playerX-screenLeftX, playerY-screenTopY, goalX-screenLeftX, goalY-screenTopY);
  }
}