class Intro {

  PImage introImage;

  Intro() {
     introImage = loadImage("images/intro.png");
  }

  void draw()  {
    imageMode(CORNER);
    image (introImage, 500, 500);
  }
}