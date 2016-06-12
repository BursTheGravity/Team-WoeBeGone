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
}