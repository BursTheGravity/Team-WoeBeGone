public class Obstacle {

	final static int ALIVE = 0;
	final static int CONSTRUCTING = 1;
	final static int DEAD = 2;

	protected int HP, xcor, ycor, _width, _height, state, cost;

  public Obstacle(int x, int y, int w, int h) {
    HP = 50;
    xcor = x;
    ycor = y;
    _width = w;
    _height = h;
    state = ALIVE;
    cost = 100;
  }

	//Accessors
	public int getHP() { return HP; }
	public int getX() { return xcor; }
	public int getY() { return ycor; }
	public int getState() { return state; }
  public int getCost() { return cost; }

	//Mutators
	public void setHP ( int i ) { HP = i; }
	public void setX ( int i ) { xcor = i; }
	public void setY ( int i ) { ycor = i; }
	public void setState ( int i ) { state = i; }
  public void setCost ( int i ) { cost = i; }

}