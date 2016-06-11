public class Beetle extends Pest {

  public Beetle() { 
    super();
    HP = 1;
    dx = (int)random(2);
    dy = (int)random(2);
    size = 20;
  }

  void draw() {
    ellipse(xcor,ycor,size,size);
    color c = color( 255,0,0 );
    fill(c);
  }

  void move() {
    int randX = (int)random(2);
    int randY = (int)random(2);
    
    if (randX == 0)
      randX = -1;
    else 
      randX = 1;
    
    if (randY == 0)
      randY = -1;
    else 
      randY = 1;
      
    if (state == ALIVE) {
      xcor += dx; //add wiggle?
      ycor += dy;
      bounce();   
    }
  }
  
  void attack() {}
    //if in its range-- each pest has diff range-- eat food
}