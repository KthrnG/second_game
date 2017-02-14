class Background {
  PImage backgroundImg;

  Background() {
    backgroundImg = loadImage ("images/background.jpg");
  }

  void draw() {
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

  // Maps x to an output y = map(x,xRef,yRef,factor), such that
  //     - x0 is mapped to y0
  //     - increasing x by 1 increases y by factor
  float map (float x, float xRef, float yRef, float factor) {
    return factor*(x-xRef)+yRef;
  }
}