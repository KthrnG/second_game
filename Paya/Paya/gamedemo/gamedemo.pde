Map map;

//Monster ELLIPSE (x, y)
float x, y;
float vX, vY;
float r = 20;



  // Position of player center in level coordinates
  float playerX, playerY;
  // Velocity of player
  float playerVX, playerVY;
  // Speed at which the player moves
  float playerSpeed = 150;
  // The player is a circle and this is its radius
  float playerR = 10;
  // Position of the goal center
  // Will be set by restart
  float goalX=0, goalY=0;
  // Whether to illustrate special functions of class Map
  boolean showSpecialFunctions=false;

  // left / top border of the screen in map coordinates
  // used for scrolling
  float screenLeftX, screenTopY;

  float time;
  int GAMEWAIT=0, GAMERUNNING=1, GAMEOVER=2, GAMEWON=3;
  int gameState;

  PImage backgroundImg;

  void setup() {
    size( 900, 750 );
    backgroundImg = loadImage ("images/fire.jpg");
    newGame ();
  }



  // Maps x to an output y = map(x,xRef,yRef,factor), such that
  //     - x0 is mapped to y0
  //     - increasing x by 1 increases y by factor
  float map (float x, float xRef, float yRef, float factor) {
    return factor*(x-xRef)+yRef;
  }

  void drawBackground() {
    // Explanation to the computation of x and y:
    // If screenLeftX increases by 1, i.e. the main level moves 1 to the left on screen,
    // we want the background map to move 0.5 to the left, i.e. x decrease by 0.5
    // Further, imagine the center of the screen (width/2) corresponds to the center of the level
    // (map.widthPixel), i.e. screenLeftX=map.widthPixel()/2-width/2. Then we want
    // the center of the background image (backgroundImg.width/2) also correspond to the screen
    // center (width/2), i.e. x=-backgroundImg.width/2+width/2.
    float x = map (screenLeftX, map.widthPixel()/2-width/2, -backgroundImg.width/2+width/2, -0.5);
    float y = map (screenTopY, map.heightPixel()/2-height/2, -backgroundImg.height/2+height/2, -0.5);
    image (backgroundImg, x, y);
  }


  void drawMap() {   
    // The left border of the screen is at screenLeftX in map coordinates
    // so we draw the left border of the map at -screenLeftX in screen coordinates
    // Same for screenTopY.
    map.draw( -screenLeftX, -screenTopY );
  }


  void draw() {
    if (gameState==GAMERUNNING) {
      updatePlayer();
      time+=1/frameRate;
    } else if (keyPressed && key==' ') {
      if (gameState==GAMEWAIT) gameState=GAMERUNNING;
      else if (gameState==GAMEOVER || gameState==GAMEWON) newGame();
    }
    screenLeftX = playerX - width/2;
    screenTopY  = (map.heightPixel() - height)/2;

    drawBackground();
    drawMap();
    drawPlayer();
    drawText();
    drawScore();

    //drawMonster();
  }