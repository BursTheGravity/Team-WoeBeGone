public class Roach extends Pest {

  public Roach() { 
    super();
    HP = 2;
    speed = .4;
    size = 20;
  }

  void draw() {
    ellipse(xcor,ycor,size,size);
    color c = color( 0,0,255 );
    fill(c);
  }
}