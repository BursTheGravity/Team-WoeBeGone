//Team WoeBeGone -- Leo Au-Yeung, Jannie Li, Henry Zhang
//APCS2 pd9
//Final Project -- Pest Decimation
//Due Date: 2016-06-13

import java.util.Comparator;
import java.util.PriorityQueue;
//ints for _screen
final static int HOME = 0;
final static int HELP = 1;
final static int PLAY = 2;
final static int END = 3;
color yellow = color(255, 204, 0);
color purple = color(175, 100, 220);
color blue = color(20, 75, 200);

boolean _gameOver;
boolean _startGame;
boolean _holdingObstacle;
int _screen;
int _money;
int _level;
int _score;
Storage _storage;
Obstacle _currObstacle;
PShape _currShape;
ArrayList<Obstacle> _obstacles;
ArrayList<Pest> _pests;
PriorityQueue _processor;
String _hint;
int bugsLeft;
//queue ConstructionQueue;

void setup() {

  size(650, 800);
  homeScreen();

  //VARIABLES
  _startGame=false;
  _gameOver = false;
  _holdingObstacle = false;
  _screen = HOME;
  _money = 10000;
  _level = 0;
  _score = 0;
  _storage = new Storage(25);
  _obstacles = new ArrayList<Obstacle>();
  _hint="Good Luck";
  _processor=new PriorityQueue();
  _pests = new ArrayList<Pest>();
  textAlign(CENTER);

  /*BUG SPAWN RANGE: --- ***we're just doing the bug screen without side panes first***
   X-cor: randomly choose an x-cor from 75 to 525...
   if <100 or >525, then choose y-cor from 50 to 550
   else choose y-cor from either 50 to 75 or 525 to 550
   also-
   make the spawn range a different color?
   */
  //make bugs to add to queue
  bugsLeft = 10;
 
  if (_level == 1)
    bugsLeft = 20;
  else if (_level == 2)
    bugsLeft = 30;
    
  for (int i = 0; i < bugsLeft; i++) 
    _pests.add(new Beetle()); //ADD DIFF BUGS IN DIFF PROPORTIONS DEPENDING ON LEVEL
}

void draw() {

  if ( _screen == HOME ) {
    homeScreen();
  }
  else if ( _screen == HELP ) {
    helpScreen();
  }
  else if ( _screen == PLAY ) {

    gameScreen();

    //Obstacle following mouse cursor
    if ( _holdingObstacle ) {
      stroke(yellow);
      fill(blue);
      shape(_currShape, mouseX, mouseY);
    }
    
  }
  else if ( _screen == END ) {
    _gameOver = true;
  }
}

//Setting up game's home screen
void homeScreen() {
  background(0);
  stroke(255); //to avoid border intersection
  fill(255); //makes it grey
  rect(75, 50, 50, 500);
  rect(525, 50, 50, 500);
  rect(75, 50, 500, 50);
  rect(75, 500, 500, 50);

  textSize(40);

  fill(255);
  text("PEST DECIMATION ", 330, 200);

  fill(255);
  rect(250, 250, 125, 50);
  fill(0);
  text ("PLAY", 310, 289);

  fill(255);
  rect(250, 350, 125, 50);
  fill(0);
  text ("HELP", 310, 389);

  //Credits ?? Later
}

//Setting up game's help screen
void helpScreen() {
  background(0);
  textSize(30);
  fill(255);
  textAlign(CENTER);
  text("HELP",width/2,35);
  textSize(20);
  text("You are the victim of a pest infestation",width/2, 60);
  text("and your food is being eaten by the pests!",width/2,85);
  text("Click on the pests before they get to the white circle (the food).",width/2,110);
  text("<ADD OBSTACLE INFO HERE>",width/2,135);
  text("If you kill them all before all the food is gone, you win!",width/2,160);
  text("If you kill two or three or more at the same time...",width/2,185);
  text("you'll get more points!",width/2,210);
}

//Setting up game's screen
void gameScreen() {
  background(0);
  stroke(255);
  fill(255);

  //Spawn platforms
  rect(75, 50, 50, 500);
  rect(525, 50, 50, 500);
  rect(75, 50, 500, 50);
  rect(75, 500, 500, 50);

  //Information
  textSize(30);
  text("LVL: "+_level, 275, 35);
  text("$"+_money, 125, 35);
  text("Score: "+_score, 425, 35);
  
  //Hint
  fill(150);
  rect(0, 560, 650, 65);
  fill(255);
  textSize(32);
  text(_hint, 325, 600);
  
  //PRINT STORAGE
  if (_storage.draw() || bugsLeft <= 0) {
    text("GAME OVER",_storage.getX(), _storage.getY());
    _screen = END;
    if (bugsLeft <= 0)
        text("YOU WIN", _storage.getX(), _storage.getY()+50);
    else
        text ("YOU LOSE", _storage.getX(), _storage.getY()+50);
  }
  
  //SPAWN BUGS AND PROCESS STATES
  for (int i = 0; i < _pests.size(); i++) {
    _pests.get(i).move();
  }
  for (int i = 0; i < _pests.size(); i++) {
    _pests.get(i).draw();
    if (_pests.get(i).process(_storage.getSize()))
      _storage.lowerHP();
  }
  
  //OBSTACLES
  if ( !_obstacles.isEmpty() ) {
    for ( int i = 0; i < _obstacles.size(); i++ ) {
      Obstacle x = _obstacles.get(i);
      stroke(yellow);
      fill(blue);
      rect(x.xcor, x.ycor, x._width, x._height);
      stroke(255);
      fill(255);
    }
  }

  //STORE
  displayShop();
  
}

void displayShop() {
  
  stroke(200);
  fill(200);
  
  //RECTANGLES FOR ICONS
  
  //Square
  rect(30, 650, 125, 50);
  //Small Rectangle (H)
  rect(185, 650, 125, 50);
  //Medium Rectangle (H)
  rect(340, 650, 125, 50);
  //Large Rectangle (H)
  rect(495, 650, 125, 50);
  //Small Rectangle (V)
  rect(30, 725, 125, 50);
  //Medium Rectangle (V)
  rect(185, 725, 125, 50);
  //Large Rectangle (V)
  rect(340, 725, 125, 50);
  //??
  rect(495, 725, 125, 50);
  
  textSize(20);
  stroke(yellow);
  
  //Square
  fill(0);
  text("$25:", 65, 685);
  fill(blue);
  rect(100, 665, 25, 25);
  //Small Rectangle (H)
  fill(0);
  text("$50:", 220, 685);
  fill(blue);
  rect(255, 665, 35, 25);
  //Medium Rectangle (H)
  fill(0);
  text("$75:", 375, 685);
  fill(blue);
  rect(410, 665, 43, 25);
  //Large Rectangle (H)
  fill(0);
  text("$100:", 530, 685);
  fill(blue);
  rect(565, 665, 50, 25);
  //Small Rectangle (V)
  fill(0);
  text("$50:", 65, 760);
  fill(blue);
  rect(100, 740, 35, 25);
  //Medium Rectangle (V)
  fill(0);
  text("$75:", 220, 760);
  fill(blue);
  rect(255, 740, 43, 25);
  //Large Rectangle (V)
  fill(0);
  text("$100:", 375, 760);
  fill(blue);
  rect(410, 740, 50, 25);
  
  textSize(40);
}

void mousePressed() {

  //Home Screen
  if ( _screen == HOME ) {

    if ( (mouseX > 250) && (mouseX < 375) && (mouseY > 250) && (mouseY < 300) ) {
      _startGame=true;
      _screen = PLAY;
    }
    else if ( (mouseX > 250) && (mouseX < 375) && (mouseY > 350) && (mouseY < 400) ) {
      _screen = HELP;
    }
  }
  else if ( _screen == HELP ) {
    //Display help screen
    //Create a button somewhere to go BACK
  }
  else if ( _screen == PLAY ) {

    //All functions using a mouse click within the game will go here:
    //1. Killing Pests
    for (int i = 0; i < _pests.size(); i++) {
       if (abs(mouseX - _pests.get(i).getX()) < 15 && //RANGE SHOULD DEPEND ON SIZE
           abs(mouseY - _pests.get(i).getY()) < 15 && _pests.get(i).getState()==0) {
           _pests.get(i).lowerHP();
           _score++;
           bugsLeft--;
       }
     }
     //2. Buying Obstacles
    if ( !_holdingObstacle ) {
      
      //Square
      if ( _money >= 25 && mouseX > 30 && mouseX < 155 && mouseY > 650 && mouseY < 700 ) {
        _money -= 25;
        _holdingObstacle = true;
        _currShape = createShape(RECT, 0, 0, 25, 25);
        _currObstacle = new Obstacle(25, 25, 1);
      }
      //Small Rectangle (H)
      else if ( _money >= 50 && mouseX > 185 && mouseX < 310 && mouseY > 650 && mouseY < 700 ) {
        _money -= 50;
        _holdingObstacle = true;
        _currShape = createShape(RECT, 0, 0, 40, 25);
        _currObstacle = new Obstacle(40, 25, 2);
      }
      //Medium Rectangle (H)
      else if ( _money >= 75 && mouseX > 340 && mouseX < 465 && mouseY > 650 && mouseY < 700 ) {
        _money -= 75;
        _holdingObstacle = true;
        _currShape = createShape(RECT, 0, 0, 55, 25);
        _currObstacle = new Obstacle(55, 25, 3);
      }
      //Large Rectangle (H)
      else if ( _money >= 100 && mouseX > 495 && mouseX < 620 && mouseY > 650 && mouseY < 700 ) {
        _money -= 100;
        _holdingObstacle = true;
        _currShape = createShape(RECT, 0, 0, 70, 25);
        _currObstacle = new Obstacle(70, 25, 4);
      }
      //Small Rectangle (V)
      if ( _money >= 50 && mouseX > 30 && mouseX < 155 && mouseY > 725 && mouseY < 775 ) {
        _money -= 50;
        _holdingObstacle = true;
        _currShape = createShape(RECT, 0, 0, 25, 40);
        _currObstacle = new Obstacle(25, 40, 2);
      }
      //Medium Rectangle (V)
      else if ( _money >= 75 && mouseX > 185 && mouseX < 310 && mouseY > 725 && mouseY < 775 ) {
        _money -= 75;
        _holdingObstacle = true;
        _currShape = createShape(RECT, 0, 0, 25, 55);
        _currObstacle = new Obstacle(25, 55, 3);
      }
      //Large Rectangle (V)
      else if ( _money >= 100 && mouseX > 340 && mouseX < 465 && mouseY > 725 && mouseY < 775 ) {
        _money -= 100;
        _holdingObstacle = true;
        _currShape = createShape(RECT, 0, 0, 25, 70);
        _currObstacle = new Obstacle(25, 70, 1);
      }
      
      else {
        _hint="NOT ENOUGH MONEY!";
      }
    }
    //3. Setting down obstacles
    else if ( _holdingObstacle ) {
      if ((mouseX>125)&& (mouseX<525)&&(mouseY>100)&&(mouseY<500)) {
        _currObstacle.setX(mouseX);
        _currObstacle.setY(mouseY);
        _obstacles.add(_currObstacle);
        _holdingObstacle = false;
      }
    }
    
  }
}