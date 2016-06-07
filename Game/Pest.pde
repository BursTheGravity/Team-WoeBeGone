public abstract class Pest {

	final static int ALIVE = 0;
	final static int DEAD = 1;

	private int HP, xcor, ycor, state, diff, speed;

	public Pest() {
		HP = 1;
		xcor = random(500);
		ycor = random(500);
		diff = 1;
    speed = 2;
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

  public boolean isAlive() { return HP > 0; }
  public void lowerHP() { HP -= 1; }
  public void raiseHP() { HP += 1; }
  public void raiseHP(int amt) { HP += amt; }
    
  public void show() { //draw()?
   //draws bug
  }
  
  
  
  //abstract methods
  public abstract void move();
    //add obstacle avoiding
    //xcor += random(speed);
    //ycor += random(speed);
    //attack();
  
  public abstract void attack();
    //if in its range-- each pest has diff range-- eat food

}