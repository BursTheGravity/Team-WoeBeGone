public class Ant extends Pest {

  public Ant() { 
    super();
    HP = 1;
    dx = .3;
    dy = .3;
    size = 10;
  }

  void draw() {
    ellipse(xcor,ycor,size,size); //EVENTUALLY MAKE A PSHAPE
    color c = color( 136,27,219 );
    fill(c);
  }
}