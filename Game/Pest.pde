import java.util.Random;
public abstract class Pest {
 
  //VARIABLES
  final static int ALIVE = 0;
  final static int DEAD = 1;

  int HP, state, size;
  float xcor,ycor,speed;
  
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
  public int getSize() { return size; }

  //Mutators
  public void setHP ( int i ) { HP = i; }
  public void setX ( int i ) { xcor = i; }
  public void setY ( int i ) { ycor = i; }
  public void setState ( int i ) { state = i; }

  //Other Methods
  public boolean isAlive() { return HP > 0; }
  public void lowerHP() { 
    HP -= 1;
    if (HP <= 0)
      state = 1;
  }
  public void raiseHP() { HP += 1; }
  public void raiseHP(int amt) { HP += amt; }


  //==========================================
  
  //call move and see what state it's in and if it's on the food
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
        xcor += speed;
      else 
        xcor -= speed;
      if (ycor < 300)
        ycor += speed;
      else
        ycor -= speed;
    }
  }
  
  void moveBack() {
    //make it move away from the food
    if (state == ALIVE) {
      if (xcor < 313)
        xcor -= 2 * speed;
      else 
        xcor += 2 * speed;
      if (ycor < 300)
        ycor -= 2 * speed;
      else
        ycor += 2 * speed;
    }
  }
  
  //ABSTRACT METHODS
  
  abstract void draw();
}