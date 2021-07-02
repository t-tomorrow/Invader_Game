//Bullet bullet[];
//Bullet bullet;

class Launcher{
  int i;         //array
  int x, y;      //location
  int num;
  color launcher_c;
 
  Launcher(){
    i = 0;
    num = 20;
    launcher_c = color(0, 255, 0);
    bullets = new Bullet[num];

  }
  
  void setLocation(int X, int Y){
    x = X;
    y = Y;
  }
  
  void display(){
    rectMode(CENTER);
    ellipseMode(CENTER);
    
    fill(launcher_c);
    rect(x, y-50, 50, 20);
    rect(x, y-65, 40, 10);
    ellipse(x, y-70, 10, 15); 
  }
  
  int move(int operation){
    switch(operation){
      case 1:  move_x = -10;   break;  
      case 2:  move_x = 10;  break;
    }
    return move_x;
  }
}
