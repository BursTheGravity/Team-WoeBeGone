public class Pest {

	final static int ALIVE = 0;
	final static int DEAD = 1;

	private int HP, xcor, ycor, state, diff;

	public Pest() {
		HP = 1;
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
