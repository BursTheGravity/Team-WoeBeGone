public class Termite extends Pest {

  public Termite() { 
    super();
    HP = 1;
    dx = .6;
    dy = .6;
    size = 15;
  }

  void draw() {
    ellipse(xcor,ycor,size,size);
    color c = color( 0,255,0 );
    fill(c);
  }
}