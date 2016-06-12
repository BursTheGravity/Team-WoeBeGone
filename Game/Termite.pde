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
}