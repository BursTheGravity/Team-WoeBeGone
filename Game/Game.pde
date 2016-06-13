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
color red = color( 255,0,0 );

boolean _gameOver;
boolean _startGame;
boolean _holdingObstacle;
boolean _nextGame;
boolean _restart;
int _screen;
int _money;
int _level;
int _score;
Storage _storage;
Obstacle _currObstacle;
PShape _currShape;
ArrayList<Obstacle> _obstacles;
ArrayList<Pest> _pests;
ALQueue<Obstacle> _processor;
String _hint;
int bugsLeft;

void setup() {

  size(650, 800);
  homeScreen();

  //VARIABLES
  _screen = HOME;
  _money = 100;
  _level = 0;
  _score = 0;
  _storage = new Storage(25);
  _obstacles = new ArrayList<Obstacle>();
  _hint="Good Luck";
  _processor=new ALQueue<Obstacle>();
  _pests = new ArrayList<Pest>();
  textAlign(CENTER);

  bugsLeft = 10;
    
  for (int i = 0; i < bugsLeft; i++) 
    _pests.add(new Beetle()); 
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


//return true if obstacle and pest given are touching-- NOT SURE IF THIS WORKS RIGHT 
boolean isTouching(Obstacle o, Pest p) {
    if (abs(p.getX() - o.getX() - o.getWidth()/2)>o.getWidth()/2+p.getSize()/2){
      return false;
    }
    if (abs(p.getX() - o.getX() - o.getWidth()/2)>o.getHeight()/2+p.getSize()/2){
      return false;
    }
    if (abs(p.getX() - o.getX() - o.getWidth()/2)<=o.getWidth()/2){
      return true;
    }
    if (abs(p.getX() - o.getX() - o.getWidth()/2)<=o.getHeight()/2){
      return true;
    }
    float tmp=pow(p.getX()-o.getY()/2,2)+pow(p.getY()-o.getHeight()/2,2);
    return tmp<=pow(p.getSize()/2,2);
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
}


//Setting up game's help screen
void helpScreen() {
  background(0);
  textSize(30);
  fill(255);
  textAlign(CENTER);
  text("HELP",width/2,35);
  textSize(20);
  text("You are the victim of a pest infestation",width/2, 65);
  text("and your food is being eaten by the pests!",width/2,90);
  text("Click on the pests before they get to the white circle (the food).",width/2,115);
  text("Buy obstacles in the shop tab at the bottom to help stop them.",width/2,140);
  text("The obstacles that turn blue are walls.",width/2,165);
  text("They stop the pests until they break.",width/2,190);
  text("The obstacles that turn brown and explode are bombs.",width/2,215);
  text("They kill the pests in their range.",width/2,240);
  text("The bigger and more expensive the obstacle, the bigger the range.",width/2,265);
  text("If you kill all the pests before all the food is gone, you win!",width/2,290);
  text("Pests will have different sizes and speeds as you progress...",width/2,315);
  text("but you might not be able to tell which is which!",width/2,340);
  text("Some might need more than one click to kill!",width/2,365);
  textSize(30);
  text("CLICK if you're ready to begin!",width/2,410);
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
  textSize(20);
  text(_hint, 325, 600);
  
  //PRINT STORAGE
  if (_storage.draw() || bugsLeft <= 0) {
    text("GAME OVER",_storage.getX(), _storage.getY()); //nOT SURE WHY YOU WIN SOMETIMES BEFORE ALL THE BUGS ARE KILLED
    if (bugsLeft <= 0) {
        text("YOU WIN", _storage.getX(), _storage.getY()+50);
        if (_level < 6) {
          _nextGame = true;
          text("click for next round", _storage.getX(), _storage.getY()+80);
        }
    }
    else {
        _screen = END;
        text ("YOU LOSE", _storage.getX(), _storage.getY()+50);
        text("click to go back home",_storage.getX(), _storage.getY()+80);
    }
  }
  
  //SPAWN BUGS AND PROCESS STATES
  for (int i = 0; i < _pests.size(); i++) {
    _pests.get(i).draw();
    
    //if the pests are near or on the food, decrease food hp
    if (_pests.get(i).process(_storage.getSize()))
      _storage.lowerHP();
      
    //dealing with obstacles- if pests near, breaks it down
    for (int z = 0; z < _obstacles.size(); z++) {
        if (isTouching(_obstacles.get(z),_pests.get(i))) {
            _pests.get(i).moveBack(); //obstacles slows it down/stops it until it is destroyed
            _obstacles.get(z).lowerHP();
        }
    }
  }
  
  //PROCESSOR (PRIORITY QUEUE)
  if ( !_processor.isEmpty() ) {
    //Placing down all obstacles within the queue
    for ( int i = _processor.size(); i > 0 ; i-- ) {
      Obstacle temp = _processor.get(i);
      stroke(yellow);
      fill(red);
      rect(temp.xcor, temp.ycor, temp._width, temp._height);
    }
    //Dealing with first obstacle in queue
    Obstacle foo = _processor.peekFront();
    if ( foo.timer > 0 ) {
      foo.timer -= 1;
    }
    else if ( foo.timer == 0 ) {
      //obstacle ready
      foo.state = foo.ALIVE;
      
      //if bomb, explode
      if (foo.isBomb()) {
        for (int i = 0; i < _pests.size(); i++) { //auto-bomb radius is 30
          Pest x = _pests.get(i);
          if ((x.getSize() + 15) > (sqrt( sq(x.getX() - foo.getX())+sq(x.getY() - foo.getY())))) {
            x.setState(1);
          }
        }
        foo.explode();
        foo.setState(2);
      }
      
      //dequeue
      _obstacles.add( _processor.dequeue() );
    }
  }
  
  //OBSTACLES
  if ( !_obstacles.isEmpty() ) {
    for ( int i = 0; i < _obstacles.size(); i++ ) {
      Obstacle x = _obstacles.get(i);
      if ( x.isAlive() && x.state == x.ALIVE ) {
        stroke(yellow);
        
        if (x.isBomb())
          fill(90,57,2);
        else 
          fill(blue);
        
        rect(x.xcor, x.ycor, x._width, x._height);
      }
      else if ( !x.isAlive() ) {
        rect(x.xcor, x.ycor, 0, 0);
      }
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


//start the next wave based on level
void addPests() {
   if (_level == 1) {
      for (int i = 0; i < 10; i++) {
        _pests.add(new Beetle());
        if (i % 2 == 0) {
          _pests.add(new Termite());
        }
      }
    }
    else if (_level == 2) {
      for (int i = 0; i < 10; i++) {
        _pests.add(new Beetle());
        if (i % 2 == 0) {
          _pests.add(new Termite());
        }
        else {
          _pests.add(new Roach());
        }
      }
   }
   else if (_level == 3) {
      for (int i = 0; i < 15; i++) {
        _pests.add(new Beetle());
        if (i % 2 == 0) {
          _pests.add(new Termite());
        }
        else if (i % 3 == 0) {
          _pests.add(new Mouse());
        }
        else {
          _pests.add(new Roach());
        }
      }
   }
   else if (_level == 4) {
      for (int i = 0; i < 15; i++) {
        _pests.add(new Termite());
        if (i % 2 == 0) {
          _pests.add(new Beetle());
        }
        else if (i % 3 == 0) {
          _pests.add(new Roach());
        }
      }
   }
   else if (_level == 5) {
      for (int i = 0; i < 15; i++) {
        _pests.add(new Mouse());
        if (i % 2 == 0) {
          _pests.add(new Beetle());
        }
        else if (i % 3 == 0) {
          _pests.add(new Roach());
        }
      }
   }
   else if (_level == 6) {
      for (int i = 0; i < 15; i++) {
        _pests.add(new Mouse());
        if (i % 2 == 0) {
          _pests.add(new Beetle());
          _pests.add(new Termite());
        }
        else if (i % 3 == 0) {
          _pests.add(new Roach());
          _pests.add(new Ant());
        }
      }
   }
}


//reset all the variables to start the game again
void restart() {
   homeScreen();

  //VARIABLES
  _screen = HOME;
  _money = 100;
  _level = 0;
  _score = 0;
  _storage = new Storage(25);
  _obstacles = new ArrayList<Obstacle>();
  _hint="Good Luck";
  _processor=new ALQueue<Obstacle>();
  _pests = new ArrayList<Pest>();
  textAlign(CENTER);

  bugsLeft = 10;
    
  for (int i = 0; i < bugsLeft; i++) 
    _pests.add(new Beetle()); 
}


//what happens when you press the mouse!
void mousePressed() {

  //Home Screen
  if ( _screen == HOME ) {
    if (_restart == true) {
      _restart = false;
      restart();
    }

    if ( (mouseX > 250) && (mouseX < 375) && (mouseY > 250) && (mouseY < 300) ) {
      _startGame=true;
      _screen = PLAY;
    }
    else if ( (mouseX > 250) && (mouseX < 375) && (mouseY > 350) && (mouseY < 400) ) {
      _screen = HELP;
    }
  }
  else if ( _screen == HELP || _screen == END ) {
    _restart = true;
    _screen = HOME;
  }
  else if ( _screen == PLAY ) {

    //All functions using a mouse click within the game will go here:
    
    //start next level
    if (_nextGame == true) {
      _nextGame = false; //reset this boolean
      _level+=1; //increment level;
      _pests = new ArrayList(); //refresh arraylist
      addPests(); 
      bugsLeft = _pests.size(); //update how many to kill to win
    }
     
    //1. Killing Pests
    for (int i = 0; i < _pests.size(); i++) {
       if (abs(mouseX - _pests.get(i).getX()) < _pests.get(i).getSize() &&
           abs(mouseY - _pests.get(i).getY()) < _pests.get(i).getSize() && _pests.get(i).getState()==0) {
           _pests.get(i).lowerHP();
           _score++;
           if (_pests.get(i).getState()==1){
             bugsLeft--;
           }
           _money+=10;
       }
     }
     //2. Buying Obstacles
    if ( !_holdingObstacle ) {
      
      //Square-- *** BOMB *** 
      if ( _money >= 25 && mouseX > 30 && mouseX < 155 && mouseY > 650 && mouseY < 700 ) {
        _money -= 25;
        _holdingObstacle = true;
        _currShape = createShape(RECT, 0, 0, 25, 25);
        _currObstacle = new Obstacle(25,25,2,true);
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
        _hint="NOT ENOUGH MONEY (or you're not clicking on a store option)";
      }
    }
    //3. Setting down obstacles
    else if ( _holdingObstacle ) {
      if ((mouseX>125)&& (mouseX<525)&&(mouseY>100)&&(mouseY<500)) {
        _currObstacle.setX(mouseX);
        _currObstacle.setY(mouseY);
        _processor.enqueue(_currObstacle);
        _holdingObstacle = false;
      }
    }
    
  }
}