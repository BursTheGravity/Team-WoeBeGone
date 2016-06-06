public class Storage {

	private int HP, xcor, ycor, size;

	public Storage() {
		HP = 100;
		xcor = 300;
		ycor = 275;
		size = HP;
	}

	//Accessors
	public int getHP() { return HP; }
	public int getX() { return xcor; }
	public int getY() { return ycor; }
	public int getSize() { return size; }

	//Mutators
	public void setHP ( int i ) { HP = i; }
	public void setX ( int i ) { xcor = x; }
	public void setY ( int i ) { ycor = y; }
	public void setSize ( int i ) { size = i; }

	public boolean isAlive() { return HP > 0; }
	public void lowerHP() { HP -= 1; }

}
