class Enemy_Bullet{
  int x, y;
  int speed;
  
  Enemy_Bullet(int enemyBullet_x, int enemyBullet_y){
    x = enemyBullet_x;
    y = enemyBullet_y;
    speed = 3;
  }
  
  void display1(){
    fill(255);
    beginShape(LINE_STRIP);
    curveVertex( x , y-2);
    curveVertex( x , y-2);
    curveVertex(x-1, y-1);
    curveVertex( x ,  y );
    curveVertex(x+1, y+1);
    curveVertex( x , y+2);
    curveVertex( x , y+2);
    endShape();
  }
  
  void display2(){
    fill(255);
    beginShape(LINE_STRIP);
    curveVertex( x , y-2);
    curveVertex( x , y-2);
    curveVertex(x+1, y-1);
    curveVertex( x ,  y );
    curveVertex(x-1, y+1);
    curveVertex( x , y+2);
    curveVertex( x , y+2);
    endShape();
  }
  
  int[] move(){
    y = speed;
    
    int enemy_bullet[] = new int[2];
    enemy_bullet[0] = 0;
    enemy_bullet[1] = y;
    
    return enemy_bullet;
  }
}
