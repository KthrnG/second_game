class Intro {

  PImage introImage;

  Intro() {
     introImage = loadImage("images/intro.png");
  }

  void draw()  {
    imageMode(CORNER);
    image (introImage, 0, 0, 700, 700);
  }
}