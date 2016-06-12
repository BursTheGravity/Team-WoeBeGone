public class Mouse extends Pest {

  public Mouse() { 
    super();
    HP = 4;
    speed = .3;
    size = 30;
  }

  void draw() {
    ellipse(xcor,ycor,size,size);
    color c = color( 120,120,120 );
    fill(c);
  }
}