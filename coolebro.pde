//global variables
Snake s;
BoardGame bg;
color pointColor = color(0,0,255);
color bonusColor = color(0,255,0);
color snakeColor = color(0);

void setup(){
  size(320, 480);
  strokeWeight(3);
  background(255);
  
  //start the black magic
  s = new Snake();
  bg = new BoardGame();
}

void draw(){
  s.update();
  bg.checkForNewItem();
}

void keyPressed(){
  //TODO: remove 
  if(key == 'b' ){
    bg.putItem(bonusColor);  
  }
  
  if(key == 'i'){
    bg.putItem(pointColor);
  }
}

