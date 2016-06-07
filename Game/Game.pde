boolean _gameOver;
int _money;
int _level;
//queue ConstructionQueue;


void setup() {
  size(500,500);
  _gameOver = false;
  _money = 0;
  _level = 0;
  /*BUG SPAWN RANGE: --- ***we're just doing the bug screen without side panes first***
  X-cor: randomly choose an x-cor from 75 to 525...
  if <100 or >525, then choose y-cor from 50 to 550
  else choose y-cor from either 50 to 75 or 525 to 550
  also-
  make the spawn range a different color?
  */
  //make bugs to add to queue
}

void draw() {
  background(0,0,0); //refresh background;
  //show bugs
  //have them move, etc.
}

void mousePressed() {
  //if same xcor and ycor as bug, decrease hp
}