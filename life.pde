int defeatedInvader_num;

class Life{
  Launcher[] launch_life;
  int life_num = 3;
  
  Life(){
    launch_life = new Launcher[3];
    for(int i=0;i<life_num;i++){
      launch_life[i]=new Launcher();
    }
    
    defeatedInvader_num = 0;
  }
  
  void display(){
    fill(0, 255, 0);
    rect(width/2, height-65, width, 2);      //bar
    
    PFont font = createFont("MS Gothic", 18, true);
    textFont(font);
    textSize(30);
    fill(255);  
    text("SCORE", 0, height);
    
    if(scoreFlag == false){
      text(100 * defeatedInvader_num, 100, height);  
    }
    else{
      text("CLEAR!!", 100, height);
    }
    
    text("LIFE", width/2-150, height);
    
    fill(0,255,0);
    for(int k=0; k<life_num; k++){
      launch_life[k].setLocation(width/2+80*k, height+40);  
      launch_life[k].display();
    }
  }
  
  void damege(){ 
     life_num -= 1;
  }
}
