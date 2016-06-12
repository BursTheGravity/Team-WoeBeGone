public class Obstacle extends Purchasable //implements Processable{
  {
  final static int INQUEUE=3;
	final static int ALIVE = 0;
	final static int CONSTRUCTING = 1;
	final static int DEAD = 2;

	protected int HP, xcor, ycor, _width, _height, state, timer;

  public Obstacle(int w, int h, int diff) {
    HP = diff * 10;
    _width = w;
    _height = h;
    timer = diff * 60;
    state = CONSTRUCTING;
  }
  
  public boolean isAlive() { return HP > 0; }
  
  public void setX(int x) { xcor = x; }
  public void setY(int y) { ycor = y; }
  public void lowerHP() { HP -= 1; }
}