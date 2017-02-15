Map map;
Player player;
Background background;
ArrayList<Monster> monsters;

// left / top border of the screen in map coordinates
// used for scrolling
float screenLeftX, screenTopY;

float time;
int GAMEWAIT=0, GAMERUNNING=1, GAMEOVER=2, GAMEWON=3;
int gameState;
int totalNumberOfGreenCards = 0;

void setup() {
  size( 700, 700  );
  background = new Background();
  newGame();
}

void newGame () {
  map = new Map( "demo.map");
  // Liste von Monstern initialisieren
  monsters = new ArrayList<Monster>();
  for ( int x = 0; x < map.w; ++x ) {
    for ( int y = 0; y < map.h; ++y ) {
      // put player at 'S' tile and replace with 'F'  
      if ( map.at(x, y) == 'S' ) {
        float playerX = map.centerXOfTile (x);
        float playerY = map.centerYOfTile (y);
        // Konstruktor aufrufen
        player = new Player(playerX, playerY);
        map.set(x, y, 'F');
      }
      if (map.at (x, y) == 'F') {
        //Mit einer Chance von 4% landet in jedem 'F' Tile ein Monster
        if (random(100) <= 4) {
          float monsterX = map.centerXOfTile(x);
          float monsterY = map.centerYOfTile(y);
          monsters.add(new Monster(monsterX, monsterY));
        }
      }
      if (map.at(x, y) == 'H') {
        totalNumberOfGreenCards++;
      }
    }
  }


  time=0;
  // playerVX = 0;
  // playerVY = 0;
  gameState = GAMEWAIT;
}

void keyPressed() {
  player.keyPressed();
}

void drawMap() {   
  // The left border of the screen is at screenLeftX in map coordinates
  // so we draw the left border of the map at -screenLeftX in screen coordinates
  // Same for screenTopY.
  map.draw( -screenLeftX, -screenTopY );
}

void drawText() { 
  textAlign(CENTER, CENTER);
  fill(#FF2177);  
  textSize(20);  
  if (gameState==GAMEWAIT) text ("PRESS SPACE TO START", 160, height/2);
  else if (gameState == GAMERUNNING) text("SCORE " + player.score + "/" + totalNumberOfGreenCards, 160, 10);
  else if (gameState==GAMEOVER) text ("GAME OVER", width/2, height/2);
  else if (gameState==GAMEWON) text ("CONGRATULATIONS! YOUR GREEN CARD HAS BEEN APPROVED", width/2, height/2);
}

void draw() {
  if (gameState==GAMERUNNING) {
    player.update();
    for (Monster monster : monsters) {
      monster.update();
      if (monster.collidesWith(player)) { 
        gameState = GAMEOVER;
      }
    }
    time+=1/frameRate;
  } else if (keyPressed && key==' ') {
    if (gameState==GAMEWAIT) gameState=GAMERUNNING;
    else if (gameState==GAMEOVER || gameState==GAMEWON) newGame();
  }
  screenLeftX = player.playerX - width/2;
  screenTopY  = (map.heightPixel() - height)/2;

  background.draw();
  drawMap();
  player.draw();
  for (Monster monster : monsters) {
    monster.draw();
  }
  drawText();
}