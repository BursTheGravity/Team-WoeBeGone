public abstract class Pest {
 
  //VARIABLES
  final static int ALIVE = 0;
  final static int DEAD = 1;

  int HP, state, size;
  float xcor,ycor, dx, dy;
  
  //CONSTRUCTORS
  public Pest() {
    xcor = (int) random(400) + 120 - size; //change these to get it into the right box
    ycor = (int) random(400) + 95 - size;
    state = ALIVE;
  }


  //==========================================
  //Accessors
  public int getHP() { return HP; }
  public float getX() { return xcor; }
  public float getY() { return ycor; }
  public int getState() { return state; }

  //Mutators
  public void setHP ( int i ) { HP = i; }
  public void setX ( int i ) { xcor = i; }
  public void setY ( int i ) { ycor = i; }
  public void setState ( int i ) { state = i; }

  public boolean isAlive() { return HP > 0; }
  public void lowerHP() { 
    HP -= 1;
    if (HP <= 0)
      state = 1;
  }
  public void raiseHP() { HP += 1; }
  public void raiseHP(int amt) { HP += amt; }


  //==========================================
  void bounce(){
    if (xcor <= 125 )
      dx = -dx;
    if (ycor <= 100 || ycor >= 500)
      dy = -dy;
  }
  
  boolean process(int storSize){
    move();
    if (state==1) 
      size = 0;
    if (state==0)
      if (abs(xcor - 313) < storSize && 
          abs(ycor - 300) < storSize)
        return true;
    return false;
  }
  
  
  //ABSTRACT METHODS
  
  abstract void draw();
  
  abstract void move();
  
  //abstract void attack();
}