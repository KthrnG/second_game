Map myMap;
Bird myBird;
Monster myMonster;
Diamants myDiamants;
Game myGame;
Intro myIntro;
Score myScore;

void setup() {
  size (500, 500);
  myMap = new Map();
  myBird = new Bird();
  myMonster = new Monster();
  myDiamants = new Diamants();
  myGame = new Game();
  myIntro = new Intro();
  myScore = newScore();
}