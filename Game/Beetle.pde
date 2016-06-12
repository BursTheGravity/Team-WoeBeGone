public class Beetle extends Pest {

  public Beetle() { 
    super();
    HP = 1;
    dx = .1;
    dy = .1;
    size = 20;
  }

  void draw() {
    ellipse(xcor,ycor,size,size); //EVENTUALLY MAKE A PSHAPE
    color c = color( 255,0,0 );
    fill(c);
  }
}