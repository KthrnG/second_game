class Monster {
  int x;
  int y;
}

void moveMonster() {
  int richtung = (int)random(0, 4);
  if (richtung == 0) {
    moveLeft();
  }
  if (richtung == 1) {
    moveRight();
  }
  if (richtung == 2) {
    moveUp();
  }
  if (richtung == 3) {
    moveDown();
  }
}

  void drawMonster () {
    fill(0);
    ellipse(x, y, r*2, r*2);
  }

//Ping Pong Code fuer die Waende
//boolean limitWalls(){
//  if y(y-r<0 && vY<0){
//  y=r;
//return true;
//}