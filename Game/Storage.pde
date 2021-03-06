public class Storage {

  static final int ALIVE = 0;
  static final int DEAD = 1;
  private int HP, xcor, ycor, size, state;

  public Storage() {
    HP = 5000;
    xcor = 313;
    ycor = 300;
    size = 25;
  }

  public Storage(int hp) {
    this();
    HP = hp;
  }

  //Accessors
  public int getHP() { return HP; }
  public int getX() { return xcor; }
  public int getY() { return ycor; }
  public int getSize() { return size; }

  //Mutators
  public void setHP ( int i ) { HP = i; }
  public void setX ( int i ) { xcor = i; }
  public void setY ( int i ) { ycor = i; }
  public void setSize ( int i ) { size = i; }

  public boolean isEmpty() { return HP > 0; }
  public void lowerHP() { 
    HP -= 1;
    if (HP <= 0)
      state = DEAD;
  }


  public boolean draw() { //draw()?
    if (state == DEAD)
      size = 0;
    ellipseMode(CENTER);
    ellipse(xcor, ycor, size*2, size*2);
    String _HP = "" + HP;
    fill(color( 255,0,0 ));
    text(_HP, xcor, ycor - 30);
    fill(255);
    if (state == DEAD)
      return true;
    return false;
  }
}