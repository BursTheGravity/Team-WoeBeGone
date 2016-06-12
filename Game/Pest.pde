import java.util.Random;
public abstract class Pest {
 
  //VARIABLES
  final static int ALIVE = 0;
  final static int DEAD = 1;

  int HP, state, size;
  float xcor,ycor, dx, dy;
  
  //CONSTRUCTORS
  public Pest() {
    /*BUG SPAWN RANGE: --- ***we're just doing the bug screen without side panes first***
   X-cor: randomly choose an x-cor from 75 to 555...
   if <100 or >525, then choose y-cor from 50 to 550
   else choose y-cor from either 50 to 100 or 525 to 550
   also-
   make the spawn range a different color?
   */
  //make bugs to add to queue
    xcor = (int) (random(475)) + 75 ; //change these to get it into the right box
    if (xcor<125 || xcor>525){
      ycor=500;
      //ycor = (int) random(500) + 50 - size;
    }
    else{
      //int tmp = (int) (random(1));
      //if (tmp==0){
        //ycor= (int) random(50)+50;
      //}
      //else{
        Random rand=new Random(); 
        if(Math.random() < 0.5) {
        ycor=(int) random(25)+525;
        }
        else{
          ycor=(int)random(50)+50;
      //}
    }
    state = ALIVE;
  }
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
    
  void move() {    
    //make it approach the food
    if (state == ALIVE) {
      if (xcor < 313)
        xcor += dx;
      else 
        xcor -= dx;
      if (ycor < 300)
        ycor += dy;
      else
        ycor -= dy;
    }
  }
  
  //ABSTRACT METHODS
  
  abstract void draw();
}