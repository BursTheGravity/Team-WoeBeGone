public class Roach extends Pest {

  public Roach() { 
    super();
    HP = 2;
    dx = .1;
    dy = .1;
    size = 20;
  }

  void draw() {
    ellipse(xcor,ycor,size,size); //EVENTUALLY MAKE A PSHAPE
    color c = color( 0,0,255 );
    fill(c);
  }

  void move() {    
    //need to make it approach the food
    if (state == ALIVE) {
      if (xcor < 313)
        xcor += dx;
      else 
        xcor -= dx;
      if (ycor < 300)
        ycor += dy;
      else
        ycor -= dy;
    }
  }
}
