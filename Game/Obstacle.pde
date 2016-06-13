public class Obstacle extends Purchasable //implements Processable{
  {
  final static int INQUEUE=3;
	final static int ALIVE = 0;
	final static int CONSTRUCTING = 1;
	final static int DEAD = 2;

	protected int HP, xcor, ycor, _width, _height, state, timer;
  boolean isBomb;

  public Obstacle(int w, int h, int diff) {
    HP = diff * 10;
    _width = w;
    _height = h;
    timer = diff * 60;
    state = CONSTRUCTING;
  }
  
  public Obstacle(int w, int h, int diff, boolean bomb) {
    this(w,h,diff);
    isBomb = bomb;
  }
  
  public boolean isAlive() { return HP > 0; }
  public boolean isBomb() { return isBomb; }
  
  //Accessors
  public int getHP() { return HP; }
  public float getX() { return xcor; }
  public float getY() { return ycor; }
  public int getState() { return state; }
  public int getWidth() { return _width; }
  public int getHeight() { return _height; }
  
  //Mutators
  public void setState(int s) { state = s; }
  public void setX(int x) { xcor = x; }
  public void setY(int y) { ycor = y; }
  public void lowerHP() { 
    HP -= 1;
    if (HP <= 0) {
      state = DEAD;
      _width = 0;
      _height = 0;
    } 
  }
  
  //Other Methods

  //check state if bomb alive
  void explode() {
    fill(255,77,0);
    ellipse(xcor,ycor,15,15);
    ellipse(xcor,ycor,20,20);
    delay(3);
  }
}