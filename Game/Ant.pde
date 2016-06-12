public class Ant extends Pest {

  public Ant() { 
    super();
    HP = 1;
    dx = .1;
    dy = .1;
    size = 10;
  }

  void draw() {
    ellipse(xcor,ycor,size,size); //EVENTUALLY MAKE A PSHAPE
    color c = color( 136,27,219 );
    fill(c);
  }
}