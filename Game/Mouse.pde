public class Mouse extends Pest {

  public Mouse() { 
    super();
    HP = 4;
    dx = .3;
    dy = .3;
    size = 30;
  }

  void draw() {
    ellipse(xcor,ycor,size,size); //EVENTUALLY MAKE A PSHAPE
    color c = color( 120,120,120 );
    fill(c);
  }
}