import java.util.Iterator.*;

//global variables
Snake s;
BoardGame bg;
Grid g;

color pointColor = color(0,0,255);
color bonusColor = color(0,255,0);
color snakeColor = color(0);

void setup(){
  size(320, 480);
  strokeWeight(3);
  background(0);
  
  //start the black magic
  s = new Snake();
  bg = new BoardGame();
  g = new Grid();
}

void draw(){
  if(g.grigEnded){
    s.update();
    bg.checkForNewItem();
  }else{
    g.render();
  }
}

void keyPressed(){
  //TODO: remove 
  if(key == 'b' ){
    bg.putItem(true);  
  }
  
  if(key == 'i'){
    bg.putItem(false);
  }
}

//controls for touchScreen
void mousePressed(){
  if(s.lastkeyCode == null){
    s.lastkeyCode = LEFT;
  }
  
  if(s.lastkeyCode == UP || s.lastkeyCode == DOWN){
    if(mouseX > (width/2))  { keyCode = RIGHT; }
    if(mouseX < (width/2))  { keyCode = LEFT; }
  }
  
  if(s.lastkeyCode == RIGHT || s.lastkeyCode == LEFT){
    if(mouseY > (height/2)) { keyCode = DOWN; }
    if(mouseY < (height/2)) { keyCode = UP; }
  }
}
