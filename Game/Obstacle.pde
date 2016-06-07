public abstract class Obstacle {

	final static int ALIVE = 0;
	final static int CONSTRUCTING = 1;
	final static int DEAD = 2;

	protected int HP, xcor, ycor, state, diff; //what is diff?

  public Obstacle(int x, int y) {
    HP = 50;
    xcor = x;
    ycor = y;
    diff = 1;
    state = ALIVE;
  }

	//Accessors
	public int getHP() { return HP; }
	public int getX() { return xcor; }
	public int getY() { return ycor; }
	public int getState() { return state; }

	//Mutators
	public void setHP ( int i ) { HP = i; }
	public void setX ( int i ) { xcor = i; }
	public void setY ( int i ) { ycor = i; }
	public void setState ( int i ) { state = i; }

}