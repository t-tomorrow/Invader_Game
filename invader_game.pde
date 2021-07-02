Invader[][] invaders;
Launcher launcher;
Bullet[] bullets;
Life life;                                //

int launcher_x, launcher_y;                //ランチャーの位置

int invader_xyd[];                         //インベーダーの場所の返り値に代入
int each_invader[][][];                    //それぞれのインベーダー情報
int invader_direction;
int invader_speed;
int mostLeft_invader_x;
int mostRight_invader_x;
int invader0_attack_count;                //
int[] edge = new int[2];

int bullet_xy[][];
int[] bullet_move;                        //
int bullet_num;

int move_x;                                //ランチャーの動作
int ope_launch, operate;                  //
int mode;                                  //
boolean a, d, enter;                       //どのボタンを押されたかを判断
int enterFlag, currentFlag;                //ボタンが押されたかを判定
boolean scoreFlag;                         //score judge_flag
boolean blindFlag;                         //invader[0][0]が打たれたかを判断

void setup(){
  size(1000, 700);
  smooth();
  
  launcher = new Launcher();  
  launcher_x = 500;  launcher_y = 670;        //ランチャーの初期ポジション
  move_x = 0;
  
  invaders = new Invader[10][5];
  each_invader = new int[10][5][3];
  invader_xyd = new int[3];
//  each_invader[0][0][0] = 100;                //initial most-left invader's x_position
//  each_invader[0][0][1] = 150;                //initial most-left invader's y_position
  invader_direction = 0;                      //インベーダーは始め左に動く
  invader_speed = 3;
  mostLeft_invader_x = 0;
  mostRight_invader_x = 0;
  invader0_attack_count = 0;

//インベーダーの初期状態を設定
  for(int i=0; i<10; i++){
    for(int j=0; j<5; j++){
      for(int k=0; k<3; k++){
        if(k==2)    each_invader[i][j][k] = invader_speed;
        else        each_invader[i][j][k] = 0;
      }
    }
  }

//invader[0][0]の座標
  each_invader[0][0][0] = 100;                //invader[0][0]のｘ座標
  each_invader[0][0][1] = 150;                //invader[0][0]のｙ座標

//インベーダーを配置
  for(int i=0; i<10; i++){
    for(int j=0; j<5; j++){
      invaders[i][j] = new Invader(80*i+each_invader[0][0][0], 60*j+each_invader[0][0][1]);
    }
  }

//弾
  bullet_num = 0;
  bullet_xy = new int[20][2];
  
  for(int i=0; i<20; i++){
    bullet_xy[i][0] = 0;
    bullet_xy[i][1] = launcher_y-70;
  }
  
//ボタン  
  a = false;  d = false;  enter = false;
  mode = 0;
  
  enterFlag = 0;
  currentFlag = 0;
  scoreFlag = false;
  blindFlag = false;
  
//ライフ
  life = new Life();
}

void draw(){
  
//再描画
  background(0);
  life.display();
  
//ランチャーの位置更新
  launcher.setLocation(launcher_x, launcher_y);
  launcher.display();

//インベーダーの位置更新
  for(int i=0; i<10; i++){
    for(int j=0; j<5; j++){
      invaders[i][j].display();
    }
  }

//
  for(int i=0; i<10; i++){
    for(int j=0; j<5; j++){
      
      //If invaders[i][j] was not defeated...
      if(blindFlag == true){
        invaders[0][0].blind(each_invader[0][0][0], each_invader[0][0][1]);
      }
  
      if(each_invader[i][j][1] < height){
        invaders[i][j].setLocation(80*i+each_invader[0][0][0], 60*j+each_invader[0][0][1], each_invader[i][j][2], invader_direction);
      }
      else{
        invaders[i][j].setLocation( width/2, 5000, 0, invader_direction);
      }
      
      invader_xyd = invaders[i][j].move();
      each_invader[i][j][0] = invader_xyd[0];
      each_invader[i][j][1] = invader_xyd[1];
      each_invader[i][j][2] = invader_xyd[2];
      invader_direction     = invader_xyd[3];
    }
  }  

  
//最も左にあるインベーダーと最も左にあるインベーダーを探す
  search_for_edge(each_invader);


//ＡかＤボタンが押されたら。。。
  if(a || d){
     move_x = launcher.move(mode); 
     launcher_x += move_x;
     
     if(launcher_x < 30)        launcher_x = 30;
     if(launcher_x > width-30)  launcher_x = width-30;
  }
  
  
//Enterキーが押されたら。。。  
  if(enter){
    if(currentFlag != enterFlag){                  //
      bullet_xy[bullet_num][0] = launcher_x;
      bullet_xy[bullet_num][1] = launcher_y-70;
      
      currentFlag = enterFlag;
      
      bullet_num++;
      if(bullet_num >= 19)  bullet_num = 0;
      
      bullets[bullet_num] = new Bullet(bullet_xy[bullet_num][0], bullet_xy[bullet_num][1]);
      bullet_move = bullets[bullet_num].move();
    }
  }
  
  
//弾が打たれている間。。。
  for(int b_num=0; b_num<20; b_num++){
    if(bullets[b_num] != null){
      bullets[b_num].display();

      bullets[b_num].setLocation(bullet_xy[b_num][0], bullet_xy[b_num][1]);
      
      bullet_xy[b_num][0] += bullet_move[0];
      bullet_xy[b_num][1] += bullet_move[1];
      
      for(int i=0; i<10; i++){
        for(int j=0; j<5; j++){
          if((each_invader[0][0][0]-10 <= bullet_xy[b_num][0]) && ( bullet_xy[b_num][0] <= each_invader[0][0][0]+10) &&  each_invader[0][0][1]+15 >= bullet_xy[b_num][1] && each_invader[0][0][1]-15 <= bullet_xy[b_num][1])
            {
              blindFlag = true;
              invader0_attack_count++;
              if(invader0_attack_count == 1)  defeatedInvader_num++;
            }
          else if((each_invader[i][j][0]-10 <= bullet_xy[b_num][0]) && ( bullet_xy[b_num][0] <= each_invader[i][j][0]+10) &&  each_invader[i][j][1]+15 >= bullet_xy[b_num][1] && each_invader[i][j][1]-15 <= bullet_xy[b_num][1]) 
            {
              defeatedInvader_num++;
              each_invader[i][j][1] = invaders[i][j].damage();
            }
            
          if(defeatedInvader_num == 50)    scoreFlag = true;
        }
      }

    //弾のｘ座標、ｙ座標、invader[0][0]のｘ座標、ｙ座標、全てのインベーダーを消したか
      println(bullet_xy[bullet_num][0], bullet_xy[bullet_num][1], each_invader[0][0][0], each_invader[0][0][1], scoreFlag);
    }
  } 
}

//インベーダーの端を探す
void search_for_edge(int[][][] each_invader){
  mostLeft_invader_x = each_invader[9][0][0];         
  mostRight_invader_x = each_invader[0][0][0];        
  
  for(int i=0; i<10; i++){
    for(int j=0; j<5; j++){
      if((each_invader[i][j][1] >= 0) && (each_invader[i][j][1] <= height) && (each_invader[i][j][0] <= mostLeft_invader_x)){
        if(blindFlag == false){                                //If invader[0][0] is not defeated...
          mostLeft_invader_x = each_invader[i][j][0];
        }
        else if(blindFlag == true){
          if((i == 0) && ((each_invader[i][1][1] <= height)||(each_invader[i][2][1] <= height)||(each_invader[i][3][1] <= height)||(each_invader[i][4][1] <= height))){      //The first column does not consider the first row
            mostLeft_invader_x = each_invader[i][j][0];
          }
          else if((i != 0) && ((each_invader[i][0][1] <= height)||(each_invader[i][1][1] <= height)||(each_invader[i][2][1] <= height)||(each_invader[i][3][1] <= height)||(each_invader[i][4][1] >= 0))){    //after the second column, it consider the first row           
            mostLeft_invader_x = each_invader[i][j][0];
          }
        }
        else{
          continue;
        }
      }
      if((each_invader[i][j][1] <= height) && (each_invader[i][j][0] >= mostRight_invader_x)){      
        mostRight_invader_x = each_invader[i][j][0];
      }
    }
  }
  
  edge[0] = mostLeft_invader_x;
  edge[1] = mostRight_invader_x;
}

void search_for_under(int[][][] each_invader){
  int[] under_invader_y = new int[10];
  for(int i=0; i<10; i++)
    under_invader_y[i] = 0;
  
  for(int i=0; i<10; i++){
    for(int j=5; j>0; j--){
      
      if((under_invader_y[i] <= each_invader[i][j][1]) && (each_invader[i][j][1] <= height))
        under_invader_y[i] = each_invader[i][j][1]; 
    }
  }
}


void keyPressed(){
  switch(key){
    case 'a':    a = true;  mode = 1;  break;
    case 'd':    d = true;  mode = 2;  break;
    case ENTER:  enter = true;  enterFlag = ~enterFlag;  break;
  }
}

void keyReleased(){
  switch(key){
    case 'a':    a = false;  mode = 0;  break;
    case 'd':    d = false;  mode = 0;  break;
  }
}
