public class Termite extends Pest {

  public Termite() { 
    super();
    HP = 1;
    dx = .2;
    dy = .2;
    size = 15;
  }

  void draw() {
    ellipse(xcor,ycor,size,size); //EVENTUALLY MAKE A PSHAPE
    color c = color( 0,255,0 );
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
