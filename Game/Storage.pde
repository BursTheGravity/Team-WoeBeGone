public class Storage {

  private int HP, xcor, ycor, size;
  //add state?

  public Storage() {
    HP = 100;
    xcor = width / 2;
    ycor = height / 2;
    //xcor = 300;
    //ycor = 275;
    size = HP;
  }

  public Storage(int hp) {
    HP = hp;
    xcor = width / 2;
    ycor = height / 2;
    //xcor = 300;
    //ycor = 275;
    size = HP;
  }

  //Accessors
  public int getHP() { 
    return HP;
  }
  public int getX() { 
    return xcor;
  }
  public int getY() { 
    return ycor;
  }
  public int getSize() { 
    return size;
  }

  //Mutators
  public void setHP ( int i ) { 
    HP = i;
  }
  public void setX ( int i ) { 
    xcor = i;
  }
  public void setY ( int i ) { 
    ycor = i;
  }
  public void setSize ( int i ) { 
    size = i;
  }



  public boolean isEmpty() { 
    return HP > 0;
  }
  public void lowerHP() { 
    HP -= 1;
  }
}