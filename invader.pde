Enemy_Bullet[] enemy_bullet;

class Invader{
  int x, y;                    //インベーダーの位置
  int[] invader_info;          //それぞれのインベーダー情報([0]=x_position, [1]=y_position, [2]=speed, [3]=direction)
  int mostLeft_x, mostRight_x;
  int direction;
  int speed;                   //インベーダーの速度
  color chara_c, eye_c;

  Invader(int X, int Y){
    x = X; y = Y;
    direction = 0;
    speed = 3;
    chara_c = color(255);
    eye_c = color(0);
    invader_info = new int[4];
    mostLeft_x = 0;
    mostRight_x = 0;
  }
  
  void setLocation(int X, int Y, int s, int d){
    x = X;
    y = Y;
    speed = s;
    direction = d;
  }  
  
  void display(){
    ellipseMode(CENTER);
    rectMode(CENTER);
    
    fill(chara_c);
    noStroke();
    ellipse(x, y, 50, 30);   //body
    
    pushMatrix();            //left tactile
    translate(x-10, y-15);
    rotate(PI/4);
    translate(-(x-10), -(y-15));
    rect(x-10, y-15, 20, 10);
    popMatrix();
    
    pushMatrix();            //right tactile
    translate(x+10, y-15);
    rotate(-PI/4);
    translate(-(x+10), -(y-15));
    rect(x+10, y-15, 20, 10);
    popMatrix();


    fill(eye_c);
    rect(x-10, y, 5, 5);  //left_eye
    rect(x+10, y, 5, 5);  //right_eye
  }
  
  //to hide standard invader[0][0]
  void blind(int hide_posX, int hide_posY){ 
    rectMode(CENTER);
    fill(0);
    rect(hide_posX, hide_posY, 50, 50);
  }
  
  int[] move(){   
     if(direction == 0){          //left
       x -= speed;
       if(edge[0] < 31){
         y  += 5;
         direction = 1;
       }
     }else if(direction == 1){    //right
       x += speed;
       if(edge[1] > width-31){
         y += 5;
         direction = 0;
       }
     }
     invader_info[0] = x;
     invader_info[1] = y;
     invader_info[2] = speed;
     invader_info[3] = direction;
     
     return invader_info;
  }
  
  int damage(){
//    speed = 0;
//    x = 1000;
    y = 5000;
    
    return y;
  }
  
  void attack(){
    
  }
}
