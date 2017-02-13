Map map;

Map myMap;
Bird myBird;
Monster myMonster;
Diamants myDiamants;
Game myGame;
Intro myIntro;
Score myScore;

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
  size (500, 500);
  backgroundImg = loadImage ("images/fire.jpg");
  newGame ();
}
  
  void newGame (){
  myMap = new Map();
  myBird = new Bird();
  myMonster = new Monster();
  myDiamants = new Diamants();
  myGame = new Game();
  myIntro = new Intro();
  myScore = newScore();
}