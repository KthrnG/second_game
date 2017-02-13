class Game {

}

void newGame () {
  map = new Map( "demo.map");
  for ( int x = 0; x < map.w; ++x ) {
    for ( int y = 0; y < map.h; ++y ) {
      // put player at 'S' tile and replace with 'F'  
      if ( map.at(x, y) == 'S' ) {
        playerX = map.centerXOfTile (x);
        playerY = map.centerYOfTile (y);
        map.set(x, y, 'F');
      }
      // put goal at 'E' tile  
      if ( map.at(x, y) == 'E' ) {
        goalX = map.centerXOfTile (x);
        goalY = map.centerYOfTile (y);
      }
    }
  }
  time=0;
  playerVX = 0;
  playerVY = 0;
  gameState = GAMEWAIT;
}

void drawText() { 
  textAlign(CENTER, CENTER);
  fill(0, 255, 0);  
  textSize(40);  
  if (gameState==GAMEWAIT) text ("press space to start", width/2, height/2);
  else if (gameState==GAMEOVER) text ("game over", width/2, height/2);
  else if (gameState==GAMEWON) text ("won in "+ round(time) + " seconds", width/2, height/2);
}