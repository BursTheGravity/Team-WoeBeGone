public class Beetle extends Pest {

  public Beetle() { 
    super();
    HP = 1;
    dx = .2;
    dy = .2;
    size = 20;
  }

  void draw() {
    ellipse(xcor,ycor,size,size);
    color c = color( 255,0,0 );
    fill(c);
  }
}