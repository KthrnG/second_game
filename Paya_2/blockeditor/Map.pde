class Map
{  
  int mode = CORNER;


  // Constructor: tmptileSize is the width/height of one tile in pixel
  Map( int tmptileSize ) {
    tileSize = tmptileSize;
    images = new PImage[26];
  }

  // Constructor: Loads a map file
  Map( String mapFile ) {
    images = new PImage[26];
    loadFile( mapFile );
  }

  //! Sets the mode in which coordinates are specified, supported is CORNER, CENTER, CORNERS
  void mode (int tmpMode) { 
    mode=tmpMode;
  }


  int widthPixel() {
    return w * tileSize;
  }

  int heightPixel() {
    return h * tileSize;
  }

  // Left border (pixel) of the tile at tile position x
  int leftOfTile(int x) {
    return x * tileSize;
  }

  // Right border (pixel) of the tile at tile position x
  int rightOfTile(int x) {
    return (x+1) * tileSize-1;
  }

  // Top border (pixel) of the tile at tile position y
  int topOfTile(int y) {
    return y * tileSize;
  }

  // Bottom border (pixel) of the tile at tile position y
  int bottomOfTile(int y) {
    return (y+1) * tileSize-1;
  }

  //! Center of the tile at tile position x
  int centerXOfTile (int x) {
    return x*tileSize+tileSize/2;
  }

  //! Center of the tile at tile position x
  int centerYOfTile (int y) {
    return y*tileSize+tileSize/2;
  }

  // Returns the tile at tile position x,y. '_' for invalid positions (out of range)
  char at( int x, int y ) {
    if ( x < 0 || y < 0 || x >= w || y >= h )
      return '_';
    else
      return map[y].charAt(x);
  }

  // Returns the tile at pixel position 'x,y', '_' for invalid
  char atPixel (float x, float y) {
    return at (floor(x/tileSize), floor(y/tileSize));
  }

  // Sets the tile at tile position x,y
  // Coordinates below 0 are ignored, for coordinates
  // beyond the map border, the map is extended
  void set (int x, int y, char ch) {
    if ( x < 0 || y < 0 ) return;
    extend (x+1, y+1);
    map[y] = replace (map[y], x, ch);
  }

  // Sets the tile at image position 'x,y' see set
  void setPixel (int x, int y, char ch) {
    set (x/tileSize, y/tileSize, ch);
  }


  // Reference to a tile in the map  
  class TileReference {
    // Position in the map in tiles
    int x, y;
    // Position in the map in pixels
    // This position definitely belong to the tile (x,y)
    // where it is on the tile depents on the function returning this reference
    float xPixel, yPixel;
    // Type of the tile
    char tile;
    // Border of that tile in pixel
    int left, right, top, bottom;
    // Center of that tile in pixel
    int centerX, centerY;

    // Creates a reference to the tile at (x,y)
    // all other components are taken from the map
    TileReference (int tmpX, int tmpY) {
      x = tmpX;
      y = tmpY;
      setBorders();
      xPixel = centerX;
      yPixel = centerY;
    }

    // Computes tile, left, right, top, bottom, centerX, centerY from referenced tile
    void setBorders() {
      tile = at(x, y);
      left = leftOfTile(x);
      right = rightOfTile(x);
      top = topOfTile(y);
      bottom = bottomOfTile(y);
      centerX =  centerXOfTile(x);
      centerY = centerYOfTile(y);
    }


    // Consider the line xPixel, yPixel towards goalX, goalY.
    // This line must start in tile x, y.
    // Then advanceTowards follows this line until it leaves x, y
    // updating xPixel,yPixel with the point where it leaves
    // and the rest with the tile it enters.
    void advanceTowards (float goalX, float goalY)
    {
      float dX = goalX-xPixel;
      float dY = goalY-yPixel;
      // First try to go x until next tile
      float lambdaToNextX = Float.POSITIVE_INFINITY;
      if (dX>0) {
        float nextX = (x+1)*tileSize;
        lambdaToNextX = (nextX-xPixel)/dX;
      }   
      else if (dX<0) {
        float nextX = x*tileSize;
        lambdaToNextX = (nextX-xPixel)/dX;
      }
      // Then try to go y until next tile
      float lambdaToNextY = Float.POSITIVE_INFINITY;
      if (dY>0) {
        float nextY = (y+1)*tileSize;
        lambdaToNextY = (nextY-yPixel)/dY;
      }   
      else if (dY<0) {
        float nextY = y*tileSize;
        lambdaToNextY = (nextY-yPixel)/dY;
      }
      // Then choose which comes first x, y or goal
      if (lambdaToNextX<lambdaToNextY && lambdaToNextX<1) { // Go x
        xPixel += dX*lambdaToNextX;
        yPixel += dY*lambdaToNextX;
        if (dX>0) x++;
        else x--;
      }
      else if (lambdaToNextY<=lambdaToNextX && lambdaToNextY<1) { // Go y
        xPixel += dX*lambdaToNextY;
        yPixel += dY*lambdaToNextY;
        if (dY>0) y++;
        else y--;
      }
      else {// reached goal in same cell
        xPixel = goalX;
        yPixel = goalY;
      }
    }
  };
  
    // Returns a reference to a given pixel and its tile
    TileReference newRefOfPixel (float pixelX, float pixelY) {
      TileReference ref = new TileReference (floor(pixelX/tileSize), floor(pixelY/tileSize));
      ref.xPixel = pixelX;
      ref.yPixel = pixelY;
      return ref;
    }


  // True if the rectangle given by x, y, w, h (partially) contains an element with a tile
  // from list. The meaning of x,y,w,h is governed by mode (CORNER, CENTER, CORNERS.
  boolean testTileInRect( float x, float y, float w, float h, String list ) {
    if (mode==CENTER) {
      x-=w/2;
      y-=w/2;
    }
    if (mode==CORNERS) {
      w=w-x;
      h=h-y;
    }
    int startX = floor(x / tileSize), 
    startY = floor(y / tileSize), 
    endX   = floor((x+w) / tileSize), 
    endY   = floor((y+h) / tileSize);

    for ( int xx = startX; xx <= endX; ++xx )
    {
      for ( int yy = startY; yy <= endY; ++yy )
      {
        if ( list.indexOf( at(xx, yy) ) != -1 )
          return true;
      }
    }
    return false;
  }

  // Like testtileInRect(...) but returns a reference to the tile if one is found
  // and null else. The meaning of x,y,w,h is governed by mode (CORNER, CENTER, CORNERS.
  TileReference findTileInRect( float x, float y, float w, float h, String list ) {
    if (mode==CENTER) {
      x-=w/2;
      y-=w/2;
    }
    if (mode==CORNERS) {
      w=w-x;
      h=h-y;
    }
    int startX = floor(x / tileSize), 
    startY = floor(y / tileSize), 
    endX   = floor((x+w) / tileSize), 
    endY   = floor((y+h) / tileSize);

    for ( int xx = startX; xx <= endX; ++xx )
    {
      for ( int yy = startY; yy <= endY; ++yy )
      {
        if ( list.indexOf( at(xx, yy) ) != -1 )
          return new TileReference(xx, yy);
      }
    }
    return null;
  }

  // Like findTileInRect(...) but returns a reference to the tile closest to the center
  TileReference findClosestTileInRect( float x, float y, float w, float h, String list ) {
    if (mode==CENTER) {
      x-=w/2;
      y-=w/2;
    }
    if (mode==CORNERS) {
      w=w-x;
      h=h-y;
    }
    float centerX=x+w/2, centerY=y+h/2;
    int startX = floor(x / tileSize), 
    startY = floor(y / tileSize), 
    endX   = floor((x+w) / tileSize), 
    endY   = floor((y+h) / tileSize);

    int xFound=-1, yFound=-1;
    float dFound = Float.POSITIVE_INFINITY;
    for ( int xx = startX; xx <= endX; ++xx )
    {
      for ( int yy = startY; yy <= endY; ++yy )
      {
        if ( list.indexOf( at(xx, yy) ) != -1 ) {
          float d = dist(centerXOfTile(xx), centerYOfTile(yy), centerX, centerY);
          if (d<dFound) {
            dFound = d;
            xFound = xx;
            yFound = yy;
          }
        }
      }
    }
    if (dFound<Float.POSITIVE_INFINITY) return new TileReference (xFound, yFound);
    else return null;
  }

  // True if the rectangle is completely inside tiles from the list
  //The meaning of x,y,w,h is governed by mode (CORNER, CENTER, CORNERS.
  boolean testTileFullyInsideRect( float x, float y, float w, float h, String list ) {
    if (mode==CENTER) {
      x-=w/2;
      y-=w/2;
    }
    if (mode==CORNERS) {
      w=w-x;
      h=h-y;
    }
    float centerX=x+w/2, centerY=y+h/2;
    int startX = floor(x / tileSize), 
    startY = floor(y / tileSize), 
    endX   = floor((x+w) / tileSize), 
    endY   = floor((y+h) / tileSize);

    for ( int xx = startX; xx <= endX; ++xx ) {
      for ( int yy = startY; yy <= endY; ++yy ) {
        if ( list.indexOf( at(xx, yy) ) == -1 ) return false;
      }
    }
    return true;
  }


  // Searches along the line from x1,y1 to x2,y2 for a tile from list
  // Returns the first found or null if none.
  TileReference findTileOnLine( float x1, float y1, float x2, float y2, String list ) {
    TileReference ref = newRefOfPixel (x1, y1);
    int ctr=0;
    int maxCtr = floor(abs(x1-x2)+abs(y1-y2))/tileSize+3;
    while (ctr<=maxCtr && (ref.xPixel!=x2 || ref.yPixel!=y2)) {
      if (ctr>0) ref.advanceTowards (x2, y2);
      if (list.indexOf(at(ref.x, ref.y))!=-1) {
        ref.setBorders (); 
        return ref;
      }
      ctr++;
    }
    if (ctr>maxCtr) println ("Internal error in Map:findTileOnLine");
    return null;
  }

  // Returns, whether on the line from x1,y1 to x2,y2 there is a tile from list
  boolean testTileOnLine ( float x1, float y1, float x2, float y2, String list ) {
    return findTileOnLine (x1, y1, x2, y2, list)!=null;
  }

  // Draws the map on the screen, where the origin, i.e. left/upper
  // corner of the map is drawn at \c leftX, topY regardless of mode
  void draw( float leftX, float topY ) {
    pushStyle();
    imageMode(CORNER);
    int startX = floor(-leftX / tileSize), 
    startY = floor(-topY / tileSize);
    for ( int y = startY; y < startY + height/tileSize + 2; ++y ) {
      for ( int x  = startX; x < startX + width/tileSize + 2; ++x ) {
        PImage img = null;
        char tile = at( x, y );
        if ( tile == '_' )
          img = outsideImage;
        else if ('A'<=tile && tile<='Z')
          img = images[at( x, y ) - 'A'];
        if ( img != null )
          image( img, 
          x*tileSize + leftX, 
          y*tileSize + topY, 
          tileSize, tileSize );
      }
    }
    popStyle();
  } 

  // Loads a map file
  // element size is obtained from the first image loaded
  void loadFile( String mapFile ) {
    map = loadStrings( mapFile );
    if (map==null) 
      throw new Error ("Map "+mapFile+" not found.");
    while (map.length>0 && map[map.length-1].equals (""))
      map = shorten(map);
    h = map.length;
    if ( h == 0 ) 
      throw new Error("Map has zero size");
    w = map[0].length();

    // Load images
    for (char c='A'; c<='Z'; c++) 
      images[c - 'A'] = loadImageRelativeToMap (mapFile, c + ".png" );        
    outsideImage = loadImageRelativeToMap (mapFile, "_.png");

    for ( int y = 0; y < h; ++y ) {
      String line = map[y];
      if ( line.length() != w )
        throw new Error("Not every line in map of same length");

      for ( int x = 0; x < line.length(); ++x ) {
        char c = line.charAt(x);
        if (c==' ' || c=='_') {
        }
        else if ('A'<=c && c<='Z') {
          if (images[c - 'A'] == null) 
            throw new Error ("Image for "+c+".png missing");
        }
        else throw new Error("map must only contain A-Z, space or _");
      }
    }    

    determinetileSize ();
  }

  // Saves the map into a file
  void saveFile (String mapFile) {
    saveStrings (mapFile, map);
  }


  //********************************************************************************************
  //********* The code below this line is just for internal use of the library *****************
  //********************************************************************************************

  // Internal: load and Image and return null if not found
  protected PImage tryLoadImage (String imageFilename) {
    //println("Trying "+imageFilename);
    if (createInput(imageFilename)!=null) {
      //println("Found");
      return loadImage (imageFilename);
    }
    else return null;
  }

  // Internal: Loads an image named imageName from a locatation relative
  // to the map file mapFile. It must be either in the same
  // directory, or in a subdirectory images, or in a parallel
  // directory images.
  protected PImage loadImageRelativeToMap (String mapFile, String imageName) {
    File base = new File(mapFile);
    File parent = base.getParentFile();
    PImage img;
    img = tryLoadImage (new File (parent, imageName).getPath());
    if (img!=null) return img;
    img = tryLoadImage (new File (parent, "images/"+imageName).getPath());
    if (img!=null) return img;
    img = tryLoadImage (new File (parent, "../images/"+imageName).getPath());
    return img;
  }

  // Goes through all images loaded and determine stileSize as amx
  // If image sizes are not square and equal a warning message is printed
  protected void determinetileSize () {
    tileSize = 0;
    PImage[] allImages = (PImage[]) append (images, outsideImage);
    for (int i=0; i<allImages.length; i++) if (allImages[i]!=null) {
      if (tileSize>0 && 
        (allImages[i].width!=tileSize || allImages[i].height!=tileSize))
        println ("WARNING: Images are not square and of same size");
      if (allImages[i].width>tileSize)  tileSize = allImages[i].width;
      if (allImages[i].height>tileSize) tileSize = allImages[i].height;
    }
    if (tileSize==0) throw new Error ("No image could be loaded.");
  }

  // If the dimension of the map is below width times height
  // _ are appended in each line and full lines are appended
  // such that it is width times height.
  protected void extend (int width, int height) {
    while (height>h) {
      map = append(map, "");
      h++;
    }
    if (w<width) w = width;
    for (int y=0; y<h; y++) {
      while (map[y].length ()<w) 
        map[y] = map[y] + "_";
    }
  }

  // Replaces s.charAt(index) with ch
  String replace (String s, int index, char ch) {
    return s.substring(0, index)+ch+s.substring(index+1, s.length());
  }


  // *** variables ***
  // tile x, y is map[y].charAt(x)
  String map[];
  // images[c-'A'] is the image for tile c
  PImage images[];
  // special image drawn outside the map
  PImage outsideImage;
  // map dimensions in tiles
  int w, h;
  // width and height of an element in pixels
  int tileSize;
}

