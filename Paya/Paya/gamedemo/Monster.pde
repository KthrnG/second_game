class Monster {
  int x;
  int y;
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