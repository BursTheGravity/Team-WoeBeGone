public abstract class Obstacle {

	final static int ALIVE = 0;
	final static int DEAD = 1;
	final static int CONSTRUCTING = 2;

	protected int HP, xcor, ycor, state, diff;

	public Obstacle() {
		HP = 50;
		xcor = ;
		ycor = ;
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
	public void setX ( int i ) { xcor = x; }
	public void setY ( int i ) { ycor = y; }
	public void setState ( int i ) { state = i; }

}
