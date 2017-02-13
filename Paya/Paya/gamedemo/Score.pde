
// Variables Score
int numberdiamant = 200;
ArrayList<Score> score = new ArrayList();
float radius = 15;
int point = 0;
// x und y Werte fuer die Ellipse Diamanten
float ex = 500;
float ey = 350;

class Score {
  int dx, dy;
  Score (int dx, int dy) {
    this.dx = dx;
    this.dy = dy;
  }
}

  void ScoreTile() {
    ellipseMode(RADIUS);
    for (int i = 0; i < numberdiamant; i++) {
      Score S = new Score((int)random(width), (int)random(height));
      score.add(S);
    }
  }

  void drawScore() {
    noStroke();
    fill (0, 0, 255);
    ellipse(ex, ey, 100, 100);
    textAlign(CENTER);
    textSize(40);
    fill(0, 0, 255);
    text("score " + point, width/2, 30);
    fill (0, 175, 255);
    // smooth ();
    noStroke();
    for (int i=0; i<score.size(); i++) {
      Score Sc = (Score) score.get(i);
      if (dist(x, y, Sc.dx, Sc.dy)<radius) { // checking if Pacman is over the point 
        score.remove(i);
        point = point+1; // numbers of point has been eaten
      }
    }
  }