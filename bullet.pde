class Bullet{
  int x, y;
  int speed;
  
  Bullet(int bullet_x, int bullet_y){
    x = bullet_x;
    y = bullet_y;
    speed = 5;
  }
  
  void setLocation(int X, int Y){
    x = X;
    y = Y;
  }
  
  void display(){
    fill(0,255,0);
    rect(x, y, 3, 5); 
  }
 
  int[] move(){
    y = speed;
    
    int[] move_xy = new int[2];
    move_xy[0] = 0;
    move_xy[1] = -y;
    return move_xy;
  }
}
