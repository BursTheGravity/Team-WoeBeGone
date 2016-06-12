public class Ant extends Pest {

  public Ant() { 
    super();
    HP = 1;
    speed = .3;
    size = 10;
  }

  void draw() {
    ellipse(xcor,ycor,size,size);
    color c = color( 136,27,219 );
    fill(c);
  }
}