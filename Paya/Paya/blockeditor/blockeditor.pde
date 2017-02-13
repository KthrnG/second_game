import java.io.*;

// Filename of the map currently edited
// If you insert a filename here it will be automatically loaded upon startup
// Maybe you need to use \\ (not \) instead of / for Windows?
String mapname="../gamedemo/demo.map";
// The map currently edited
Map map;


// x and y index of the block shown at 0,0 on the screen
int leftBlock, topBlock;
// current level element
int cursorX, cursorY;

void openMap (String newMapName)
{
  mapname = newMapName;
  Map newMap=null;
  if (mapname!=null && !mapname.equals("")) newMap = new Map(mapname);
  if (newMap!=null) {
    map = newMap;
    leftBlock = topBlock = cursorX  = cursorY = 0;
  }
}

void openMapCallback(File newMapName)
{
  if (newMapName==null) return;
  openMap (newMapName.getAbsolutePath());
}
// opens a new map with a file input dialog
void openMap() {
  selectInput ("Open block-level map file", "openMapCallback");
}

// saves the current map into a new file
void saveAsMap() {
  selectOutput ("Save block-level map file as", "saveMapAsCallback");
}

void saveMapAsCallback (File newMapname) {
   if (newMapname==null) return;
   mapname=newMapname.getAbsolutePath();
   if (mapname!=null) map.saveFile (mapname);
}

// saves the current map to the current file
void saveMap () {
  if (mapname==null) saveAsMap();
  else map.saveFile (mapname);
}

void newMapCallback (File newMapname) {
  if (newMapname==null) return;
  mapname = newMapname.getAbsolutePath();
  if (mapname==null || mapname.equals("")) exit();
  else {
    String[] emptyMapAsStrings = {
      "_"
    };
    saveStrings (mapname, emptyMapAsStrings);
    map = new Map (mapname);
  }
}

void newMap() {
    selectOutput ("Save new block-level map file as","newMapCallback");
}

void setup()
{
  size( 1024, 800 );
  openMap (mapname);     
}

void keyPressed () {
  if (key==14) newMap(); // CTRL-N
  else if (key==15) openMap(); // CTRL-O
  if (map!=null) {
    if (keyCode==LEFT) cursorX--;
    else if (keyCode==RIGHT) cursorX++;
    else if (keyCode==UP) cursorY--;
    else if (keyCode==DOWN) cursorY++;
    else if (key==' ' || key=='_' || ('A'<=key && key<='Z')) map.set (cursorX, cursorY, key);
    else if ('a'<=key && key<='z') map.set (cursorX, cursorY, char('A'+(key-'a')));
    else if (key==19) saveMap(); // CTRL-S
    else if (key==1) saveAsMap(); // CTRL-A
    else println ("key="+key+" "+int(key));

    // No negative indices  
    if (cursorX<0) cursorX=0;
    if (cursorY<0) cursorY=0;

    // Scroll with cursor
    int scrollStep=3;
    if (cursorX-scrollStep<leftBlock) leftBlock=cursorX-scrollStep;
    if (cursorX-width/map.tileSize+scrollStep>leftBlock) leftBlock=cursorX-width/map.tileSize+scrollStep;
    if (cursorY-scrollStep<topBlock) topBlock=cursorY-scrollStep;
    if (cursorY-height/map.tileSize+scrollStep>topBlock) topBlock=cursorY-height/map.tileSize+scrollStep;

    if (leftBlock<0) leftBlock=0;
    if (topBlock<0) topBlock=0;
  }
}

void drawCursor () {
  stroke (255);
  fill (0,0,0,128);
  if (map!=null) rect ((cursorX-leftBlock)*map.tileSize, (cursorY-topBlock)*map.tileSize, map.tileSize, map.tileSize);
}

void drawTextInfo () {
  fill (255);
  textSize (12);
  textAlign (LEFT, TOP);
  if (map!=null) text ("New CTRL-N   Open CTRL-O   Save CTRL-S   Save as CTRL-A\n"+
    "("+cursorX+"/"+cursorY+") ["+map.at(cursorX, cursorY)+"] "+mapname, 0,0 );
  else text ("New CTRL-N   Open CTRL-O", 0,0 );
}

void draw () {
  background (128);
  if (map!=null) map.draw (-leftBlock*map.tileSize, -topBlock*map.tileSize);  
  drawTextInfo();
  drawCursor ();
}

